import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { db } from '../../services/database';
import { PermissionsManager } from '../../services/permissions';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('studi-config')
    .setDescription('Configurer le système Studi')
    .addStringOption((option) =>
      option.setName('api_url').setDescription("URL de l'API Studi").setRequired(false)
    )
    .addStringOption((option) =>
      option.setName('api_key').setDescription('Clé API Studi').setRequired(false)
    )
    .addBooleanOption((option) =>
      option.setName('actif').setDescription('Activer/désactiver le système').setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.Administrator),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) return;

    if (!interaction.guildId) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const apiUrl = interaction.options.getString('api_url');
    const apiKey = interaction.options.getString('api_key');
    const actif = interaction.options.getBoolean('actif');

    await interaction.deferReply({ ephemeral: true });

    try {
      // Construire les données de mise à jour
      const updateData: any = {};
      if (actif !== null) updateData.enabled = actif;
      if (Object.keys(updateData).length > 0) updateData.updatedAt = new Date();

      await db.client.studiConfig.upsert({
        where: { guildId: interaction.guildId },
        update: updateData,
        create: {
          guildId: interaction.guildId,
          enabled: actif || false,
        },
      });

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Configuration Studi Mise à Jour')
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Studi config error:', error);
      await interaction.followUp({ content: 'Erreur lors de la configuration.', ephemeral: true });
    }
  },
};
