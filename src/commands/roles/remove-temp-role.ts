import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { temporaryRolesService } from '../../services/temporary-roles';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('remove-temp-role')
    .setDescription('Retirer un rôle temporaire')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur dont retirer le rôle').setRequired(true)
    )
    .addRoleOption((option) => option.setName('role').setDescription('Rôle à retirer').setRequired(true))
    .addStringOption((option) =>
      option.setName('raison').setDescription('Raison du retrait').setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageRoles),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    // Vérification des permissions
    if (!interaction.memberPermissions?.has(PermissionFlagsBits.ManageRoles)) {
      await interaction.reply({
        content: '❌ Vous devez avoir la permission "Gérer les rôles" pour utiliser cette commande.',
        ephemeral: true,
      });
      return;
    }

    await interaction.deferReply();

    try {
      const user = interaction.options.getUser('utilisateur', true);
      const role = interaction.options.getRole('role', true);
      const raison = interaction.options.getString('raison') || 'Retrait manuel';

      const result = await temporaryRolesService.removeTemporaryRole(
        interaction.client,
        user.id,
        interaction.guild.id,
        role.id,
        interaction.user.id
      );

      if (!result.success) {
        await interaction.followUp({
          content: '❌ Erreur lors du retrait du rôle temporaire',
          ephemeral: true,
        });
        return;
      }

      const embed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('🗑️ Rôle Temporaire Retiré')
        .setDescription('Le rôle temporaire a été retiré avec succès')
        .addFields(
          { name: '👤 Utilisateur', value: `${user}`, inline: true },
          { name: '🎭 Rôle', value: `${role}`, inline: true },
          { name: '📝 Raison', value: raison, inline: false }
        )
        .setTimestamp()
        .setFooter({
          text: `Retiré par ${interaction.user.username}`,
          iconURL: interaction.user.displayAvatarURL(),
        });

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Remove temp role error:', error);

      const errorEmbed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur')
        .setDescription('Une erreur est survenue lors du retrait du rôle temporaire.')
        .setTimestamp();

      await interaction.followUp({ embeds: [errorEmbed] });
    }
  },
};
