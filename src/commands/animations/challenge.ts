import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

/**
 * Calcule les bornes de la semaine en cours (lundi -> dimanche)
 */
function getWeeklyBounds(now = new Date()) {
  const date = new Date(now);
  const day = (date.getDay() + 6) % 7;
  const monday = new Date(date);
  monday.setDate(date.getDate() - day);
  monday.setHours(0, 0, 0, 0);
  const sunday = new Date(monday);
  sunday.setDate(monday.getDate() + 6);
  sunday.setHours(23, 59, 59, 999);
  return { start: monday, end: sunday };
}

/**
 * Calcule les bornes du mois en cours
 */
function getMonthlyBounds(now = new Date()) {
  const date = new Date(now.getFullYear(), now.getMonth(), 1);
  date.setHours(0, 0, 0, 0);
  const nextMonth = new Date(date.getFullYear(), date.getMonth() + 1, 1);
  nextMonth.setMilliseconds(-1);
  return { start: date, end: nextMonth };
}

/**
 * Retourne les bornes selon le type de challenge
 */
function getBoundsForType(type: string) {
  return type === 'weekly' ? getWeeklyBounds() : getMonthlyBounds();
}

/**
 * Formate une date pour MySQL (YYYY-MM-DD)
 */
function toMysqlDate(d: Date): string {
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${day}`;
}

/**
 * Récupère la configuration du challenge pour un serveur
 */
async function getConfig(guildId: string) {
  const config = await db.client.challengeConfig.findUnique({
    where: { guildId },
  });
  return config || { weeklyTitle: null, monthlyTitle: null };
}

/**
 * Affiche les informations du challenge en cours
 */
async function handleInfo(interaction: ChatInputCommandInteraction, guildId: string, type: string) {
  await interaction.deferReply();
  const config = await getConfig(guildId);
  const { start, end } = getBoundsForType(type);
  const title = type === 'weekly' ? config.weeklyTitle : config.monthlyTitle;

  const embed = new EmbedBuilder()
    .setColor(0x0099ff)
    .setTitle(type === 'weekly' ? '🏁 Challenge Hebdomadaire' : '🏆 Challenge Mensuel')
    .addFields(
      { name: 'Intitulé', value: title || 'Non configuré', inline: false },
      {
        name: 'Période',
        value: `Du <t:${Math.floor(start.getTime() / 1000)}:D> au <t:${Math.floor(end.getTime() / 1000)}:D>`,
        inline: false,
      }
    )
    .setTimestamp();

  if (!title) {
    embed.setDescription("Configure l'intitulé sur le Dashboard.");
  }

  await interaction.editReply({ embeds: [embed] });
}

/**
 * Soumet une participation au challenge
 */
async function handleSubmit(
  interaction: ChatInputCommandInteraction,
  guildId: string,
  type: string,
  note: string | null
) {
  await interaction.deferReply({ ephemeral: true });
  const config = await getConfig(guildId);
  const title = type === 'weekly' ? config.weeklyTitle : config.monthlyTitle;
  if (!title) {
    await interaction.editReply({ content: "Le challenge n'est pas configuré pour ce serveur." });
    return;
  }

  const { start, end } = getBoundsForType(type);
  const userId = interaction.user.id;
  const metadata = JSON.stringify({ note });

  try {
    await db.client.challengeSubmission.create({
      data: {
        guildId,
        userDiscordId: userId,
        type: type as 'weekly' | 'monthly',
        periodStart: toMysqlDate(start),
        periodEnd: toMysqlDate(end),
        submittedAt: new Date(),
        metadata,
      },
    });
  } catch (e: any) {
    if (e.code === 'P2002') {
      await interaction.editReply({ content: 'Tu as déjà participé pour cette période.' });
      return;
    }
    throw e;
  }

  await interaction.editReply({ content: 'Participation enregistrée ✅' });
}

/**
 * Affiche le classement du challenge
 */
async function handleLeaderboard(interaction: ChatInputCommandInteraction, guildId: string, type: string) {
  await interaction.deferReply();
  const { start } = getBoundsForType(type);

  const rows = await db.client.$queryRaw<
    Array<{
      discord_id: string;
      username: string | null;
      submissions: bigint;
      votes: bigint | null;
    }>
  >`
    SELECT cs.user_discord_id as discord_id, du.username,
           COUNT(*) as submissions,
           COALESCE(v.votes, 0) as votes
    FROM challenge_submissions cs
    LEFT JOIN discord_users du ON du.discord_id = cs.user_discord_id
    LEFT JOIN (
       SELECT target_user_discord_id, COUNT(*) as votes
       FROM challenge_votes
       WHERE guild_id = ${guildId} AND type = ${type} AND period_start = ${toMysqlDate(start)}
       GROUP BY target_user_discord_id
    ) v ON v.target_user_discord_id = cs.user_discord_id
    WHERE cs.guild_id = ${guildId} AND cs.type = ${type} AND cs.period_start = ${toMysqlDate(start)}
    GROUP BY cs.user_discord_id, du.username, v.votes
    ORDER BY votes DESC, submissions DESC, MIN(cs.submitted_at) ASC
    LIMIT 25
  `;

  const embed = new EmbedBuilder()
    .setColor(0x00ae86)
    .setTitle(type === 'weekly' ? 'Classement Hebdo' : 'Classement Mensuel')
    .setDescription(rows.length === 0 ? 'Aucun participant pour le moment.' : '')
    .setTimestamp();

  if (rows.length > 0) {
    const lines = rows.map((r: any, idx: number) => {
      const votes = Number(r.votes || 0);
      const submissions = Number(r.submissions);
      return `${idx + 1}. ${r.username || r.discord_id} — ⭐ ${votes} vote${votes !== 1 ? 's' : ''} — ${submissions} participation${submissions > 1 ? 's' : ''}`;
    });
    embed.addFields({ name: 'Participants', value: lines.join('\n') });
  }

  await interaction.editReply({ embeds: [embed] });
}

/**
 * Vote pour un participant du challenge
 */
async function handleVote(
  interaction: ChatInputCommandInteraction,
  guildId: string,
  type: string,
  targetUserId: string
) {
  await interaction.deferReply({ ephemeral: true });
  const voterId = interaction.user.id;

  if (voterId === targetUserId) {
    await interaction.editReply({ content: 'Tu ne peux pas voter pour toi-même.' });
    return;
  }

  const { start } = getBoundsForType(type);

  // Vérifier que le participant a bien soumis une participation
  const hasSubmission = await db.client.challengeSubmission.findFirst({
    where: {
      guildId,
      type: type as 'weekly' | 'monthly',
      periodStart: toMysqlDate(start),
      userDiscordId: targetUserId,
    },
  });

  if (!hasSubmission) {
    await interaction.editReply({ content: "Ce participant n'a pas encore soumis de participation." });
    return;
  }

  try {
    await db.client.challengeVote.create({
      data: {
        guildId,
        type: type as 'weekly' | 'monthly',
        periodStart: toMysqlDate(start),
        voterDiscordId: voterId,
        targetUserDiscordId: targetUserId,
        votedAt: new Date(),
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
  } catch (e: any) {
    if (e.code === 'P2002') {
      await interaction.editReply({ content: 'Tu as déjà voté pour cette période.' });
      return;
    }
    throw e;
  }

  await interaction.editReply({ content: 'Ton vote a été pris en compte ✅' });
}

export default {
  data: new SlashCommandBuilder()
    .setName('challenge')
    .setDescription('Challenges hebdo et mensuels')
    .addSubcommand((sub) =>
      sub
        .setName('info')
        .setDescription('Afficher le challenge en cours')
        .addStringOption((o) =>
          o
            .setName('type')
            .setDescription('Type de challenge')
            .setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' }
            )
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('submit')
        .setDescription('Participer au challenge en cours')
        .addStringOption((o) =>
          o
            .setName('type')
            .setDescription('Type de challenge')
            .setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' }
            )
        )
        .addStringOption((o) => o.setName('note').setDescription('Lien ou description courte').setRequired(false))
    )
    .addSubcommand((sub) =>
      sub
        .setName('leaderboard')
        .setDescription('Classement des participants du challenge')
        .addStringOption((o) =>
          o
            .setName('type')
            .setDescription('Type de challenge')
            .setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' }
            )
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('vote')
        .setDescription('Voter pour un participant du challenge en cours')
        .addStringOption((o) =>
          o
            .setName('type')
            .setDescription('Type de challenge')
            .setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' }
            )
        )
        .addUserOption((o) => o.setName('participant').setDescription('Utilisateur pour lequel voter').setRequired(true))
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guildId) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const sub = interaction.options.getSubcommand();
    const type = interaction.options.getString('type', true);
    const guildId = interaction.guildId;

    try {
      if (sub === 'info') {
        await handleInfo(interaction, guildId, type);
      } else if (sub === 'submit') {
        const note = interaction.options.getString('note') || null;
        await handleSubmit(interaction, guildId, type, note);
      } else if (sub === 'leaderboard') {
        await handleLeaderboard(interaction, guildId, type);
      } else if (sub === 'vote') {
        const target = interaction.options.getUser('participant', true);
        await handleVote(interaction, guildId, type, target.id);
      }
    } catch (error) {
      log.error('challenge command error:', error);
      const embed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur')
        .setDescription('Une erreur est survenue lors du traitement de la commande.')
        .setTimestamp();

      if (interaction.deferred || interaction.replied) {
        await interaction.editReply({ embeds: [embed] });
      } else {
        await interaction.reply({ embeds: [embed], ephemeral: true });
      }
    }
  },
};
