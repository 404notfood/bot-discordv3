import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  PermissionFlagsBits,
  ChannelType,
} from 'discord.js';
import { db } from '../../services/database';
import { PermissionsManager } from '../../services/permissions';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('config-dev-actif')
    .setDescription('Configurer le systeme de role Dev Actif automatique')
    .addRoleOption((option) =>
      option
        .setName('role')
        .setDescription('Role a attribuer aux membres actifs (5+ msg/jour pendant 5 jours)')
        .setRequired(false)
    )
    .addRoleOption((option) =>
      option
        .setName('role_immunise')
        .setDescription('Role immunise (ne perd jamais le role Dev Actif)')
        .setRequired(false)
    )
    .addChannelOption((option) =>
      option
        .setName('canal')
        .setDescription('Canal ou poster les messages d\'attribution/retrait du role')
        .addChannelTypes(ChannelType.GuildText)
        .setRequired(false)
    )
    .addBooleanOption((option) =>
      option
        .setName('desactiver')
        .setDescription('Desactiver le systeme Dev Actif')
        .setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.Administrator),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) return;

    if (!interaction.guildId) {
      await interaction.reply({
        content: 'Cette commande doit etre utilisee dans un serveur.',
        ephemeral: true,
      });
      return;
    }

    const role = interaction.options.getRole('role');
    const roleImmunise = interaction.options.getRole('role_immunise');
    const canal = interaction.options.getChannel('canal');
    const desactiver = interaction.options.getBoolean('desactiver');

    await interaction.deferReply({ ephemeral: true });

    try {
      const updateData: any = {};

      if (desactiver) {
        updateData.activeDevRoleId = null;
        updateData.activeDevChannelId = null;
        updateData.immuneRoleId = null;
      } else {
        if (role) updateData.activeDevRoleId = role.id;
        if (canal) updateData.activeDevChannelId = canal.id;
        if (roleImmunise) updateData.immuneRoleId = roleImmunise.id;
      }

      if (Object.keys(updateData).length === 0) {
        // Aucune option fournie → afficher la config actuelle
        const config = await db.client.guildConfig.findUnique({
          where: { guildId: interaction.guildId },
          select: { activeDevRoleId: true, activeDevChannelId: true, immuneRoleId: true },
        });

        const devRole = config?.activeDevRoleId
          ? interaction.guild!.roles.cache.get(config.activeDevRoleId)
          : null;
        const immuneRole = config?.immuneRoleId
          ? interaction.guild!.roles.cache.get(config.immuneRoleId)
          : null;

        const embed = new EmbedBuilder()
          .setColor(0x3498db)
          .setTitle('Configuration Dev Actif')
          .addFields(
            {
              name: 'Role Dev Actif',
              value: devRole ? `<@&${devRole.id}>` : 'Non configure',
              inline: true,
            },
            {
              name: 'Role Immunise',
              value: immuneRole ? `<@&${immuneRole.id}>` : 'Non configure',
              inline: true,
            },
            {
              name: 'Canal annonces',
              value: config?.activeDevChannelId ? `<#${config.activeDevChannelId}>` : 'Non configure',
              inline: true,
            },
            {
              name: 'Regles',
              value: [
                '• **Attribution** : 5+ messages/jour pendant 5 jours glissants',
                '• **Retrait** : 2 jours sans message',
                '• **Immunite** : les membres avec le role immunise ne perdent jamais le role',
              ].join('\n'),
            }
          )
          .setTimestamp();

        await interaction.followUp({ embeds: [embed] });
        return;
      }

      await db.client.guildConfig.update({
        where: { guildId: interaction.guildId },
        data: updateData,
      });

      const embed = new EmbedBuilder()
        .setColor(desactiver ? 0xe74c3c : 0x2ecc71)
        .setTitle(desactiver ? 'Systeme Dev Actif desactive' : 'Configuration Dev Actif mise a jour')
        .setTimestamp();

      if (!desactiver) {
        const fields = [];
        if (role) {
          fields.push({ name: 'Role Dev Actif', value: `<@&${role.id}>`, inline: true });
        }
        if (roleImmunise) {
          fields.push({ name: 'Role Immunise', value: `<@&${roleImmunise.id}>`, inline: true });
        }
        if (canal) {
          fields.push({ name: 'Canal annonces', value: `<#${canal.id}>`, inline: true });
        }
        fields.push({
          name: 'Regles',
          value: [
            '• **Attribution** : 5+ messages/jour pendant 5 jours glissants',
            '• **Retrait** : 2 jours sans message',
            '• **Immunite** : les membres immunises ne perdent jamais le role',
          ].join('\n'),
        });
        embed.addFields(fields);
      }

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('config-dev-actif error:', error);
      await interaction.followUp({
        content: 'Erreur lors de la configuration.',
        ephemeral: true,
      });
    }
  },
};
