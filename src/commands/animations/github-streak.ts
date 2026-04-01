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
      const commits = event.payload.commits || 0;
      return `📝 ${commits} commit${commits > 1 ? 's' : ''} sur ${event.repo} (${date})`;
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
      ON DUPLICATE KEY UPDATE
      streak_days = VALUES(streak_days),
      last_commit_date = VALUES(last_commit_date),
      total_repos = VALUES(total_repos),
      followers = VALUES(followers),
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

export default {
  data: new SlashCommandBuilder()
    .setName('github-streak')
    .setDescription('Voir votre streak de commits GitHub')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur à vérifier (optionnel)').setRequired(false)
    )
    .addStringOption((option) =>
      option
        .setName('github_username')
        .setDescription("Nom d'utilisateur GitHub (si différent du Discord)")
        .setRequired(false)
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
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
