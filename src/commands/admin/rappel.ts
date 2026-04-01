import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('rappel')
    .setDescription('Créer un rappel')
    .addStringOption((option) =>
      option.setName('message').setDescription('Message du rappel').setRequired(true)
    )
    .addIntegerOption((option) =>
      option
        .setName('temps')
        .setDescription('Temps en minutes')
        .setRequired(true)
        .setMinValue(1)
        .setMaxValue(10080) // 7 jours max
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const message = interaction.options.getString('message', true);
    const temps = interaction.options.getInteger('temps', true);

    const embed = new EmbedBuilder()
      .setColor(0xffaa00)
      .setTitle('⏰ Rappel Programmé')
      .setDescription(`Je vous rappellerai dans **${temps} minute${temps > 1 ? 's' : ''}**.`)
      .addFields([
        {
          name: 'Message',
          value: message,
          inline: false,
        },
      ])
      .setTimestamp();

    await interaction.reply({ embeds: [embed] });

    // Programmer le rappel
    setTimeout(async () => {
      try {
        const reminderEmbed = new EmbedBuilder()
          .setColor(0xff0000)
          .setTitle('🔔 Rappel!')
          .setDescription(message)
          .addFields([
            {
              name: 'Programmé il y a',
              value: `${temps} minute${temps > 1 ? 's' : ''}`,
              inline: false,
            },
          ])
          .setTimestamp();

        await interaction.followUp({
          content: `<@${interaction.user.id}>`,
          embeds: [reminderEmbed],
        });
      } catch (error) {
        log.error('Reminder error:', error);
      }
    }, temps * 60 * 1000);
  },
};
