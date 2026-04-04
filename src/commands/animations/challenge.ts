import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
} from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';
import { PermissionsManager } from '../../services/permissions';

// ---------------------------------------------------------------------------
// Utilitaires dates
// ---------------------------------------------------------------------------

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

function getMonthlyBounds(now = new Date()) {
  const date = new Date(now.getFullYear(), now.getMonth(), 1);
  date.setHours(0, 0, 0, 0);
  const nextMonth = new Date(date.getFullYear(), date.getMonth() + 1, 1);
  nextMonth.setMilliseconds(-1);
  return { start: date, end: nextMonth };
}

/** Retourne le lundi de la semaine N (1-5) du mois donné */
function getWeekNBounds(year: number, month: number, weekNum: number) {
  const firstDay = new Date(year, month, 1);
  // Trouver le premier lundi du mois
  const firstDayOfWeek = firstDay.getDay();
  const daysUntilMonday = firstDayOfWeek === 0 ? 1 : (firstDayOfWeek === 1 ? 0 : 8 - firstDayOfWeek);
  const firstMonday = new Date(year, month, 1 + daysUntilMonday);

  const monday = new Date(firstMonday);
  monday.setDate(firstMonday.getDate() + (weekNum - 1) * 7);
  monday.setHours(0, 0, 0, 0);

  const sunday = new Date(monday);
  sunday.setDate(monday.getDate() + 6);
  sunday.setHours(23, 59, 59, 999);

  return { start: monday, end: sunday };
}

function getBoundsForType(type: string) {
  return type === 'weekly' ? getWeeklyBounds() : getMonthlyBounds();
}

/** Retourne une string YYYY-MM-DD (pour les raw queries) */
function toDateStr(d: Date): string {
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${day}`;
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

/** Retourne le channelId specifique au type, ou le fallback general */
function getChannelForType(cfg: any, type: string): string | null {
  if (type === 'weekly') return cfg.weeklyChannelId || cfg.announceChannelId || null;
  return cfg.monthlyChannelId || cfg.announceChannelId || null;
}

// ---------------------------------------------------------------------------
// Recuperer le challenge actif (plan > config fallback)
// ---------------------------------------------------------------------------

async function getActiveChallenge(guildId: string, type: string): Promise<{
  title: string | null;
  description: string | null;
  start: Date;
  end: Date;
  source: 'plan' | 'config' | 'none';
}> {
  const { start, end } = getBoundsForType(type);

  // Chercher d'abord dans les plans
  const plan = await (db.client as any).challengePlan.findFirst({
    where: {
      guildId,
      type: type as any,
      periodStart: toDateOnly(start),
    },
  });

  if (plan) {
    return {
      title: plan.title,
      description: plan.description,
      start,
      end,
      source: 'plan',
    };
  }

  // Fallback sur la config globale
  const config = await db.client.challengeConfig.findUnique({ where: { guildId } });
  const title = type === 'weekly' ? config?.weeklyTitle : config?.monthlyTitle;

  return {
    title: title || null,
    description: null,
    start,
    end,
    source: title ? 'config' : 'none',
  };
}

// ---------------------------------------------------------------------------
// Planifier (admin) - planifier les challenges a l'avance
// ---------------------------------------------------------------------------

async function handlePlanifier(interaction: ChatInputCommandInteraction) {
  if (!(await PermissionsManager.requireAdmin(interaction))) return;

  const guildId = interaction.guildId!;
  const type = interaction.options.getString('type', true);
  const titre = interaction.options.getString('titre', true);
  const description = interaction.options.getString('description');
  const semaine = interaction.options.getInteger('semaine');
  const moisOffset = interaction.options.getInteger('mois') || 0;

  await interaction.deferReply({ ephemeral: true });

  try {
    let start: Date;
    let end: Date;

    if (type === 'weekly' && semaine) {
      // Semaine specifique du mois
      const now = new Date();
      const targetMonth = now.getMonth() + moisOffset;
      const targetYear = now.getFullYear() + Math.floor(targetMonth / 12);
      const normalizedMonth = ((targetMonth % 12) + 12) % 12;
      const bounds = getWeekNBounds(targetYear, normalizedMonth, semaine);
      start = bounds.start;
      end = bounds.end;
    } else if (type === 'monthly') {
      const now = new Date();
      const targetMonth = now.getMonth() + (moisOffset || 1);
      const targetYear = now.getFullYear() + Math.floor(targetMonth / 12);
      const normalizedMonth = ((targetMonth % 12) + 12) % 12;
      start = new Date(targetYear, normalizedMonth, 1);
      start.setHours(0, 0, 0, 0);
      end = new Date(targetYear, normalizedMonth + 1, 0);
      end.setHours(23, 59, 59, 999);
    } else {
      // Semaine prochaine par defaut
      const now = new Date();
      const nextWeek = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000);
      const bounds = getWeeklyBounds(nextWeek);
      start = bounds.start;
      end = bounds.end;
    }

    await (db.client as any).challengePlan.upsert({
      where: {
        guildId_type_periodStart: {
          guildId,
          type: type as any,
          periodStart: toDateOnly(start),
        },
      },
      update: {
        title: titre,
        description,
        periodEnd: toDateOnly(end),
        updatedAt: new Date(),
      },
      create: {
        guildId,
        type: type as any,
        title: titre,
        description,
        periodStart: toDateOnly(start),
        periodEnd: toDateOnly(end),
        createdBy: interaction.user.id,
      },
    });

    const embed = new EmbedBuilder()
      .setColor(0x00ff00)
      .setTitle(`📅 Challenge planifie !`)
      .addFields(
        { name: 'Type', value: `${typeEmoji(type)} ${typeLabel(type)}`, inline: true },
        { name: 'Intitule', value: titre, inline: false },
        ...(description ? [{ name: 'Description', value: description, inline: false }] : []),
        {
          name: 'Periode',
          value: `Du <t:${Math.floor(start.getTime() / 1000)}:D> au <t:${Math.floor(end.getTime() / 1000)}:D>`,
          inline: false,
        },
      )
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
  } catch (error) {
    log.error('challenge planifier error:', error);
    await interaction.editReply({ content: 'Erreur lors de la planification.' });
  }
}

// ---------------------------------------------------------------------------
// Planning (voir les challenges planifies)
// ---------------------------------------------------------------------------

async function handlePlanning(interaction: ChatInputCommandInteraction) {
  const guildId = interaction.guildId!;

  await interaction.deferReply();

  const now = new Date();
  const plans = await (db.client as any).challengePlan.findMany({
    where: {
      guildId,
      periodEnd: { gte: toDateOnly(now) },
    },
    orderBy: { periodStart: 'asc' },
    take: 20,
  });

  const embed = new EmbedBuilder()
    .setColor(0x0099ff)
    .setTitle('📅 Planning des challenges')
    .setTimestamp();

  if (plans.length === 0) {
    embed.setDescription('Aucun challenge planifie.\nUn admin peut utiliser `/challenge planifier` pour en creer.');
  } else {
    const lines = plans.map((p: any) => {
      const startTs = Math.floor(new Date(p.periodStart).getTime() / 1000);
      const endTs = Math.floor(new Date(p.periodEnd).getTime() / 1000);
      const isNow = new Date(p.periodStart) <= now && new Date(p.periodEnd) >= now;
      const status = isNow ? '🟢 En cours' : '⏳ A venir';

      return `${typeEmoji(p.type)} **${p.title}**\n> ${status} | <t:${startTs}:D> → <t:${endTs}:D>${p.description ? `\n> 📝 ${p.description}` : ''}`;
    });

    embed.setDescription(lines.join('\n\n'));
  }

  await interaction.editReply({ embeds: [embed] });
}

// ---------------------------------------------------------------------------
// Config (admin) - config globale rapide
// ---------------------------------------------------------------------------

async function handleConfig(interaction: ChatInputCommandInteraction) {
  if (!(await PermissionsManager.requireAdmin(interaction))) return;

  const guildId = interaction.guildId!;
  const type = interaction.options.getString('type', true);
  const titre = interaction.options.getString('titre', true);
  const channel = interaction.options.getChannel('salon');

  await interaction.deferReply({ ephemeral: true });

  try {
    const updateData: Record<string, any> = { updatedAt: new Date() };
    const createData: Record<string, any> = { guildId };

    if (type === 'weekly') {
      updateData.weeklyTitle = titre;
      createData.weeklyTitle = titre;
    } else {
      updateData.monthlyTitle = titre;
      createData.monthlyTitle = titre;
    }

    if (channel) {
      if (type === 'weekly') {
        updateData.weeklyChannelId = channel.id;
        createData.weeklyChannelId = channel.id;
      } else {
        updateData.monthlyChannelId = channel.id;
        createData.monthlyChannelId = channel.id;
      }
    }

    await db.client.challengeConfig.upsert({
      where: { guildId },
      update: updateData,
      create: createData as any,
    });

    // Creer aussi un plan pour la periode en cours
    const { start, end } = getBoundsForType(type);
    await (db.client as any).challengePlan.upsert({
      where: {
        guildId_type_periodStart: {
          guildId,
          type: type as any,
          periodStart: toDateOnly(start),
        },
      },
      update: { title: titre, updatedAt: new Date() },
      create: {
        guildId,
        type: type as any,
        title: titre,
        periodStart: toDateOnly(start),
        periodEnd: toDateOnly(end),
        createdBy: interaction.user.id,
      },
    });

    const embed = new EmbedBuilder()
      .setColor(0x00ff00)
      .setTitle(`${typeEmoji(type)} Challenge ${typeLabel(type)} configure`)
      .addFields(
        { name: 'Intitule', value: titre, inline: false },
        ...(channel ? [{ name: `Salon ${typeLabel(type).toLowerCase()}`, value: `<#${channel.id}>`, inline: true }] : []),
      )
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
  } catch (error) {
    log.error('challenge config error:', error);
    await interaction.editReply({ content: 'Erreur lors de la configuration.' });
  }
}

// ---------------------------------------------------------------------------
// Info
// ---------------------------------------------------------------------------

async function handleInfo(interaction: ChatInputCommandInteraction) {
  const guildId = interaction.guildId!;
  const type = interaction.options.getString('type', true);

  await interaction.deferReply();

  const challenge = await getActiveChallenge(guildId, type);

  const participantCount = await db.client.challengeSubmission.count({
    where: { guildId, type: type as any, periodStart: toDateOnly(challenge.start) },
  });

  const embed = new EmbedBuilder()
    .setColor(challenge.title ? 0x0099ff : 0xffa500)
    .setTitle(`${typeEmoji(type)} Challenge ${typeLabel(type)}`)
    .addFields(
      { name: 'Intitule', value: challenge.title || 'Aucun challenge configure', inline: false },
      ...(challenge.description ? [{ name: 'Description', value: challenge.description, inline: false }] : []),
      {
        name: 'Periode',
        value: `Du <t:${Math.floor(challenge.start.getTime() / 1000)}:D> au <t:${Math.floor(challenge.end.getTime() / 1000)}:D>`,
        inline: true,
      },
      { name: 'Participants', value: `${participantCount}`, inline: true },
    )
    .setTimestamp();

  if (challenge.title) {
    embed.setDescription(
      '**Comment participer ?**\n' +
      '`/challenge submit` avec le lien de votre repo GitHub\n\n' +
      '**Comment voter ?**\n' +
      '`/challenge vote` puis le numero du participant'
    );
  } else {
    embed.setDescription('Un admin peut configurer le challenge avec `/challenge config` ou `/challenge planifier`.');
  }

  await interaction.editReply({ embeds: [embed] });
}

// ---------------------------------------------------------------------------
// Submit
// ---------------------------------------------------------------------------

async function handleSubmit(interaction: ChatInputCommandInteraction) {
  const guildId = interaction.guildId!;
  const type = interaction.options.getString('type', true);
  const githubUrl = interaction.options.getString('github_url', true).trim();
  const description = interaction.options.getString('description');

  await interaction.deferReply();

  const challenge = await getActiveChallenge(guildId, type);

  if (!challenge.title) {
    await interaction.editReply({ content: 'Aucun challenge n\'est configure pour cette periode.' });
    return;
  }

  const githubRegex = /^https?:\/\/(www\.)?github\.com\/[\w.-]+\/[\w.-]+/i;
  if (!githubRegex.test(githubUrl)) {
    await interaction.editReply({
      content: 'Le lien doit etre un lien GitHub valide (ex: `https://github.com/user/repo`).',
    });
    return;
  }

  const metadata = JSON.stringify({
    githubUrl,
    description: description || null,
  });

  try {
    await db.client.challengeSubmission.create({
      data: {
        guildId,
        userDiscordId: interaction.user.id,
        type: type as any,
        periodStart: toDateOnly(challenge.start),
        periodEnd: toDateOnly(challenge.end),
        submittedAt: new Date(),
        metadata,
      },
    });

    const embed = new EmbedBuilder()
      .setColor(0x00ff00)
      .setTitle(`${typeEmoji(type)} Participation enregistree !`)
      .setDescription(`**${interaction.user.username}** participe au challenge : **${challenge.title}**`)
      .addFields(
        { name: '🔗 Repo GitHub', value: `[Voir le projet](${githubUrl})`, inline: false },
        ...(description ? [{ name: '📝 Description', value: description, inline: false }] : []),
        { name: '💡 Astuce', value: 'Chaque commit sur ce repo compte aussi pour votre `/github-streak` !', inline: false },
      )
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
  } catch (e: any) {
    if (e.code === 'P2002') {
      await interaction.editReply({ content: 'Vous avez deja participe pour cette periode !' });
      return;
    }
    throw e;
  }
}

// ---------------------------------------------------------------------------
// Leaderboard
// ---------------------------------------------------------------------------

async function handleLeaderboard(interaction: ChatInputCommandInteraction) {
  const guildId = interaction.guildId!;
  const type = interaction.options.getString('type', true);

  await interaction.deferReply();

  const challenge = await getActiveChallenge(guildId, type);
  const periodStart = toDateStr(challenge.start);

  const rows = await db.client.$queryRaw<
    Array<{
      user_discord_id: string;
      metadata: string | null;
      submitted_at: Date;
      votes: bigint;
    }>
  >`
    SELECT cs.user_discord_id, cs.metadata::text, cs.submitted_at,
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
  `;

  const embed = new EmbedBuilder()
    .setColor(0x00ae86)
    .setTitle(`${typeEmoji(type)} Challenge ${typeLabel(type)} — Participants`)
    .setTimestamp();

  if (challenge.title) {
    embed.setDescription(`**${challenge.title}**\n\nPour voter : \`/challenge vote <numero>\``);
  }

  if (rows.length === 0) {
    embed.addFields({ name: 'Participants', value: 'Aucun participant pour le moment.\nUtilisez `/challenge submit` pour participer !', inline: false });
  } else {
    const medals = ['🥇', '🥈', '🥉'];
    const lines = rows.map((r, idx) => {
      const votes = Number(r.votes || 0);
      const medal = idx < 3 ? medals[idx] : `**${idx + 1}.**`;
      let meta: { githubUrl?: string; description?: string } = {};
      try { meta = r.metadata ? JSON.parse(r.metadata) : {}; } catch {}
      const githubLink = meta.githubUrl ? `[Repo](${meta.githubUrl})` : '';
      const desc = meta.description ? ` — ${meta.description}` : '';
      const voteText = votes > 0 ? ` — ⭐ ${votes} vote${votes > 1 ? 's' : ''}` : '';

      return `${medal} \`#${idx + 1}\` <@${r.user_discord_id}> ${githubLink}${desc}${voteText}`;
    });

    embed.addFields({ name: `Participants (${rows.length})`, value: lines.join('\n'), inline: false });
  }

  embed.setFooter({ text: 'Votez avec /challenge vote <numero>' });
  await interaction.editReply({ embeds: [embed] });
}

// ---------------------------------------------------------------------------
// Vote
// ---------------------------------------------------------------------------

async function handleVote(interaction: ChatInputCommandInteraction) {
  const guildId = interaction.guildId!;
  const type = interaction.options.getString('type', true);
  const number = interaction.options.getInteger('numero', true);

  await interaction.deferReply({ ephemeral: true });

  const voterId = interaction.user.id;
  const challenge = await getActiveChallenge(guildId, type);
  const periodStart = toDateStr(challenge.start);

  const participants = await db.client.$queryRaw<
    Array<{ user_discord_id: string }>
  >`
    SELECT cs.user_discord_id
    FROM challenge_submissions cs
    LEFT JOIN (
      SELECT target_user_discord_id, COUNT(*) as vote_count
      FROM challenge_votes
      WHERE guild_id = ${guildId} AND type = ${type} AND period_start = ${periodStart}::date
      GROUP BY target_user_discord_id
    ) v ON v.target_user_discord_id = cs.user_discord_id
    WHERE cs.guild_id = ${guildId} AND cs.type = ${type} AND cs.period_start = ${periodStart}::date
    ORDER BY COALESCE(v.vote_count, 0) DESC, cs.submitted_at ASC
  `;

  if (number < 1 || number > participants.length) {
    await interaction.editReply({
      content: `Numero invalide. Il y a ${participants.length} participant${participants.length > 1 ? 's' : ''}. Utilisez \`/challenge leaderboard\` pour voir la liste.`,
    });
    return;
  }

  const target = participants[number - 1];

  if (target.user_discord_id === voterId) {
    await interaction.editReply({ content: 'Vous ne pouvez pas voter pour vous-meme !' });
    return;
  }

  try {
    await db.client.challengeVote.create({
      data: {
        guildId,
        type: type as any,
        periodStart: toDateOnly(challenge.start),
        voterDiscordId: voterId,
        targetUserDiscordId: target.user_discord_id,
        votedAt: new Date(),
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });

    await interaction.editReply({
      content: `Vote enregistre pour le participant **#${number}** (<@${target.user_discord_id}>) !`,
    });
  } catch (e: any) {
    if (e.code === 'P2002') {
      await interaction.editReply({ content: 'Vous avez deja vote pour cette periode !' });
      return;
    }
    throw e;
  }
}

// ---------------------------------------------------------------------------
// Annonce (admin) – envoyer manuellement l'annonce du challenge
// ---------------------------------------------------------------------------

async function handleAnnonce(interaction: ChatInputCommandInteraction) {
  if (!(await PermissionsManager.requireAdmin(interaction))) return;

  const guildId = interaction.guildId!;
  const type = interaction.options.getString('type', true);
  const channelOverride = interaction.options.getChannel('salon');

  await interaction.deferReply({ flags: 64 });

  const challenge = await getActiveChallenge(guildId, type);

  if (!challenge.title) {
    await interaction.editReply({
      content: `Aucun challenge ${typeLabel(type).toLowerCase()} n'est configure pour cette periode.\nUtilisez \`/challenge config\` ou \`/challenge planifier\` d'abord.`,
    });
    return;
  }

  // Determiner le salon cible
  let targetChannelId = channelOverride?.id || null;

  if (!targetChannelId) {
    const cfg = await db.client.challengeConfig.findUnique({ where: { guildId } });
    if (cfg) {
      targetChannelId = getChannelForType(cfg, type);
    }
  }

  if (!targetChannelId) {
    await interaction.editReply({
      content: 'Aucun salon configure pour ce type de challenge.\nSpecifiez un salon avec l\'option `salon` ou configurez-le avec `/challenge config`.',
    });
    return;
  }

  const targetChannel = await interaction.client.channels.fetch(targetChannelId).catch(() => null);
  if (!targetChannel || !targetChannel.isTextBased()) {
    await interaction.editReply({ content: 'Salon introuvable ou inaccessible.' });
    return;
  }

  const startTs = Math.floor(challenge.start.getTime() / 1000);
  const endTs = Math.floor(challenge.end.getTime() / 1000);

  const participantCount = await db.client.challengeSubmission.count({
    where: { guildId, type: type as any, periodStart: toDateOnly(challenge.start) },
  });

  const embed = new EmbedBuilder()
    .setColor(type === 'weekly' ? 0x00ae86 : 0xffd700)
    .setTitle(`${typeEmoji(type)} Challenge ${typeLabel(type)}`)
    .setDescription(
      `**${challenge.title}**` +
      (challenge.description ? `\n\n${challenge.description}` : '')
    )
    .addFields(
      { name: '📅 Periode', value: `Du <t:${startTs}:D> au <t:${endTs}:D>`, inline: false },
      { name: '👥 Participants', value: `${participantCount}`, inline: true },
      { name: '🚀 Participer', value: '`/challenge submit`', inline: true },
      { name: '⭐ Voter', value: '`/challenge vote`', inline: true },
    )
    .setFooter({
      text: type === 'weekly'
        ? 'Le gagnant obtient le role Challenger !'
        : 'Le gagnant obtient le role Super-Challenger !',
    })
    .setTimestamp();

  await (targetChannel as any).send({ embeds: [embed] });

  await interaction.editReply({
    content: `Annonce du challenge ${typeLabel(type).toLowerCase()} envoyee dans <#${targetChannelId}> !`,
  });
}

// ---------------------------------------------------------------------------
// Roles (admin) – configurer les roles Challenger / Super-Challenger
// ---------------------------------------------------------------------------

async function handleRoles(interaction: ChatInputCommandInteraction) {
  if (!(await PermissionsManager.requireAdmin(interaction))) return;

  const guildId = interaction.guildId!;
  const challengerRole = interaction.options.getRole('challenger');
  const superChallengerRole = interaction.options.getRole('super_challenger');

  if (!challengerRole && !superChallengerRole) {
    await interaction.reply({
      content: 'Vous devez specifier au moins un role (challenger ou super_challenger).',
      ephemeral: true,
    });
    return;
  }

  await interaction.deferReply({ ephemeral: true });

  try {
    const updateData: Record<string, any> = { updatedAt: new Date() };
    const createData: Record<string, any> = { guildId };

    if (challengerRole) {
      updateData.challengerRoleId = challengerRole.id;
      createData.challengerRoleId = challengerRole.id;
    }
    if (superChallengerRole) {
      updateData.superChallengerRoleId = superChallengerRole.id;
      createData.superChallengerRoleId = superChallengerRole.id;
    }

    await db.client.challengeConfig.upsert({
      where: { guildId },
      update: updateData,
      create: createData as any,
    });

    const fields = [];
    if (challengerRole) {
      fields.push({ name: '🏁 Role Challenger (hebdo)', value: `<@&${challengerRole.id}>`, inline: true });
    }
    if (superChallengerRole) {
      fields.push({ name: '🏆 Role Super-Challenger (mensuel)', value: `<@&${superChallengerRole.id}>`, inline: true });
    }

    const embed = new EmbedBuilder()
      .setColor(0x00ff00)
      .setTitle('⚙️ Roles des challenges configures !')
      .setDescription(
        'Les roles seront automatiquement attribues au gagnant a la fin de chaque periode.\n' +
        '• **Challenger** → gagnant du challenge hebdomadaire\n' +
        '• **Super-Challenger** → gagnant du challenge mensuel\n\n' +
        'Si le meme joueur gagne a nouveau, il conserve le role. Sinon, le role est transfere au nouveau gagnant.'
      )
      .addFields(fields)
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
  } catch (error) {
    log.error('challenge roles error:', error);
    await interaction.editReply({ content: 'Erreur lors de la configuration des roles.' });
  }
}

// ---------------------------------------------------------------------------
// Export commande
// ---------------------------------------------------------------------------

export default {
  data: new SlashCommandBuilder()
    .setName('challenge')
    .setDescription('Challenges hebdomadaires et mensuels de code')
    .addSubcommand((sub) =>
      sub
        .setName('config')
        .setDescription('[Admin] Configurer le challenge de la periode en cours')
        .addStringOption((o) =>
          o.setName('type').setDescription('Type de challenge').setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' },
            )
        )
        .addStringOption((o) =>
          o.setName('titre').setDescription('Intitule du challenge').setRequired(true)
        )
        .addChannelOption((o) =>
          o.setName('salon').setDescription('Salon d\'annonce pour ce type de challenge').setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('planifier')
        .setDescription('[Admin] Planifier un challenge a l\'avance')
        .addStringOption((o) =>
          o.setName('type').setDescription('Type de challenge').setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' },
            )
        )
        .addStringOption((o) =>
          o.setName('titre').setDescription('Intitule du challenge').setRequired(true)
        )
        .addIntegerOption((o) =>
          o.setName('semaine').setDescription('Numero de la semaine dans le mois (1-5, uniquement pour hebdo)')
            .setRequired(false).setMinValue(1).setMaxValue(5)
        )
        .addIntegerOption((o) =>
          o.setName('mois').setDescription('Dans combien de mois ? (0 = ce mois, 1 = mois prochain...)')
            .setRequired(false).setMinValue(0).setMaxValue(6)
        )
        .addStringOption((o) =>
          o.setName('description').setDescription('Description detaillee du challenge').setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('planning')
        .setDescription('Voir tous les challenges planifies a venir')
    )
    .addSubcommand((sub) =>
      sub
        .setName('info')
        .setDescription('Voir le challenge en cours')
        .addStringOption((o) =>
          o.setName('type').setDescription('Type de challenge').setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' },
            )
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('submit')
        .setDescription('Participer au challenge avec un lien GitHub')
        .addStringOption((o) =>
          o.setName('type').setDescription('Type de challenge').setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' },
            )
        )
        .addStringOption((o) =>
          o.setName('github_url').setDescription('Lien vers votre repo GitHub').setRequired(true)
        )
        .addStringOption((o) =>
          o.setName('description').setDescription('Description courte de votre projet').setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('leaderboard')
        .setDescription('Classement et liste des participants')
        .addStringOption((o) =>
          o.setName('type').setDescription('Type de challenge').setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' },
            )
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('vote')
        .setDescription('Voter pour un participant (par numero)')
        .addStringOption((o) =>
          o.setName('type').setDescription('Type de challenge').setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' },
            )
        )
        .addIntegerOption((o) =>
          o.setName('numero').setDescription('Numero du participant (voir /challenge leaderboard)').setRequired(true)
            .setMinValue(1)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('annonce')
        .setDescription('[Admin] Envoyer l\'annonce du challenge en cours')
        .addStringOption((o) =>
          o.setName('type').setDescription('Type de challenge').setRequired(true)
            .addChoices(
              { name: 'Hebdomadaire', value: 'weekly' },
              { name: 'Mensuel', value: 'monthly' },
            )
        )
        .addChannelOption((o) =>
          o.setName('salon').setDescription('Salon cible (sinon utilise le salon configure)').setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('roles')
        .setDescription('[Admin] Configurer les roles Challenger et Super-Challenger')
        .addRoleOption((o) =>
          o.setName('challenger').setDescription('Role Challenger (gagnant hebdo)').setRequired(false)
        )
        .addRoleOption((o) =>
          o.setName('super_challenger').setDescription('Role Super-Challenger (gagnant mensuel)').setRequired(false)
        )
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guildId) {
      await interaction.reply({ content: 'Cette commande doit etre utilisee dans un serveur.', ephemeral: true });
      return;
    }

    const sub = interaction.options.getSubcommand();

    try {
      switch (sub) {
        case 'config': return await handleConfig(interaction);
        case 'planifier': return await handlePlanifier(interaction);
        case 'planning': return await handlePlanning(interaction);
        case 'info': return await handleInfo(interaction);
        case 'submit': return await handleSubmit(interaction);
        case 'leaderboard': return await handleLeaderboard(interaction);
        case 'vote': return await handleVote(interaction);
        case 'annonce': return await handleAnnonce(interaction);
        case 'roles': return await handleRoles(interaction);
      }
    } catch (error) {
      log.error('challenge command error:', error);
      const embed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur')
        .setDescription('Une erreur est survenue.')
        .setTimestamp();

      if (interaction.deferred || interaction.replied) {
        await interaction.editReply({ embeds: [embed] });
      } else {
        await interaction.reply({ embeds: [embed], ephemeral: true });
      }
    }
  },
};
