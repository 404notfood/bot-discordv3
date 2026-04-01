import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, version } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

/**
 * Formate le temps d'uptime en format lisible
 */
function formatUptime(seconds: number): string {
  const days = Math.floor(seconds / 86400);
  const hours = Math.floor((seconds % 86400) / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);

  if (days > 0) return `${days}j ${hours}h ${minutes}m`;
  if (hours > 0) return `${hours}h ${minutes}m`;
  return `${minutes}m`;
}

export default {
  data: new SlashCommandBuilder()
    .setName('info')
    .setDescription('Informations sur le bot et le serveur'),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    await interaction.deferReply();

    try {
      const guild = interaction.guild;
      if (!guild) {
        await interaction.followUp({
          content: 'Cette commande doit être utilisée dans un serveur.',
          ephemeral: true,
        });
        return;
      }

      const botUser = interaction.client.user;

      // Récupérer les statistiques de commandes
      const today = new Date();
      today.setHours(0, 0, 0, 0);

      const commandCount = await db.client.commandLog.count({
        where: {
          createdAt: { gte: today },
        },
      });

      const totalCommands = await db.client.commandLog.count();

      const embed = new EmbedBuilder()
        .setColor(0x0099ff)
        .setTitle('ℹ️ Informations Bot & Serveur')
        .setThumbnail(botUser.displayAvatarURL())
        .addFields(
          {
            name: '🤖 Bot',
            value: `**Nom:** ${botUser.tag}\n**ID:** ${botUser.id}\n**Créé le:** <t:${Math.floor(botUser.createdTimestamp / 1000)}:F>`,
            inline: true,
          },
          {
            name: '🏠 Serveur',
            value: `**Nom:** ${guild.name}\n**Membres:** ${guild.memberCount}\n**Créé le:** <t:${Math.floor(guild.createdTimestamp / 1000)}:F>`,
            inline: true,
          },
          {
            name: '📊 Statistiques',
            value: `**Commandes aujourd'hui:** ${commandCount}\n**Total commandes:** ${totalCommands}\n**Uptime:** ${formatUptime(process.uptime())}`,
            inline: true,
          },
          {
            name: '⚙️ Technique',
            value: `**Discord.js:** v${version}\n**Node.js:** ${process.version}\n**Mémoire:** ${(process.memoryUsage().heapUsed / 1024 / 1024).toFixed(2)} MB`,
            inline: true,
          },
          {
            name: '📌 Version',
            value: 'Taureau Celtique Bot v3.0\nTypeScript Edition',
            inline: true,
          }
        )
        .setTimestamp()
        .setFooter({
          text: `Demandé par ${interaction.user.tag}`,
          iconURL: interaction.user.displayAvatarURL(),
        });

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Info command error:', error);
      await interaction.followUp({
        content: 'Erreur lors de la récupération des informations.',
        ephemeral: true,
      });
    }
  },
};
