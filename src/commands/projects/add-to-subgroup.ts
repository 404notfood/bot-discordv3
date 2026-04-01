import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('add-to-subgroup')
    .setDescription('Ajouter un membre au sous-groupe')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur à ajouter').setRequired(true)
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

      // Vérifier que l'utilisateur n'est pas déjà membre
      const existing = await db.client.subgroupMember.findFirst({
        where: { userId: user.id, subgroupId: subgroup.id },
      });

      if (existing) {
        await interaction.followUp({ content: 'Cet utilisateur est déjà dans ce sous-groupe.', ephemeral: true });
        return;
      }

      // Ajouter le membre au sous-groupe
      await db.client.subgroupMember.create({
        data: {
          userId: user.id,
          username: user.username,
          subgroupId: subgroup.id,
          addedBy: interaction.user.id,
          addedAt: new Date(),
        },
      });

      // Attribuer le rôle du projet si configuré
      const member = interaction.guild.members.cache.get(user.id);
      if (member && project.roleId) {
        const role = interaction.guild.roles.cache.get(project.roleId);
        if (role) {
          await member.roles.add(role);
        }
      }

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Membre Ajouté au Sous-groupe')
        .addFields(
          { name: 'Utilisateur', value: user.toString(), inline: true },
          { name: 'Sous-groupe', value: subgroupName, inline: true },
          { name: 'Projet', value: projectName, inline: true },
          { name: 'Ajouté par', value: interaction.user.tag, inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Add to subgroup error:', error);
      await interaction.followUp({ content: "Erreur lors de l'ajout au sous-groupe.", ephemeral: true });
    }
  },
};
