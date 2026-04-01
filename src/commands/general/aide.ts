import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { PermissionsManager } from '../../services/permissions';

// Informations des catégories de commandes
interface CategoryInfo {
  title: string;
  color: number;
  commands: string[];
}

const categories: Record<string, CategoryInfo> = {
  general: {
    title: '📋 Commandes Générales',
    color: 0x00ae86,
    commands: [
      '`/aide` - Affiche cette aide (+ catégories spécifiques)',
      '`/docs` - Accès à la documentation technique complète',
      '`/search` - Recherche avancée sur le web',
      '`/vt` - Articles de veille technologique',
    ],
  },
  admin: {
    title: '🔧 Administration',
    color: 0xff6b35,
    commands: [
      '`/ping` - Vérifier la latence du bot et l\'API',
      '`/info` - Informations détaillées sur le bot et serveur',
      '`/rappel` - Créer des rappels personnalisés',
    ],
  },
  moderation: {
    title: '🛡️ Modération',
    color: 0xff0000,
    commands: [
      '`/ban-add` - Bannir un utilisateur (temporaire/permanent)',
      '`/ban-remove` - Débannir un utilisateur avec raison',
    ],
  },
  system: {
    title: '⚙️ Système & Administration',
    color: 0x9b59b6,
    commands: [
      '`/db-status` - État de la base de données',
      '`/add-admin` - Ajouter un administrateur',
      '`/stats` - Statistiques complètes du bot',
    ],
  },
  projects: {
    title: '📊 Gestion de Projets',
    color: 0x3498db,
    commands: [
      '**Projets:**',
      '`/create-project` - Créer un nouveau projet collaboratif',
      '`/list-projects` - Liste tous les projets actifs',
      '',
      '**Sous-groupes:**',
      '`/create-subgroup` - Créer un sous-groupe de projet',
      '`/add-to-subgroup` - Ajouter un membre au sous-groupe',
      '`/remove-from-subgroup` - Retirer un membre du sous-groupe',
      '`/list-subgroups` - Liste des sous-groupes d\'un projet',
      '`/list-subgroup-members` - Membres d\'un sous-groupe spécifique',
    ],
  },
  animations: {
    title: '🎯 Animations & Défis',
    color: 0xf39c12,
    commands: [
      '`/quiz` - Quiz développeur configurable (thèmes, programmation)',
      '`/challenge` - Système de défis hebdomadaires/mensuels',
      '`/sql-clinic` - Exercices pratiques SQL avec datasets',
      '`/sql-challenge` - SQL Challenge en 7 semaines',
      '`/github-streak` - Suivi des contributions GitHub',
      '`/daily-dev-tip` - Conseil de développement quotidien',
    ],
  },
  roles: {
    title: '👥 Gestion des Rôles',
    color: 0xe74c3c,
    commands: [
      '`/give-temp-role` - Attribuer un rôle temporaire',
      '`/remove-temp-role` - Retirer un rôle temporaire manuellement',
      '`/list-temp-roles` - Lister tous les rôles temporaires actifs',
    ],
  },
  channels: {
    title: '🔐 Gestion des Canaux',
    color: 0x1abc9c,
    commands: [
      '`/create-private-channel` - Créer un canal privé (texte/vocal)',
      '`/manage-channel-permissions` - Gérer permissions de canal',
      '`/bot-permissions` - Gérer les permissions du bot',
      '`/bot-roles` - Gérer les rôles du bot sur le serveur',
    ],
  },
  studi: {
    title: '🧑‍💻 Système Anti-Studi',
    color: 0x8e44ad,
    commands: [
      '`/studi-config` - Configuration du système anti-Studi',
      '`/studi-status` - État actuel et statistiques du système',
    ],
  },
  emploi: {
    title: '💼 Offres d\'emploi',
    color: 0x00cc66,
    commands: [
      '`/emploi setup` - Configurer le canal des annonces',
      '`/emploi config` - Modifier la configuration',
      '`/emploi status` - Voir le statut et les stats',
      '`/emploi start` - Activer le service',
      '`/emploi stop` - Désactiver le service',
      '`/emploi poll` - Forcer une recherche immédiate',
    ],
  },
};

/**
 * Affiche l'aide complète avec toutes les catégories
 */
async function showAllCategories(interaction: ChatInputCommandInteraction): Promise<void> {
  const embed = new EmbedBuilder()
    .setColor(0x00ae86)
    .setTitle('🤖 Aide - Commandes Disponibles')
    .setDescription(
      '**Taureau Celtique Bot v3.0** 🚀\n\nVoici toutes les commandes disponibles. Utilisez `/aide categorie:` pour voir les détails d\'une catégorie spécifique.'
    )
    .addFields(
      {
        name: '📋 **Général** (4 commandes)',
        value: '`/aide` `/docs` `/search` `/vt`\n*Aide, documentation, recherche web, veille techno*',
        inline: true,
      },
      {
        name: '🔧 **Administration** (3 commandes)',
        value: '`/ping` `/info` `/rappel`\n*Infos bot, latence, rappels*',
        inline: true,
      },
      {
        name: '🛡️ **Modération** (2 commandes)',
        value: '`/ban-add` `/ban-remove`\n*Bannir/débannir utilisateurs*',
        inline: true,
      },
      {
        name: '⚙️ **Système** (3 commandes)',
        value: '`/db-status` `/add-admin` `/stats`\n*BDD, administration, statistiques*',
        inline: true,
      },
      {
        name: '📊 **Projets** (7 commandes)',
        value: '`/create-project` `/list-projects` `/create-subgroup`\n*Gestion projets et sous-groupes*',
        inline: true,
      },
      {
        name: '🎯 **Animations** (6 commandes)',
        value: '`/quiz` `/challenge` `/sql-clinic` `/github-streak`\n*Quiz, défis, SQL clinic, conseils dev*',
        inline: true,
      },
      {
        name: '👥 **Rôles** (3 commandes)',
        value: '`/give-temp-role` `/remove-temp-role` `/list-temp-roles`\n*Gestion rôles temporaires*',
        inline: true,
      },
      {
        name: '🔐 **Canaux** (4 commandes)',
        value: '`/create-private-channel` `/bot-permissions` `/bot-roles`\n*Canaux privés, permissions*',
        inline: true,
      },
      {
        name: '🧑‍💻 **Anti-Studi** (2 commandes)',
        value: '`/studi-config` `/studi-status`\n*Protection contre Studi*',
        inline: true,
      },
      {
        name: '💼 **Emploi** (6 sous-commandes)',
        value: '`/emploi setup` `/emploi config` `/emploi status`\n*Annonces d\'emploi dev junior*',
        inline: true,
      }
    )
    .addFields(
      {
        name: '🔗 **Liens Utiles**',
        value: '• Dashboard: https://bot.rtfm2win.ovh/\n• Documentation: `/docs`\n• Support: Contactez un administrateur',
        inline: false,
      }
    )
    .setTimestamp()
    .setFooter({ text: 'Taureau Celtique Bot v3.0 • Toutes les commandes synchronisées avec le dashboard' });

  await interaction.reply({ embeds: [embed] });
}

/**
 * Affiche les détails d'une catégorie spécifique
 */
async function showCategory(interaction: ChatInputCommandInteraction, categorie: string): Promise<void> {
  const category = categories[categorie];

  if (!category) {
    await interaction.reply({
      content: 'Catégorie inconnue. Utilisez `/aide` pour voir toutes les catégories.',
      ephemeral: true,
    });
    return;
  }

  const embed = new EmbedBuilder()
    .setColor(category.color)
    .setTitle(`${category.title} - Détails`)
    .setDescription(category.commands.join('\n'))
    .addFields({
      name: '💡 Astuce',
      value:
        'Toutes ces commandes sont synchronisées avec le **dashboard web**. Vous pouvez aussi les gérer depuis https://bot.rtfm2win.ovh/',
      inline: false,
    })
    .setTimestamp()
    .setFooter({ text: 'Utilisez /aide pour revenir au menu principal' });

  await interaction.reply({ embeds: [embed] });
}

export default {
  data: new SlashCommandBuilder()
    .setName('aide')
    .setDescription('Affiche la liste complète des commandes disponibles')
    .addStringOption((option) =>
      option
        .setName('categorie')
        .setDescription('Afficher une catégorie spécifique')
        .setRequired(false)
        .addChoices(
          { name: 'Général', value: 'general' },
          { name: 'Administration', value: 'admin' },
          { name: 'Modération', value: 'moderation' },
          { name: 'Système', value: 'system' },
          { name: 'Projets', value: 'projects' },
          { name: 'Animations', value: 'animations' },
          { name: 'Rôles', value: 'roles' },
          { name: 'Canaux', value: 'channels' },
          { name: 'Anti-Studi', value: 'studi' },
          { name: 'Emploi', value: 'emploi' }
        )
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    // Vérifier si l'utilisateur est administrateur du bot
    if (!(await PermissionsManager.requireAdmin(interaction))) {
      return;
    }

    const categorie = interaction.options.getString('categorie');

    if (categorie) {
      await showCategory(interaction, categorie);
    } else {
      await showAllCategories(interaction);
    }
  },
};
