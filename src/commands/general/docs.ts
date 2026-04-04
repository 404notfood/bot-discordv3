import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  AutocompleteInteraction,
} from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

// Interfaces pour les données de la documentation
interface SuperCategory {
  id: number;
  name: string;
  description: string | null;
  icon: string | null;
  color: string | null;
  sort_order: number;
  is_active: number;
}

interface Category {
  id: number;
  name: string;
  description: string | null;
  icon: string | null;
  sort_order: number;
  super_category_id: number;
  super_category_name?: string;
  super_category_icon?: string;
  super_category_color?: string;
  resource_count?: number;
}

interface Resource {
  id: number;
  name: string;
  description: string | null;
  url: string | null;
  search_url: string | null;
  tutorial_url: string | null;
  language: string;
  difficulty_level: string;
  category_id: number;
  category_name?: string;
  super_category_name?: string;
  created_at: Date;
}

// Mapping des super-catégories
const SUPER_CATEGORY_MAP: Record<string, string> = {
  frontend: 'Frontend',
  backend: 'Backend',
  database: 'Database',
  devops: 'DevOps',
  security: 'Security',
  tools: 'Tools',
};

/**
 * Affiche la liste des super-catégories et catégories
 */
async function showCategories(interaction: ChatInputCommandInteraction): Promise<void> {
  try {
    const superCategories = await db.client.$queryRaw<SuperCategory[]>`
      SELECT
        dsc.id,
        dsc.name,
        dsc.description,
        dsc.icon,
        dsc.color,
        dsc.sort_order
      FROM doc_super_categories dsc
      WHERE dsc.is_active = true
      ORDER BY dsc.sort_order
    `;

    if (superCategories.length === 0) {
      const embed = new EmbedBuilder()
        .setColor(0x0099ff)
        .setTitle('📚 Documentation Technique')
        .setDescription('Aucune super-catégorie disponible pour le moment.')
        .addFields({
          name: 'Utilisation',
          value: 'Utilisez `/docs recherche: terme` pour rechercher dans la documentation.',
          inline: false,
        });

      await interaction.followUp({ embeds: [embed] });
      return;
    }

    const embed = new EmbedBuilder()
      .setColor(0x0099ff)
      .setTitle('📚 Documentation Technique')
      .setDescription('Super-catégories et technologies disponibles :');

    for (const superCat of superCategories) {
      const catRows = await db.client.$queryRaw<Pick<Category, 'name' | 'description' | 'icon'>[]>`
        SELECT name, description, icon
        FROM doc_categories
        WHERE super_category_id = ${superCat.id} AND is_active = true
        ORDER BY sort_order, name
      `;

      if (catRows.length > 0) {
        const catList = catRows.map((cat) => `• **${cat.name}**`).join('\n');

        embed.addFields({
          name: `${superCat.name}`,
          value: catList,
          inline: true,
        });
      }
    }

    embed.addFields({
      name: '🔍 Recherche',
      value: 'Utilisez `/docs recherche: terme` pour rechercher dans la documentation.',
      inline: false,
    });

    await interaction.followUp({ embeds: [embed] });
  } catch (error) {
    log.error('Erreur dans showCategories', { error });
    throw error;
  }
}

/**
 * Recherche dans la documentation
 */
async function searchDocs(interaction: ChatInputCommandInteraction, terme: string): Promise<void> {
  try {
    const searchPattern = `%${terme}%`;

    const resources = await db.client.$queryRaw<Resource[]>`
      SELECT dr.*, dc.name as category_name, dsc.name as super_category_name
      FROM doc_resources dr
      LEFT JOIN doc_categories dc ON dr.category_id = dc.id
      LEFT JOIN doc_super_categories dsc ON dc.super_category_id = dsc.id
      WHERE dr.name LIKE ${searchPattern}
        OR dr.description LIKE ${searchPattern}
        OR dc.name LIKE ${searchPattern}
        OR dsc.name LIKE ${searchPattern}
      ORDER BY dr.created_at DESC
      LIMIT 10
    `;

    const embed = new EmbedBuilder()
      .setColor(0x0099ff)
      .setTitle(`🔍 Recherche Documentation: "${terme}"`)
      .setDescription(`${resources.length} résultat(s) trouvé(s):`);

    if (resources.length === 0) {
      embed.addFields({
        name: 'Aucun résultat',
        value: 'Aucun document trouvé pour ce terme.',
        inline: false,
      });
    } else {
      resources.forEach((resource: any) => {
        const description =
          resource.description && resource.description.length > 100
            ? resource.description.substring(0, 100) + '...'
            : resource.description || 'Pas de description';

        let resourceValue =
          `**Super-catégorie:** ${resource.super_category_name || 'Non classé'}\n` +
          `**Catégorie:** ${resource.category_name || 'Non classé'}\n` +
          `**Langage:** ${resource.language}\n` +
          `**Difficulté:** ${resource.difficulty_level}\n\n${description}`;

        if (resource.url) {
          resourceValue += `\n\n🔗 **Lien:** ${resource.url}`;
        }
        if (resource.search_url) {
          resourceValue += `\n🔍 **Recherche:** ${resource.search_url}`;
        }
        if (resource.tutorial_url) {
          resourceValue += `\n📖 **Tutoriel:** ${resource.tutorial_url}`;
        }

        embed.addFields({
          name: `📄 ${resource.name}`,
          value: resourceValue,
          inline: false,
        });
      });
    }

    await interaction.followUp({ embeds: [embed] });
  } catch (error) {
    log.error('Erreur dans searchDocs', { error });
    throw error;
  }
}

/**
 * Affiche les détails d'une super-catégorie
 */
async function showSuperCategory(interaction: ChatInputCommandInteraction, superCat: string): Promise<void> {
  try {
    const superCategoryName = SUPER_CATEGORY_MAP[superCat];

    if (!superCategoryName) {
      await interaction.followUp({
        content: 'Super-catégorie invalide.',
        flags: 64,
      });
      return;
    }

    const superCategoryData = await db.client.$queryRaw<(SuperCategory & { category_count: number })[]>`
      SELECT dsc.*,
             COUNT(dc.id) as category_count
      FROM doc_super_categories dsc
      LEFT JOIN doc_categories dc ON dsc.id = dc.super_category_id AND dc.is_active = true
      WHERE dsc.name = ${superCategoryName} AND dsc.is_active = true
      GROUP BY dsc.id
    `;

    if (superCategoryData.length === 0) {
      await interaction.followUp({
        content: 'Super-catégorie non trouvée.',
        flags: 64,
      });
      return;
    }

    const superCatData = superCategoryData[0];

    const catRows = await db.client.$queryRaw<Category[]>`
      SELECT dc.*,
             COUNT(dr.id) as resource_count
      FROM doc_categories dc
      LEFT JOIN doc_resources dr ON dc.id = dr.category_id AND dr.is_active = true
      WHERE dc.super_category_id = ${superCatData.id} AND dc.is_active = true
      GROUP BY dc.id
      ORDER BY dc.sort_order, dc.name
    `;

    const color = superCatData.color ? parseInt(superCatData.color.replace('#', ''), 16) : 0x0099ff;

    const embed = new EmbedBuilder()
      .setColor(color)
      .setTitle(`${superCatData.name}`)
      .setDescription(superCatData.description || 'Documentation technique');

    if (catRows.length === 0) {
      embed.addFields({
        name: 'Aucune catégorie',
        value: 'Aucune catégorie trouvée dans cette super-catégorie.',
        inline: false,
      });
    } else {
      let techList = '';
      catRows.forEach((cat: any) => {
        techList += `**${cat.name}** (${cat.resource_count || 0} ressources)\n${cat.description || 'Pas de description'}\n\n`;
      });

      embed.addFields({
        name: 'Technologies',
        value: techList.trim(),
        inline: false,
      });
    }

    embed.addFields({
      name: '💡 Utilisation',
      value: 'Utilisez `/docs technologie:` avec auto-complétion pour voir une technologie spécifique.',
      inline: false,
    });

    await interaction.followUp({ embeds: [embed] });
  } catch (error) {
    log.error('Erreur dans showSuperCategory', { error });
    throw error;
  }
}

/**
 * Affiche les détails d'une technologie spécifique
 */
async function showTechnology(interaction: ChatInputCommandInteraction, techName: string): Promise<void> {
  try {
    const categoryData = await db.client.$queryRaw<Category[]>`
      SELECT dc.*, dsc.name as super_category_name, dsc.icon as super_category_icon, dsc.color as super_category_color
      FROM doc_categories dc
      LEFT JOIN doc_super_categories dsc ON dc.super_category_id = dsc.id
      WHERE LOWER(dc.name) = ${techName.toLowerCase()} AND dc.is_active = true
    `;

    if (categoryData.length === 0) {
      await interaction.followUp({
        content: `Technologie "${techName}" non trouvée.`,
        flags: 64,
      });
      return;
    }

    const category = categoryData[0];

    const resources = await db.client.$queryRaw<Resource[]>`
      SELECT dr.*
      FROM doc_resources dr
      WHERE dr.category_id = ${category.id} AND dr.is_active = true
      ORDER BY dr.created_at DESC
    `;

    const color = category.super_category_color
      ? parseInt(category.super_category_color.replace('#', ''), 16)
      : 0x0099ff;

    const embed = new EmbedBuilder()
      .setColor(color)
      .setTitle(`${category.name}`)
      .setDescription(category.description || 'Documentation technique');

    if (resources.length === 0) {
      embed.addFields({
        name: 'Aucune ressource',
        value: 'Aucune ressource disponible pour cette technologie pour le moment.',
        inline: false,
      });
    } else {
      resources.slice(0, 5).forEach((resource: any) => {
        const description =
          resource.description && resource.description.length > 200
            ? resource.description.substring(0, 200) + '...'
            : resource.description || 'Pas de description';

        let resourceValue = `${description}`;

        if (resource.url) {
          resourceValue += `\n\n🔗 **Lien:** ${resource.url}`;
        }
        if (resource.search_url) {
          resourceValue += `\n🔍 **Recherche:** ${resource.search_url}`;
        }
        if (resource.tutorial_url) {
          resourceValue += `\n📖 **Tutoriel:** ${resource.tutorial_url}`;
        }

        embed.addFields({
          name: `📄 ${resource.name}`,
          value: resourceValue,
          inline: false,
        });
      });

      if (resources.length > 5) {
        embed.addFields({
          name: '📚 Plus de ressources',
          value: `... et ${resources.length - 5} autres ressources. Utilisez \`/docs recherche:${techName}\` pour tout voir.`,
          inline: false,
        });
      }
    }

    await interaction.followUp({ embeds: [embed] });
  } catch (error) {
    log.error('Erreur dans showTechnology', { error });
    throw error;
  }
}

/**
 * Gestion de l'autocomplete pour la sélection de technologies
 */
async function handleAutocomplete(interaction: AutocompleteInteraction): Promise<void> {
  const focusedValue = interaction.options.getFocused();
  const superCategorie = interaction.options.getString('super_categorie');

  try {
    log.debug('Autocomplete docs', { focusedValue, superCategorie });

    let catResults: { name: string }[];

    if (superCategorie) {
      const superCategoryName = SUPER_CATEGORY_MAP[superCategorie];
      if (superCategoryName) {
        catResults = await db.client.$queryRaw<{ name: string }[]>`
          SELECT dc.name
          FROM doc_categories dc
          LEFT JOIN doc_super_categories dsc ON dc.super_category_id = dsc.id
          WHERE dsc.name = ${superCategoryName}
            AND dc.is_active = true
            AND dc.name LIKE ${`%${focusedValue}%`}
          ORDER BY dc.name
          LIMIT 25
        `;
      } else {
        catResults = [];
      }
    } else {
      catResults = await db.client.$queryRaw<{ name: string }[]>`
        SELECT name
        FROM doc_categories
        WHERE is_active = true
          AND name LIKE ${`%${focusedValue}%`}
        ORDER BY name
        LIMIT 25
      `;
    }

    const results = catResults.map((cat) => ({
      name: cat.name,
      value: cat.name.toLowerCase(),
    }));

    await interaction.respond(results);
  } catch (error) {
    log.error('Erreur autocomplete docs', { error });

    try {
      const fallbackCategories = await db.client.$queryRaw<{ name: string }[]>`
        SELECT name
        FROM doc_categories
        WHERE is_active = true
        ORDER BY name
        LIMIT 10
      `;

      const fallbackResults = fallbackCategories.map((cat) => ({
        name: cat.name,
        value: cat.name.toLowerCase(),
      }));

      await interaction.respond(fallbackResults);
    } catch (fallbackError) {
      log.error('Erreur fallback autocomplete docs', { fallbackError });
      await interaction.respond([]);
    }
  }
}

export default {
  data: new SlashCommandBuilder()
    .setName('docs')
    .setDescription('Accès à la documentation technique')
    .addStringOption((option) =>
      option
        .setName('super_categorie')
        .setDescription('Choisir une super-catégorie')
        .setRequired(false)
        .addChoices(
          { name: '🎨 Frontend', value: 'frontend' },
          { name: '⚙️ Backend', value: 'backend' },
          { name: '🗄️ Base de Données', value: 'database' },
          { name: '🚀 DevOps', value: 'devops' },
          { name: '🔐 Sécurité', value: 'security' },
          { name: '🛠️ Outils', value: 'tools' }
        )
    )
    .addStringOption((option) =>
      option
        .setName('technologie')
        .setDescription('Nom de la technologie (auto-complétion disponible)')
        .setRequired(false)
        .setAutocomplete(true)
    )
    .addStringOption((option) =>
      option
        .setName('recherche')
        .setDescription('Terme de recherche libre dans le contenu')
        .setRequired(false)
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const superCategorie = interaction.options.getString('super_categorie');
    const technologie = interaction.options.getString('technologie');
    const recherche = interaction.options.getString('recherche');

    await interaction.deferReply();

    try {
      if (recherche) {
        await searchDocs(interaction, recherche);
      } else if (technologie) {
        await showTechnology(interaction, technologie);
      } else if (superCategorie) {
        await showSuperCategory(interaction, superCategorie);
      } else {
        await showCategories(interaction);
      }
    } catch (error) {
      log.error('Erreur commande docs', { error });
      await interaction.followUp({
        content: 'Erreur lors de l\'accès à la documentation.',
        flags: 64,
      });
    }
  },

  async autocomplete(interaction: AutocompleteInteraction): Promise<void> {
    await handleAutocomplete(interaction);
  },
};
