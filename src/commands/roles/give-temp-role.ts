import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { temporaryRolesService } from '../../services/temporary-roles';
import { log } from '../../services/logger';

/**
 * Calcule la durée en millisecondes selon l'unité choisie
 */
function calculateDurationMs(duree: number, unite: 'minutes' | 'hours' | 'days' | 'weeks'): number {
  const multipliers = {
    minutes: 60 * 1000,
    hours: 60 * 60 * 1000,
    days: 24 * 60 * 60 * 1000,
    weeks: 7 * 24 * 60 * 60 * 1000,
  };
  return duree * multipliers[unite];
}

export default {
  data: new SlashCommandBuilder()
    .setName('give-temp-role')
    .setDescription('Attribuer un rôle temporaire à un utilisateur')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur à qui donner le rôle').setRequired(true)
    )
    .addRoleOption((option) =>
      option.setName('role').setDescription('Rôle à attribuer temporairement').setRequired(true)
    )
    .addIntegerOption((option) =>
      option.setName('duree').setDescription('Durée en nombre').setRequired(true).setMinValue(1).setMaxValue(365)
    )
    .addStringOption((option) =>
      option
        .setName('unite')
        .setDescription('Unité de temps')
        .setRequired(true)
        .addChoices(
          { name: 'Minutes', value: 'minutes' },
          { name: 'Heures', value: 'hours' },
          { name: 'Jours', value: 'days' },
          { name: 'Semaines', value: 'weeks' }
        )
    )
    .addStringOption((option) =>
      option.setName('raison').setDescription("Raison de l'attribution du rôle").setRequired(false)
    )
    .addStringOption((option) =>
      option
        .setName('source')
        .setDescription("Source de l'attribution")
        .setRequired(false)
        .addChoices(
          { name: 'Manuel', value: 'manual' },
          { name: 'Quiz', value: 'quiz' },
          { name: 'Animation', value: 'animation' },
          { name: 'Événement', value: 'event' },
          { name: 'Récompense', value: 'reward' }
        )
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
      const duree = interaction.options.getInteger('duree', true);
      const unite = interaction.options.getString('unite', true) as 'minutes' | 'hours' | 'days' | 'weeks';
      const raison = interaction.options.getString('raison') || 'Attribution manuelle';
      const source = interaction.options.getString('source') || 'manual';

      // Vérifier la hiérarchie des rôles
      if (role.position >= interaction.guild.members.me!.roles.highest.position) {
        await interaction.followUp({
          content: `❌ Je ne peux pas attribuer le rôle **${role.name}** car il est trop élevé dans la hiérarchie.`,
          ephemeral: true,
        });
        return;
      }

      // Calculer la durée en millisecondes
      const durationMs = calculateDurationMs(duree, unite);

      // Attribuer le rôle temporaire via le service
      const result = await temporaryRolesService.giveTemporaryRole(interaction.client, {
        userId: user.id,
        guildId: interaction.guild.id,
        roleId: role.id,
        durationMs: durationMs,
        reason: raison,
        source,
        grantedBy: interaction.user.id,
      });

      const embed = new EmbedBuilder()
        .setColor(result.action === 'granted' ? 0x00ff00 : 0xffa500)
        .setTitle(result.action === 'granted' ? '✅ Rôle Temporaire Accordé' : '🔄 Rôle Temporaire Étendu')
        .setDescription(
          `${result.action === 'granted' ? 'Le rôle a été attribué' : 'La durée du rôle a été étendue'} avec succès`
        )
        .addFields(
          { name: '👤 Utilisateur', value: `${user}`, inline: true },
          { name: '🎭 Rôle', value: `${role}`, inline: true },
          { name: '⏱️ Durée', value: `${duree} ${unite}`, inline: true },
          { name: '📝 Raison', value: raison, inline: true },
          { name: '🏷️ Source', value: source, inline: true },
          { name: '⏰ Expire le', value: `<t:${Math.floor(result.expiresAt.getTime() / 1000)}:F>`, inline: true }
        )
        .setTimestamp()
        .setFooter({
          text: `Accordé par ${interaction.user.username}`,
          iconURL: interaction.user.displayAvatarURL(),
        });

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('Give temp role error:', error);

      const errorEmbed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur')
        .setDescription("Une erreur est survenue lors de l'attribution du rôle temporaire.")
        .setTimestamp();

      await interaction.followUp({ embeds: [errorEmbed] });
    }
  },
};
