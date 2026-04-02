import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
} from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('profile')
    .setDescription('Gerer votre profil developpeur')
    .addSubcommand((sub) =>
      sub
        .setName('github')
        .setDescription('Lier votre compte GitHub')
        .addStringOption((option) =>
          option
            .setName('username')
            .setDescription('Votre nom d\'utilisateur GitHub')
            .setRequired(true)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('voir')
        .setDescription('Voir votre profil ou celui d\'un autre utilisateur')
        .addUserOption((option) =>
          option
            .setName('utilisateur')
            .setDescription('Utilisateur a consulter (optionnel)')
            .setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('supprimer')
        .setDescription('Supprimer le lien avec votre compte GitHub')
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const subcommand = interaction.options.getSubcommand();

    if (subcommand === 'github') {
      return handleLinkGithub(interaction);
    }

    if (subcommand === 'voir') {
      return handleViewProfile(interaction);
    }

    if (subcommand === 'supprimer') {
      return handleUnlinkGithub(interaction);
    }
  },
};

// ---------------------------------------------------------------------------
// Lier un compte GitHub
// ---------------------------------------------------------------------------

async function handleLinkGithub(interaction: ChatInputCommandInteraction): Promise<void> {
  const username = interaction.options.getString('username', true).trim();

  // Validation basique du username GitHub
  if (!/^[a-zA-Z0-9](?:[a-zA-Z0-9]|-(?=[a-zA-Z0-9])){0,38}$/.test(username)) {
    await interaction.reply({
      content: 'Ce nom d\'utilisateur GitHub n\'est pas valide.',
      ephemeral: true,
    });
    return;
  }

  await interaction.deferReply({ ephemeral: true });

  try {
    await db.client.userProfile.upsert({
      where: { discordId: interaction.user.id },
      update: {
        githubUsername: username,
        updatedAt: new Date(),
      },
      create: {
        discordId: interaction.user.id,
        username: interaction.user.username,
        githubUsername: username,
      },
    });

    const embed = new EmbedBuilder()
      .setColor(0x00ff00)
      .setTitle('✅ Compte GitHub lie !')
      .setDescription(
        `Votre compte GitHub **[${username}](https://github.com/${username})** a ete lie avec succes.\n\n` +
        'Vous pouvez maintenant utiliser `/github-streak voir` sans preciser votre username !'
      )
      .setThumbnail(`https://github.com/${username}.png`)
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });

    log.info(`GitHub lie: ${interaction.user.username} -> ${username}`);
  } catch (error) {
    log.error('Erreur liaison GitHub:', error);
    await interaction.editReply({
      content: 'Erreur lors de la liaison du compte GitHub.',
    });
  }
}

// ---------------------------------------------------------------------------
// Voir un profil
// ---------------------------------------------------------------------------

async function handleViewProfile(interaction: ChatInputCommandInteraction): Promise<void> {
  const targetUser = interaction.options.getUser('utilisateur') || interaction.user;

  await interaction.deferReply();

  try {
    const profile = await db.client.userProfile.findUnique({
      where: { discordId: targetUser.id },
    });

    if (!profile) {
      const embed = new EmbedBuilder()
        .setColor(0xffa500)
        .setTitle('📋 Profil introuvable')
        .setDescription(
          targetUser.id === interaction.user.id
            ? 'Vous n\'avez pas encore de profil.\nUtilisez `/profile github <username>` pour commencer !'
            : `${targetUser.username} n'a pas encore de profil.`
        )
        .setTimestamp();

      await interaction.editReply({ embeds: [embed] });
      return;
    }

    // Recuperer les stats de streak si GitHub est lie
    let streakInfo = '';
    if (profile.githubUsername) {
      const streak = await db.client.$queryRaw<Array<{
        streak_days: number;
        best_streak: number;
        total_repos: number;
        followers: number;
      }>>`
        SELECT streak_days, best_streak, total_repos, followers
        FROM github_streaks
        WHERE discord_id = ${targetUser.id}
        ORDER BY updated_at DESC
        LIMIT 1
      `.then((r: any) => r[0]).catch(() => null);

      if (streak) {
        streakInfo = `\n🔥 Streak: **${streak.streak_days}j** | Record: **${streak.best_streak}j**\n📊 ${streak.total_repos} repos | 👥 ${streak.followers} followers`;
      }
    }

    const embed = new EmbedBuilder()
      .setColor(0x0099ff)
      .setTitle(`📋 Profil de ${targetUser.username}`)
      .setThumbnail(targetUser.displayAvatarURL({ size: 256 }))
      .setTimestamp();

    const fields = [];

    if (profile.githubUsername) {
      fields.push({
        name: '🐙 GitHub',
        value: `[${profile.githubUsername}](https://github.com/${profile.githubUsername})${streakInfo}`,
        inline: false,
      });
    }

    if (profile.bio) {
      fields.push({ name: '📝 Bio', value: profile.bio, inline: false });
    }

    if (profile.location) {
      fields.push({ name: '📍 Localisation', value: profile.location, inline: true });
    }

    if (profile.websiteUrl) {
      fields.push({ name: '🌐 Site web', value: profile.websiteUrl, inline: true });
    }

    if (profile.linkedinUrl) {
      fields.push({ name: '💼 LinkedIn', value: profile.linkedinUrl, inline: true });
    }

    fields.push({ name: '⭐ Niveau', value: `Niveau ${profile.level} (${profile.totalXp} XP)`, inline: true });

    if (fields.length > 0) {
      embed.addFields(fields);
    }

    if (!profile.githubUsername && !profile.bio && !profile.location) {
      embed.setDescription('Profil vide pour le moment. Utilisez `/profile github <username>` pour lier votre GitHub !');
    }

    await interaction.editReply({ embeds: [embed] });
  } catch (error) {
    log.error('Erreur affichage profil:', error);
    await interaction.editReply({
      content: 'Erreur lors de la recuperation du profil.',
    });
  }
}

// ---------------------------------------------------------------------------
// Supprimer le lien GitHub
// ---------------------------------------------------------------------------

async function handleUnlinkGithub(interaction: ChatInputCommandInteraction): Promise<void> {
  await interaction.deferReply({ ephemeral: true });

  try {
    const profile = await db.client.userProfile.findUnique({
      where: { discordId: interaction.user.id },
    });

    if (!profile || !profile.githubUsername) {
      await interaction.editReply({
        content: 'Vous n\'avez pas de compte GitHub lie.',
      });
      return;
    }

    await db.client.userProfile.update({
      where: { discordId: interaction.user.id },
      data: {
        githubUsername: null,
        updatedAt: new Date(),
      },
    });

    const embed = new EmbedBuilder()
      .setColor(0xff0000)
      .setTitle('🔓 Compte GitHub delie')
      .setDescription('Votre compte GitHub a ete delie de votre profil.')
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });

    log.info(`GitHub delie: ${interaction.user.username}`);
  } catch (error) {
    log.error('Erreur suppression lien GitHub:', error);
    await interaction.editReply({
      content: 'Erreur lors de la suppression du lien.',
    });
  }
}
