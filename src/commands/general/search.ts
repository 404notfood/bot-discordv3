import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { externalApiService } from '../../services/external-apis';
import { log } from '../../services/logger';

/**
 * Recherche web avec liens directs vers les moteurs de recherche
 */
async function searchWeb(interaction: ChatInputCommandInteraction, query: string): Promise<void> {
  const embed = new EmbedBuilder()
    .setColor(0x00ae86)
    .setTitle(`🔍 Recherche Web: "${query}"`)
    .setDescription('Voici quelques liens utiles pour votre recherche:')
    .addFields(
      {
        name: 'Google',
        value: `[Rechercher "${query}"](https://www.google.com/search?q=${encodeURIComponent(query)})`,
        inline: true,
      },
      {
        name: 'Stack Overflow',
        value: `[Rechercher "${query}"](https://stackoverflow.com/search?q=${encodeURIComponent(query)})`,
        inline: true,
      },
      {
        name: 'GitHub',
        value: `[Rechercher "${query}"](https://github.com/search?q=${encodeURIComponent(query)})`,
        inline: true,
      },
      {
        name: 'MDN Web Docs',
        value: `[Rechercher "${query}"](https://developer.mozilla.org/fr/search?q=${encodeURIComponent(query)})`,
        inline: true,
      },
      {
        name: 'Dev.to',
        value: `[Rechercher "${query}"](https://dev.to/search?q=${encodeURIComponent(query)})`,
        inline: true,
      }
    )
    .setTimestamp();

  await interaction.followUp({ embeds: [embed] });
}

/**
 * Recherche YouTube via l'API externe
 */
async function searchYouTube(interaction: ChatInputCommandInteraction, query: string): Promise<void> {
  if (!process.env.YOUTUBE_API_KEY) {
    await interaction.followUp({
      content: 'YouTube API non configurée.',
      ephemeral: true,
    });
    return;
  }

  try {
    const videos = await externalApiService.searchYouTubeDevVideos(query, 'fr');

    if (videos.length === 0) {
      await interaction.followUp({
        content: 'Aucune vidéo trouvée pour cette recherche.',
        ephemeral: true,
      });
      return;
    }

    const embed = new EmbedBuilder()
      .setColor(0xff0000)
      .setTitle(`📺 YouTube Dev FR: "${query}"`)
      .setDescription('Voici les meilleures vidéos trouvées:');

    videos.forEach((video) => {
      embed.addFields({
        name: video.title,
        value: `[Regarder](${video.url})\n*${video.channel.name}*`,
        inline: false,
      });
    });

    await interaction.followUp({ embeds: [embed] });
  } catch (error) {
    log.error('Erreur recherche YouTube', { error });
    await interaction.followUp({
      content: 'Erreur lors de la recherche YouTube.',
      ephemeral: true,
    });
  }
}

export default {
  data: new SlashCommandBuilder()
    .setName('search')
    .setDescription('Recherche sur le web et YouTube')
    .addStringOption((option) =>
      option.setName('query').setDescription('Terme à rechercher').setRequired(true)
    )
    .addStringOption((option) =>
      option
        .setName('type')
        .setDescription('Type de recherche')
        .setRequired(false)
        .addChoices(
          { name: 'Web', value: 'web' },
          { name: 'YouTube (Dev FR)', value: 'youtube' }
        )
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const query = interaction.options.getString('query', true);
    const type = interaction.options.getString('type') || 'web';

    await interaction.deferReply();

    try {
      if (type === 'youtube') {
        await searchYouTube(interaction, query);
      } else {
        await searchWeb(interaction, query);
      }
    } catch (error) {
      log.error('Erreur commande search', { error });
      await interaction.followUp({
        content: 'Erreur lors de la recherche. Réessayez plus tard.',
        ephemeral: true,
      });
    }
  },
};
