import { Client, EmbedBuilder, TextChannel, GuildMember } from 'discord.js';
import { db } from './database';
import { log } from './logger';
import { ChallengeType } from '../generated/prisma/client';

// ---------------------------------------------------------------------------
// Helpers – date bounds
// ---------------------------------------------------------------------------

function getWeeklyBounds(now: Date = new Date()): { start: Date; end: Date } {
  const date = new Date(now);
  const day = (date.getDay() + 6) % 7; // Monday = 0
  const monday = new Date(date);
  monday.setDate(date.getDate() - day);
  monday.setHours(0, 0, 0, 0);
  const sunday = new Date(monday);
  sunday.setDate(monday.getDate() + 6);
  sunday.setHours(23, 59, 59, 999);
  return { start: monday, end: sunday };
}

function getMonthlyBounds(now: Date = new Date()): { start: Date; end: Date } {
  const start = new Date(now.getFullYear(), now.getMonth(), 1, 0, 0, 0, 0);
  const end = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59, 999);
  return { start, end };
}

function toDateStr(d: Date): string {
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

/** Retourne un Date a minuit UTC (pour Prisma @db.Date) */
function toDateOnly(d: Date): Date {
  return new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
}

function typeLabel(type: string): string {
  return type === 'weekly' ? 'Hebdomadaire' : 'Mensuel';
}

function typeEmoji(type: string): string {
  return type === 'weekly' ? '🏁' : '🏆';
}

function roleNameForType(type: string): string {
  return type === 'weekly' ? 'Challenger' : 'Super-Challenger';
}

// ---------------------------------------------------------------------------
// Get active challenge (plan > config fallback)
// ---------------------------------------------------------------------------

async function getActiveChallenge(guildId: string, type: string) {
  const { start, end } = type === 'weekly' ? getWeeklyBounds() : getMonthlyBounds();

  const plan = await db.client.challengePlan.findFirst({
    where: { guildId, type: type as ChallengeType, periodStart: toDateOnly(start) },
  });

  if (plan) {
    return { title: plan.title, description: plan.description, start, end };
  }

  const config = await db.client.challengeConfig.findUnique({ where: { guildId } });
  const title = type === 'weekly' ? config?.weeklyTitle : config?.monthlyTitle;
  return { title: title || null, description: null, start, end };
}

// ---------------------------------------------------------------------------
// Determine the winner of a period
// ---------------------------------------------------------------------------

async function getWinner(
  guildId: string,
  type: string,
  periodStart: string,
): Promise<{ userId: string; votes: number; metadata: string | null } | null> {
  const rows = await db.client.$queryRaw<
    Array<{ user_discord_id: string; metadata: string | null; votes: bigint }>
  >`
    SELECT cs.user_discord_id, cs.metadata::text,
           COALESCE(v.vote_count, 0) as votes
    FROM challenge_submissions cs
    LEFT JOIN (
      SELECT target_user_discord_id, COUNT(*) as vote_count
      FROM challenge_votes
      WHERE guild_id = ${guildId} AND type = ${type} AND period_start = ${periodStart}::date
      GROUP BY target_user_discord_id
    ) v ON v.target_user_discord_id = cs.user_discord_id
    WHERE cs.guild_id = ${guildId} AND cs.type = ${type} AND cs.period_start = ${periodStart}::date
    ORDER BY votes DESC, cs.submitted_at ASC
    LIMIT 1
  `;

  if (rows.length === 0) return null;
  return {
    userId: rows[0].user_discord_id,
    votes: Number(rows[0].votes || 0),
    metadata: rows[0].metadata,
  };
}

// ---------------------------------------------------------------------------
// Transfer role: remove from old winner, give to new winner
// ---------------------------------------------------------------------------

async function transferRole(
  client: Client,
  guildId: string,
  roleId: string,
  oldWinnerId: string | null,
  newWinnerId: string,
): Promise<boolean> {
  try {
    const guild = await client.guilds.fetch(guildId).catch(() => null);
    if (!guild) return false;

    const role = guild.roles.cache.get(roleId);
    if (!role) {
      log.warn(`Challenge role ${roleId} not found on guild ${guildId}`);
      return false;
    }

    // Si c'est la meme personne, on ne fait rien (il garde le role)
    if (oldWinnerId === newWinnerId) {
      log.info(`Challenge role: ${newWinnerId} garde le role ${role.name} (meme gagnant)`);
      return true;
    }

    // Retirer le role a l'ancien gagnant
    if (oldWinnerId) {
      const oldMember = await guild.members.fetch(oldWinnerId).catch(() => null);
      if (oldMember && oldMember.roles.cache.has(roleId)) {
        await oldMember.roles.remove(role, 'Fin du challenge — nouveau gagnant');
        log.info(`Challenge role: retire ${role.name} de ${oldMember.user.username}`);
      }
    }

    // Donner le role au nouveau gagnant
    const newMember = await guild.members.fetch(newWinnerId).catch(() => null);
    if (newMember) {
      await newMember.roles.add(role, 'Gagnant du challenge !');
      log.info(`Challenge role: donne ${role.name} a ${newMember.user.username}`);
      return true;
    }

    return false;
  } catch (error) {
    log.error('transferRole error', { error, guildId, roleId, newWinnerId });
    return false;
  }
}

// ---------------------------------------------------------------------------
// Announce a NEW challenge at the start of a period
// ---------------------------------------------------------------------------

async function announceNewChallenge(
  client: Client,
  guildId: string,
  type: ChallengeType,
  channelId: string,
): Promise<void> {
  const challenge = await getActiveChallenge(guildId, type);
  if (!challenge.title) return;

  const channel = (await client.channels.fetch(channelId).catch(() => null)) as TextChannel | null;
  if (!channel) return;

  const startTs = Math.floor(challenge.start.getTime() / 1000);
  const endTs = Math.floor(challenge.end.getTime() / 1000);

  const embed = new EmbedBuilder()
    .setColor(type === 'weekly' ? 0x00ae86 : 0xffd700)
    .setTitle(`${typeEmoji(type)} Nouveau Challenge ${typeLabel(type)} !`)
    .setDescription(
      `**${challenge.title}**` +
      (challenge.description ? `\n\n${challenge.description}` : '')
    )
    .addFields(
      { name: '📅 Periode', value: `Du <t:${startTs}:D> au <t:${endTs}:D>`, inline: false },
      { name: '🚀 Participer', value: '`/challenge submit`', inline: true },
      { name: '📊 Classement', value: '`/challenge leaderboard`', inline: true },
      { name: '⭐ Voter', value: '`/challenge vote`', inline: true },
    )
    .setFooter({
      text: type === 'weekly'
        ? 'Le gagnant obtient le role Challenger !'
        : 'Le gagnant obtient le role Super-Challenger !',
    })
    .setTimestamp();

  await channel.send({ embeds: [embed] }).catch(() => null);
  log.info(`Challenge annonce: ${type} pour guild ${guildId} — "${challenge.title}"`);
}

// ---------------------------------------------------------------------------
// Close a challenge: announce winner + transfer role
// ---------------------------------------------------------------------------

async function closeChallenge(
  client: Client,
  guildId: string,
  type: ChallengeType,
  cfg: any,
  periodStart: string,
  periodBounds: { start: Date; end: Date },
): Promise<void> {
  const channelId = String(cfg.announceChannelId || '');
  const roleId = type === 'weekly'
    ? cfg.challengerRoleId
    : cfg.superChallengerRoleId;
  const oldWinnerId = type === 'weekly'
    ? cfg.lastWeeklyWinnerId
    : cfg.lastMonthlyWinnerId;

  const winner = await getWinner(guildId, type, periodStart);

  // Participants count
  const participantCount = await db.client.challengeSubmission.count({
    where: {
      guildId,
      type: type as ChallengeType,
      periodStart: new Date(periodStart + 'T00:00:00Z'),
    },
  });

  // ---- Transfer role ----
  if (winner && roleId) {
    await transferRole(client, guildId, roleId, oldWinnerId, winner.userId);
  } else if (!winner && oldWinnerId && roleId) {
    // Pas de participant = retirer le role a l'ancien gagnant
    const guild = await client.guilds.fetch(guildId).catch(() => null);
    if (guild) {
      const oldMember = await guild.members.fetch(oldWinnerId).catch(() => null);
      const role = guild.roles.cache.get(roleId);
      if (oldMember && role && oldMember.roles.cache.has(roleId)) {
        await oldMember.roles.remove(role, 'Aucun participant — role retire');
        log.info(`Challenge role: retire ${role.name} de ${oldMember.user.username} (aucun participant)`);
      }
    }
  }

  // ---- Update config with new winner ----
  const updateData: Record<string, any> = { updatedAt: new Date() };
  if (type === 'weekly') {
    updateData.lastWeeklyWinnerId = winner?.userId || null;
    updateData.lastWeeklyClosedAt = new Date();
  } else {
    updateData.lastMonthlyWinnerId = winner?.userId || null;
    updateData.lastMonthlyClosedAt = new Date();
  }
  await db.client.challengeConfig.update({
    where: { guildId },
    data: updateData,
  });

  // ---- Announce results ----
  if (!channelId) return;

  const channel = (await client.channels.fetch(channelId).catch(() => null)) as TextChannel | null;
  if (!channel) return;

  const challenge = await db.client.challengePlan.findFirst({
    where: { guildId, type: type as ChallengeType, periodStart: new Date(periodStart + 'T00:00:00Z') },
  });
  const challengeTitle = challenge?.title || (type === 'weekly' ? cfg.weeklyTitle : cfg.monthlyTitle) || 'Challenge';

  const embed = new EmbedBuilder()
    .setColor(winner ? 0xffd700 : 0xff6600)
    .setTitle(`${typeEmoji(type)} Challenge ${typeLabel(type)} — Resultats !`)
    .setTimestamp();

  if (winner) {
    let meta: { githubUrl?: string; description?: string } = {};
    try { meta = winner.metadata ? JSON.parse(winner.metadata) : {}; } catch {}

    const guild = await client.guilds.fetch(guildId).catch(() => null);
    const winnerMember = guild ? await guild.members.fetch(winner.userId).catch(() => null) : null;
    const winnerName = winnerMember?.user.username || winner.userId;

    embed.setDescription(
      `🎉 Le challenge **${challengeTitle}** est termine !\n\n` +
      `🥇 **Gagnant** : <@${winner.userId}> avec **${winner.votes} vote${winner.votes > 1 ? 's' : ''}** !` +
      (meta.githubUrl ? `\n🔗 [Voir le projet](${meta.githubUrl})` : '') +
      (meta.description ? `\n📝 ${meta.description}` : '') +
      `\n\n👥 **${participantCount}** participant${participantCount > 1 ? 's' : ''} cette periode`
    );

    if (roleId) {
      embed.addFields({
        name: `🏅 Role ${roleNameForType(type)}`,
        value: oldWinnerId === winner.userId
          ? `<@${winner.userId}> conserve son role !`
          : `<@${winner.userId}> recoit le role **${roleNameForType(type)}** !`,
        inline: false,
      });
    }

    // Thumbnails
    if (winnerMember) {
      embed.setThumbnail(winnerMember.user.displayAvatarURL({ size: 256 }));
    }
  } else {
    embed.setDescription(
      `Le challenge **${challengeTitle}** est termine.\n\n` +
      `😢 Aucun participant cette fois-ci.\n` +
      `Participez au prochain challenge avec \`/challenge submit\` !`
    );
  }

  await channel.send({ embeds: [embed] }).catch(() => null);
  log.info(`Challenge cloture: ${type} pour guild ${guildId}, gagnant: ${winner?.userId || 'aucun'}`);
}

// ---------------------------------------------------------------------------
// Service class
// ---------------------------------------------------------------------------

export class ChallengeSchedulerService {
  private interval: NodeJS.Timeout | null = null;
  private client: Client | null = null;

  // Check every 10 minutes
  private static readonly CHECK_INTERVAL_MS = 10 * 60 * 1000;

  start(client: Client): void {
    this.client = client;

    // Run immediately on start
    this.tick().catch((e) => log.error('challenge-scheduler first tick error', { error: e }));

    // Then every 10 minutes
    this.interval = setInterval(() => {
      this.tick().catch((e) => log.error('challenge-scheduler tick error', { error: e }));
    }, ChallengeSchedulerService.CHECK_INTERVAL_MS);

    log.service('ChallengeSchedulerService', 'started (10 min interval)');
  }

  stop(): void {
    if (this.interval) {
      clearInterval(this.interval);
      this.interval = null;
    }
    log.info('ChallengeSchedulerService stopped');
  }

  // ------------------------------------------------------------------
  // Main tick – called every 10 min
  // ------------------------------------------------------------------

  private async tick(): Promise<void> {
    if (!this.client) return;

    const configs = await db.client.challengeConfig.findMany();
    const now = new Date();

    for (const cfg of configs) {
      try {
        await this.processGuild(cfg, now);
      } catch (error) {
        log.error(`challenge-scheduler error for guild ${cfg.guildId}`, { error });
      }
    }
  }

  // ------------------------------------------------------------------
  // Process one guild
  // ------------------------------------------------------------------

  private async processGuild(cfg: any, now: Date): Promise<void> {
    if (!this.client) return;

    // ====== WEEKLY CHALLENGE ======
    if (cfg.autoAnnounceWeekly) {
      const currentWeek = getWeeklyBounds(now);
      const previousWeek = getWeeklyBounds(new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000));
      const prevPeriodStart = toDateStr(previousWeek.start);

      // --- Cloture de la semaine precedente ---
      // On cloture si :
      //   1. On est dans une nouvelle semaine (lundi)
      //   2. Et la derniere cloture est AVANT le debut de la semaine actuelle
      const lastWeeklyClosed = cfg.lastWeeklyClosedAt ? new Date(cfg.lastWeeklyClosedAt) : null;
      const needsWeeklyClose = !lastWeeklyClosed || lastWeeklyClosed < currentWeek.start;

      if (needsWeeklyClose) {
        // Verifier qu'il y avait un challenge la semaine derniere
        const hadPrevChallenge = await this.hadChallenge(cfg.guildId, 'weekly', prevPeriodStart);
        if (hadPrevChallenge) {
          log.info(`Cloture du challenge weekly pour guild ${cfg.guildId}`);
          await closeChallenge(this.client, cfg.guildId, 'weekly', cfg, prevPeriodStart, previousWeek);
          // Re-fetch config car closeChallenge a mis a jour les IDs
          const updatedCfg = await db.client.challengeConfig.findUnique({ where: { guildId: cfg.guildId } });
          if (updatedCfg) Object.assign(cfg, updatedCfg);
        } else {
          // Pas de challenge precedent, juste marquer comme cloture
          await db.client.challengeConfig.update({
            where: { guildId: cfg.guildId },
            data: { lastWeeklyClosedAt: new Date(), updatedAt: new Date() },
          });
        }

        // --- Annonce du nouveau challenge de cette semaine ---
        if (cfg.announceChannelId) {
          await announceNewChallenge(this.client, cfg.guildId, 'weekly', cfg.announceChannelId);
        }
      }
    }

    // ====== MONTHLY CHALLENGE ======
    if (cfg.autoAnnounceMonthly) {
      const currentMonth = getMonthlyBounds(now);
      const previousMonth = getMonthlyBounds(new Date(now.getFullYear(), now.getMonth() - 1, 15));
      const prevPeriodStart = toDateStr(previousMonth.start);

      const lastMonthlyClosed = cfg.lastMonthlyClosedAt ? new Date(cfg.lastMonthlyClosedAt) : null;
      const needsMonthlyClose = !lastMonthlyClosed || lastMonthlyClosed < currentMonth.start;

      if (needsMonthlyClose) {
        const hadPrevChallenge = await this.hadChallenge(cfg.guildId, 'monthly', prevPeriodStart);
        if (hadPrevChallenge) {
          log.info(`Cloture du challenge monthly pour guild ${cfg.guildId}`);
          await closeChallenge(this.client, cfg.guildId, 'monthly', cfg, prevPeriodStart, previousMonth);
          const updatedCfg = await db.client.challengeConfig.findUnique({ where: { guildId: cfg.guildId } });
          if (updatedCfg) Object.assign(cfg, updatedCfg);
        } else {
          await db.client.challengeConfig.update({
            where: { guildId: cfg.guildId },
            data: { lastMonthlyClosedAt: new Date(), updatedAt: new Date() },
          });
        }

        if (cfg.announceChannelId) {
          await announceNewChallenge(this.client, cfg.guildId, 'monthly', cfg.announceChannelId);
        }
      }
    }
  }

  // ------------------------------------------------------------------
  // Check if there was a challenge (plan or config) for a given period
  // ------------------------------------------------------------------

  private async hadChallenge(guildId: string, type: string, periodStart: string): Promise<boolean> {
    // Check if there's a plan
    const plan = await db.client.challengePlan.findFirst({
      where: { guildId, type: type as ChallengeType, periodStart: new Date(periodStart + 'T00:00:00Z') },
    });
    if (plan) return true;

    // Check config fallback
    const config = await db.client.challengeConfig.findUnique({ where: { guildId } });
    const title = type === 'weekly' ? config?.weeklyTitle : config?.monthlyTitle;
    return !!title;
  }
}

// Singleton
export const challengeScheduler = new ChallengeSchedulerService();
