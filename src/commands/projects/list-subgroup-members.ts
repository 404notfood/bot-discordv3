import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('list-subgroup-members')
    .setDescription("Membres d'un sous-groupe")
    .addStringOption((option) =>
      option.setName('sous_groupe').setDescription('Nom du sous-groupe').setRequired(true)
    )
    .addStringOption((option) => option.setName('projet').setDescription('Nom du projet').setRequired(true)),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const subgroupName = interaction.options.getString('sous_groupe', true);
    const projectName = interaction.options.getString('projet', true);

    await interaction.deferReply();

    try {
      // Vérifier le projet
      const project = await db.client.project.findFirst({
        where: { name: projectName, guildId: interaction.guild.id, isActive: true },
      });

      if (!project) {
        await interaction.followUp({ content: 'Projet non trouvé.', ephemeral: true });
        return;
      }

      // Récupérer le sous-groupe avec ses membres
      const subgroup = await db.client.subgroup.findFirst({
        where: { name: subgroupName, projectId: project.id },
        include: {
          members: {
            orderBy: { addedAt: 'asc' },
          },
        },
      });

      if (!subgroup) {
        await interaction.followUp({ content: 'Sous-groupe non trouvé.', ephemeral: true });
        return;
      }

      const embed = new EmbedBuilder()
        .setColor(0x0099ff)
        .setTitle('👥 Membres du Sous-groupe')
        .setDescription(
          `**Projet:** ${projectName}\n**Sous-groupe:** ${subgroupName}\n**Description:** ${subgroup.description}`
        )
        .setTimestamp();

      if (subgroup.members.length === 0) {
        embed.addFields({
          name: 'Aucun membre',
          value: 'Ce sous-groupe ne contient aucun membre.',
          inline: false,
        });
      } else {
        // Paginer les membres par groupes de 10
        const chunks: any[][] = [];
        for (let i = 0; i < subgroup.members.length; i += 10) {
          chunks.push(subgroup.members.slice(i, i + 10));
        }

        chunks.forEach((chunk, index) => {
          const memberList = chunk
            .map((member, memberIndex) => {
              const globalIndex = index * 10 + memberIndex + 1;
              const userMention = `<@${member.userId}>`;
              const joinedDate = `<t:${Math.floor(new Date(member.addedAt).getTime() / 1000)}:R>`;

              return `${globalIndex}. ${userMention}\n   └ Ajouté ${joinedDate}`;
            })
            .join('\n\n');

          const fieldName = index === 0 ? '👥 Membres' : `👥 Membres (suite ${index + 1})`;

          embed.addFields({
            name: fieldName,
            value: memberList,
            inline: false,
          });
        });
      }

      // Informations du sous-groupe
      const createdAtTimestamp = subgroup.createdAt
        ? Math.floor(new Date(subgroup.createdAt).getTime() / 1000)
        : 0;

      embed.addFields({
        name: 'ℹ️ Informations',
        value: `**Membres total:** ${subgroup.members.length}\n**Créé:** <t:${createdAtTimestamp}:R>\n**Créateur:** <@${subgroup.createdBy}>`,
        inline: true,
      });

      embed.addFields({
        name: '⚙️ Actions',
        value:
          '`/add-to-subgroup` - Ajouter membre\n`/remove-from-subgroup` - Retirer membre\n`/list-subgroups` - Tous les sous-groupes',
        inline: true,
      });

      embed.setFooter({
        text: `${subgroup.members.length} membre${subgroup.members.length > 1 ? 's' : ''} dans ce sous-groupe`,
      });

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('List subgroup members error:', error);
      await interaction.followUp({ content: 'Erreur lors de la récupération des membres.', ephemeral: true });
    }
  },
};
