import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('ban-remove')
    .setDescription('Débannir un utilisateur')
    .addStringOption((option) =>
      option
        .setName('user_id')
        .setDescription("ID de l'utilisateur à débannir")
        .setRequired(true)
    )
    .addStringOption((option) =>
      option.setName('raison').setDescription('Raison du débannissement').setRequired(false)
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

    const userId = interaction.options.getString('user_id', true);
    const raison = interaction.options.getString('raison') || 'Aucune raison fournie';

    try {
      // Vérifier que l'utilisateur est bien banni
      const bans = await interaction.guild.bans.fetch();
      const bannedUser = bans.get(userId);

      if (!bannedUser) {
        await interaction.reply({
          content: "Cet utilisateur n'est pas banni ou l'ID est incorrect.",
          ephemeral: true,
        });
        return;
      }

      // Exécuter le unban Discord
      await interaction.guild.members.unban(userId, `${raison} - Par ${interaction.user.tag}`);

      // Mettre à jour la base de données
      await db.client.bannedUser.updateMany({
        where: {
          userId,
          guildId: interaction.guild.id,
          unbannedAt: null,
        },
        data: {
          unbannedAt: new Date(),
          unbannedBy: interaction.user.id,
        },
      });

      // Créer le log de modération
      await db.client.moderationLog.create({
        data: {
          action: 'unban',
          userId,
          moderatorId: interaction.user.id,
          guildId: interaction.guild.id,
          reason: raison,
          executedAt: new Date(),
        },
      });

      const embed = new EmbedBuilder()
        .setColor(0x00ff00)
        .setTitle('✅ Utilisateur Débanni')
        .addFields(
          { name: 'Utilisateur', value: `${bannedUser.user.tag} (${userId})`, inline: true },
          { name: 'Modérateur', value: interaction.user.tag, inline: true },
          { name: 'Raison', value: raison, inline: false }
        )
        .setTimestamp();

      await interaction.reply({ embeds: [embed] });
    } catch (error) {
      log.error('Unban error:', error);
      await interaction.reply({
        content: "Erreur lors du débannissement. Vérifiez l'ID et mes permissions.",
        ephemeral: true,
      });
    }
  },
};
