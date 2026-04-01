import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';

export default {
  data: new SlashCommandBuilder()
    .setName('bot-permissions')
    .setDescription('Afficher les permissions du bot'),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const botMember = interaction.guild.members.me;
    if (!botMember) {
      await interaction.reply({ content: 'Impossible de récupérer les informations du bot.', ephemeral: true });
      return;
    }

    const permissions = botMember.permissions.toArray();

    const embed = new EmbedBuilder()
      .setColor(0x0099ff)
      .setTitle('🤖 Permissions du Bot')
      .setDescription(`**${permissions.length}** permissions accordées`)
      .addFields({
        name: 'Permissions',
        value: permissions.map((p) => `• ${p}`).join('\n') || 'Aucune',
        inline: false,
      })
      .setTimestamp();

    await interaction.reply({ embeds: [embed], ephemeral: true });
  },
};
