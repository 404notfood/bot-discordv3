import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, ChannelType, PermissionFlagsBits } from 'discord.js';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('create-private-channel')
    .setDescription('Créer un canal privé')
    .addStringOption((option) =>
      option.setName('nom').setDescription('Nom du canal').setRequired(true)
    )
    .addUserOption((option) =>
      option.setName('membre').setDescription('Premier membre à ajouter').setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageChannels),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const nom = interaction.options.getString('nom', true);
    const membre = interaction.options.getUser('membre');

    await interaction.deferReply({ ephemeral: true });

    try {
      // Créer le canal privé avec les permissions de base
      const channel = await interaction.guild.channels.create({
        name: nom,
        type: ChannelType.GuildText,
        permissionOverwrites: [
          {
            id: interaction.guild.id,
            deny: [PermissionFlagsBits.ViewChannel],
          },
          {
            id: interaction.user.id,
            allow: [PermissionFlagsBits.ViewChannel, PermissionFlagsBits.SendMessages],
          },
        ],
      });

      // Ajouter un membre supplémentaire si spécifié
      if (membre) {
        await channel.permissionOverwrites.create(membre.id, {
          ViewChannel: true,
          SendMessages: true,
        });
      }

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Canal Privé Créé')
        .addFields(
          { name: 'Canal', value: channel.toString(), inline: true },
          { name: 'Créateur', value: interaction.user.toString(), inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Create private channel error:', error);
      await interaction.followUp({ content: 'Erreur lors de la création du canal.', ephemeral: true });
    }
  },
};
