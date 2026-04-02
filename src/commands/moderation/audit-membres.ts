import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  PermissionFlagsBits,
  GuildMember,
} from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('audit-membres')
    .setDescription('Auditer les membres inactifs : attribuer roles et prevenir les inactifs')
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
    .setDefaultMemberPermissions(PermissionFlagsBits.Administrator),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({
        content: 'Cette commande doit etre utilisee dans un serveur.',
        ephemeral: true,
      });
      return;
    }

    const roleDebutant = interaction.options.getRole('role-debutant', true);
    const rolePreavis = interaction.options.getRole('role-preavis', true);

    // Verifier que le bot peut gerer ces roles
    const botMember = interaction.guild.members.me;
    if (!botMember) {
      await interaction.reply({
        content: 'Impossible de recuperer les informations du bot.',
        ephemeral: true,
      });
      return;
    }

    if (roleDebutant.position >= botMember.roles.highest.position) {
      await interaction.reply({
        content: `Le role **${roleDebutant.name}** est au-dessus de mon role le plus haut. Je ne peux pas l'attribuer.`,
        ephemeral: true,
      });
      return;
    }

    if (rolePreavis.position >= botMember.roles.highest.position) {
      await interaction.reply({
        content: `Le role **${rolePreavis.name}** est au-dessus de mon role le plus haut. Je ne peux pas l'attribuer.`,
        ephemeral: true,
      });
      return;
    }

    // Defer car ca peut prendre du temps
    await interaction.deferReply();

    try {
      // Recuperer tous les membres du serveur
      const members = await interaction.guild.members.fetch();
      const now = new Date();
      const eightMonthsAgo = new Date(now.getTime() - 8 * 30 * 24 * 60 * 60 * 1000);

      // Recuperer les donnees d'activite depuis la BDD
      const dbMembers = await db.client.guildMember.findMany({
        where: { guildId: interaction.guild.id },
      });

      const dbMemberMap = new Map(dbMembers.map((m) => [m.userId, m]));

      let debutantCount = 0;
      let preavisCount = 0;
      let dmFailCount = 0;
      let skippedBots = 0;
      const preavisList: string[] = [];
      const debutantList: string[] = [];

      for (const [, member] of members) {
        // Ignorer les bots et les admins
        if (member.user.bot) {
          skippedBots++;
          continue;
        }
        if (member.permissions.has(PermissionFlagsBits.Administrator)) continue;

        // Ne pas traiter si le membre a deja le role preavis
        if (member.roles.cache.has(rolePreavis.id)) continue;

        const dbMember = dbMemberMap.get(member.id);
        const messageCount = dbMember?.messageCount ?? 0;
        const lastActiveAt = dbMember?.lastActiveAt;
        const joinedAt = member.joinedAt || new Date();

        // ---------------------------------------------------------------
        // Cas 1 : Membre n'a JAMAIS parle
        // ---------------------------------------------------------------
        if (messageCount === 0) {
          const joinedLongAgo = joinedAt < eightMonthsAgo;

          if (joinedLongAgo) {
            // Jamais parle ET present depuis 8+ mois -> En preavis
            await assignRolePreavis(member, rolePreavis.id, interaction.guild.name);
            preavisCount++;
            preavisList.push(member.user.tag);
            if (preavisList.length <= 30) {
              // Log DM failure silently
            }
          } else {
            // Jamais parle mais recent -> Dev Debutant
            if (!member.roles.cache.has(roleDebutant.id)) {
              try {
                await member.roles.add(roleDebutant.id, 'Audit membres - jamais parle');
                debutantCount++;
                debutantList.push(member.user.tag);
              } catch (err) {
                log.debug('Erreur attribution role debutant', { error: err, userId: member.id });
              }
            }
          }
          continue;
        }

        // ---------------------------------------------------------------
        // Cas 2 : Membre a parle mais inactif depuis 8+ mois
        // ---------------------------------------------------------------
        const lastActivity = lastActiveAt || joinedAt;
        if (lastActivity < eightMonthsAgo) {
          await assignRolePreavis(member, rolePreavis.id, interaction.guild.name);
          preavisCount++;
          preavisList.push(member.user.tag);
        }
      }

      // Enregistrer la date de l'audit pour le kick-preavis
      await db.client.moderationLog.create({
        data: {
          action: 'audit',
          userId: interaction.user.id,
          moderatorId: interaction.user.id,
          guildId: interaction.guild.id,
          reason: `Audit: ${debutantCount} debutants, ${preavisCount} en preavis`,
          executedAt: new Date(),
        },
      });

      // Embed de resultat
      const embed = new EmbedBuilder()
        .setColor(0xE67E22)
        .setTitle('📋 Audit des membres termine')
        .setDescription('Voici le resume de l\'audit des membres du serveur.')
        .addFields(
          {
            name: '🆕 Dev Debutant (jamais parle)',
            value: debutantCount > 0
              ? `**${debutantCount}** membre(s)\n${debutantList.slice(0, 15).join(', ')}${debutantList.length > 15 ? ` ...et ${debutantList.length - 15} autres` : ''}`
              : 'Aucun nouveau membre inactif',
            inline: false,
          },
          {
            name: '⚠️ En Preavis (inactif 8+ mois)',
            value: preavisCount > 0
              ? `**${preavisCount}** membre(s)\n${preavisList.slice(0, 15).join(', ')}${preavisList.length > 15 ? ` ...et ${preavisList.length - 15} autres` : ''}`
              : 'Aucun membre inactif depuis 8 mois',
            inline: false,
          },
          {
            name: '📊 Statistiques',
            value: [
              `Membres scannes : **${members.size}**`,
              `Bots ignores : **${skippedBots}**`,
              `Role "${roleDebutant.name}" attribue : **${debutantCount}**`,
              `Role "${rolePreavis.name}" attribue : **${preavisCount}**`,
              `DM d'avertissement envoyes : **${preavisCount - dmFailCount}**`,
              dmFailCount > 0 ? `DM echoues (DMs fermes) : **${dmFailCount}**` : '',
            ].filter(Boolean).join('\n'),
            inline: false,
          }
        )
        .setFooter({ text: 'Utilisez /kick-preavis dans 7 jours pour kicker les membres en preavis' })
        .setTimestamp();

      await interaction.editReply({ embeds: [embed] });

      log.service('Audit', `Audit termine sur ${interaction.guild.name}: ${debutantCount} debutants, ${preavisCount} en preavis`);
    } catch (error) {
      log.error('Erreur audit-membres:', error);
      await interaction.editReply({
        content: 'Une erreur est survenue lors de l\'audit des membres.',
      });
    }
  },
};

// ============================================================
// Helpers
// ============================================================

async function assignRolePreavis(
  member: GuildMember,
  rolePreavisId: string,
  guildName: string,
): Promise<boolean> {
  try {
    // Attribuer le role
    await member.roles.add(rolePreavisId, 'Audit membres - inactif depuis 8+ mois');

    // Enregistrer la date d'attribution en BDD pour le kick dans 7 jours
    await db.client.moderationLog.create({
      data: {
        action: 'preavis',
        userId: member.id,
        moderatorId: 'system',
        guildId: member.guild.id,
        reason: 'Inactif depuis 8+ mois - preavis de kick (7 jours)',
        executedAt: new Date(),
      },
    });

    // Envoyer un DM d'avertissement
    try {
      const dmEmbed = new EmbedBuilder()
        .setColor(0xFF6B35)
        .setTitle('⚠️ Avertissement - Inactivite')
        .setDescription(
          [
            `Bonjour **${member.user.globalName || member.user.username}**,`,
            '',
            `Nous avons remarque que cela fait un bon moment que tu es sur le serveur **${guildName}** sans t'etre presente(e) ou sans avoir participe aux discussions.`,
            '',
            'Notre serveur est une communaute active de developpeurs et nous aimerions beaucoup te connaitre ! 🚀',
            '',
            '**Tu as 7 jours pour te presenter et participer**, sinon tu seras automatiquement retire(e) du serveur.',
            '',
            'N\'hesite pas a :',
            '• Te presenter dans le canal de presentation',
            '• Poser des questions',
            '• Participer aux discussions',
            '• Rejoindre les events et challenges',
            '',
            'On espere te voir bientot parmi nous ! 💪',
          ].join('\n')
        )
        .setFooter({ text: guildName })
        .setTimestamp();

      await member.send({ embeds: [dmEmbed] });
      return true;
    } catch (dmErr) {
      log.debug('Impossible d\'envoyer le DM de preavis', { userId: member.id, error: dmErr });
      return false;
    }
  } catch (err) {
    log.error('Erreur attribution role preavis', { error: err, userId: member.id });
    return false;
  }
}
