import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  PermissionFlagsBits,
} from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';
import { executeAudit, buildAuditEmbed } from '../../services/audit-membres';

export default {
  data: new SlashCommandBuilder()
    .setName('audit-membres-dm')
    .setDescription('Auditer les membres inactifs, attribuer les roles ET envoyer un DM d\'avertissement')
    .addRoleOption((option) =>
      option
        .setName('role-debutant')
        .setDescription('Role a attribuer aux membres qui n\'ont jamais parle')
        .setRequired(true)
    )
    .addRoleOption((option) =>
      option
        .setName('role-preavis')
        .setDescription('Role a attribuer aux membres inactifs depuis 8 mois')
        .setRequired(true)
    )
    .addRoleOption((option) =>
      option
        .setName('role-ignore')
        .setDescription('Role a ignorer (les membres avec ce role ne seront pas audites)')
        .setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageRoles | PermissionFlagsBits.KickMembers),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({ content: 'Cette commande doit etre utilisee dans un serveur.', ephemeral: true });
      return;
    }

    const roleDebutant = interaction.options.getRole('role-debutant', true);
    const rolePreavis = interaction.options.getRole('role-preavis', true);
    const roleIgnore = interaction.options.getRole('role-ignore');

    // Verifier que le bot peut gerer ces roles
    const botMember = interaction.guild.members.me;
    if (!botMember) {
      await interaction.reply({ content: 'Impossible de recuperer les informations du bot.', ephemeral: true });
      return;
    }

    if (roleDebutant.position >= botMember.roles.highest.position) {
      await interaction.reply({ content: `Le role **${roleDebutant.name}** est au-dessus de mon role le plus haut.`, ephemeral: true });
      return;
    }

    if (rolePreavis.position >= botMember.roles.highest.position) {
      await interaction.reply({ content: `Le role **${rolePreavis.name}** est au-dessus de mon role le plus haut.`, ephemeral: true });
      return;
    }

    await interaction.deferReply();

    try {
      await interaction.editReply('🔍 Scan de l\'historique des canaux en cours + envoi de DM... Cela peut prendre quelques minutes.');

      const result = await executeAudit({
        guild: interaction.guild,
        roleDebutantId: roleDebutant.id,
        rolePreavisId: rolePreavis.id,
        roleIgnoreId: roleIgnore?.id,
        sendDMs: true,
      });

      // Log en BDD
      await db.client.moderationLog.create({
        data: {
          action: 'audit',
          userId: interaction.user.id,
          moderatorId: interaction.user.id,
          guildId: interaction.guild.id,
          reason: `Audit (avec DM): ${result.debutantCount} debutants, ${result.preavisCount} en preavis, ${result.dmSentCount} DMs envoyes`,
          executedAt: new Date(),
        },
      });

      const embed = buildAuditEmbed(result, roleDebutant.name, rolePreavis.name, true);
      await interaction.editReply({ content: '', embeds: [embed] });

      log.service('Audit', `Audit (avec DM) termine sur ${interaction.guild.name}: ${result.debutantCount} debutants, ${result.preavisCount} en preavis, ${result.dmSentCount} DMs`);
    } catch (error) {
      log.error('Erreur audit-membres-dm:', error);
      await interaction.editReply({ content: 'Une erreur est survenue lors de l\'audit des membres.' });
    }
  },
};
