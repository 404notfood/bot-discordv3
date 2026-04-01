import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('create-subgroup')
    .setDescription('Créer un sous-groupe de projet')
    .addStringOption((option) => option.setName('nom').setDescription('Nom du sous-groupe').setRequired(true))
    .addStringOption((option) => option.setName('projet').setDescription('Nom du projet parent').setRequired(true))
    .addStringOption((option) =>
      option.setName('description').setDescription('Description du sous-groupe').setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageChannels),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const nom = interaction.options.getString('nom', true);
    const projetNom = interaction.options.getString('projet', true);
    const description = interaction.options.getString('description') || `Sous-groupe ${nom}`;

    await interaction.deferReply();

    try {
      // Vérifier que le projet parent existe
      const project = await db.client.project.findFirst({
        where: { name: projetNom, guildId: interaction.guild.id, isActive: true },
      });

      if (!project) {
        await interaction.followUp({ content: 'Projet parent non trouvé ou inactif.', ephemeral: true });
        return;
      }

      // Vérifier l'unicité du sous-groupe
      const existing = await db.client.subgroup.findFirst({
        where: { name: nom, projectId: project.id },
      });

      if (existing) {
        await interaction.followUp({
          content: 'Un sous-groupe avec ce nom existe déjà dans ce projet.',
          ephemeral: true,
        });
        return;
      }

      // Créer le sous-groupe
      await db.client.subgroup.create({
        data: {
          name: nom,
          description,
          projectId: project.id,
          guildId: interaction.guild.id,
          createdBy: interaction.user.id,
          createdAt: new Date(),
        },
      });

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Sous-groupe Créé')
        .addFields(
          { name: 'Nom', value: nom, inline: true },
          { name: 'Projet parent', value: projetNom, inline: true },
          { name: 'Description', value: description, inline: false },
          { name: 'Créé par', value: interaction.user.tag, inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Create subgroup error:', error);
      await interaction.followUp({ content: 'Erreur lors de la création du sous-groupe.', ephemeral: true });
    }
  },
};
