import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('list-subgroups')
    .setDescription('Liste des sous-groupes')
    .addStringOption((option) =>
      option.setName('projet').setDescription('Filtrer par projet').setRequired(false)
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const projectFilter = interaction.options.getString('projet');
    await interaction.deferReply();

    try {
      // Construire les filtres
      const where: any = { guildId: interaction.guild.id };
      const include: any = { project: true, _count: { select: { members: true } } };

      if (projectFilter) {
        where.project = { name: projectFilter };
      }

      const subgroups = await db.client.subgroup.findMany({
        where,
        include,
        orderBy: [{ project: { name: 'asc' } }, { createdAt: 'desc' }],
      });

      const embed = new EmbedBuilder()
        .setColor(0x0099ff)
        .setTitle('📑 Liste des Sous-groupes')
        .setDescription(
          `**Serveur:** ${interaction.guild.name}${projectFilter ? `\n**Projet:** ${projectFilter}` : ''}`
        );

      if (subgroups.length === 0) {
        embed.addFields({
          name: 'Aucun sous-groupe',
          value: projectFilter
            ? `Aucun sous-groupe dans le projet ${projectFilter}.`
            : 'Aucun sous-groupe créé.',
          inline: false,
        });
      } else {
        // Grouper par projet
        const grouped: Record<string, any[]> = {};
        subgroups.forEach((subgroup: any) => {
          const projectName = subgroup.project.name;
          if (!grouped[projectName]) {
            grouped[projectName] = [];
          }
          grouped[projectName].push(subgroup);
        });

        for (const [projectName, projectSubgroups] of Object.entries(grouped)) {
          const subgroupList = projectSubgroups
            .map((sg) => {
              const memberCount = sg._count.members;
              return `**${sg.name}** (${memberCount} membres)\n└ ${sg.description}\n└ Créé <t:${Math.floor(new Date(sg.createdAt).getTime() / 1000)}:R>`;
            })
            .join('\n\n');

          embed.addFields({
            name: `📁 ${projectName} (${projectSubgroups.length} sous-groupes)`,
            value: subgroupList,
            inline: false,
          });
        }
      }

      // Statistiques
      const totalSubgroups = await db.client.subgroup.count({ where: { guildId: interaction.guild.id } });
      const projectsWithSubgroups = await db.client.subgroup.groupBy({
        by: ['projectId'],
        where: { guildId: interaction.guild.id },
      });

      embed.addFields({
        name: '📊 Statistiques',
        value: `**Total sous-groupes:** ${totalSubgroups}\n**Projets avec sous-groupes:** ${projectsWithSubgroups.length}`,
        inline: true,
      });

      embed.addFields({
        name: '⚙️ Actions',
        value:
          '`/create-subgroup` - Créer un sous-groupe\n`/add-to-subgroup` - Ajouter un membre\n`/list-subgroup-members` - Voir les membres',
        inline: true,
      });

      embed.setTimestamp().setFooter({
        text: `${subgroups.length} sous-groupe${subgroups.length > 1 ? 's' : ''} affiché${subgroups.length > 1 ? 's' : ''}`,
      });

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('List subgroups error:', error);
      await interaction.followUp({
        content: 'Erreur lors de la récupération des sous-groupes.',
        ephemeral: true,
      });
    }
  },
};
