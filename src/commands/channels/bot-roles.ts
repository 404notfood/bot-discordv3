import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';

export default {
  data: new SlashCommandBuilder()
    .setName('bot-roles')
    .setDescription('Afficher les rôles du bot'),

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

    // Filtrer le rôle @everyone
    const roles = botMember.roles.cache.filter((r) => r.id !== interaction.guild!.id);

    const embed = new EmbedBuilder()
      .setColor(0x0099ff)
      .setTitle('🎭 Rôles du Bot')
      .setDescription(`**${roles.size}** rôles`)
      .addFields({
        name: 'Rôles',
        value: roles.map((r) => r.toString()).join(', ') || 'Aucun',
        inline: false,
      })
      .setTimestamp();

    await interaction.reply({ embeds: [embed], ephemeral: true });
  },
};
