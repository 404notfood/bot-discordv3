import { Client, EmbedBuilder, TextChannel } from 'discord.js';
import { db } from './database';
import { temporaryRolesService } from './temporary-roles';
import { log } from './logger';
import { sleep } from '../utils/sleep';
import { QuizSessionStatus } from '../generated/prisma/client';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function shuffle<T>(array: T[]): T[] {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
}

const DIFFICULTY_EMOJI: Record<string, string> = { easy: '🟢', medium: '🟡', hard: '🔴' };
const DIFFICULTY_LABEL: Record<string, string> = { easy: 'Facile', medium: 'Moyen', hard: 'Difficile' };
const BASE_POINTS: Record<string, number> = { easy: 10, medium: 15, hard: 25 };

// ---------------------------------------------------------------------------
// Build the question set for a session
// ---------------------------------------------------------------------------

async function buildQuestionSet(
  sessionId: bigint,
  themeSlug: string | null,
  count: number,
): Promise<void> {
  const where: any = { isActive: true };

  if (themeSlug) {
    const theme = await db.client.quizTheme.findUnique({ where: { slug: themeSlug } });
    if (theme) where.themeId = theme.id;
  }

  // Prisma does not support ORDER BY RAND(), so we fetch more, shuffle, then slice
  const questions = await db.client.quizQuestion.findMany({
    where,
    orderBy: { id: 'asc' },
    take: count * 3,
  });

  const selectedQuestions = shuffle(questions).slice(0, count);

  for (let i = 0; i < selectedQuestions.length; i++) {
    const q: any = selectedQuestions[i];
    const answers = await db.client.quizAnswer.findMany({
      where: { questionId: q.id },
      orderBy: { label: 'asc' },
    });

    const correctLabels = answers.filter((a: any) => a.isCorrect).map((a: any) => a.label);

    await db.client.quizSessionQuestion.create({
      data: {
        sessionId,
        questionId: q.id,
        position: i + 1,
        correctLabels: JSON.stringify(correctLabels),
      },
    });
  }
}

// ---------------------------------------------------------------------------
// Calculate points for a correct answer (with speed bonus)
// ---------------------------------------------------------------------------

function calculatePoints(
  basePoints: number,
  responseTimeSec: number,
  isCorrect: boolean,
): number {
  if (!isCorrect) return 0;

  let finalPoints = basePoints;

  let speedBonus = 0;
  if (responseTimeSec <= 2) {
    speedBonus = basePoints * 0.5;
  } else if (responseTimeSec <= 10) {
    const factor = 0.3 - ((responseTimeSec - 2) / 8) * 0.2;
    speedBonus = basePoints * factor;
  } else if (responseTimeSec <= 30) {
    const factor = 0.05 - ((responseTimeSec - 10) / 20) * 0.05;
    speedBonus = basePoints * Math.max(0, factor);
  }

  finalPoints += Math.round(speedBonus * 100) / 100;
  return Math.round(finalPoints * 100) / 100;
}

// ---------------------------------------------------------------------------
// Run a single quiz session
// ---------------------------------------------------------------------------

export async function runSession(client: Client, session: any): Promise<void> {
  try {
    const cfg = await db.client.quizConfig.findUnique({
      where: { guildId: session.guildId },
    });
    if (!cfg) return;

    const channel = (await client.channels
      .fetch(String(session.channelId))
      .catch(() => null)) as TextChannel | null;
    if (!channel) return;

    // Build questions if not already built
    const existingCount = await db.client.quizSessionQuestion.count({
      where: { sessionId: session.id },
    });

    if (existingCount === 0) {
      await buildQuestionSet(
        session.id,
        session.themeSlug,
        session.questionCount || 20,
      );
    }

    // Transition to running
    const actualStartTime = new Date();
    await db.client.quizSession.update({
      where: { id: session.id },
      data: { status: 'running', startAt: actualStartTime, updatedAt: actualStartTime },
    });

    const questions = await db.client.quizSessionQuestion.findMany({
      where: { sessionId: session.id },
      orderBy: { position: 'asc' },
    });

    // Fetch full question details (preserve sessionQuestion.id as sessionQuestionId)
    const questionsDetails = await Promise.all(
      questions.map(async (q: any) => {
        const question = await db.client.quizQuestion.findUnique({
          where: { id: q.questionId },
        });
        return { ...question, ...q, sessionQuestionId: q.id };
      }),
    );

    // Iterate over each question
    for (const q of questionsDetails) {
      const answers = await db.client.quizAnswer.findMany({
        where: { questionId: q.questionId },
      });

      const shuffledAnswers = shuffle([...answers]);

      // Re-assign labels A, B, C, D after shuffle
      const labelMapping: Record<string, string> = {};
      shuffledAnswers.forEach((answer: any, index: number) => {
        const newLabel = String.fromCharCode(65 + index);
        labelMapping[answer.label] = newLabel;
        (answer as any).displayLabel = newLabel;
      });

      // Update correct labels to match the new shuffle order
      const originalCorrectLabels: string[] = JSON.parse(q.correctLabels as string);
      const newCorrectLabels = originalCorrectLabels.map(
        (oldLabel: string) => labelMapping[oldLabel],
      );
      const correctLabelsUpdated = JSON.stringify(newCorrectLabels);

      const options = shuffledAnswers
        .map((x: any) => `${x.displayLabel}. ${x.text}`)
        .join('\n');

      const prompt = new EmbedBuilder()
        .setColor(0x00aaff)
        .setTitle(
          `❓ Question ${q.position} ${DIFFICULTY_EMOJI[q.difficulty || 'medium'] || '🟡'}`,
        )
        .setDescription(q.question || '')
        .addFields({ name: 'Reponses', value: options })
        .setFooter({
          text: `Vous avez 30 secondes • Niveau: ${DIFFICULTY_LABEL[q.difficulty || 'medium'] || 'Moyen'}`,
        });

      // Update current position so message-create knows which question we're on
      await db.client.$executeRaw`
        UPDATE quiz_sessions SET current_position = ${q.position}, updated_at = NOW() WHERE id = ${session.id}
      `;

      const askedAt = Date.now();
      await channel.send({ embeds: [prompt] });

      // Wait 30 seconds for answers
      await sleep(30 * 1000);

      // Score the responses
      const correctSet = new Set<string>(JSON.parse(correctLabelsUpdated));
      const responses = await db.client.quizResponse.findMany({
        where: { sessionId: session.id, sessionQuestionId: q.sessionQuestionId },
      });

      const questionBasePoints = BASE_POINTS[q.difficulty || 'medium'] || 15;

      const responsesWithPoints: any[] = [];

      for (const r of responses) {
        const userSet = new Set(
          String(r.labels)
            .split(',')
            .filter(Boolean),
        );
        const isCorrect =
          userSet.size === correctSet.size && [...userSet].every((x) => correctSet.has(x));

        const responseTime = (new Date(r.createdAt!).getTime() - askedAt) / 1000;
        const answerTimeMs = Math.max(0, responseTime * 1000);

        const finalPoints = calculatePoints(questionBasePoints, responseTime, isCorrect);

        responsesWithPoints.push({
          ...r,
          answerTimeMs: Math.round(answerTimeMs),
          finalPoints,
          responseTime: Math.round(responseTime * 100) / 100,
          isCorrect,
        });
      }

      // Persist computed points
      for (const rp of responsesWithPoints) {
        await db.client.quizResponse.update({
          where: { id: rp.id },
          data: {
            points: rp.finalPoints,
            answerTimeMs: rp.answerTimeMs,
            updatedAt: new Date(),
          },
        });

        if (rp.finalPoints > 0) {
          await db.client.quizParticipant.updateMany({
            where: {
              sessionId: session.id,
              userDiscordId: rp.userDiscordId,
            },
            data: {
              score: { increment: rp.finalPoints },
              updatedAt: new Date(),
            },
          });
        }
      }

      // Build reveal embed
      const correctDisplay = [...correctSet].join(', ');

      const correctResponses = responsesWithPoints
        .filter((r) => r.isCorrect)
        .sort((a, b) => b.finalPoints - a.finalPoints)
        .slice(0, 5);

      const reveal = new EmbedBuilder()
        .setColor(0x00c853)
        .setTitle(
          `✅ Correction Q${q.position} ${DIFFICULTY_EMOJI[q.difficulty || 'medium'] || ''} (${questionBasePoints} pts de base)`,
        )
        .setDescription(`**Bonne(s) reponse(s): ${correctDisplay}**`);

      if (q.description && q.description.trim()) {
        reveal.addFields({ name: '💡 Explication', value: q.description, inline: false });
      }

      if (correctResponses.length > 0) {
        const topScorers = await Promise.all(
          correctResponses.map(async (r, i) => {
            let displayName = r.userDiscordId;
            try {
              const member = await channel.guild.members.fetch(r.userDiscordId);
              displayName = member.displayName || member.user.username;
            } catch {
              // Ignore – keep the raw ID as fallback
            }

            const medal =
              i === 0 ? '🥇' : i === 1 ? '🥈' : i === 2 ? '🥉' : '🏅';
            return `${medal} **${displayName}** • ${r.finalPoints}pts • ${r.responseTime}s`;
          }),
        );

        reveal.addFields({
          name: `🏆 Top ${correctResponses.length} (${correctResponses.length}/${responses.length} correct)`,
          value: topScorers.join('\n'),
          inline: false,
        });
      } else {
        reveal.addFields({
          name: '😔 Aucune bonne reponse',
          value: `${responses.length} participants ont tente leur chance`,
          inline: false,
        });
      }

      await channel.send({ embeds: [reveal] });

      // Short pause between questions
      await sleep(5 * 1000);
    }

    // ---------------------------------------------------------------
    // End of session
    // ---------------------------------------------------------------

    await db.client.quizSession.update({
      where: { id: session.id },
      data: { status: 'finished', endAt: new Date(), updatedAt: new Date() },
    });

    // Final leaderboard
    const podium = await db.client.$queryRaw<any[]>`
      SELECT qp.user_discord_id, qp.username, qp.score,
             COUNT(CASE WHEN qr.points > 0 THEN 1 END) as correct_answers,
             COALESCE(AVG(CASE WHEN qr.points > 0 THEN qr.answer_time_ms END), 999999) as avg_time_correct,
             COALESCE(SUM(CASE WHEN qr.points > 0 THEN qr.answer_time_ms END), 999999999) as total_time_correct
      FROM quiz_participants qp
      LEFT JOIN quiz_responses qr ON qr.session_id = qp.session_id AND qr.user_discord_id = qp.user_discord_id
      WHERE qp.session_id = ${session.id}
      GROUP BY qp.user_discord_id, qp.username, qp.score
      ORDER BY qp.score DESC, correct_answers DESC, avg_time_correct ASC
      LIMIT 10
    `;

    if (podium.length > 0) {
      const podiumLines = await Promise.all(
        podium.slice(0, 3).map(async (p: any, i: number) => {
          let displayName = p.username || p.user_discord_id;
          try {
            const member = await channel.guild.members.fetch(p.user_discord_id);
            displayName = member.displayName || member.user.username;
          } catch {
            // fallback to stored username
          }

          const medal = i === 0 ? '🥇' : i === 1 ? '🥈' : '🥉';
          const avgTime =
            p.avg_time_correct < 999999
              ? `${Math.round((p.avg_time_correct / 1000) * 100) / 100}s`
              : 'N/A';
          return `${medal} **${displayName}**\n└ ${p.score}pts • ${p.correct_answers} bonnes • ⌀${avgTime}`;
        }),
      );

      const endEmbed = new EmbedBuilder()
        .setColor(0xffd600)
        .setTitle('🏁 Resultats du Quiz')
        .setDescription('**🏆 PODIUM**\n' + podiumLines.join('\n\n'))
        .setFooter({
          text: `${podium.length} participants • Systeme de points avance avec bonus vitesse`,
        });

      if (podium.length > 3) {
        const otherLines = await Promise.all(
          podium.slice(3).map(async (p: any, i: number) => {
            let displayName = p.username || p.user_discord_id;
            try {
              const member = await channel.guild.members.fetch(p.user_discord_id);
              displayName = member.displayName || member.user.username;
            } catch {
              // fallback
            }
            return `${i + 4}. ${displayName} • ${p.score}pts • ${p.correct_answers} bonnes`;
          }),
        );

        endEmbed.addFields({
          name: '📊 Classement Complet',
          value: otherLines.join('\n'),
          inline: false,
        });
      }

      await channel.send({ embeds: [endEmbed] });
    } else {
      const endEmbed = new EmbedBuilder()
        .setColor(0x999999)
        .setTitle('🏁 Fin du Quiz')
        .setDescription("Aucun participant n'a repondu aux questions")
        .setFooter({ text: 'Peut-etre la prochaine fois ! 🤔' });
      await channel.send({ embeds: [endEmbed] });
    }

    // ---------------------------------------------------------------
    // Winner reward – temporary role
    // ---------------------------------------------------------------

    if (podium[0]) {
      try {
        let rewardConfig = await db.client.$queryRaw<any[]>`
          SELECT * FROM quiz_rewards_configs
          WHERE guild_id = ${session.guildId} AND is_active = true
          LIMIT 1
        `.then((r: any) => r[0]);

        // Create default config with automatic role if none exists
        if (!rewardConfig) {
          const guild = await client.guilds.fetch(String(session.guildId)).catch(() => null);
          if (guild) {
            const role = await guild.roles
              .create({
                name: '🏆 Gagnant Quiz',
                color: 0xffd700,
                reason: 'Auto-created role for quiz winners',
                permissions: [],
                mentionable: true,
              })
              .catch(() => null);

            if (role) {
              await db.client.$executeRaw`
                INSERT INTO quiz_rewards_configs (guild_id, winner_role_id, duration_days, reward_message, is_active, created_at, updated_at)
                VALUES (${session.guildId}, ${role.id}, 5, 'Felicitations ! Vous avez gagne le quiz et obtenez le role de champion pour 5 jours ! 🏆', true, NOW(), NOW())
              `;

              rewardConfig = {
                winner_role_id: role.id,
                duration_days: 5,
                reward_message:
                  'Felicitations ! Vous avez gagne le quiz et obtenez le role de champion pour 5 jours ! 🏆',
              };

              log.info(`"🏆 Gagnant Quiz" role auto-created for guild ${guild.name}`);
            }
          }
        }

        if (rewardConfig && rewardConfig.winner_role_id) {
          const guild = await client.guilds.fetch(String(session.guildId)).catch(() => null);
          let role = guild ? guild.roles.cache.get(rewardConfig.winner_role_id) : null;

          // Re-create role if it was deleted
          if (!role && guild) {
            role = await guild.roles
              .create({
                name: '🏆 Gagnant Quiz',
                color: 0xffd700,
                reason: 'Auto re-created role (previously deleted)',
                permissions: [],
                mentionable: true,
              })
              .catch(() => null);

            if (role) {
              await db.client.$executeRaw`
                UPDATE quiz_rewards_configs
                SET winner_role_id = ${role.id}, updated_at = NOW()
                WHERE guild_id = ${session.guildId}
              `;
              rewardConfig.winner_role_id = role.id;
              log.info('"🏆 Gagnant Quiz" role re-created automatically');
            }
          }

          if (role) {
            await temporaryRolesService.initialize();

            const durationDays = rewardConfig.duration_days || 5;
            const durationMs = durationDays * 24 * 60 * 60 * 1000;

            await temporaryRolesService.giveTemporaryRole(client, {
              userId: String(podium[0].user_discord_id),
              guildId: String(session.guildId),
              roleId: String(rewardConfig.winner_role_id),
              durationMs,
              reason: rewardConfig.reward_message || 'Quiz winner',
              source: 'quiz',
              grantedBy: null,
            });

            log.info(
              `Temporary "quiz winner" role assigned to ${podium[0].username || podium[0].user_discord_id} for ${durationDays} days`,
            );

            if (rewardConfig.reward_message) {
              const rewardEmbed = new EmbedBuilder()
                .setColor(0xffd700)
                .setTitle('🏆 Felicitations au gagnant !')
                .setDescription(rewardConfig.reward_message)
                .addFields(
                  { name: 'Gagnant', value: `<@${podium[0].user_discord_id}>`, inline: true },
                  { name: 'Duree du role', value: `${durationDays} jours`, inline: true },
                  { name: 'Role', value: `${role.name}`, inline: true },
                );

              await channel.send({ embeds: [rewardEmbed] });
            }
          } else {
            log.error('Unable to create or retrieve the winner role');
          }
        }
      } catch (error) {
        log.error('Error assigning quiz winner role', { error });
      }
    }
  } catch (e) {
    log.error('runSession error', { error: e });
    try {
      await db.client.quizSession.update({
        where: { id: session.id },
        data: { status: 'cancelled', updatedAt: new Date() },
      });
    } catch {
      // swallow – best effort
    }
  }
}

// ---------------------------------------------------------------------------
// Scheduler tick (called periodically)
// ---------------------------------------------------------------------------

export async function tickQuizScheduler(client: Client): Promise<void> {
  try {
    const now = new Date();

    // Announce sessions starting within 1 hour
    const announceFrom = new Date(now.getTime() + 60 * 60 * 1000);
    const announceFromMinus1s = new Date(announceFrom.getTime() - 1000);

    const soon = await db.client.quizSession.findMany({
      where: {
        status: 'scheduled',
        startAt: {
          not: null,
          gte: announceFromMinus1s,
          lte: announceFrom,
        },
      },
    });

    for (const s of soon) {
      const cfg = await db.client.quizConfig.findUnique({
        where: { guildId: s.guildId },
      });
      if (!cfg) continue;

      const channel = cfg.announceChannelId
        ? ((await client.channels
            .fetch(String(cfg.announceChannelId))
            .catch(() => null)) as TextChannel | null)
        : null;

      if (channel) {
        const embed = new EmbedBuilder()
          .setColor(0x00aaff)
          .setTitle('⏰ Quiz dans 1 heure')
          .setDescription(`Theme: ${s.themeSlug || 'aleatoire'}`);

        await channel
          .send({
            content: cfg.mentionEveryone ? '@everyone' : undefined,
            embeds: [embed],
          })
          .catch(() => {});
      }

      await db.client.quizSession.update({
        where: { id: s.id },
        data: { announceAt: new Date(), status: 'announced' },
      });
    }

    // Start sessions whose start time has arrived
    const due = await db.client.quizSession.findMany({
      where: {
        status: { in: ['scheduled', 'announced'] },
        startAt: { not: null, lte: now },
      },
      orderBy: { id: 'asc' },
    });

    for (const s of due) {
      await runSession(client, s);
    }
  } catch (e) {
    log.error('tickQuizScheduler error', { error: e });
  }
}
