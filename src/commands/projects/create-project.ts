import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  ChannelType,
  PermissionFlagsBits,
} from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

/**
 * Retourne la couleur associée au type de projet
 */
function getProjectColor(type: string): number {
  const colors: Record<string, number> = {
    web: 0x61dafb,
    mobile: 0x34c759,
    game: 0xff6b35,
    ai: 0x8a2be2,
    opensource: 0xff4500,
    other: 0x0099ff,
  };
  return colors[type] || 0x0099ff;
}

/**
 * Retourne le label d'affichage du type de projet
 */
function getTypeDisplay(type: string): string {
  const types: Record<string, string> = {
    web: '🌐 Développement Web',
    mobile: '📱 Application Mobile',
    game: '🎮 Jeu Vidéo',
    ai: '🤖 Intelligence Artificielle',
    opensource: '📂 Open Source',
    other: '🔧 Autre',
  };
  return types[type] || '🔧 Autre';
}

export default {
  data: new SlashCommandBuilder()
    .setName('create-project')
    .setDescription('Créer un nouveau projet communautaire')
    .addStringOption((option) => option.setName('nom').setDescription('Nom du projet').setRequired(true))
    .addStringOption((option) => option.setName('description').setDescription('Description du projet').setRequired(true))
    .addStringOption((option) =>
      option
        .setName('type')
        .setDescription('Type de projet')
        .setRequired(false)
        .addChoices(
          { name: 'Développement Web', value: 'web' },
          { name: 'Application Mobile', value: 'mobile' },
          { name: 'Jeu Vidéo', value: 'game' },
          { name: 'Intelligence Artificielle', value: 'ai' },
          { name: 'Open Source', value: 'opensource' },
          { name: 'Autre', value: 'other' }
        )
    )
    .addBooleanOption((option) =>
      option.setName('prive').setDescription('Projet privé (canaux privés)').setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageChannels),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const nom = interaction.options.getString('nom', true);
    const description = interaction.options.getString('description', true);
    const type = interaction.options.getString('type') || 'other';
    const prive = interaction.options.getBoolean('prive') || false;

    await interaction.deferReply();

    try {
      // Vérifier qu'un projet avec ce nom n'existe pas déjà
      const existing = await db.client.project.findFirst({
        where: { name: nom, guildId: interaction.guild.id },
      });

      if (existing) {
        await interaction.followUp({ content: 'Un projet avec ce nom existe déjà.', ephemeral: true });
        return;
      }

      // Créer la catégorie Discord
      const category = await interaction.guild.channels.create({
        name: `📁 ${nom}`,
        type: ChannelType.GuildCategory,
        reason: `Projet créé par ${interaction.user.tag}`,
      });

      // Permissions de base
      const permissions = [
        {
          id: interaction.guild.id,
          deny: prive ? [PermissionFlagsBits.ViewChannel] : [],
        },
        {
          id: interaction.client.user.id,
          allow: [PermissionFlagsBits.ViewChannel, PermissionFlagsBits.SendMessages],
        },
      ];

      // Créer le canal textuel
      const textChannel = await interaction.guild.channels.create({
        name: `💬-${nom.toLowerCase().replace(/\s+/g, '-')}`,
        type: ChannelType.GuildText,
        parent: category.id,
        topic: description,
        permissionOverwrites: permissions,
        reason: `Canal textuel pour le projet ${nom}`,
      });

      // Créer le canal vocal
      const voiceChannel = await interaction.guild.channels.create({
        name: `🔊 ${nom}`,
        type: ChannelType.GuildVoice,
        parent: category.id,
        permissionOverwrites: permissions,
        reason: `Canal vocal pour le projet ${nom}`,
      });

      // Créer le rôle du projet
      const role = await interaction.guild.roles.create({
        name: `Project: ${nom}`,
        color: getProjectColor(type),
        reason: `Rôle pour le projet ${nom}`,
        mentionable: true,
      });

      // Attribuer le rôle au créateur
      const member = interaction.guild.members.cache.get(interaction.user.id);
      if (member) {
        await member.roles.add(role);
      }

      // Enregistrer en base de données
      await db.client.project.create({
        data: {
          name: nom,
          description,
          projectType: type as 'web' | 'mobile' | 'game' | 'ai' | 'opensource' | 'other',
          isPrivate: prive,
          guildId: interaction.guild.id,
          categoryId: category.id,
          textChannelId: textChannel.id,
          voiceChannelId: voiceChannel.id,
          roleId: role.id,
          createdBy: interaction.user.id,
          createdAt: new Date(),
        },
      });

      // Embed de confirmation
      const embed = new EmbedBuilder()
        .setColor(getProjectColor(type))
        .setTitle('🎉 Nouveau Projet Créé')
        .addFields(
          { name: 'Nom', value: nom, inline: true },
          { name: 'Type', value: getTypeDisplay(type), inline: true },
          { name: 'Visibilité', value: prive ? '🔒 Privé' : '🌐 Public', inline: true },
          { name: 'Description', value: description, inline: false },
          { name: 'Canaux', value: `📁 ${category}\n💬 ${textChannel}\n🔊 ${voiceChannel}`, inline: true },
          { name: 'Rôle', value: role.toString(), inline: true },
          { name: 'Créateur', value: interaction.user.toString(), inline: true }
        )
        .setTimestamp();

      await interaction.followUp({ embeds: [embed] });

      // Message de bienvenue dans le canal du projet
      const welcomeEmbed = new EmbedBuilder()
        .setColor(getProjectColor(type))
        .setTitle(`Bienvenue dans le projet ${nom}!`)
        .setDescription(description)
        .addFields(
          {
            name: 'Pour rejoindre',
            value: 'Les modérateurs peuvent vous ajouter avec `/add-to-subgroup`',
            inline: false,
          },
          {
            name: 'Gestion',
            value: 'Utilisez `/list-projects` pour voir tous les projets',
            inline: false,
          }
        )
        .setTimestamp()
        .setFooter({ text: `Créé par ${interaction.user.tag}` });

      await textChannel.send({ embeds: [welcomeEmbed] });
    } catch (error) {
      log.error('Create project error:', error);
      await interaction.followUp({ content: 'Erreur lors de la création du projet.', ephemeral: true });
    }
  },
};
