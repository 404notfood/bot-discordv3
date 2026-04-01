import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

/**
 * Retourne le label d'affichage du type de projet
 */
function getTypeDisplay(type: string): string {
  const types: Record<string, string> = {
    web: 'Développement Web',
    mobile: 'Application Mobile',
    game: 'Jeu Vidéo',
    ai: 'Intelligence Artificielle',
    opensource: 'Open Source',
    other: 'Autre',
  };
  return types[type] || 'Autre';
}

/**
 * Retourne l'icône associée au type de projet
 */
function getTypeIcon(type: string): string {
  const icons: Record<string, string> = {
    web: '🌐',
    mobile: '📱',
    game: '🎮',
    ai: '🤖',
    opensource: '📂',
    other: '🔧',
  };
  return icons[type] || '🔧';
}

export default {
  data: new SlashCommandBuilder()
    .setName('list-projects')
    .setDescription('Liste tous les projets communautaires')
    .addStringOption((option) =>
      option
        .setName('filtre')
        .setDescription('Filtrer par type de projet')
        .setRequired(false)
        .addChoices(
          { name: 'Développement Web', value: 'web' },
          { name: 'Application Mobile', value: 'mobile' },
          { name: 'Jeu Vidéo', value: 'game' },
          { name: 'Intelligence Artificielle', value: 'ai' },
          { name: 'Open Source', value: 'opensource' },
          { name: 'Autre', value: 'other' }
        )
    )
    .addStringOption((option) =>
      option
        .setName('statut')
        .setDescription('Filtrer par statut')
        .setRequired(false)
        .addChoices(
          { name: 'Actifs uniquement', value: 'active' },
          { name: 'Archivés uniquement', value: 'archived' },
          { name: 'Tous', value: 'all' }
        )
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const filtre = interaction.options.getString('filtre');
    const statut = interaction.options.getString('statut') || 'active';

    await interaction.deferReply();

    try {
      // Construire les filtres de recherche
      const where: any = { guildId: interaction.guild.id };
      if (filtre) where.projectType = filtre;
      if (statut === 'active') where.isActive = true;
      else if (statut === 'archived') where.isActive = false;

      const projects = await db.client.project.findMany({
        where,
        orderBy: { createdAt: 'desc' },
      });

      const embed = new EmbedBuilder()
        .setColor(0x0099ff)
        .setTitle('📋 Liste des Projets Communautaires')
        .setDescription(
          `**Serveur:** ${interaction.guild.name}${filtre ? `\n**Filtre:** ${getTypeDisplay(filtre)}` : ''}`
        );

      if (projects.length === 0) {
        embed.addFields({
          name: 'Aucun projet',
          value: filtre
            ? `Aucun projet de type ${getTypeDisplay(filtre)} trouvé.`
            : "Aucun projet créé pour le moment.\nUtilisez `/create-project` pour en créer un.",
          inline: false,
        });
      } else {
        // Grouper les projets par type
        const grouped: Record<string, any[]> = {};
        projects.forEach((project: any) => {
          if (!grouped[project.projectType]) {
            grouped[project.projectType] = [];
          }
          grouped[project.projectType].push(project);
        });

        for (const [type, typeProjects] of Object.entries(grouped)) {
          const projectList = typeProjects
            .map((project) => {
              const status = project.isActive ? '🟢' : '🔴';
              const privacy = project.isPrivate ? '🔒' : '🌐';
              const channel = interaction.guild!.channels.cache.get(project.textChannelId);
              const role = interaction.guild!.roles.cache.get(project.roleId);
              const memberCount = role ? role.members.size : 0;

              return `${status} **${project.name}** ${privacy}\n${channel ? `└ ${channel}` : '└ Canal supprimé'} • ${memberCount} membres • <t:${Math.floor(new Date(project.createdAt).getTime() / 1000)}:R>`;
            })
            .join('\n\n');

          embed.addFields({
            name: `${getTypeIcon(type)} ${getTypeDisplay(type)} (${typeProjects.length})`,
            value: projectList,
            inline: false,
          });
        }
      }

      // Statistiques globales
      const total = await db.client.project.count({ where: { guildId: interaction.guild.id } });
      const active = await db.client.project.count({ where: { guildId: interaction.guild.id, isActive: true } });
      const privateProjects = await db.client.project.count({
        where: { guildId: interaction.guild.id, isPrivate: true },
      });

      embed.addFields({
        name: '📊 Statistiques',
        value: `**Total:** ${total}\n**Actifs:** ${active}\n**Privés:** ${privateProjects}`,
        inline: true,
      });

      embed.addFields({
        name: '⚙️ Actions',
        value: "`/create-project` - Créer un projet\n`/list-subgroups` - Voir les sous-groupes",
        inline: true,
      });

      embed
        .setTimestamp()
        .setFooter({
          text: `${projects.length} projet${projects.length > 1 ? 's' : ''} affiché${projects.length > 1 ? 's' : ''}`,
        });

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('List projects error:', error);
      await interaction.followUp({ content: 'Erreur lors de la récupération des projets.', ephemeral: true });
    }
  },
};
