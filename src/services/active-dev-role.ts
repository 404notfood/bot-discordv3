import { Client, Guild, TextChannel } from 'discord.js';
import { db } from './database';
import { log } from './logger';

// ---------------------------------------------------------------------------
// Constantes
// ---------------------------------------------------------------------------

const MIN_MESSAGES_PER_DAY = 5;
const ACTIVE_DAYS_REQUIRED = 5;
const INACTIVE_DAYS_THRESHOLD = 2;

// ---------------------------------------------------------------------------
// Messages droles
// ---------------------------------------------------------------------------

const GRANTED_MESSAGES = [
  (name: string) => `Woaaa ${name} tellement tu parles que t'as reussi a pirater le systeme pour te mettre Dev Actif. Respect.`,
  (name: string) => `Alerte intrusion ! ${name} a spam le chat tellement fort que le bot a capitule et lui a file le role Dev Actif.`,
  (name: string) => `${name}... T'as pas de vie hein ? 5 jours non-stop a parler. Bon bah tiens, prends ton role Dev Actif, tu l'as merite (malheureusement).`,
  (name: string) => `Le clavier de ${name} demande grace mais le systeme a parle : Dev Actif. Tes doigts ont souffert pour ca.`,
  (name: string) => `Nan mais ${name}, t'es au courant que toucher de l'herbe c'est gratuit ? En attendant, voila ton role Dev Actif, bavard.`,
  (name: string) => `${name} a atteint un niveau de blabla tellement eleve que meme le bot est impressionne. Dev Actif debloque. Felicitations... je crois.`,
  (name: string) => `BREAKING NEWS : ${name} parle plus que la meteo sur BFM. Le role Dev Actif lui a ete attribue de force.`,
  (name: string) => `Le serveur voulait te ban pour flood ${name}, mais on t'a file Dev Actif a la place. C'est pas la meme energie.`,
  (name: string) => `Attention, ${name} a debloque le succes "Diarrhee Verbale niveau 5". Recompense : Dev Actif.`,
  (name: string) => `Les doigts de ${name} n'ont pas vu la lumiere du jour depuis 5 jours. En compensation, voici le role Dev Actif.`,
  (name: string) => `${name} a ecrit plus de lignes dans le chat que dans son code. Mais bon, Dev Actif quand meme.`,
  (name: string) => `On pensait que ${name} etait un bot tellement il parle. Verification faite... non, juste un etre humain sans bouton OFF. Dev Actif.`,
  (name: string) => `${name} a depasse le quota de blabla autorise par la convention de Geneve. Le role Dev Actif est une mesure de containment.`,
  (name: string) => `Si le bavardage etait un sport olympique, ${name} serait deja sur le podium. Medaille : Dev Actif.`,
  (name: string) => `Les notifications du serveur quand ${name} est la : 📳📳📳📳📳. Dev Actif attribue pour services rendus au bruit ambiant.`,
  (name: string) => `${name}, ta facture d'electricite doit etre enorme vu le temps que tu passes ici. Tiens, un role Dev Actif, ca compensera pas mais c'est gratuit.`,
];

const REVOKED_MESSAGES = [
  (name: string) => `MOUAHAHA ${name} fallait causer avec nous ! Ton role Dev Actif vient de disparaitre comme ta motivation.`,
  (name: string) => `${name} a ete porte disparu. Le role Dev Actif aussi. Coincidence ? Non.`,
  (name: string) => `Allo ${name} ? T'es la ? Non ? Bon bah bye bye Dev Actif alors. Reviens quand t'auras retrouve ton clavier.`,
  (name: string) => `RIP le role Dev Actif de ${name}. Cause du deces : silence radio. On t'aimait bien pourtant (ou pas).`,
  (name: string) => `${name} est passe de "Dev Actif" a "Dev Actif... sur un autre serveur probablement". Trahison.`,
  (name: string) => `Le role Dev Actif de ${name} a fait ses valises. Il a dit qu'il en avait marre d'attendre que tu parles.`,
  (name: string) => `${name}, 2 jours sans un mot ? Meme mon oncle bourre a Noel parle plus que toi. Dev Actif retire.`,
  (name: string) => `Plot twist : ${name} n'etait pas dev actif, c'etait juste une phase. Le role a ete confisque.`,
  (name: string) => `${name} a ghost le serveur plus fort que son ex. Dev Actif retire, dignite aussi.`,
  (name: string) => `On a lance un avis de recherche pour ${name}. En attendant, le role Dev Actif a ete redistribue aux vivants.`,
  (name: string) => `${name} est plus silencieux qu'un commit sans message. Allez, rends le role.`,
  (name: string) => `Le dernier message de ${name} date d'une autre ere geologique. Dev Actif supprime, fossile confirme.`,
  (name: string) => `${name} pensait que le role Dev Actif c'etait a vie. Surprise ! C'etait pas un CDI.`,
  (name: string) => `Moment de silence pour le role Dev Actif de ${name}. Ah bah c'est deja silencieux en fait, c'est le probleme.`,
  (name: string) => `${name} a disparu plus vite qu'un stagiaire un vendredi a 16h. Dev Actif revoque.`,
  (name: string) => `"Je reviens dans 5 min" - ${name}, il y a 2 jours. Le role Dev Actif n'a pas attendu.`,
];

function getRandomGrantedMessage(displayName: string): string {
  return GRANTED_MESSAGES[Math.floor(Math.random() * GRANTED_MESSAGES.length)](displayName);
}

function getRandomRevokedMessage(displayName: string): string {
  return REVOKED_MESSAGES[Math.floor(Math.random() * REVOKED_MESSAGES.length)](displayName);
}

// ---------------------------------------------------------------------------
// Service Dev Actif
// ---------------------------------------------------------------------------

export class ActiveDevRoleService {
  private checkInterval: NodeJS.Timeout | null = null;

  // ------------------------------------------------------------------
  // Verification principale — appelée par l'intervalle
  // ------------------------------------------------------------------

  async checkAllGuilds(client: Client): Promise<void> {
    try {
      const configs = await db.client.guildConfig.findMany({
        where: {
          isActive: true,
          activeDevRoleId: { not: null },
        },
        select: {
          guildId: true,
          activeDevRoleId: true,
          activeDevChannelId: true,
          immuneRoleId: true,
        },
      });

      for (const config of configs) {
        try {
          const guild = await client.guilds.fetch(config.guildId).catch(() => null);
          if (!guild) continue;

          await this.processGuild(guild, config.activeDevRoleId!, config.activeDevChannelId, config.immuneRoleId);
        } catch (error) {
          log.error(`ActiveDevRole: erreur guild ${config.guildId}`, { error });
        }
      }
    } catch (error) {
      log.error('ActiveDevRole: erreur globale checkAllGuilds', { error });
    }
  }

  // ------------------------------------------------------------------
  // Traitement d'un serveur
  // ------------------------------------------------------------------

  private async processGuild(
    guild: Guild,
    activeDevRoleId: string,
    activeDevChannelId: string | null,
    immuneRoleId: string | null,
  ): Promise<void> {
    const role = guild.roles.cache.get(activeDevRoleId);
    if (!role) {
      log.warn(`ActiveDevRole: role ${activeDevRoleId} introuvable sur ${guild.name}`);
      return;
    }

    // Canal pour les messages d'annonce
    const announceChannel = activeDevChannelId
      ? (guild.channels.cache.get(activeDevChannelId) as TextChannel | undefined)
      : null;

    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

    // Date de debut de la fenetre glissante (5 jours)
    const windowStart = new Date(today);
    windowStart.setDate(windowStart.getDate() - ACTIVE_DAYS_REQUIRED + 1);

    // Date seuil d'inactivite (2 jours sans message)
    const inactiveThreshold = new Date(today);
    inactiveThreshold.setDate(inactiveThreshold.getDate() - INACTIVE_DAYS_THRESHOLD);

    // Recuperer tous les compteurs quotidiens de la fenetre
    const dailyCounts = await db.client.dailyMessageCount.findMany({
      where: {
        guildId: guild.id,
        date: { gte: windowStart },
      },
    });

    // Grouper par userId
    const userDays = new Map<string, { activeDays: number; lastActiveDate: Date }>();

    for (const entry of dailyCounts) {
      const existing = userDays.get(entry.userId);
      const entryDate = new Date(entry.date);

      if (entry.count >= MIN_MESSAGES_PER_DAY) {
        if (existing) {
          existing.activeDays++;
          if (entryDate > existing.lastActiveDate) {
            existing.lastActiveDate = entryDate;
          }
        } else {
          userDays.set(entry.userId, { activeDays: 1, lastActiveDate: entryDate });
        }
      } else if (!existing) {
        userDays.set(entry.userId, { activeDays: 0, lastActiveDate: entryDate });
      } else if (entryDate > existing.lastActiveDate) {
        existing.lastActiveDate = entryDate;
      }
    }

    // Traiter les membres du serveur
    let granted = 0;
    let revoked = 0;

    const members = await guild.members.fetch().catch(() => null);
    if (!members) return;

    for (const [memberId, member] of members) {
      if (member.user.bot) continue;

      // Les membres immunises ne perdent jamais le role
      const isImmune = immuneRoleId ? member.roles.cache.has(immuneRoleId) : false;

      const hasRole = member.roles.cache.has(activeDevRoleId);
      const userData = userDays.get(memberId);

      const qualifies = userData ? userData.activeDays >= ACTIVE_DAYS_REQUIRED : false;
      const isInactive = !userData || userData.lastActiveDate < inactiveThreshold;

      // Attribution du role
      if (qualifies && !hasRole) {
        try {
          await member.roles.add(role, 'Dev Actif: 5+ messages/jour pendant 5 jours');
          granted++;
          log.service('ActiveDevRole', `Role attribue a ${member.user.username}`);

          if (announceChannel) {
            try {
              await announceChannel.send(getRandomGrantedMessage(member.displayName));
            } catch {
              // Pas de permission d'ecrire, pas grave
            }
          }
        } catch (err) {
          log.error(`ActiveDevRole: impossible d'ajouter le role a ${member.user.username}`, { error: err });
        }
      }

      // Retrait du role (sauf immunises)
      if (hasRole && isInactive && !isImmune) {
        try {
          await member.roles.remove(role, 'Dev Actif: inactif depuis 2+ jours');
          revoked++;
          log.service('ActiveDevRole', `Role retire de ${member.user.username}`);

          if (announceChannel) {
            try {
              await announceChannel.send(getRandomRevokedMessage(member.displayName));
            } catch {
              // Pas de permission d'ecrire, pas grave
            }
          }
        } catch (err) {
          log.error(`ActiveDevRole: impossible de retirer le role de ${member.user.username}`, { error: err });
        }
      }
    }

    if (granted > 0 || revoked > 0) {
      log.info(`ActiveDevRole [${guild.name}]: +${granted} attribue(s), -${revoked} retire(s)`);
    }

    // Nettoyage des vieilles donnees (> 10 jours)
    const cleanupDate = new Date(today);
    cleanupDate.setDate(cleanupDate.getDate() - 10);

    await db.client.dailyMessageCount.deleteMany({
      where: {
        guildId: guild.id,
        date: { lt: cleanupDate },
      },
    }).catch((err) => log.debug('ActiveDevRole: erreur nettoyage', { error: err }));
  }

  // ------------------------------------------------------------------
  // Intervalle (toutes les heures)
  // ------------------------------------------------------------------

  startInterval(client: Client): void {
    if (this.checkInterval) {
      clearInterval(this.checkInterval);
    }

    // Verifier toutes les heures
    this.checkInterval = setInterval(() => {
      this.checkAllGuilds(client).catch((error) => {
        log.error('ActiveDevRole: erreur intervalle', { error });
      });
    }, 60 * 60 * 1000);

    // Premiere verification immédiate
    this.checkAllGuilds(client).catch((error) => {
      log.error('ActiveDevRole: erreur premiere verification', { error });
    });

    log.info('ActiveDevRole: service demarre (intervalle 1h)');
  }

  stopInterval(): void {
    if (this.checkInterval) {
      clearInterval(this.checkInterval);
      this.checkInterval = null;
      log.info('ActiveDevRole: service arrete');
    }
  }

  async cleanup(): Promise<void> {
    this.stopInterval();
  }
}

// Singleton
export const activeDevRoleService = new ActiveDevRoleService();
