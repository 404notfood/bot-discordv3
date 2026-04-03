import {
  Guild,
  GuildMember,
  EmbedBuilder,
  PermissionFlagsBits,
  TextChannel,
  ChannelType,
} from 'discord.js';
import { db } from './database';
import { log } from './logger';

// ============================================================
// Types
// ============================================================

export interface AuditOptions {
  guild: Guild;
  roleDebutantId: string;
  rolePreavisId: string;
  sendDMs: boolean;
}

export interface AuditResult {
  debutantCount: number;
  preavisCount: number;
  dmSentCount: number;
  dmFailCount: number;
  skippedBots: number;
  skippedActive: number;
  totalScanned: number;
  channelsScanned: number;
  membersInHistory: number;
  debutantList: string[];
  preavisList: string[];
}

// ============================================================
// Scan de l'historique des canaux
// ============================================================

export async function scanChannelHistory(guild: Guild): Promise<Map<string, Date>> {
  const lastMessageMap = new Map<string, Date>();
  const botMember = guild.members.me;
  if (!botMember) return lastMessageMap;

  const textChannels = guild.channels.cache.filter(
    (ch) => ch.type === ChannelType.GuildText || ch.type === ChannelType.GuildForum
  );

  for (const [, channel] of textChannels) {
    try {
      const textChannel = channel as TextChannel;

      // Verifier que le bot peut lire ce canal
      if (!textChannel.permissionsFor(botMember)?.has('ViewChannel')) continue;
      if (!textChannel.permissionsFor(botMember)?.has('ReadMessageHistory')) continue;

      // Recuperer les 200 derniers messages de chaque canal
      let lastId: string | undefined;
      let fetched = 0;
      const maxMessages = 200;

      while (fetched < maxMessages) {
        const options: { limit: number; before?: string } = { limit: 100 };
        if (lastId) options.before = lastId;

        const messages = await textChannel.messages.fetch(options);
        if (messages.size === 0) break;

        for (const [, msg] of messages) {
          if (msg.author.bot) continue;

          const existing = lastMessageMap.get(msg.author.id);
          if (!existing || msg.createdAt > existing) {
            lastMessageMap.set(msg.author.id, msg.createdAt);
          }
        }

        lastId = messages.last()?.id;
        fetched += messages.size;

        // Si le dernier message date de plus de 10 mois, on arrete pour ce canal
        const oldestMsg = messages.last();
        if (oldestMsg && oldestMsg.createdAt < new Date(Date.now() - 10 * 30 * 24 * 60 * 60 * 1000)) {
          break;
        }
      }
    } catch (err) {
      log.debug('Erreur scan canal', { channelId: channel.id, error: err });
    }
  }

  // Completer avec les donnees BDD (tracking recent)
  const dbMembers = await db.client.guildMember.findMany({
    where: { guildId: guild.id },
  });

  for (const dbMember of dbMembers) {
    if (dbMember.lastActiveAt) {
      const existing = lastMessageMap.get(dbMember.userId);
      if (!existing || dbMember.lastActiveAt > existing) {
        lastMessageMap.set(dbMember.userId, dbMember.lastActiveAt);
      }
    }
  }

  log.service('Audit', `Historique scanne: ${lastMessageMap.size} membres actifs trouves dans ${textChannels.size} canaux`);

  return lastMessageMap;
}

// ============================================================
// Execution de l'audit
// ============================================================

export async function executeAudit(options: AuditOptions): Promise<AuditResult> {
  const { guild, roleDebutantId, rolePreavisId, sendDMs } = options;

  // Sauvegarder le role preavis en config
  await db.client.guildConfig.upsert({
    where: { guildId: guild.id },
    update: { preavisRoleId: rolePreavisId },
    create: {
      guildId: guild.id,
      guildName: guild.name,
      preavisRoleId: rolePreavisId,
    },
  });

  // Phase 1 : Scanner l'historique
  const lastMessageMap = await scanChannelHistory(guild);

  const textChannels = guild.channels.cache.filter(
    (ch) => ch.type === ChannelType.GuildText || ch.type === ChannelType.GuildForum
  );

  // Phase 2 : Auditer les membres
  const members = await guild.members.fetch();
  const now = new Date();
  const eightMonthsAgo = new Date(now.getTime() - 8 * 30 * 24 * 60 * 60 * 1000);

  const result: AuditResult = {
    debutantCount: 0,
    preavisCount: 0,
    dmSentCount: 0,
    dmFailCount: 0,
    skippedBots: 0,
    skippedActive: 0,
    totalScanned: members.size,
    channelsScanned: textChannels.size,
    membersInHistory: lastMessageMap.size,
    debutantList: [],
    preavisList: [],
  };

  for (const [, member] of members) {
    // Ignorer les bots et les admins
    if (member.user.bot) {
      result.skippedBots++;
      continue;
    }
    if (member.permissions.has(PermissionFlagsBits.Administrator)) continue;

    // Ne pas traiter si le membre a deja le role preavis
    if (member.roles.cache.has(rolePreavisId)) continue;

    const lastMessage = lastMessageMap.get(member.id);
    const joinedAt = member.joinedAt || new Date();

    // Cas 1 : Membre a parle recemment (< 8 mois) -> on ne touche pas
    if (lastMessage && lastMessage >= eightMonthsAgo) {
      result.skippedActive++;
      continue;
    }

    // Cas 2 : Membre n'a JAMAIS parle
    if (!lastMessage) {
      const joinedLongAgo = joinedAt < eightMonthsAgo;

      if (joinedLongAgo) {
        // Jamais parle ET present depuis 8+ mois -> En preavis
        const dmSuccess = await assignRolePreavis(member, rolePreavisId, guild.name, sendDMs);
        result.preavisCount++;
        result.preavisList.push(member.user.tag);
        if (sendDMs) {
          if (dmSuccess) result.dmSentCount++;
          else result.dmFailCount++;
        }
      } else {
        // Jamais parle mais arrive recemment -> Dev Debutant
        if (!member.roles.cache.has(roleDebutantId)) {
          try {
            await member.roles.add(roleDebutantId, 'Audit membres - jamais parle');
            result.debutantCount++;
            result.debutantList.push(member.user.tag);
          } catch (err) {
            log.debug('Erreur attribution role debutant', { error: err, userId: member.id });
          }
        }
      }
      continue;
    }

    // Cas 3 : Membre a parle mais inactif depuis 8+ mois
    const dmSuccess = await assignRolePreavis(member, rolePreavisId, guild.name, sendDMs);
    result.preavisCount++;
    result.preavisList.push(member.user.tag);
    if (sendDMs) {
      if (dmSuccess) result.dmSentCount++;
      else result.dmFailCount++;
    }
  }

  return result;
}

// ============================================================
// Attribution du role preavis (+/- DM)
// ============================================================

async function assignRolePreavis(
  member: GuildMember,
  rolePreavisId: string,
  guildName: string,
  sendDM: boolean,
): Promise<boolean> {
  try {
    // Attribuer le role
    await member.roles.add(rolePreavisId, 'Audit membres - inactif depuis 8+ mois');

    // Enregistrer la date d'attribution en BDD pour le kick dans 7 jours
    await db.client.moderationLog.create({
      data: {
        action: 'preavis',
        userId: member.id,
        moderatorId: 'system',
        guildId: member.guild.id,
        reason: 'Inactif depuis 8+ mois - preavis de kick (7 jours)',
        executedAt: new Date(),
      },
    });

    // Envoyer un DM d'avertissement uniquement si demande
    if (!sendDM) return true;

    try {
      const dmEmbed = new EmbedBuilder()
        .setColor(0xFF6B35)
        .setTitle('⚠️ Avertissement - Inactivite')
        .setDescription(
          [
            `Bonjour **${member.user.globalName || member.user.username}**,`,
            '',
            `Nous avons remarque que cela fait un bon moment que tu es sur le serveur **${guildName}** sans t'etre presente(e) ou sans avoir participe aux discussions.`,
            '',
            'Notre serveur est une communaute active de developpeurs et nous aimerions beaucoup te connaitre ! 🚀',
            '',
            '**Tu as 7 jours pour te presenter et participer**, sinon tu seras automatiquement retire(e) du serveur.',
            '',
            'N\'hesite pas a :',
            '• Te presenter dans le canal de presentation',
            '• Poser des questions',
            '• Participer aux discussions',
            '• Rejoindre les events et challenges',
            '',
            'On espere te voir bientot parmi nous ! 💪',
          ].join('\n')
        )
        .setFooter({ text: guildName })
        .setTimestamp();

      await member.send({ embeds: [dmEmbed] });
      return true;
    } catch (dmErr) {
      log.debug('Impossible d\'envoyer le DM de preavis', { userId: member.id, error: dmErr });
      return false;
    }
  } catch (err) {
    log.error('Erreur attribution role preavis', { error: err, userId: member.id });
    return false;
  }
}

// ============================================================
// Embed de resultat (partage entre les deux commandes)
// ============================================================

export function buildAuditEmbed(
  result: AuditResult,
  roleDebutantName: string,
  rolePreavisName: string,
  sendDMs: boolean,
): EmbedBuilder {
  const dmLines = sendDMs
    ? [
        `DM d'avertissement envoyes : **${result.dmSentCount}**`,
        result.dmFailCount > 0 ? `DM echoues (DMs fermes) : **${result.dmFailCount}**` : '',
      ]
    : ['DM : **desactives** (utilisez /audit-membres-dm pour envoyer les DMs)'];

  return new EmbedBuilder()
    .setColor(sendDMs ? 0xE67E22 : 0x3498DB)
    .setTitle(sendDMs ? '📋 Audit des membres termine (avec DM)' : '📋 Audit des membres termine (sans DM)')
    .setDescription(
      sendDMs
        ? 'Roles attribues et DM d\'avertissement envoyes.'
        : 'Roles attribues **sans envoyer de DM**. Utilisez `/audit-membres-dm` pour envoyer les DMs.',
    )
    .addFields(
      {
        name: '🆕 Dev Debutant (jamais parle, < 8 mois)',
        value: result.debutantCount > 0
          ? `**${result.debutantCount}** membre(s)\n${result.debutantList.slice(0, 15).join(', ')}${result.debutantList.length > 15 ? ` ...et ${result.debutantList.length - 15} autres` : ''}`
          : 'Aucun nouveau membre inactif',
        inline: false,
      },
      {
        name: '⚠️ En Preavis (inactif 8+ mois)',
        value: result.preavisCount > 0
          ? `**${result.preavisCount}** membre(s)\n${result.preavisList.slice(0, 15).join(', ')}${result.preavisList.length > 15 ? ` ...et ${result.preavisList.length - 15} autres` : ''}`
          : 'Aucun membre inactif depuis 8 mois',
        inline: false,
      },
      {
        name: '📊 Statistiques',
        value: [
          `Membres scannes : **${result.totalScanned}**`,
          `Membres actifs (ignores) : **${result.skippedActive}**`,
          `Bots ignores : **${result.skippedBots}**`,
          `Role "${roleDebutantName}" attribue : **${result.debutantCount}**`,
          `Role "${rolePreavisName}" attribue : **${result.preavisCount}**`,
          ...dmLines,
          `Canaux scannes : **${result.channelsScanned}**`,
          `Membres trouves dans l'historique : **${result.membersInHistory}**`,
        ].filter(Boolean).join('\n'),
        inline: false,
      }
    )
    .setFooter({ text: 'Utilisez /kick-preavis dans 7 jours pour kicker les membres en preavis' })
    .setTimestamp();
}
