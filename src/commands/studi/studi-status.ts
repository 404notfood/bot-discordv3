import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('studi-status')
    .setDescription('Voir le statut du système Studi'),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guildId) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    await interaction.deferReply({ ephemeral: true });

    try {
      const config = await db.client.studiConfig.findUnique({
        where: { guildId: interaction.guildId },
      });

      const embed = new EmbedBuilder()
        .setColor(config?.enabled ? 0x00ff00 : 0xff0000)
        .setTitle('📊 Statut Système Studi')
        .addFields(
          { name: 'Statut', value: config?.enabled ? '🟢 Actif' : '🔴 Inactif', inline: true },
          { name: 'Auto Ban', value: config?.autoBan ? '✅ Activé' : '❌ Désactivé', inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Studi status error:', error);
      await interaction.followUp({ content: 'Erreur lors de la récupération du statut.', ephemeral: true });
    }
  },
};
