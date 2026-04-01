import { Client, EmbedBuilder, TextChannel } from 'discord.js';
import { db } from './database';
import { log } from './logger';
import { ChallengeType } from '../generated/prisma/client';

// ---------------------------------------------------------------------------
// Helpers
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

// ---------------------------------------------------------------------------
// Announce a challenge to a guild's channel
// ---------------------------------------------------------------------------

async function announce(
  client: Client,
  guildId: string,
  type: ChallengeType,
  cfg: any,
): Promise<void> {
  const channelId = String(cfg.announceChannelId || '');
  if (!channelId) return;

  const title = type === 'weekly' ? cfg.weeklyTitle : cfg.monthlyTitle;
  if (!title) return;

  const channel = (await client.channels
    .fetch(channelId)
    .catch(() => null)) as TextChannel | null;
  if (!channel) return;

  const { start, end } =
    type === 'weekly' ? getWeeklyBounds() : getMonthlyBounds();

  const embed = new EmbedBuilder()
    .setColor(0x00ae86)
    .setTitle(type === 'weekly' ? '🏁 Challenge Hebdomadaire' : '🏆 Challenge Mensuel')
    .setDescription(title)
    .addFields(
      {
        name: 'Periode',
        value: `Du <t:${Math.floor(start.getTime() / 1000)}:D> au <t:${Math.floor(end.getTime() / 1000)}:D>`,
      },
      { name: 'Participer', value: '`/challenge submit`' },
      { name: 'Classement', value: '`/challenge leaderboard`' },
    )
    .setTimestamp();

  await channel.send({ embeds: [embed] }).catch(() => null);
}

// ---------------------------------------------------------------------------
// Main cron entry point
// ---------------------------------------------------------------------------

export async function runChallengeAnnouncements(client: Client): Promise<void> {
  try {
    const configs = await db.client.challengeConfig.findMany();
    const now = new Date();
    const isMondayMorning = now.getDay() === 1 && now.getHours() === 9;
    const isFirstDayMorning = now.getDate() === 1 && now.getHours() === 9;

    for (const cfg of configs) {
      if (cfg.autoAnnounceWeekly && isMondayMorning) {
        await announce(client, cfg.guildId, 'weekly', cfg);
      }
      if (cfg.autoAnnounceMonthly && isFirstDayMorning) {
        await announce(client, cfg.guildId, 'monthly', cfg);
      }
    }
  } catch (e) {
    const err = e as Error;
    log.error('cron-challenges error', { error: err.message });
  }
}
