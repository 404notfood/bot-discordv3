import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { PermissionsManager } from '../../services/permissions';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('sql-challenge')
    .setDescription('SQL Challenge configurable')
    .addSubcommand((sub) =>
      sub
        .setName('start')
        .setDescription('Lancer une des 7 semaines de SQL Challenge')
        .addIntegerOption((o) =>
          o.setName('week_number').setDescription('Numéro de la semaine (1-7)').setRequired(true).setMinValue(1).setMaxValue(7)
        )
    )
    .addSubcommand((sub) => sub.setName('stop').setDescription('Arrêter le SQL Challenge actuel'))
    .addSubcommand((sub) =>
      sub
        .setName('config')
        .setDescription('Configurer les canaux du SQL Challenge')
        .addChannelOption((o) =>
          o.setName('challenge_channel').setDescription('Canal pour les inscriptions/annonces').setRequired(true)
        )
        .addChannelOption((o) =>
          o.setName('announce_channel').setDescription('Canal pour les annonces de bonnes réponses').setRequired(false)
        )
        .addBooleanOption((o) => o.setName('mention_everyone').setDescription("Mentionner @everyone à l'annonce"))
    )
    .addSubcommand((sub) => sub.setName('stats').setDescription('Afficher les statistiques du SQL Challenge actuel')),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) {
      return;
    }

    if (!interaction.guildId) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const sub = interaction.options.getSubcommand();

    try {
      // -- Configuration des canaux --
      if (sub === 'config') {
        const challengeChannel = interaction.options.getChannel('challenge_channel', true);
        const announceChannel = interaction.options.getChannel('announce_channel');
        const mentionEveryone = interaction.options.getBoolean('mention_everyone');

        await db.client.$executeRaw`
          INSERT INTO sql_challenge_configs (guild_id, challenge_channel_id, announce_channel_id, mention_everyone, created_at, updated_at)
          VALUES (${interaction.guildId}, ${challengeChannel.id}, ${announceChannel?.id || null}, ${mentionEveryone ? 1 : 0}, NOW(), NOW())
          ON DUPLICATE KEY UPDATE
          challenge_channel_id = VALUES(challenge_channel_id),
          announce_channel_id = VALUES(announce_channel_id),
          mention_everyone = VALUES(mention_everyone),
          updated_at = NOW()
        `;

        await interaction.reply({ content: '✅ Configuration SQL Challenge enregistrée', ephemeral: true });
        return;
      }

      // -- Lancer une semaine --
      if (sub === 'start') {
        const weekNumber = interaction.options.getInteger('week_number', true);

        const config = await db.client.$queryRaw<Array<any>>`
          SELECT * FROM sql_challenge_configs WHERE guild_id = ${interaction.guildId} LIMIT 1
        `.then((r: any) => r[0]);

        if (!config?.challenge_channel_id) {
          await interaction.reply({
            content: "❌ Canal de challenge non configuré. Utilisez `/sql-challenge config` d'abord.",
            ephemeral: true,
          });
          return;
        }

        const weekData = await db.client.$queryRaw<Array<any>>`
          SELECT * FROM sql_challenge_sessions WHERE week_number = ${weekNumber} LIMIT 1
        `.then((r: any) => r[0]);

        if (!weekData) {
          await interaction.reply({
            content: `❌ Semaine ${weekNumber} non trouvée dans la base de données.`,
            ephemeral: true,
          });
          return;
        }

        // Terminer les sessions actives et activer la nouvelle
        await db.client.$executeRaw`UPDATE sql_challenge_sessions SET status = 'completed' WHERE status = 'active'`;
        await db.client.$executeRaw`UPDATE sql_challenge_sessions SET status = 'active' WHERE id = ${weekData.id}`;

        const questionsData = JSON.parse(weekData.questions_data);
        const nbQuestions = questionsData.length;

        // Envoyer l'annonce dans le canal de challenge
        const challengeChannel = await interaction.client.channels.fetch(config.challenge_channel_id).catch(() => null);
        if (challengeChannel && challengeChannel.isTextBased()) {
          const announceEmbed = new EmbedBuilder()
            .setColor(0x00aaff)
            .setTitle(`🏥 ${weekData.title}`)
            .setDescription(weekData.description)
            .addFields(
              { name: '📊 Difficulté', value: weekData.difficulty, inline: true },
              { name: '🎯 Questions', value: `${nbQuestions} questions`, inline: true },
              {
                name: '🔥 Comment participer',
                value: 'Tapez `!challenge` pour vous inscrire et commencer !',
                inline: false,
              }
            )
            .setFooter({ text: 'Bonne chance à tous !' });

          const mentionText = config.mention_everyone ? '@everyone' : undefined;
          if ('send' in challengeChannel) {
            await (challengeChannel as any).send({ content: mentionText, embeds: [announceEmbed] });
          }

          // Envoyer aussi dans le canal d'annonce si différent
          if (config.announce_channel_id && config.announce_channel_id !== config.challenge_channel_id) {
            const annChannel = await interaction.client.channels.fetch(config.announce_channel_id).catch(() => null);
            if (annChannel && 'send' in annChannel && annChannel.isTextBased()) {
              await (annChannel as any).send({ content: mentionText, embeds: [announceEmbed] });
            }
          }
        }

        await interaction.reply({ content: `✅ ${weekData.title} lancée avec succès !`, ephemeral: true });
        return;
      }

      // -- Arrêter le challenge --
      if (sub === 'stop') {
        await db.client.$executeRaw`UPDATE sql_challenge_sessions SET status = 'completed', updated_at = NOW() WHERE status = 'active'`;
        await interaction.reply({ content: '✅ SQL Challenge arrêté', ephemeral: true });
        return;
      }

      // -- Statistiques --
      if (sub === 'stats') {
        const activeSession = await db.client.$queryRaw<Array<any>>`
          SELECT * FROM sql_challenge_sessions
          WHERE status = 'active'
          ORDER BY id DESC LIMIT 1
        `.then((r: any) => r[0]);

        if (!activeSession) {
          await interaction.reply({ content: '❌ Aucun SQL Challenge actif', ephemeral: true });
          return;
        }

        const participants = await db.client.$queryRaw<Array<{ count: bigint }>>`
          SELECT COUNT(*) as count FROM sql_challenge_users
          WHERE session_id = ${activeSession.id}
        `.then((r: any) => Number(r[0].count));

        const finished = await db.client.$queryRaw<Array<{ count: bigint }>>`
          SELECT COUNT(*) as count FROM sql_challenge_users
          WHERE session_id = ${activeSession.id} AND is_finished = 1
        `.then((r: any) => Number(r[0].count));

        const topUsers = await db.client.$queryRaw<Array<any>>`
          SELECT username, total_points, current_question, is_finished
          FROM sql_challenge_users
          WHERE session_id = ${activeSession.id}
          ORDER BY total_points DESC, current_question DESC
          LIMIT 10
        `;

        const statsEmbed = new EmbedBuilder()
          .setColor(0x00aaff)
          .setTitle(`📊 Statistiques - ${activeSession.title}`)
          .addFields(
            { name: '👥 Participants', value: participants.toString(), inline: true },
            { name: '🏁 Terminés', value: finished.toString(), inline: true },
            { name: '📅 Semaine', value: activeSession.week_number.toString(), inline: true }
          );

        if (topUsers.length > 0) {
          const leaderboard = topUsers
            .map((user: any, index: number) => {
              const medal = index === 0 ? '🥇' : index === 1 ? '🥈' : index === 2 ? '🥉' : `${index + 1}.`;
              const status = user.is_finished ? '✅' : `Q${user.current_question}`;
              return `${medal} **${user.username}** - ${user.total_points} pts (${status})`;
            })
            .join('\n');

          statsEmbed.addFields({ name: '🏆 Classement', value: leaderboard, inline: false });
        }

        await interaction.reply({ embeds: [statsEmbed], ephemeral: true });
        return;
      }
    } catch (error) {
      log.error('SQL Challenge command error:', error);
      await interaction.reply({ content: '❌ Erreur lors du traitement de la commande', ephemeral: true });
    }
  },
};
