import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { PermissionsManager } from '../../services/permissions';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('db-status')
    .setDescription('Vérifier le statut de la base de données'),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) return;

    await interaction.deferReply({ ephemeral: true });

    try {
      // Mesurer la latence de la base de données
      const start = Date.now();
      await db.client.$queryRaw`SELECT 1`;
      const latency = Date.now() - start;

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Statut Base de Données')
        .addFields(
          { name: 'Connexion', value: '🟢 Active', inline: true },
          { name: 'Latence', value: `${latency}ms`, inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('DB status error:', error);

      const embed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur Base de Données')
        .setDescription('Impossible de se connecter à la base de données')
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    }
  },
};
