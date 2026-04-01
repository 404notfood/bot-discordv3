import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { PermissionsManager } from '../../services/permissions';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('add-admin')
    .setDescription('Ajouter un administrateur du bot')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur à promouvoir admin').setRequired(true)
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) return;

    if (!interaction.guildId) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const user = interaction.options.getUser('utilisateur', true);

    await interaction.deferReply({ ephemeral: true });

    try {
      // Ajouter ou mettre à jour l'admin en base de données
      await db.client.botAdmin.upsert({
        where: {
          userId_guildId: {
            userId: user.id,
            guildId: interaction.guildId,
          },
        },
        update: {
          username: user.username,
        },
        create: {
          userId: user.id,
          username: user.username,
          guildId: interaction.guildId,
          adminLevel: 'server',
          addedBy: interaction.user.id,
          addedAt: new Date(),
        },
      });

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Administrateur Ajouté')
        .addFields({ name: 'Utilisateur', value: user.toString(), inline: true })
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Add admin error:', error);
      await interaction.followUp({
        content: "Erreur lors de l'ajout de l'administrateur.",
        ephemeral: true,
      });
    }
  },
};
