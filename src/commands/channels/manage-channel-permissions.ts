import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  PermissionFlagsBits,
  ChannelType,
} from 'discord.js';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('manage-channel-permissions')
    .setDescription("Gérer les permissions d'un canal")
    .addChannelOption((option) =>
      option
        .setName('canal')
        .setDescription('Canal à modifier')
        .setRequired(true)
        .addChannelTypes(ChannelType.GuildText, ChannelType.GuildVoice)
    )
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur concerné').setRequired(true)
    )
    .addBooleanOption((option) =>
      option.setName('voir').setDescription('Autoriser à voir le canal').setRequired(true)
    )
    .addBooleanOption((option) =>
      option.setName('ecrire').setDescription('Autoriser à écrire dans le canal').setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageChannels),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const channel = interaction.options.getChannel('canal', true);
    const user = interaction.options.getUser('utilisateur', true);
    const voir = interaction.options.getBoolean('voir', true);
    const ecrire = interaction.options.getBoolean('ecrire');

    await interaction.deferReply({ ephemeral: true });

    try {
      const targetChannel = interaction.guild.channels.cache.get(channel.id);
      if (!targetChannel || !targetChannel.isTextBased()) {
        await interaction.followUp({ content: 'Canal invalide.', ephemeral: true });
        return;
      }

      // Construire les permissions à appliquer
      const permissions: any = {
        ViewChannel: voir,
      };

      if (ecrire !== null) {
        permissions.SendMessages = ecrire;
      }

      // Appliquer les permissions
      if ('permissionOverwrites' in targetChannel) {
        await (targetChannel as any).permissionOverwrites.edit(user.id, permissions);
      } else {
        await interaction.followUp({
          content: 'Ce canal ne supporte pas la gestion de permissions.',
          ephemeral: true,
        });
        return;
      }

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Permissions Mises à Jour')
        .addFields(
          { name: 'Canal', value: targetChannel.toString(), inline: true },
          { name: 'Utilisateur', value: user.toString(), inline: true },
          { name: 'Voir', value: voir ? '✅' : '❌', inline: true },
          { name: 'Écrire', value: ecrire === null ? '➖' : ecrire ? '✅' : '❌', inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Manage channel permissions error:', error);
      await interaction.followUp({
        content: 'Erreur lors de la modification des permissions.',
        ephemeral: true,
      });
    }
  },
};
