import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('ban-add')
    .setDescription('Bannir un utilisateur')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur à bannir').setRequired(true)
    )
    .addStringOption((option) =>
      option.setName('raison').setDescription('Raison du bannissement').setRequired(false)
    )
    .addIntegerOption((option) =>
      option
        .setName('duree')
        .setDescription('Durée en jours (0 = permanent)')
        .setRequired(false)
        .setMinValue(0)
        .setMaxValue(365)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.BanMembers),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({
        content: 'Cette commande doit être utilisée dans un serveur.',
        ephemeral: true,
      });
      return;
    }

    const target = interaction.options.getUser('utilisateur', true);
    const raison = interaction.options.getString('raison') || 'Aucune raison fournie';
    const duree = interaction.options.getInteger('duree') || 0;

    // Vérifications de sécurité
    if (target.id === interaction.user.id) {
      await interaction.reply({
        content: 'Vous ne pouvez pas vous bannir vous-même.',
        ephemeral: true,
      });
      return;
    }

    if (target.id === interaction.client.user.id) {
      await interaction.reply({
        content: 'Je ne peux pas me bannir moi-même.',
        ephemeral: true,
      });
      return;
    }

    try {
      // Exécuter le ban Discord
      await interaction.guild.members.ban(target, {
        reason: `${raison} - Par ${interaction.user.tag}`,
      });

      // Calculer la date d'expiration si durée définie
      const expiresAt = duree > 0 ? new Date(Date.now() + duree * 24 * 60 * 60 * 1000) : null;

      // Enregistrer le ban en base de données
      await db.client.bannedUser.create({
        data: {
          userId: target.id,
          username: target.tag,
          reason: raison,
          bannedBy: interaction.user.id,
          guildId: interaction.guild.id,
          durationDays: duree,
          expiresAt,
          isActive: true,
          executedAt: new Date(),
        },
      });

      // Créer le log de modération
      await db.client.moderationLog.create({
        data: {
          action: 'ban',
          userId: target.id,
          moderatorId: interaction.user.id,
          guildId: interaction.guild.id,
          reason: raison,
          durationDays: duree,
          executedAt: new Date(),
        },
      });

      const embed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('🔨 Utilisateur Banni')
        .addFields(
          { name: 'Utilisateur', value: `${target.tag} (${target.id})`, inline: true },
          { name: 'Modérateur', value: interaction.user.tag, inline: true },
          { name: 'Raison', value: raison, inline: false },
          { name: 'Durée', value: duree > 0 ? `${duree} jour(s)` : 'Permanent', inline: true }
        )
        .setTimestamp();

      await interaction.reply({ embeds: [embed] });
    } catch (error) {
      log.error('Ban error:', error);
      await interaction.reply({
        content: 'Erreur lors du bannissement. Vérifiez mes permissions.',
        ephemeral: true,
      });
    }
  },
};
