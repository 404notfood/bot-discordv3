import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('stats')
    .setDescription('Statistiques du bot'),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    await interaction.deferReply();

    try {
      // Récupérer les statistiques de commandes
      const totalCommands = await db.client.commandLog.count();
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const todayCommands = await db.client.commandLog.count({
        where: { createdAt: { gte: today } },
      });

      // Calculer l'uptime
      const uptime = process.uptime();
      const days = Math.floor(uptime / 86400);
      const hours = Math.floor((uptime % 86400) / 3600);
      const minutes = Math.floor((uptime % 3600) / 60);

      const embed = new EmbedBuilder()
        .setColor(0x0099ff)
        .setTitle('📊 Statistiques du Bot')
        .addFields(
          { name: 'Serveurs', value: interaction.client.guilds.cache.size.toString(), inline: true },
          { name: 'Utilisateurs', value: interaction.client.users.cache.size.toString(), inline: true },
          { name: 'Commandes (Total)', value: totalCommands.toString(), inline: true },
          { name: "Commandes (Aujourd'hui)", value: todayCommands.toString(), inline: true },
          { name: 'Uptime', value: `${days}j ${hours}h ${minutes}m`, inline: true },
          {
            name: 'Mémoire',
            value: `${(process.memoryUsage().heapUsed / 1024 / 1024).toFixed(2)} MB`,
            inline: true,
          }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Stats error:', error);
      await interaction.followUp({
        content: 'Erreur lors de la récupération des statistiques.',
        ephemeral: true,
      });
    }
  },
};
