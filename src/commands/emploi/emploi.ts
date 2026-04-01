import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  ChannelType,
  PermissionFlagsBits,
} from 'discord.js';
import { PermissionsManager } from '../../services/permissions';
import { jobOffersService } from '../../services/job-offers';

// ============================================
// HANDLERS
// ============================================

/**
 * Configure le canal pour les annonces d'emploi
 */
async function handleSetup(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const channel = interaction.options.getChannel('canal', true);

  try {
    const config = await jobOffersService.setupConfig(guildId, channel.id);

    const embed = new EmbedBuilder()
      .setColor(0x00cc66)
      .setTitle("✅ Service d'annonces d'emploi configuré")
      .setDescription(`Les annonces d'emploi dev junior seront publiées dans <#${channel.id}>`)
      .addFields(
        { name: '📋 Mots-clés', value: config.keywords, inline: false },
        { name: '📄 Contrats', value: config.contractTypes || 'Tous', inline: true },
        { name: '📍 Départements', value: config.departments || 'Toute la France', inline: true },
        { name: '⏰ Intervalle', value: `${config.pollInterval} minutes`, inline: true },
        { name: '📊 Max offres/cycle', value: `${config.maxOffersPerPoll}`, inline: true }
      )
      .setFooter({ text: 'Le service va commencer à chercher des offres dans quelques secondes...' })
      .setTimestamp();

    await interaction.reply({ embeds: [embed] });
  } catch (error) {
    const err = error as Error;
    await interaction.reply({
      content: `Erreur lors de la configuration: ${err.message}`,
      ephemeral: true,
    });
  }
}

/**
 * Modifie la configuration des annonces ou affiche la config actuelle
 */
async function handleConfig(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const config = await jobOffersService.getConfig(guildId);

  if (!config) {
    await interaction.reply({
      content: "Le service n'est pas encore configuré. Utilisez `/emploi setup` d'abord.",
      ephemeral: true,
    });
    return;
  }

  // Collecter les modifications
  const updates: Record<string, any> = {};

  const keywords = interaction.options.getString('mots_cles');
  if (keywords) updates.keywords = keywords;

  const departements = interaction.options.getString('departements');
  if (departements) {
    updates.departments = departements.toLowerCase() === 'tous' ? null : departements;
  }

  const contrats = interaction.options.getString('contrats');
  if (contrats) updates.contractTypes = contrats.toUpperCase();

  const intervalle = interaction.options.getInteger('intervalle');
  if (intervalle) updates.pollInterval = intervalle;

  const maxOffres = interaction.options.getInteger('max_offres');
  if (maxOffres) updates.maxOffersPerPoll = maxOffres;

  // Si aucune modification, afficher la config actuelle
  if (Object.keys(updates).length === 0) {
    const embed = new EmbedBuilder()
      .setColor(0x3498db)
      .setTitle('⚙️ Configuration actuelle des annonces')
      .addFields(
        { name: '📋 Mots-clés', value: config.keywords, inline: false },
        { name: '📄 Contrats', value: config.contractTypes || 'Tous', inline: true },
        { name: '📍 Départements', value: config.departments || 'Toute la France', inline: true },
        { name: '⏰ Intervalle', value: `${config.pollInterval} minutes`, inline: true },
        { name: '📊 Max offres/cycle', value: `${config.maxOffersPerPoll}`, inline: true },
        { name: '🔄 Actif', value: config.isActive ? 'Oui' : 'Non', inline: true },
        { name: '📢 Canal', value: config.channelId ? `<#${config.channelId}>` : 'Non configuré', inline: true }
      )
      .setTimestamp();

    await interaction.reply({ embeds: [embed] });
    return;
  }

  // Appliquer les modifications
  try {
    const updatedConfig = await jobOffersService.updateConfig(guildId, updates);

    const embed = new EmbedBuilder()
      .setColor(0x00cc66)
      .setTitle('✅ Configuration mise à jour')
      .addFields(
        Object.entries(updates).map(([key, value]) => ({
          name: key,
          value: String(value ?? 'Toute la France'),
          inline: true,
        }))
      )
      .setTimestamp();

    await interaction.reply({ embeds: [embed] });
  } catch (error) {
    const err = error as Error;
    await interaction.reply({
      content: `Erreur: ${err.message}`,
      ephemeral: true,
    });
  }
}

/**
 * Affiche le statut et les statistiques du service
 */
async function handleStatus(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const config = await jobOffersService.getConfig(guildId);

  if (!config) {
    await interaction.reply({
      content: "Le service n'est pas encore configuré. Utilisez `/emploi setup` d'abord.",
      ephemeral: true,
    });
    return;
  }

  const stats = await jobOffersService.getStats(guildId);

  const embed = new EmbedBuilder()
    .setColor(config.isActive ? 0x00cc66 : 0xff6b35)
    .setTitle("📊 Statut du service d'annonces d'emploi")
    .addFields(
      { name: '🔄 Statut', value: config.isActive ? '🟢 Actif' : '🔴 Inactif', inline: true },
      { name: '📢 Canal', value: config.channelId ? `<#${config.channelId}>` : 'Non configuré', inline: true },
      { name: '⏰ Intervalle', value: `${config.pollInterval} min`, inline: true },
      { name: '📋 Mots-clés', value: config.keywords.substring(0, 200), inline: false },
      { name: '📄 Contrats', value: config.contractTypes || 'Tous', inline: true },
      { name: '📍 Départements', value: config.departments || 'Toute la France', inline: true },
      { name: '\u200B', value: '**--- Statistiques ---**', inline: false },
      { name: '📊 Total publié', value: `${stats.totalPosted} offre(s)`, inline: true },
      { name: "📅 Aujourd'hui", value: `${stats.todayPosted} offre(s)`, inline: true },
      {
        name: '🕐 Dernière publication',
        value: stats.lastPosted
          ? `<t:${Math.floor(stats.lastPosted.getTime() / 1000)}:R>`
          : 'Aucune',
        inline: true,
      }
    )
    .setTimestamp();

  await interaction.reply({ embeds: [embed] });
}

/**
 * Active le service d'annonces
 */
async function handleStart(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const config = await jobOffersService.getConfig(guildId);

  if (!config) {
    await interaction.reply({
      content: "Le service n'est pas encore configuré. Utilisez `/emploi setup` d'abord.",
      ephemeral: true,
    });
    return;
  }

  if (!config.channelId) {
    await interaction.reply({
      content: "Aucun canal configuré. Utilisez `/emploi setup` d'abord.",
      ephemeral: true,
    });
    return;
  }

  if (config.isActive) {
    await interaction.reply({ content: 'Le service est déjà actif.', ephemeral: true });
    return;
  }

  await jobOffersService.updateConfig(guildId, { isActive: true });

  await interaction.reply({
    embeds: [
      new EmbedBuilder()
        .setColor(0x00cc66)
        .setTitle("🟢 Service d'annonces activé")
        .setDescription(
          `Les annonces seront publiées dans <#${config.channelId}> toutes les ${config.pollInterval} minutes.`
        )
        .setTimestamp(),
    ],
  });
}

/**
 * Désactive le service d'annonces
 */
async function handleStop(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const config = await jobOffersService.getConfig(guildId);

  if (!config || !config.isActive) {
    await interaction.reply({ content: "Le service n'est pas actif.", ephemeral: true });
    return;
  }

  await jobOffersService.disableConfig(guildId);

  await interaction.reply({
    embeds: [
      new EmbedBuilder()
        .setColor(0xff6b35)
        .setTitle("🔴 Service d'annonces désactivé")
        .setDescription('Le service a été arrêté. Les offres ne seront plus publiées.')
        .setTimestamp(),
    ],
  });
}

/**
 * Force une recherche immédiate d'offres
 */
async function handlePoll(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const config = await jobOffersService.getConfig(guildId);

  if (!config || !config.channelId) {
    await interaction.reply({
      content: "Le service n'est pas encore configuré. Utilisez `/emploi setup` d'abord.",
      ephemeral: true,
    });
    return;
  }

  await interaction.deferReply();

  try {
    const posted = await jobOffersService.postNewOffers(guildId);

    const embed = new EmbedBuilder()
      .setColor(posted > 0 ? 0x00cc66 : 0x3498db)
      .setTitle("🔍 Recherche d'offres terminée")
      .setDescription(
        posted > 0
          ? `**${posted}** nouvelle(s) offre(s) publiée(s) dans <#${config.channelId}>`
          : 'Aucune nouvelle offre trouvée pour le moment.'
      )
      .setTimestamp();

    await interaction.editReply({ embeds: [embed] });
  } catch (error) {
    const err = error as Error;
    await interaction.editReply({
      content: `Erreur lors de la recherche: ${err.message}`,
    });
  }
}

export default {
  data: new SlashCommandBuilder()
    .setName('emploi')
    .setDescription("Gestion du service d'annonces d'emploi dev junior")
    .addSubcommand((sub) =>
      sub
        .setName('setup')
        .setDescription("Configurer le canal des annonces d'emploi")
        .addChannelOption((option) =>
          option
            .setName('canal')
            .setDescription('Le canal où poster les annonces')
            .addChannelTypes(ChannelType.GuildText)
            .setRequired(true)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('config')
        .setDescription('Modifier la configuration des annonces')
        .addStringOption((option) =>
          option
            .setName('mots_cles')
            .setDescription('Mots-clés de recherche (séparés par des virgules)')
            .setRequired(false)
        )
        .addStringOption((option) =>
          option
            .setName('departements')
            .setDescription('Codes département (ex: 75,92,93 ou "tous" pour toute la France)')
            .setRequired(false)
        )
        .addStringOption((option) =>
          option
            .setName('contrats')
            .setDescription('Types de contrat (CDI,CDD,MIS,SAI,LIB)')
            .setRequired(false)
        )
        .addIntegerOption((option) =>
          option
            .setName('intervalle')
            .setDescription('Intervalle de vérification en minutes (min: 15, max: 120)')
            .setMinValue(15)
            .setMaxValue(120)
            .setRequired(false)
        )
        .addIntegerOption((option) =>
          option
            .setName('max_offres')
            .setDescription("Nombre max d'offres par cycle (1-10)")
            .setMinValue(1)
            .setMaxValue(10)
            .setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub.setName('status').setDescription("Voir le statut et les stats du service d'annonces")
    )
    .addSubcommand((sub) => sub.setName('start').setDescription("Activer le service d'annonces"))
    .addSubcommand((sub) => sub.setName('stop').setDescription("Désactiver le service d'annonces"))
    .addSubcommand((sub) => sub.setName('poll').setDescription("Forcer une recherche immédiate d'offres"))
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageGuild),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) {
      return;
    }

    const guildId = interaction.guildId;
    if (!guildId) {
      await interaction.reply({
        content: 'Cette commande doit être utilisée dans un serveur.',
        ephemeral: true,
      });
      return;
    }

    const subcommand = interaction.options.getSubcommand();

    switch (subcommand) {
      case 'setup':
        await handleSetup(interaction, guildId);
        break;
      case 'config':
        await handleConfig(interaction, guildId);
        break;
      case 'status':
        await handleStatus(interaction, guildId);
        break;
      case 'start':
        await handleStart(interaction, guildId);
        break;
      case 'stop':
        await handleStop(interaction, guildId);
        break;
      case 'poll':
        await handlePoll(interaction, guildId);
        break;
    }
  },
};
