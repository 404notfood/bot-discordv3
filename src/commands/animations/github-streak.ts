import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  ButtonBuilder,
  ButtonStyle,
  ActionRowBuilder,
} from 'discord.js';
import { externalApiService } from '../../services/external-apis';
import { db } from '../../services/database';
import { log } from '../../services/logger';

// -- Fonctions utilitaires pour le streak --

function getStreakColor(streak: number): number {
  if (streak === 0) return 0xff0000;
  if (streak < 7) return 0xffa500;
  if (streak < 30) return 0xffff00;
  if (streak < 100) return 0x00ff00;
  if (streak < 365) return 0x0099ff;
  return 0x9932cc;
}

function getStreakEmoji(streak: number): string {
  if (streak === 0) return '💔';
  if (streak < 7) return '🔥';
  if (streak < 30) return '🚀';
  if (streak < 100) return '⭐';
  if (streak < 365) return '💎';
  return '👑';
}

function getStreakLevel(streak: number): string {
  if (streak === 0) return '😴 Endormi';
  if (streak < 7) return '🌱 Débutant';
  if (streak < 30) return '🔥 Motivé';
  if (streak < 100) return '⭐ Régulier';
  if (streak < 365) return '💎 Expert';
  return '👑 Légendaire';
}

function getNextGoal(streak: number): string {
  if (streak < 7) return `${7 - streak} jours pour "Motivé"`;
  if (streak < 30) return `${30 - streak} jours pour "Régulier"`;
  if (streak < 100) return `${100 - streak} jours pour "Expert"`;
  if (streak < 365) return `${365 - streak} jours pour "Légendaire"`;
  return '🎉 Objectifs atteints !';
}

function getStreakRewards(streak: number): string[] {
  const rewards: string[] = [];
  if (streak >= 7) rewards.push('🎖️ Badge "Première semaine"');
  if (streak >= 30) rewards.push('🏅 Badge "Un mois de code"');
  if (streak >= 100) rewards.push('🏆 Badge "Centurion"');
  if (streak >= 365) rewards.push('👑 Badge "Code Master"');

  if (streak > 0 && streak % 50 === 0) {
    rewards.push(`✨ Milestone ${streak} jours !`);
  }

  return rewards;
}

function getStreakTips(streak: number): string {
  const tips = [
    '💡 Même un petit commit compte ! Une correction de typo maintient votre streak.',
    '📚 Contribuez à des projets open-source pour maintenir votre activité.',
    '🔄 Créez une routine quotidienne de code, même 15 minutes suffisent.',
    '📝 Tenez un journal de code pour documenter vos apprentissages quotidiens.',
    '🎯 Fixez-vous des micro-objectifs quotidiens réalisables.',
    '🤝 Collaborez avec d\'autres développeurs pour rester motivé.',
    '🛠️ Travaillez sur des side projects pendant les weekends.',
    '📖 Lisez du code et faites des améliorations mineures chaque jour.',
  ];

  if (streak === 0) {
    return "💪 Commencez dès aujourd'hui ! Votre premier commit vous attend.";
  }

  return tips[Math.floor(Math.random() * tips.length)];
}

function formatActivity(event: any): string {
  const date = new Date(event.created_at).toLocaleDateString('fr-FR');

  switch (event.type) {
    case 'PushEvent': {
      const commits = event.payload.commits || 1;
      const branch = event.payload.branch ? ` (${event.payload.branch})` : '';
      return `📝 ${commits} commit${commits > 1 ? 's' : ''} sur ${event.repo}${branch} (${date})`;
    }
    case 'IssuesEvent':
      return `🐛 ${event.payload.action} issue sur ${event.repo} (${date})`;
    case 'PullRequestEvent':
      return `🔀 ${event.payload.action} PR sur ${event.repo} (${date})`;
    case 'CreateEvent':
      return `✨ Créé ${event.payload.ref_type || 'repository'} ${event.repo} (${date})`;
    case 'ForkEvent':
      return `🍴 Fork de ${event.repo} (${date})`;
    default:
      return `${event.type.replace('Event', '')} sur ${event.repo} (${date})`;
  }
}

/**
 * Sauvegarde les statistiques de streak en base de données
 */
async function saveStreakStats(discordId: string, activity: any) {
  try {
    await db.client.$executeRaw`
      INSERT INTO github_streaks
      (discord_id, github_username, streak_days, last_commit_date, total_repos, followers, updated_at)
      VALUES (${discordId}, ${activity.user.login}, ${activity.streak}, NOW(), ${activity.user.publicRepos}, ${activity.user.followers}, NOW())
      ON CONFLICT (discord_id, github_username) DO UPDATE SET
      streak_days = EXCLUDED.streak_days,
      best_streak = GREATEST(github_streaks.best_streak, EXCLUDED.streak_days),
      last_commit_date = EXCLUDED.last_commit_date,
      total_repos = EXCLUDED.total_repos,
      followers = EXCLUDED.followers,
      updated_at = NOW()
    `;
  } catch (error) {
    log.error('Erreur sauvegarde streak:', error);
  }
}

/**
 * Affiche un message pour lier le compte GitHub
 */
async function showLinkAccountPrompt(interaction: ChatInputCommandInteraction, targetUser: any) {
  const embed = new EmbedBuilder()
    .setColor(0xffa500)
    .setTitle('🔗 Lier votre compte GitHub')
    .setDescription(
      `${targetUser === interaction.user ? "Vous n'avez" : `${targetUser.username} n'a`} pas de compte GitHub lié.\n\n` +
        'Pour utiliser cette fonctionnalité, utilisez la commande :\n' +
        '`/github-streak github_username:VotreUsername`\n\n' +
        'Ou liez votre compte permanent avec :\n' +
        '`/profile github VotreUsername`'
    )
    .addFields(
      { name: '📝 Exemple', value: '`/github-streak github_username:octocat`', inline: false },
      {
        name: '💡 Astuce',
        value: "Une fois lié, vous n'aurez plus besoin de préciser votre username !",
        inline: false,
      }
    )
    .setTimestamp();

  const row = new ActionRowBuilder<ButtonBuilder>().addComponents(
    new ButtonBuilder()
      .setLabel('Comment trouver mon username GitHub ?')
      .setStyle(ButtonStyle.Link)
      .setURL('https://docs.github.com/en/get-started/using-git/setting-your-username-in-git')
      .setEmoji('❓')
  );

  await interaction.editReply({ embeds: [embed], components: [row] });
}

// -- Medals pour le leaderboard --

const MEDALS = ['🥇', '🥈', '🥉'];

function getMedal(index: number): string {
  return MEDALS[index] || `**${index + 1}.**`;
}

// -- Leaderboard handler --

async function handleLeaderboard(interaction: ChatInputCommandInteraction): Promise<void> {
  await interaction.deferReply();

  try {
    const sortBy = interaction.options.getString('classement') || 'streak';

    const orderColumn = sortBy === 'best' ? 'best_streak' : 'streak_days';
    const title = sortBy === 'best' ? 'Meilleurs Streaks de tous les temps' : 'Streaks actuels';

    const rows = await db.client.$queryRaw<Array<{
      discord_id: string;
      github_username: string;
      streak_days: number;
      best_streak: number;
      total_repos: number;
      followers: number;
    }>>`
      SELECT discord_id, github_username, streak_days, best_streak, total_repos, followers
      FROM github_streaks
      WHERE streak_days > 0 OR best_streak > 0
      ORDER BY ${sortBy === 'best' ? db.client.$queryRaw`best_streak` : db.client.$queryRaw`streak_days`} DESC
      LIMIT 15
    `.catch(() => []);

    // Fallback: si la requete dynamique echoue, on fait les deux variantes
    let leaderboard: Array<{
      discord_id: string;
      github_username: string;
      streak_days: number;
      best_streak: number;
      total_repos: number;
      followers: number;
    }>;

    if (sortBy === 'best') {
      leaderboard = await db.client.$queryRaw`
        SELECT discord_id, github_username, streak_days, best_streak, total_repos, followers
        FROM github_streaks
        WHERE best_streak > 0
        ORDER BY best_streak DESC, streak_days DESC
        LIMIT 15
      `;
    } else {
      leaderboard = await db.client.$queryRaw`
        SELECT discord_id, github_username, streak_days, best_streak, total_repos, followers
        FROM github_streaks
        WHERE streak_days > 0
        ORDER BY streak_days DESC, best_streak DESC
        LIMIT 15
      `;
    }

    if (leaderboard.length === 0) {
      const embed = new EmbedBuilder()
        .setColor(0xffa500)
        .setTitle('📊 Leaderboard GitHub Streak')
        .setDescription('Aucun streak enregistre pour le moment !\nUtilisez `/github-streak` pour commencer a tracker votre activite.')
        .setTimestamp();

      await interaction.editReply({ embeds: [embed] });
      return;
    }

    const lines = leaderboard.map((row, i) => {
      const medal = getMedal(i);
      const emoji = getStreakEmoji(row.streak_days);
      const level = getStreakLevel(row.streak_days);
      const displayStreak = sortBy === 'best' ? row.best_streak : row.streak_days;
      const secondaryStat = sortBy === 'best'
        ? `(actuel: ${row.streak_days}j)`
        : row.best_streak > row.streak_days ? `(record: ${row.best_streak}j)` : '';

      return `${medal} ${emoji} **${row.github_username}** — **${displayStreak}** jours ${secondaryStat}\n` +
        `> <@${row.discord_id}> | ${row.total_repos} repos | ${row.followers} followers | ${level}`;
    });

    const embed = new EmbedBuilder()
      .setColor(0x00ff00)
      .setTitle(`🏆 Leaderboard — ${title}`)
      .setDescription(lines.join('\n\n'))
      .setTimestamp()
      .setFooter({ text: `Top ${leaderboard.length} | Utilisez /github-streak pour mettre a jour votre streak` });

    // Boutons pour switcher entre les classements
    const row = new ActionRowBuilder<ButtonBuilder>().addComponents(
      new ButtonBuilder()
        .setCustomId('leaderboard_streak')
        .setLabel('Streak actuel')
        .setStyle(sortBy === 'streak' ? ButtonStyle.Primary : ButtonStyle.Secondary)
        .setEmoji('🔥'),
      new ButtonBuilder()
        .setCustomId('leaderboard_best')
        .setLabel('Meilleur streak')
        .setStyle(sortBy === 'best' ? ButtonStyle.Primary : ButtonStyle.Secondary)
        .setEmoji('👑')
    );

    await interaction.editReply({ embeds: [embed], components: [row] });
  } catch (error) {
    log.error('Erreur leaderboard github-streak:', error);

    const errorEmbed = new EmbedBuilder()
      .setColor(0xff0000)
      .setTitle('❌ Erreur')
      .setDescription('Impossible de recuperer le classement.')
      .setTimestamp();

    await interaction.editReply({ embeds: [errorEmbed] });
  }
}

export default {
  data: new SlashCommandBuilder()
    .setName('github-streak')
    .setDescription('Voir votre streak de commits GitHub')
    .addSubcommand((sub) =>
      sub
        .setName('voir')
        .setDescription('Voir le streak d\'un utilisateur')
        .addUserOption((option) =>
          option.setName('utilisateur').setDescription('Utilisateur a verifier (optionnel)').setRequired(false)
        )
        .addStringOption((option) =>
          option
            .setName('github_username')
            .setDescription('Nom d\'utilisateur GitHub (si different du Discord)')
            .setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('leaderboard')
        .setDescription('Classement des streaks GitHub du serveur')
        .addStringOption((option) =>
          option
            .setName('classement')
            .setDescription('Type de classement')
            .setRequired(false)
            .addChoices(
              { name: '🔥 Streak actuel', value: 'streak' },
              { name: '👑 Meilleur streak', value: 'best' }
            )
        )
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const subcommand = interaction.options.getSubcommand();

    if (subcommand === 'leaderboard') {
      return handleLeaderboard(interaction);
    }

    // Sous-commande "voir"
    const targetUser = interaction.options.getUser('utilisateur') || interaction.user;
    const githubUsername = interaction.options.getString('github_username');

    await interaction.deferReply();

    try {
      let username = githubUsername;

      // Chercher le username GitHub en base si non fourni
      if (!username) {
        const userProfile = await db.client.$queryRaw<Array<{ github_username: string | null }>>`
          SELECT github_username FROM user_profiles WHERE discord_id = ${targetUser.id}
        `.then((r: any) => r[0]);

        if (userProfile?.github_username) {
          username = userProfile.github_username;
        } else {
          await showLinkAccountPrompt(interaction, targetUser);
          return;
        }
      }

      const activity = await externalApiService.getGitHubUserActivity(username!);

      if (!activity) {
        const embed = new EmbedBuilder()
          .setColor(0xff0000)
          .setTitle('❌ Utilisateur introuvable')
          .setDescription(`Impossible de trouver l'utilisateur GitHub "${username}"`)
          .setTimestamp();

        await interaction.editReply({ embeds: [embed] });
        return;
      }

      // Construire l'embed principal
      const embed = new EmbedBuilder()
        .setColor(getStreakColor(activity.streak))
        .setTitle(`${getStreakEmoji(activity.streak)} GitHub Streak de ${activity.user.name || activity.user.login}`)
        .setDescription(`**${activity.streak} jours** de commits consécutifs !`)
        .addFields(
          {
            name: '👤 Utilisateur GitHub',
            value: `[${activity.user.login}](https://github.com/${activity.user.login})`,
            inline: true,
          },
          { name: '📊 Repos publics', value: activity.user.publicRepos.toString(), inline: true },
          { name: '👥 Followers', value: activity.user.followers.toString(), inline: true },
          { name: '🔥 Streak actuel', value: `**${activity.streak}** jours`, inline: true },
          { name: '🏆 Niveau', value: getStreakLevel(activity.streak), inline: true },
          { name: '🎯 Prochain objectif', value: getNextGoal(activity.streak), inline: true }
        )
        .setThumbnail(activity.user.avatar)
        .setTimestamp()
        .setFooter({ text: 'GitHub Activity Tracker' });

      // Ajouter les récompenses débloquées
      const rewards = getStreakRewards(activity.streak);
      if (rewards.length > 0) {
        embed.addFields({
          name: '🎁 Récompenses débloquées',
          value: rewards.join('\n'),
          inline: false,
        });
      }

      // Ajouter l'activité récente
      if (activity.recentActivity.length > 0) {
        const recentActivities = activity.recentActivity
          .slice(0, 5)
          .map((event: any) => `• ${formatActivity(event)}`)
          .join('\n');

        embed.addFields({
          name: '📈 Activité récente',
          value: recentActivities,
          inline: false,
        });
      }

      // Conseil du jour
      const tips = getStreakTips(activity.streak);
      embed.addFields({
        name: '💡 Conseil du jour',
        value: tips,
        inline: false,
      });

      // Boutons d'action
      const row = new ActionRowBuilder<ButtonBuilder>().addComponents(
        new ButtonBuilder()
          .setLabel('Voir le profil GitHub')
          .setStyle(ButtonStyle.Link)
          .setURL(`https://github.com/${activity.user.login}`)
          .setEmoji('🔗'),
        new ButtonBuilder()
          .setCustomId('refresh_streak')
          .setLabel('Actualiser')
          .setStyle(ButtonStyle.Secondary)
          .setEmoji('🔄')
      );

      // Sauvegarder les stats
      await saveStreakStats(targetUser.id, activity);

      await interaction.editReply({ embeds: [embed], components: [row] });
    } catch (error) {
      log.error('❌ Erreur github-streak:', error);

      const errorEmbed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur')
        .setDescription('Impossible de récupérer les données GitHub.')
        .setTimestamp();

      await interaction.editReply({ embeds: [errorEmbed] });
    }
  },
};
