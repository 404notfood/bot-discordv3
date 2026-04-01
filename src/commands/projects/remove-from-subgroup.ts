import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('remove-from-subgroup')
    .setDescription('Retirer un membre du sous-groupe')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur à retirer').setRequired(true)
    )
    .addStringOption((option) =>
      option.setName('sous_groupe').setDescription('Nom du sous-groupe').setRequired(true)
    )
    .addStringOption((option) => option.setName('projet').setDescription('Nom du projet').setRequired(true))
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageRoles),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const user = interaction.options.getUser('utilisateur', true);
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

      // Vérifier le sous-groupe
      const subgroup = await db.client.subgroup.findFirst({
        where: { name: subgroupName, projectId: project.id },
      });

      if (!subgroup) {
        await interaction.followUp({ content: 'Sous-groupe non trouvé.', ephemeral: true });
        return;
      }

      // Retirer le membre
      const result = await db.client.subgroupMember.deleteMany({
        where: { userId: user.id, subgroupId: subgroup.id },
      });

      if (result.count === 0) {
        await interaction.followUp({
          content: "Cet utilisateur n'est pas dans ce sous-groupe.",
          ephemeral: true,
        });
        return;
      }

      const embed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Membre Retiré du Sous-groupe')
        .addFields(
          { name: 'Utilisateur', value: user.toString(), inline: true },
          { name: 'Sous-groupe', value: subgroupName, inline: true },
          { name: 'Projet', value: projectName, inline: true },
          { name: 'Retiré par', value: interaction.user.tag, inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Remove from subgroup error:', error);
      await interaction.followUp({ content: 'Erreur lors du retrait du sous-groupe.', ephemeral: true });
    }
  },
};
