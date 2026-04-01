import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';

/**
 * Détermine le statut de la latence avec un indicateur visuel
 */
function getLatencyStatus(ping: number): string {
  if (ping < 100) return '🟢 Excellent';
  if (ping < 200) return '🟡 Bon';
  if (ping < 300) return '🟠 Moyen';
  return '🔴 Mauvais';
}

export default {
  data: new SlashCommandBuilder()
    .setName('ping')
    .setDescription('Vérifier la latence du bot'),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const sent = await interaction.reply({
      content: 'Calcul de la latence...',
      fetchReply: true,
    });

    const embed = new EmbedBuilder()
      .setColor(0x00ae86)
      .setTitle('🏓 Pong!')
      .addFields(
        {
          name: 'Latence du Bot',
          value: `${sent.createdTimestamp - interaction.createdTimestamp}ms`,
          inline: true,
        },
        {
          name: 'Latence API',
          value: `${Math.round(interaction.client.ws.ping)}ms`,
          inline: true,
        },
        {
          name: 'Statut',
          value: getLatencyStatus(interaction.client.ws.ping),
          inline: true,
        }
      )
      .setTimestamp();

    await interaction.editReply({ content: '', embeds: [embed] });
  },
};
