import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, PermissionFlagsBits } from 'discord.js';
import { temporaryRolesService } from '../../services/temporary-roles';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('list-temp-roles')
    .setDescription('Lister les rôles temporaires')
    .addUserOption((option) =>
      option.setName('utilisateur').setDescription('Utilisateur dont afficher les rôles temporaires').setRequired(false)
    )
    .addRoleOption((option) =>
      option.setName('role').setDescription('Filtrer par rôle spécifique').setRequired(false)
    )
    .addStringOption((option) =>
      option
        .setName('source')
        .setDescription('Filtrer par source')
        .setRequired(false)
        .addChoices(
          { name: 'Manuel', value: 'manual' },
          { name: 'Quiz', value: 'quiz' },
          { name: 'Animation', value: 'animation' },
          { name: 'Événement', value: 'event' },
          { name: 'Récompense', value: 'reward' }
        )
    )
    .addBooleanOption((option) =>
      option
        .setName('actifs_seulement')
        .setDescription('Afficher uniquement les rôles actifs (non expirés)')
        .setRequired(false)
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
      const user = interaction.options.getUser('utilisateur');
      const role = interaction.options.getRole('role');
      const source = interaction.options.getString('source');
      const actifsSeulements = interaction.options.getBoolean('actifs_seulement') || false;

      // Construire les filtres
      const filters: any = {
        guildId: interaction.guild.id,
        activeOnly: actifsSeulements,
      };
      if (user) filters.userId = user.id;
      if (role) filters.roleId = role.id;
      if (source) filters.source = source;

      const tempRoles = await temporaryRolesService.listTemporaryRoles(filters);

      if (tempRoles.length === 0) {
        const embed = new EmbedBuilder()
          .setColor(0xffa500)
          .setTitle('📋 Rôles Temporaires')
          .setDescription('Aucun rôle temporaire trouvé avec ces critères.')
          .setTimestamp();

        await interaction.followUp({ embeds: [embed] });
        return;
      }

      // Séparer actifs et expirés
      const activeRoles = tempRoles.filter((r: any) => r.status === 'active');
      const expiredRoles = tempRoles.filter((r: any) => r.status === 'expired');

      const embed = new EmbedBuilder()
        .setColor(0x0099ff)
        .setTitle('📋 Liste des Rôles Temporaires')
        .setDescription(
          `**Total:** ${tempRoles.length} rôle(s)\n` +
            `**🟢 Actifs:** ${activeRoles.length}\n` +
            `**🟡 Expirés:** ${expiredRoles.length}`
        )
        .setTimestamp();

      // Afficher les rôles actifs
      if (activeRoles.length > 0) {
        let activeList = '';
        activeRoles.slice(0, 10).forEach((tempRole: any) => {
          const expiresTimestamp = Math.floor(new Date(tempRole.expiresAt).getTime() / 1000);

          activeList += `• <@${tempRole.userId}> → <@&${tempRole.roleId}>\n`;
          activeList += `  ⏰ Expire <t:${expiresTimestamp}:R> | 🏷️ ${tempRole.source}\n`;
          if (tempRole.reason) {
            activeList += `  📝 ${tempRole.reason}\n`;
          }
          activeList += '\n';
        });

        if (activeList.length > 1024) {
          activeList = activeList.substring(0, 1000) + '\n... (liste tronquée)';
        }

        embed.addFields({
          name: `🟢 Rôles Actifs (${Math.min(activeRoles.length, 10)}/${activeRoles.length})`,
          value: activeList || 'Aucun',
          inline: false,
        });
      }

      // Afficher les rôles expirés (sauf si filtre actifs uniquement)
      if (!actifsSeulements && expiredRoles.length > 0) {
        let expiredList = '';
        expiredRoles.slice(0, 5).forEach((tempRole: any) => {
          const expiredTimestamp = Math.floor(new Date(tempRole.expiresAt).getTime() / 1000);
          expiredList += `• <@${tempRole.userId}> → <@&${tempRole.roleId}> (expiré <t:${expiredTimestamp}:R>)\n`;
        });

        if (expiredList.length > 512) {
          expiredList = expiredList.substring(0, 500) + '\n... (liste tronquée)';
        }

        embed.addFields({
          name: `🟡 Rôles Expirés (${Math.min(expiredRoles.length, 5)}/${expiredRoles.length})`,
          value: expiredList || 'Aucun',
          inline: false,
        });
      }

      // Footer avec les filtres appliqués
      let footerText = `Demandé par ${interaction.user.username}`;
      if (user) footerText += ` • Filtré pour ${user.username}`;
      if (role) footerText += ` • Rôle: ${role.name}`;
      if (source) footerText += ` • Source: ${source}`;

      embed.setFooter({ text: footerText });

      await interaction.followUp({ embeds: [embed] });
    } catch (error) {
      log.error('List temp roles error:', error);

      const errorEmbed = new EmbedBuilder()
        .setColor(0xff0000)
        .setTitle('❌ Erreur')
        .setDescription('Une erreur est survenue lors de la récupération des rôles temporaires.')
        .setTimestamp();

      await interaction.followUp({ embeds: [errorEmbed] });
    }
  },
};
