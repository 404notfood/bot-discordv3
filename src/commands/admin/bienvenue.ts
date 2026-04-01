import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  ChannelType,
  PermissionFlagsBits,
} from 'discord.js';
import { PermissionsManager } from '../../services/permissions';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('bienvenue')
    .setDescription('Configurer le systeme de bienvenue automatique')
    .addSubcommand((sub) =>
      sub
        .setName('setup')
        .setDescription('Configurer le canal de bienvenue et le role nouvel utilisateur')
        .addChannelOption((option) =>
          option
            .setName('canal')
            .setDescription('Canal ou envoyer les messages de bienvenue')
            .addChannelTypes(ChannelType.GuildText)
            .setRequired(true)
        )
        .addRoleOption((option) =>
          option
            .setName('role')
            .setDescription('Role "Nouvel utilisateur" attribue automatiquement (retire au premier message)')
            .setRequired(false)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('message')
        .setDescription('Personnaliser le message de bienvenue')
        .addStringOption((option) =>
          option
            .setName('texte')
            .setDescription('Message personnalise. Variables: {user} {username} {server} {count}')
            .setRequired(true)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('status')
        .setDescription('Voir la configuration actuelle du systeme de bienvenue')
    )
    .addSubcommand((sub) =>
      sub
        .setName('activer')
        .setDescription('Activer le systeme de bienvenue')
    )
    .addSubcommand((sub) =>
      sub
        .setName('desactiver')
        .setDescription('Desactiver le systeme de bienvenue')
    )
    .addSubcommand((sub) =>
      sub
        .setName('test')
        .setDescription('Tester le message de bienvenue (simule ton arrivee)')
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageGuild),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) return;

    const guildId = interaction.guildId;
    if (!guildId) {
      await interaction.reply({ content: 'Commande reservee aux serveurs.', ephemeral: true });
      return;
    }

    const sub = interaction.options.getSubcommand();

    switch (sub) {
      case 'setup':
        await handleSetup(interaction, guildId);
        break;
      case 'message':
        await handleMessage(interaction, guildId);
        break;
      case 'status':
        await handleStatus(interaction, guildId);
        break;
      case 'activer':
        await handleToggle(interaction, guildId, true);
        break;
      case 'desactiver':
        await handleToggle(interaction, guildId, false);
        break;
      case 'test':
        await handleTest(interaction, guildId);
        break;
    }
  },
};

// ============================================================
// Handlers
// ============================================================

async function handleSetup(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const channel = interaction.options.getChannel('canal', true);
  const role = interaction.options.getRole('role');

  try {
    await db.client.guildConfig.upsert({
      where: { guildId },
      update: {
        welcomeChannelId: channel.id,
        welcomeMessages: true,
        ...(role && { autoRoleId: role.id, autoRoles: true }),
      },
      create: {
        guildId,
        guildName: interaction.guild?.name || 'Inconnu',
        welcomeChannelId: channel.id,
        welcomeMessages: true,
        ...(role && { autoRoleId: role.id, autoRoles: true }),
      },
    });

    const embed = new EmbedBuilder()
      .setColor(0x00CC66)
      .setTitle('Systeme de bienvenue configure')
      .addFields(
        { name: 'Canal', value: `<#${channel.id}>`, inline: true },
        { name: 'Actif', value: 'Oui', inline: true },
      );

    if (role) {
      embed.addFields({
        name: 'Role nouvel utilisateur',
        value: `<@&${role.id}> (retire au premier message)`,
        inline: false,
      });
    }

    embed.setFooter({ text: 'Utilise /bienvenue test pour tester' });

    await interaction.reply({ embeds: [embed] });
  } catch (error) {
    log.error('Bienvenue setup error', { error });
    await interaction.reply({ content: 'Erreur lors de la configuration.', ephemeral: true });
  }
}

async function handleMessage(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const texte = interaction.options.getString('texte', true);

  try {
    await db.client.guildConfig.update({
      where: { guildId },
      data: { welcomeMessage: texte },
    });

    // Apercu avec les variables remplacees
    const preview = texte
      .replace('{user}', `<@${interaction.user.id}>`)
      .replace('{username}', interaction.user.username)
      .replace('{server}', interaction.guild?.name || 'Serveur')
      .replace('{count}', String(interaction.guild?.memberCount || 0));

    const embed = new EmbedBuilder()
      .setColor(0x3498DB)
      .setTitle('Message de bienvenue mis a jour')
      .addFields(
        { name: 'Message brut', value: texte.substring(0, 1024), inline: false },
        { name: 'Apercu', value: preview.substring(0, 1024), inline: false },
      )
      .setFooter({ text: 'Variables: {user} {username} {server} {count}' });

    await interaction.reply({ embeds: [embed] });
  } catch (error) {
    log.error('Bienvenue message error', { error });
    await interaction.reply({ content: 'Erreur. Utilise `/bienvenue setup` d\'abord.', ephemeral: true });
  }
}

async function handleStatus(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const config = await db.client.guildConfig.findUnique({
    where: { guildId },
    select: {
      welcomeMessages: true,
      welcomeChannelId: true,
      welcomeMessage: true,
      autoRoles: true,
      autoRoleId: true,
    },
  });

  if (!config) {
    await interaction.reply({
      content: 'Le systeme de bienvenue n\'est pas configure. Utilise `/bienvenue setup`.',
      ephemeral: true,
    });
    return;
  }

  const embed = new EmbedBuilder()
    .setColor(config.welcomeMessages ? 0x00CC66 : 0xFF6B35)
    .setTitle('Configuration bienvenue')
    .addFields(
      { name: 'Statut', value: config.welcomeMessages ? 'Actif' : 'Inactif', inline: true },
      { name: 'Canal', value: config.welcomeChannelId ? `<#${config.welcomeChannelId}>` : 'Non configure', inline: true },
      { name: 'Role auto', value: config.autoRoles && config.autoRoleId ? `<@&${config.autoRoleId}> (retire au 1er message)` : 'Desactive', inline: true },
      { name: 'Message', value: config.welcomeMessage || 'Message par defaut', inline: false },
    )
    .setTimestamp();

  await interaction.reply({ embeds: [embed] });
}

async function handleToggle(interaction: ChatInputCommandInteraction, guildId: string, active: boolean): Promise<void> {
  try {
    await db.client.guildConfig.update({
      where: { guildId },
      data: { welcomeMessages: active },
    });

    await interaction.reply({
      embeds: [
        new EmbedBuilder()
          .setColor(active ? 0x00CC66 : 0xFF6B35)
          .setTitle(active ? 'Bienvenue active' : 'Bienvenue desactive')
          .setDescription(
            active
              ? 'Les nouveaux membres recevront un message de bienvenue.'
              : 'Les messages de bienvenue sont desactives.'
          ),
      ],
    });
  } catch (error) {
    await interaction.reply({ content: 'Erreur. Utilise `/bienvenue setup` d\'abord.', ephemeral: true });
  }
}

async function handleTest(interaction: ChatInputCommandInteraction, guildId: string): Promise<void> {
  const config = await db.client.guildConfig.findUnique({
    where: { guildId },
    select: { welcomeMessages: true, welcomeChannelId: true, welcomeMessage: true },
  });

  if (!config?.welcomeChannelId) {
    await interaction.reply({
      content: 'Le systeme de bienvenue n\'est pas configure. Utilise `/bienvenue setup`.',
      ephemeral: true,
    });
    return;
  }

  const member = interaction.member;
  const guild = interaction.guild!;
  const memberCount = guild.memberCount;
  const user = interaction.user;

  const description = config.welcomeMessage
    ? config.welcomeMessage
        .replace('{user}', `<@${user.id}>`)
        .replace('{username}', user.username)
        .replace('{server}', guild.name)
        .replace('{count}', String(memberCount))
    : [
        `Hey <@${user.id}> ! Bienvenue sur **${guild.name}**`,
        '',
        `Tu es notre **${memberCount}e** membre.`,
        '',
        'N\'hesite pas a te presenter et a poser des questions.',
        'On est la pour s\'entraider entre devs.',
      ].join('\n');

  const embed = new EmbedBuilder()
    .setColor(0x00CC66)
    .setTitle('Nouveau membre !')
    .setDescription(description)
    .setThumbnail(user.displayAvatarURL({ size: 256 }))
    .addFields(
      { name: 'Compte cree', value: `<t:${Math.floor(user.createdTimestamp / 1000)}:R>`, inline: true },
      { name: 'Membres', value: `${memberCount}`, inline: true },
    )
    .setTimestamp()
    .setFooter({ text: `${guild.name} (TEST)`, iconURL: guild.iconURL() || undefined });

  await interaction.reply({
    content: 'Voici un apercu du message de bienvenue :',
    embeds: [embed],
    ephemeral: true,
  });
}
