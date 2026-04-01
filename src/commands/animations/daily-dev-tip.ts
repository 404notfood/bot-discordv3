import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { externalApiService, ExternalApiService } from '../../services/external-apis';
import { log } from '../../services/logger';

/**
 * Affiche un article Dev.to du jour
 */
async function handleDevToArticle(interaction: ChatInputCommandInteraction, apiService: ExternalApiService) {
  const article = await apiService.getDevToDailyTip();

  if (!article) {
    const embed = new EmbedBuilder()
      .setColor(0xffa500)
      .setTitle('⚠️ Service indisponible')
      .setDescription("Impossible de récupérer l'article Dev.to du jour.")
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
    return;
  }

  const embed = new EmbedBuilder()
    .setColor(0x0099ff)
    .setTitle('📚 Article Dev.to du jour')
    .setDescription(article.description || 'Aucune description disponible')
    .addFields(
      { name: '📰 Titre', value: `[${article.title}](${article.url})`, inline: false },
      { name: '👤 Auteur', value: article.author.name, inline: true },
      { name: '❤️ Réactions', value: article.positive_reactions_count.toString(), inline: true },
      {
        name: '🏷️ Tags',
        value: article.tags
          .slice(0, 5)
          .map((tag: string) => `\`${tag}\``)
          .join(' '),
        inline: false,
      }
    )
    .setTimestamp(new Date(article.published_at))
    .setFooter({ text: 'Dev.to • Article du jour' });

  if (article.cover_image) {
    embed.setThumbnail(article.cover_image);
  }

  if (article.author.profile_image) {
    embed.setAuthor({
      name: article.author.name,
      iconURL: article.author.profile_image,
      url: `https://dev.to/${article.author.username}`,
    });
  }

  await interaction.editReply({ embeds: [embed] });
}

/**
 * Affiche une question Stack Overflow du jour
 */
async function handleStackOverflowQuestion(interaction: ChatInputCommandInteraction, apiService: ExternalApiService) {
  const question = await apiService.getStackOverflowQuestionOfDay();

  if (!question) {
    const embed = new EmbedBuilder()
      .setColor(0xffa500)
      .setTitle('⚠️ Service indisponible')
      .setDescription('Impossible de récupérer la question Stack Overflow du jour.')
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
    return;
  }

  const embed = new EmbedBuilder()
    .setColor(0xf48024)
    .setTitle('❓ Question Stack Overflow du jour')
    .setDescription(question.body || 'Contenu non disponible')
    .addFields(
      { name: '📝 Question', value: `[${question.title}](${question.url})`, inline: false },
      { name: '👤 Auteur', value: question.owner.name, inline: true },
      { name: '🔺 Score', value: question.score.toString(), inline: true },
      { name: '💬 Réponses', value: question.answer_count.toString(), inline: true },
      { name: '👁️ Vues', value: question.view_count.toLocaleString(), inline: true },
      {
        name: '🏷️ Tags',
        value: question.tags
          .slice(0, 5)
          .map((tag: string) => `\`${tag}\``)
          .join(' '),
        inline: false,
      }
    )
    .setTimestamp(question.creation_date)
    .setFooter({ text: `Stack Overflow • Réputation: ${question.owner.reputation.toLocaleString()}` });

  await interaction.editReply({ embeds: [embed] });
}

/**
 * Affiche un repo GitHub trending du jour
 */
async function handleGitHubTrending(interaction: ChatInputCommandInteraction, apiService: ExternalApiService) {
  const trending = await apiService.getGitHubTrending('javascript', 'daily');

  if (!trending || trending.length === 0) {
    const embed = new EmbedBuilder()
      .setColor(0xffa500)
      .setTitle('⚠️ Service indisponible')
      .setDescription('Impossible de récupérer les repos GitHub trending.')
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
    return;
  }

  const repo = trending[0];

  const embed = new EmbedBuilder()
    .setColor(0x24292e)
    .setTitle('🌟 Repo GitHub Trending du jour')
    .setDescription(repo.description || 'Aucune description disponible')
    .addFields(
      { name: '📦 Repository', value: `[${repo.fullName}](${repo.url})`, inline: false },
      { name: '👤 Propriétaire', value: repo.owner.login, inline: true },
      { name: '⭐ Stars', value: repo.stars.toLocaleString(), inline: true },
      { name: '💻 Langage', value: repo.language || 'N/A', inline: true }
    )
    .setTimestamp()
    .setFooter({ text: 'GitHub • Trending Today' });

  if (repo.owner.avatar) {
    embed.setThumbnail(repo.owner.avatar);
  }

  await interaction.editReply({ embeds: [embed] });
}

/**
 * Affiche un récapitulatif complet (article + SO + trending)
 */
async function handleAllInOne(interaction: ChatInputCommandInteraction, apiService: ExternalApiService) {
  const newsData = await apiService.getTechNewsOfTheDay();

  const embed = new EmbedBuilder()
    .setColor(0x7289da)
    .setTitle('🌟 Tech News du Jour')
    .setDescription('Voici votre récapitulatif quotidien du monde du développement !')
    .setTimestamp()
    .setFooter({ text: 'Taureau Celtique Bot • Daily Tech News' });

  if (newsData.devTip) {
    embed.addFields({
      name: '📚 Article Dev.to',
      value:
        `**[${newsData.devTip.title}](${newsData.devTip.url})**\n` +
        `👤 ${newsData.devTip.author.name} • ❤️ ${newsData.devTip.positive_reactions_count}`,
      inline: false,
    });
  }

  if (newsData.stackOverflowQOD) {
    const so = newsData.stackOverflowQOD;
    embed.addFields({
      name: '❓ Stack Overflow Question',
      value:
        `**[${so.title}](${so.url})**\n` +
        `🔺 ${so.score} • 💬 ${so.answer_count} réponses • 👁️ ${so.view_count.toLocaleString()} vues`,
      inline: false,
    });
  }

  if (newsData.trendingRepo) {
    const repo = newsData.trendingRepo;
    embed.addFields({
      name: '🌟 GitHub Trending',
      value:
        `**[${repo.fullName}](${repo.url})**\n` +
        `⭐ ${repo.stars.toLocaleString()} stars • 💻 ${repo.language || 'N/A'}`,
      inline: false,
    });
  }

  // Message de motivation aléatoire
  const motivationMessages = [
    '💪 Continuez à coder et à apprendre !',
    '🚀 Chaque ligne de code vous rapproche de vos objectifs !',
    '🎯 Le développement est un voyage, pas une destination !',
    "💡 L'innovation naît de la curiosité et de la pratique !",
    '🌟 Votre code d\'aujourd\'hui est votre legacy de demain !',
  ];

  embed.addFields({
    name: '✨ Motivation du jour',
    value: motivationMessages[Math.floor(Math.random() * motivationMessages.length)],
    inline: false,
  });

  // Fallback si aucun service n'est disponible
  if (!newsData.devTip && !newsData.stackOverflowQOD && !newsData.trendingRepo) {
    embed.setDescription('⚠️ Services temporairement indisponibles. Réessayez plus tard !');
    embed.addFields({
      name: '💡 Conseil du jour',
      value:
        'En attendant, pourquoi ne pas réviser les bases ? ' +
        "Relisez votre code d'hier avec un œil critique ! 🔍",
      inline: false,
    });
  }

  await interaction.editReply({ embeds: [embed] });
}

export default {
  data: new SlashCommandBuilder()
    .setName('daily-dev-tip')
    .setDescription('Obtenir le conseil développement du jour')
    .addStringOption((option) =>
      option
        .setName('type')
        .setDescription('Type de conseil')
        .setRequired(false)
        .addChoices(
          { name: '💡 Conseil du jour', value: 'tip' },
          { name: '📚 Article Dev.to', value: 'article' },
          { name: '❓ Question Stack Overflow', value: 'stackoverflow' },
          { name: '🌟 Repo GitHub Trending', value: 'github' },
          { name: '🎯 Tout en un', value: 'all' }
        )
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const apiService = new ExternalApiService();
    const type = interaction.options.getString('type') || 'all';

    await interaction.deferReply();

    try {
      switch (type) {
        case 'article':
          await handleDevToArticle(interaction, apiService);
          break;
        case 'stackoverflow':
          await handleStackOverflowQuestion(interaction, apiService);
          break;
        case 'github':
          await handleGitHubTrending(interaction, apiService);
          break;
        case 'all':
        default:
          await handleAllInOne(interaction, apiService);
          break;
      }
    } catch (error) {
      log.error('❌ Erreur daily-dev-tip:', error);

      const errorEmbed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur')
        .setDescription('Impossible de récupérer les conseils développement.')
        .setTimestamp();

      await interaction.editReply({ embeds: [errorEmbed] });
    }
  },
};
