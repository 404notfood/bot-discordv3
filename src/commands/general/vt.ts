import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import axios from 'axios';
import { log } from '../../services/logger';

// Couleurs par catégorie de veille techno
const CATEGORY_COLORS: Record<string, number> = {
  frontend: 0x61dafb,
  backend: 0x68a063,
  devops: 0xff6b6b,
  'ia-ml': 0x8b5cf6,
  mobile: 0x3ddc84,
  securite: 0xf59e0b,
  database: 0x336791,
  'open-source': 0x2ea44f,
  typescript: 0x3178c6,
  rust: 0xce422b,
  go: 0x00add8,
  autre: 0x6b7280,
};

// Icônes par catégorie
const CATEGORY_ICONS: Record<string, string> = {
  frontend: '🎨',
  backend: '🔧',
  devops: '🚀',
  'ia-ml': '🤖',
  mobile: '📱',
  securite: '🔒',
  database: '🗄️',
  'open-source': '💡',
  typescript: '🔷',
  rust: '🦀',
  go: '🐹',
  autre: '📌',
};

// Interface pour un article de veille techno
interface VeilleArticle {
  id: string;
  title: string;
  url: string;
  summary: string | null;
  category: string | null;
  publishedAt: string | null;
  fetchedAt: string | null;
  tags: string[];
  language: string | null;
  readingTime: number | null;
  score: number;
  aiSummary: string | null;
  source: {
    name: string;
    slug: string;
    icon: string | null;
  };
}

export default {
  data: new SlashCommandBuilder()
    .setName('vt')
    .setDescription('Récupérer les derniers articles de veille techno')
    .addStringOption((option) =>
      option
        .setName('categorie')
        .setDescription('Filtrer par catégorie')
        .setRequired(false)
        .addChoices(
          { name: '🎨 Frontend', value: 'frontend' },
          { name: '🔧 Backend', value: 'backend' },
          { name: '🚀 DevOps', value: 'devops' },
          { name: '🤖 IA / ML', value: 'ia-ml' },
          { name: '📱 Mobile', value: 'mobile' },
          { name: '🔒 Sécurité', value: 'securite' },
          { name: '🗄️ Base de données', value: 'database' },
          { name: '💡 Open Source', value: 'open-source' },
          { name: '🔷 TypeScript', value: 'typescript' },
          { name: '🦀 Rust', value: 'rust' },
          { name: '🐹 Go', value: 'go' }
        )
    )
    .addIntegerOption((option) =>
      option
        .setName('nombre')
        .setDescription("Nombre d'articles (1-10)")
        .setRequired(false)
        .setMinValue(1)
        .setMaxValue(10)
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    await interaction.deferReply();

    const category = interaction.options.getString('categorie');
    const limit = interaction.options.getInteger('nombre') || 5;

    const apiUrl = process.env.VEILLE_TECHNO_API_URL;
    const apiKey = process.env.VEILLE_TECHNO_API_KEY;

    if (!apiUrl || !apiKey) {
      await interaction.editReply(
        '❌ La veille techno n\'est pas configurée. Variables `VEILLE_TECHNO_API_URL` et `VEILLE_TECHNO_API_KEY` manquantes.'
      );
      return;
    }

    try {
      const params: Record<string, string> = { limit: limit.toString() };
      if (category) params.category = category;

      const response = await axios.get<{
        articles: VeilleArticle[];
        count: number;
        timestamp: string;
      }>(`${apiUrl}/api/discord/latest`, {
        params,
        headers: {
          Authorization: `Bearer ${apiKey}`,
        },
        timeout: 10000,
      });

      const { articles } = response.data;

      if (articles.length === 0) {
        await interaction.editReply('📭 Aucun article trouvé pour ces critères.');
        return;
      }

      // Construire les embeds pour chaque article (max 10)
      const embeds = articles.slice(0, 10).map((article) => {
        const cat = article.category || 'autre';
        const icon = CATEGORY_ICONS[cat] || '📌';
        const color = CATEGORY_COLORS[cat] || 0x6b7280;
        const lang = article.language === 'fr' ? '🇫🇷' : '🇬🇧';

        const embed = new EmbedBuilder()
          .setTitle(article.title.slice(0, 256))
          .setURL(article.url)
          .setDescription(article.summary?.slice(0, 300) || 'Pas de résumé disponible.')
          .setColor(color)
          .addFields(
            { name: 'Catégorie', value: `${icon} ${cat}`, inline: true },
            { name: 'Source', value: article.source?.name || 'Inconnue', inline: true },
            { name: 'Langue', value: lang, inline: true }
          )
          .setTimestamp(article.publishedAt ? new Date(article.publishedAt) : new Date())
          .setFooter({ text: 'Veille Techno' });

        if (article.tags?.length > 0) {
          embed.addFields({
            name: 'Tags',
            value: article.tags
              .slice(0, 5)
              .map((t) => `\`${t}\``)
              .join(' '),
            inline: false,
          });
        }

        return embed;
      });

      const categoryLabel = category
        ? ` dans **${CATEGORY_ICONS[category] || ''} ${category}**`
        : '';

      await interaction.editReply({
        content: `📰 **${articles.length} article(s) trouvé(s)**${categoryLabel}`,
        embeds,
      });
    } catch (error) {
      const err = error as Error;
      log.error('[Veille Techno] Erreur commande /vt', {
        error: err.message,
        userId: interaction.user.id,
        guildId: interaction.guildId,
      });

      if (axios.isAxiosError(error)) {
        if (error.response?.status === 401) {
          await interaction.editReply(
            '❌ Clé API Veille Techno invalide. Contacte un administrateur.'
          );
          return;
        }
        if (error.code === 'ECONNREFUSED' || error.code === 'ECONNABORTED') {
          await interaction.editReply(
            '❌ Le serveur Veille Techno est injoignable. Réessaie plus tard.'
          );
          return;
        }
      }

      await interaction.editReply(
        '❌ Erreur lors de la récupération des articles. Réessaie plus tard.'
      );
    }
  },
};
