import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  PermissionFlagsBits,
} from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('kick-preavis')
    .setDescription('Kicker les membres en preavis depuis plus de 7 jours')
    .addRoleOption((option) =>
      option
        .setName('role-preavis')
        .setDescription('Le role "En Preavis" attribue par /audit-membres')
        .setRequired(true)
    )
    .addBooleanOption((option) =>
      option
        .setName('simulation')
        .setDescription('Voir la liste sans kicker (mode dry-run)')
        .setRequired(false)
    )
    .setDefaultMemberPermissions(PermissionFlagsBits.ManageRoles | PermissionFlagsBits.KickMembers),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!interaction.guild) {
      await interaction.reply({
        content: 'Cette commande doit etre utilisee dans un serveur.',
        ephemeral: true,
      });
      return;
    }

    const rolePreavis = interaction.options.getRole('role-preavis', true);
    const simulation = interaction.options.getBoolean('simulation') ?? false;

    await interaction.deferReply();

    try {
      // Recuperer tous les logs de preavis pour ce serveur
      const preavisLogs = await db.client.moderationLog.findMany({
        where: {
          guildId: interaction.guild.id,
          action: 'preavis',
        },
        orderBy: { executedAt: 'desc' },
      });

      // Creer une map userId -> date de preavis (la plus recente)
      const preavisDateMap = new Map<string, Date>();
      for (const entry of preavisLogs) {
        if (!preavisDateMap.has(entry.userId)) {
          preavisDateMap.set(entry.userId, entry.executedAt);
        }
      }

      // Recuperer les membres avec le role preavis
      const members = await interaction.guild.members.fetch();
      const membersWithPreavis = members.filter((m) =>
        m.roles.cache.has(rolePreavis.id) && !m.user.bot
      );

      const now = new Date();
      const sevenDaysMs = 7 * 24 * 60 * 60 * 1000;

      let kickCount = 0;
      let tooRecentCount = 0;
      let noLogCount = 0;
      const kickedList: string[] = [];
      const tooRecentList: string[] = [];

      for (const [, member] of membersWithPreavis) {
        const preavisDate = preavisDateMap.get(member.id);

        if (!preavisDate) {
          // Pas de log de preavis trouve, on skip par securite
          noLogCount++;
          continue;
        }

        const elapsed = now.getTime() - preavisDate.getTime();

        if (elapsed >= sevenDaysMs) {
          // 7 jours ecoules -> kick
          if (!simulation) {
            try {
              // Envoyer un DM avant le kick
              try {
                const dmEmbed = new EmbedBuilder()
                  .setColor(0xFF0000)
                  .setTitle('👋 Au revoir')
                  .setDescription(
                    [
                      `Bonjour **${member.user.globalName || member.user.username}**,`,
                      '',
                      `Malheureusement, le delai de 7 jours est passe et tu n'as pas participe aux discussions sur **${interaction.guild!.name}**.`,
                      '',
                      'Tu as ete retire(e) du serveur. Si tu souhaites revenir un jour et participer activement, tu es toujours le/la bienvenu(e) ! 🙂',
                    ].join('\n')
                  )
                  .setTimestamp();

                await member.send({ embeds: [dmEmbed] });
              } catch {
                // DMs fermes, on continue
              }

              await member.kick('Preavis expire - inactif depuis 8+ mois sans participation');

              // Log le kick
              await db.client.moderationLog.create({
                data: {
                  action: 'kick',
                  userId: member.id,
                  moderatorId: interaction.user.id,
                  guildId: interaction.guild!.id,
                  reason: 'Preavis expire - kick automatique apres 7 jours',
                  executedAt: new Date(),
                },
              });

              kickCount++;
              kickedList.push(member.user.tag);
            } catch (err) {
              log.error('Erreur kick membre preavis', { error: err, userId: member.id });
            }
          } else {
            kickCount++;
            kickedList.push(member.user.tag);
          }
        } else {
          // Pas encore 7 jours
          const daysLeft = Math.ceil((sevenDaysMs - elapsed) / (24 * 60 * 60 * 1000));
          tooRecentCount++;
          tooRecentList.push(`${member.user.tag} (${daysLeft}j restant${daysLeft > 1 ? 's' : ''})`);
        }
      }

      // Embed de resultat
      const embed = new EmbedBuilder()
        .setColor(simulation ? 0x3498DB : 0xFF0000)
        .setTitle(simulation ? '🔍 Simulation kick-preavis' : '🔨 Kick des membres en preavis')
        .setDescription(
          simulation
            ? 'Mode simulation : aucun membre n\'a ete kicke.'
            : 'Voici le resultat du kick des membres en preavis.',
        )
        .addFields(
          {
            name: simulation ? '🎯 Seraient kickes (7+ jours)' : '🎯 Membres kickes',
            value: kickCount > 0
              ? `**${kickCount}** membre(s)\n${kickedList.slice(0, 20).join('\n')}${kickedList.length > 20 ? `\n...et ${kickedList.length - 20} autres` : ''}`
              : 'Aucun membre a kicker',
            inline: false,
          },
          {
            name: '⏳ Encore en preavis (< 7 jours)',
            value: tooRecentCount > 0
              ? `**${tooRecentCount}** membre(s)\n${tooRecentList.slice(0, 15).join('\n')}${tooRecentList.length > 15 ? `\n...et ${tooRecentList.length - 15} autres` : ''}`
              : 'Aucun',
            inline: false,
          },
        )
        .setFooter({
          text: `Total avec role preavis : ${membersWithPreavis.size}${noLogCount > 0 ? ` | ${noLogCount} sans log (ignores)` : ''}`,
        })
        .setTimestamp();

      await interaction.editReply({ embeds: [embed] });

      log.service('KickPreavis', `${simulation ? '[SIMULATION] ' : ''}${kickCount} membre(s) kicke(s) sur ${interaction.guild.name}`);
    } catch (error) {
      log.error('Erreur kick-preavis:', error);
      await interaction.editReply({
        content: 'Une erreur est survenue lors du traitement.',
      });
    }
  },
};
