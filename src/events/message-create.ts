import { Message, AttachmentBuilder, ChannelType } from 'discord.js';
import { db } from '../services/database';
import { log } from '../services/logger';
import { BotEvent } from '../types/event';
import * as fs from 'fs';
import * as path from 'path';
import * as mysql from 'mariadb';

// ---------------------------------------------------------------------------
// Utility functions
// ---------------------------------------------------------------------------

function toMysqlDateTime(d: Date): string {
  const offset = d.getTimezoneOffset() * 60000;
  const localTime = new Date(d.getTime() - offset);
  return localTime.toISOString().slice(0, 19).replace('T', ' ');
}

function parseLabels(content: string): string[] {
  const cleaned = content.trim().toUpperCase();
  const mapNumToAlpha: Record<string, string> = {
    '1': 'A',
    '2': 'B',
    '3': 'C',
    '4': 'D',
  };
  return cleaned
    .replace(/[\s]/g, '')
    .split(',')
    .map((x) => mapNumToAlpha[x] || x)
    .filter((x) => ['A', 'B', 'C', 'D'].includes(x))
    .filter((v, i, a) => a.indexOf(v) === i)
    .sort();
}

// ---------------------------------------------------------------------------
// Quiz session management
// ---------------------------------------------------------------------------

async function getRunningSession(guildId: string, channelId: string) {
  const prisma = db.client;

  // Clean up stale sessions older than 1 hour
  const oneHourAgo = new Date(Date.now() - 60 * 60 * 1000);

  await prisma.quizSession.updateMany({
    where: {
      guildId,
      channelId,
      status: { in: ['announced', 'running', 'scheduled'] },
      startAt: { lt: oneHourAgo },
    },
    data: {
      status: 'finished',
      endAt: new Date(),
      updatedAt: new Date(),
    },
  });

  // Get active session
  const session = await prisma.quizSession.findFirst({
    where: {
      guildId,
      channelId,
      status: { in: ['announced', 'running', 'scheduled'] },
    },
    orderBy: { id: 'desc' },
  });

  if (session) {
    log.debug('Active quiz session found', {
      sessionId: session.id,
      status: session.status,
      startAt: session.startAt,
    });
  } else {
    log.debug('No active quiz session found', { guildId, channelId });
  }

  return session;
}

// ---------------------------------------------------------------------------
// SQL Challenge - Join
// ---------------------------------------------------------------------------

async function handleChallengeJoin(message: Message) {
  try {
    const prisma = db.client;

    // Check for active session
    const activeSessions = await prisma.$queryRaw<any[]>`
      SELECT * FROM sql_challenge_sessions
      WHERE status = 'active'
      ORDER BY id DESC
      LIMIT 1
    `;

    const activeSession = activeSessions[0];

    if (!activeSession) {
      return message.reply(
        "Aucun SQL Challenge n'est actuellement actif. Attendez qu'un administrateur lance une nouvelle semaine !"
      );
    }

    // Check if user already enrolled
    const existingUsers = await prisma.$queryRaw<any[]>`
      SELECT * FROM sql_challenge_users
      WHERE (user_discord_id = ${message.author.id} OR user_discord_username = ${message.author.username})
        AND session_id = ${activeSession.id}
      LIMIT 1
    `;

    if (existingUsers.length > 0) {
      return message.reply(
        'Vous etes deja inscrit au SQL Challenge ! Ecrivez-moi en prive pour continuer.'
      );
    }

    // Enroll user
    const displayName =
      message.member?.displayName || message.author.username;
    await prisma.$executeRaw`
      INSERT INTO sql_challenge_users (user_discord_id, username, user_discord_username, guild_id, session_id, current_question, total_points)
      VALUES (${message.author.id}, ${displayName}, ${message.author.username}, ${message.guildId || ''}, ${activeSession.id}, 1, 0)
    `;

    // Public reply
    await message.reply(
      `**${displayName}** rejoint le SQL Challenge !\nCheck tes DMs pour la base de donnees et la premiere question.`
    );

    // Send database and instructions via DM
    try {
      const dbFilePath = path.join(
        __dirname,
        '../../sql_challenge_discord/BDD_CLINIC.sql'
      );

      const instructionsMessage = `**Base de donnees SQL Challenge - Clinique Medicale**

**6 Tables disponibles :**
- \`patient\` - Informations patients (nom, ville, date_naissance, mutuelle...)
- \`medecin\` - Medecins et specialites (cardiologue, pediatre...)
- \`service\` - Services hospitaliers (cardiologie, urgences...)
- \`consultation\` - Consultations avec prix et duree
- \`medicament\` - Medicaments avec stock et prix
- \`prescription\` - Medicaments prescrits

**Installation :**
1. Importe ce fichier dans MySQL/MariaDB
2. Utilise la base \`CLINIC\` pour tes requetes
3. **Toutes tes reponses doivent etre en MP ici !**

**Commandes MP disponibles :**
- \`!reponse SELECT * FROM patient;\` - Soumettre ta requete SQL
- \`!indice\` - Demander un indice (-1 point)
- \`!sql-progress\` - Voir ta progression actuelle

**Premiere question arrive dans 30 secondes...**`;

      if (fs.existsSync(dbFilePath)) {
        const attachment = new AttachmentBuilder(dbFilePath, {
          name: 'BDD_CLINIC.sql',
        });
        await message.author.send({
          content: instructionsMessage,
          files: [attachment],
        });
      } else {
        await message.author.send({ content: instructionsMessage });
        log.warn('SQL challenge DB file not found', { path: dbFilePath });
      }

      // Send first question after 30 seconds
      setTimeout(async () => {
        await sendQuestionToUser(message.author, activeSession, 1);
      }, 30000);
    } catch (dmError) {
      log.error('Error sending DM', {
        error: dmError,
        userId: message.author.id,
      });
      await message.reply(
        "Impossible d'envoyer les instructions en MP. Verifiez que vos DMs sont ouverts."
      );
    }
  } catch (error) {
    log.error('Error in handleChallengeJoin', { error });
    return message.reply("Erreur lors de l'inscription au challenge.");
  }
}

// ---------------------------------------------------------------------------
// SQL Challenge - Send question
// ---------------------------------------------------------------------------

async function sendQuestionToUser(
  user: any,
  session: any,
  questionNumber: number
) {
  try {
    const questions = JSON.parse(session.questions_data as string);
    const question = questions[questionNumber - 1];

    if (!question) {
      return user.send('Question introuvable.');
    }

    const questionMessage = `**Question ${questionNumber}/20** - Semaine ${session.week_number}

**${question.title}**

**Enonce :** ${question.question}

**Commandes (MP uniquement) :**
- \`!reponse SELECT ...\` - Soumettre ta requete SQL
- \`!indice\` - Demander un indice (-1 point)
- \`!sql-progress\` - Voir ta progression

**Rappel du format :**
- \`!reponse SELECT * FROM patient;\`
- \`!reponse SELECT nom FROM medecin WHERE specialite = 'CARDIOLOGUE';\`

**10 points par question** - **Penalite indices :** -1 point par indice utilise`;

    await user.send(questionMessage);
  } catch (error) {
    log.error('Error in sendQuestionToUser', { error, questionNumber });
  }
}

// ---------------------------------------------------------------------------
// SQL Challenge - Hint
// ---------------------------------------------------------------------------

async function handleSqlChallengeIndice(message: Message) {
  try {
    const prisma = db.client;

    log.debug('handleSqlChallengeIndice called', {
      username: message.author.username,
    });

    // Get user and active session
    const userInfo = await prisma.$queryRaw<any[]>`
      SELECT scu.id, scu.user_discord_id, scu.username, scu.user_discord_username, scu.guild_id, scu.session_id,
             scu.current_question, scu.total_points, scu.is_finished, scu.joined_at, scu.last_activity,
             scs.week_number, scs.title, scs.description, scs.difficulty, scs.status,
             scs.start_date, scs.end_date, scs.questions_data, scs.created_at as session_created_at
      FROM sql_challenge_users scu
      JOIN sql_challenge_sessions scs ON scs.id = scu.session_id
      WHERE (scu.user_discord_id = ${message.author.id} OR scu.user_discord_username = ${message.author.username})
        AND scs.status = 'active'
      ORDER BY scu.id DESC LIMIT 1
    `;

    const user = userInfo[0];

    log.debug('User info found', { id: user?.id, username: user?.username });

    if (!user || !user.id) {
      return message.reply(
        "Vous n'etes pas inscrit au challenge actuel ou aucun challenge n'est actif. Tapez `!challenge` dans un canal pour vous inscrire."
      );
    }

    if (user.is_finished) {
      return message.reply(
        'Vous avez deja termine cette semaine ! Attendez la prochaine semaine.'
      );
    }

    // Get current question
    const questions = JSON.parse(user.questions_data);
    const currentQ = questions[user.current_question - 1];

    if (!currentQ) {
      return message.reply('Question introuvable.');
    }

    // Check hints used for current question
    const hintsCount = await prisma.$queryRaw<any[]>`
      SELECT COUNT(*) as count FROM sql_challenge_hints
      WHERE user_id = ${user.id} AND question_number = ${user.current_question}
    `;
    const hintsUsedResult = hintsCount[0]?.count || 0;

    if (hintsUsedResult >= 3) {
      return message.reply(
        'Vous avez deja utilise tous vos indices pour cette question (3 max).'
      );
    }

    const nextHintLevel = hintsUsedResult + 1;
    const hint = currentQ.hints[nextHintLevel - 1];

    // Record hint usage
    await prisma.$executeRaw`
      INSERT INTO sql_challenge_hints (user_id, session_id, question_number, hint_level)
      VALUES (${user.id}, ${user.session_id}, ${user.current_question}, ${nextHintLevel})
    `;

    const hintCost = 1;
    return message.reply(
      `**Indice ${nextHintLevel}/3 :** ${hint}\n\n-${hintCost} point deduit`
    );
  } catch (error) {
    log.error('Error in handleSqlChallengeIndice', { error });
    return message.reply("Erreur lors de la recuperation de l'indice.");
  }
}

// ---------------------------------------------------------------------------
// SQL Challenge - Answer
// ---------------------------------------------------------------------------

async function handleSqlChallengeReponse(message: Message, sql: string) {
  try {
    const prisma = db.client;

    log.debug('handleSqlChallengeReponse called', {
      username: message.author.username,
      userId: message.author.id,
      sql,
    });

    if (!sql) {
      return message.reply(
        'Vous devez fournir une requete SQL. Exemple: `!reponse SELECT * FROM patient`'
      );
    }

    // Security check: only SELECT queries allowed
    const forbidden =
      /\b(insert|update|delete|alter|drop|truncate|create|replace|grant|revoke|exec|execute)\b/i;
    if (forbidden.test(sql)) {
      return message.reply('Seules les requetes SELECT sont autorisees.');
    }

    // Get user and session
    const userInfo = await prisma.$queryRaw<any[]>`
      SELECT scu.id, scu.user_discord_id, scu.username, scu.user_discord_username, scu.guild_id, scu.session_id,
             scu.current_question, scu.total_points, scu.is_finished, scu.joined_at, scu.last_activity,
             scs.week_number, scs.title, scs.description, scs.difficulty, scs.status,
             scs.start_date, scs.end_date, scs.questions_data, scs.created_at as session_created_at
      FROM sql_challenge_users scu
      JOIN sql_challenge_sessions scs ON scs.id = scu.session_id
      WHERE (scu.user_discord_id = ${message.author.id} OR scu.user_discord_username = ${message.author.username})
        AND scs.status = 'active'
      ORDER BY scu.id DESC LIMIT 1
    `;

    const user = userInfo[0];

    log.debug('User info found', { id: user?.id, username: user?.username });

    if (!user || !user.id) {
      return message.reply(
        "Vous n'etes pas inscrit au challenge actuel. Tapez `!challenge` dans un canal pour vous inscrire."
      );
    }

    if (user.is_finished) {
      return message.reply(
        'Vous avez deja termine cette semaine ! Attendez la prochaine semaine.'
      );
    }

    // Get current question
    const questions = JSON.parse(user.questions_data);
    const currentQ = questions[user.current_question - 1];

    if (!currentQ) {
      return message.reply('Question introuvable.');
    }

    // Check if already answered correctly
    const alreadyAnswered = await prisma.$queryRaw<any[]>`
      SELECT * FROM sql_challenge_responses
      WHERE user_id = ${user.id} AND question_number = ${user.current_question} AND is_correct = 1
      LIMIT 1
    `;

    if (alreadyAnswered.length > 0) {
      return message.reply(
        'Vous avez deja repondu correctement a cette question ! Prochaine question envoyee...'
      );
    }

    // Test the user's query against expected results
    const isCorrect = await testUserQuery(sql, currentQ);

    if (isCorrect) {
      // Calculate position and hint penalty
      const position = await calculateUserPosition(
        user.session_id,
        user.current_question
      );
      const hintsCount = await prisma.$queryRaw<any[]>`
        SELECT COUNT(*) as count FROM sql_challenge_hints
        WHERE user_id = ${user.id} AND question_number = ${user.current_question}
      `;
      const hintsUsed = hintsCount[0]?.count || 0;

      const basePoints = 10;
      let hintPenalty = 0;
      if (hintsUsed === 1) hintPenalty = 1;
      else if (hintsUsed === 2) hintPenalty = 2;
      else if (hintsUsed >= 3) hintPenalty = 3;
      const finalPoints = Math.max(0, basePoints - hintPenalty);

      // Record correct response
      await prisma.$executeRaw`
        INSERT INTO sql_challenge_responses
        (user_id, session_id, question_number, submitted_sql, is_correct, points_earned, hints_used, position_rank)
        VALUES (${user.id}, ${user.session_id}, ${user.current_question}, ${sql}, 1, ${finalPoints}, ${hintsUsed}, ${position})
      `;

      // Update user total points and advance question
      await prisma.$executeRaw`
        UPDATE sql_challenge_users
        SET total_points = total_points + ${finalPoints}, current_question = current_question + 1
        WHERE id = ${user.id}
      `;

      const hintText =
        hintsUsed > 0
          ? ` (${hintsUsed} indice${hintsUsed > 1 ? 's' : ''} utilise${
              hintsUsed > 1 ? 's' : ''
            })`
          : '';
      await message.reply(
        `**Correct !** Tu gagnes **${finalPoints} points**${hintText}\n\n**Question ${user.current_question}** terminee ! Prochaine question envoyee...`
      );

      // Send next question or finish challenge
      if (user.current_question < 20) {
        setTimeout(async () => {
          await sendQuestionToUser(
            message.author,
            user,
            user.current_question + 1
          );
        }, 3000);
      } else {
        // Mark as finished
        await prisma.$executeRaw`
          UPDATE sql_challenge_users SET is_finished = 1 WHERE id = ${user.id}
        `;

        // Calculate finish position
        const finishPositionResult = await prisma.$queryRaw<any[]>`
          SELECT COUNT(*) + 1 as position FROM sql_challenge_users
          WHERE session_id = ${user.session_id} AND is_finished = 1 AND id != ${user.id}
        `;
        const finishPosition = finishPositionResult[0]?.position || 1;

        const finalTotalPoints = user.total_points + finalPoints;

        // Points ranking
        const pointsRankingResult = await prisma.$queryRaw<any[]>`
          SELECT COUNT(*) + 1 as rank FROM sql_challenge_users
          WHERE session_id = ${user.session_id} AND is_finished = 1
            AND total_points > ${finalTotalPoints} AND id != ${user.id}
        `;
        const pointsRanking = pointsRankingResult[0]?.rank || 1;

        // Get top 5
        const top5 = await prisma.$queryRaw<any[]>`
          SELECT username, total_points
          FROM sql_challenge_users
          WHERE session_id = ${user.session_id} AND is_finished = 1
          ORDER BY total_points DESC
          LIMIT 5
        `;

        // Private completion message
        await message.reply(
          `**Felicitations !** Vous avez termine la Semaine ${user.week_number} avec **${finalTotalPoints} points** !`
        );

        // Public announcement in the guild channel
        try {
          const configs = await prisma.$queryRaw<any[]>`
            SELECT * FROM sql_challenge_configs WHERE guild_id = ${user.guild_id} LIMIT 1
          `;
          const config = configs[0];

          if (config && message.client.guilds) {
            const guild = await message.client.guilds.fetch(user.guild_id);
            if (guild) {
              const channelId =
                config.announce_channel_id || config.challenge_channel_id;
              const channel = await guild.channels
                .fetch(channelId)
                .catch(() => null);

              if (channel && channel.isTextBased()) {
                const displayName =
                  guild.members.cache.get(message.author.id)?.displayName ||
                  message.author.username;

                let publicMessage = `**${displayName}** est le **${finishPosition}${
                  finishPosition === 1 ? 'er' : 'eme'
                }** a finir ce SQL Challenge avec **${finalTotalPoints} points** !\n`;
                publicMessage += `Il est donc en **${pointsRanking}${
                  pointsRanking === 1 ? 'ere' : 'eme'
                } position** au classement par points.\n\n`;

                if (top5.length > 0) {
                  publicMessage += `**Top 5 actuel :**\n`;
                  top5.forEach((u: any, index: number) => {
                    const medal =
                      index === 0
                        ? '1.'
                        : index === 1
                        ? '2.'
                        : index === 2
                        ? '3.'
                        : `${index + 1}.`;
                    publicMessage += `${medal} **${u.username}** - ${u.total_points} pts\n`;
                  });
                }

                if ('send' in channel) {
                  await channel.send(publicMessage);
                }
              }
            }
          }
        } catch (error) {
          log.error('Error sending public announcement', { error });
        }
      }
    } else {
      // Incorrect response
      await prisma.$executeRaw`
        INSERT INTO sql_challenge_responses
        (user_id, session_id, question_number, submitted_sql, is_correct, points_earned, hints_used)
        VALUES (${user.id}, ${user.session_id}, ${user.current_question}, ${sql}, 0, 0, 0)
      `;

      await message.reply(
        'Reponse incorrecte. Reessaye ! Tape `!indice` pour un indice (-1 point)'
      );
    }
  } catch (error) {
    log.error('Error in handleSqlChallengeReponse', { error });
    return message.reply('Erreur lors du traitement de votre reponse.');
  }
}

// ---------------------------------------------------------------------------
// SQL Challenge - Progress
// ---------------------------------------------------------------------------

async function handleSqlProgress(message: Message) {
  try {
    const prisma = db.client;

    const userInfos = await prisma.$queryRaw<any[]>`
      SELECT scu.*, scs.week_number, scs.title
      FROM sql_challenge_users scu
      JOIN sql_challenge_sessions scs ON scs.id = scu.session_id
      WHERE scu.user_discord_id = ${message.author.id} AND scs.status = 'active'
      ORDER BY scu.id DESC LIMIT 1
    `;

    const userInfo = userInfos[0];

    if (!userInfo) {
      return message.reply("Vous n'etes pas inscrit au challenge actuel.");
    }

    const progress = `**Ta progression - ${userInfo.title}**

**Question actuelle :** ${userInfo.current_question}/20
**Points totaux :** ${userInfo.total_points}
**Statut :** ${userInfo.is_finished ? 'Termine' : 'En cours'}

${!userInfo.is_finished ? 'Continue comme ca !' : 'Bravo pour avoir termine !'}`;

    return message.reply(progress);
  } catch (error) {
    log.error('Error in handleSqlProgress', { error });
    return message.reply(
      'Erreur lors de la recuperation de votre progression.'
    );
  }
}

// ---------------------------------------------------------------------------
// SQL Challenge - Test user query against expected result
// ---------------------------------------------------------------------------

async function testUserQuery(userSql: string, question: any): Promise<boolean> {
  let conn: mysql.Connection | null = null;

  try {
    // Create test database connection using mariadb driver
    conn = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: 'discord_test',
      password: 'Maglit3s',
      database: 'discord_test',
    });

    try {
      // Execute user query
      const userResult = await conn.query(userSql);

      // Collect all solution queries to test against
      const solutionsToTest: string[] = [];

      if (question.solutions && Array.isArray(question.solutions)) {
        question.solutions.forEach((solution: any) => {
          if (typeof solution === 'string') {
            solutionsToTest.push(solution);
          } else if (solution.sql) {
            solutionsToTest.push(solution.sql);
          }
        });
      } else if (question.solution) {
        solutionsToTest.push(question.solution);
      }

      // Compare user result with each valid solution
      for (const solutionSql of solutionsToTest) {
        try {
          const correctResult = await conn.query(solutionSql);

          if (JSON.stringify(userResult) === JSON.stringify(correctResult)) {
            await conn.end();
            return true;
          }
        } catch (solutionError) {
          log.debug('Error in reference solution', { solutionError });
          continue;
        }
      }

      await conn.end();
      return false;
    } catch (userError) {
      await conn.end();
      log.debug('User SQL error', { userError });
      return false;
    }
  } catch (connectionError) {
    log.error('Error connecting to test database', { connectionError });
    if (conn) {
      await conn.end().catch(() => {});
    }

    // Fallback to text-based comparison
    const normalize = (sql: string) =>
      sql.toLowerCase().replace(/\s+/g, ' ').trim();
    const normalizedUserSql = normalize(userSql);

    if (question.solutions && Array.isArray(question.solutions)) {
      return question.solutions.some((solution: any) => {
        if (typeof solution === 'string') {
          return normalize(solution) === normalizedUserSql;
        } else if (solution.sql) {
          return normalize(solution.sql) === normalizedUserSql;
        }
        return false;
      });
    } else if (question.solution) {
      return normalize(question.solution) === normalizedUserSql;
    }

    return false;
  }
}

// ---------------------------------------------------------------------------
// SQL Challenge - Calculate user position for a question
// ---------------------------------------------------------------------------

async function calculateUserPosition(
  sessionId: number,
  questionNumber: number
): Promise<number> {
  const prisma = db.client;

  const counts = await prisma.$queryRaw<any[]>`
    SELECT COUNT(*) as count FROM sql_challenge_responses
    WHERE session_id = ${sessionId} AND question_number = ${questionNumber} AND is_correct = 1
  `;

  return (counts[0]?.count || 0) + 1;
}

// ---------------------------------------------------------------------------
// Message patterns for fast filtering
// ---------------------------------------------------------------------------

const PARTICIPE_PATTERN = /^!participe$/i;
const CHALLENGE_PATTERN = /^!challenge$/i;
const TEST_PATTERN = /^!test$/i;
const SQL_COMMANDS_PATTERN = /^!(indice|reponse|sql-progress)/i;
const QUIZ_ANSWER_PATTERN = /^[a-d](,[a-d])*$|^[1-4](,[1-4])*$/i;

// ---------------------------------------------------------------------------
// Main event handler
// ---------------------------------------------------------------------------

const messageCreateEvent: BotEvent = {
  name: 'messageCreate',
  async execute(message: Message) {
    // Ignore bot messages
    if (message.author.bot) return;

    // ------------------------------------------------------------------
    // Retrait du role "Nouvel utilisateur" au premier message
    // ------------------------------------------------------------------
    if (message.guild && message.member) {
      try {
        const guildConfig = await db.client.guildConfig.findUnique({
          where: { guildId: message.guild.id },
          select: { autoRoles: true, autoRoleId: true },
        });

        if (guildConfig?.autoRoles && guildConfig.autoRoleId) {
          const hasNewRole = message.member.roles.cache.has(guildConfig.autoRoleId);
          if (hasNewRole) {
            await message.member.roles.remove(
              guildConfig.autoRoleId,
              'Premier message - retrait du role Nouvel utilisateur'
            );
            log.service('Welcome', `Role Nouvel utilisateur retire de ${message.author.tag} (premier message)`);
          }
        }
      } catch (err) {
        // Pas critique, on log et on continue
        log.debug('Erreur retrait role nouvel utilisateur', { error: err });
      }
    }

    const content = message.content.trim();

    // Fast filtering: only process relevant messages
    const isRelevantMessage =
      PARTICIPE_PATTERN.test(content) ||
      CHALLENGE_PATTERN.test(content) ||
      TEST_PATTERN.test(content) ||
      SQL_COMMANDS_PATTERN.test(content) ||
      QUIZ_ANSWER_PATTERN.test(content);

    if (!isRelevantMessage) {
      return;
    }

    log.debug('Relevant message received', {
      channelType: message.channel.type,
      content,
      username: message.author.username,
    });

    const prisma = db.client;

    try {
      // ---------------------------------------------------------------
      // !participe - Join a quiz session
      // ---------------------------------------------------------------
      if (PARTICIPE_PATTERN.test(content)) {
        if (!message.guildId || !message.channelId) return;

        const session = await getRunningSession(
          message.guildId,
          message.channelId
        );
        if (!session) return;

        // Accept participation before and during quiz
        if (
          session.status === 'scheduled' ||
          session.status === 'announced' ||
          session.status === 'running'
        ) {
          const displayName =
            message.member?.displayName || message.author.username;

          await prisma.quizParticipant.upsert({
            where: {
              sessionId_userDiscordId: {
                sessionId: session.id,
                userDiscordId: message.author.id,
              },
            },
            update: {
              username: displayName,
              updatedAt: new Date(),
            },
            create: {
              sessionId: session.id,
              userId: message.author.id,
              userDiscordId: message.author.id,
              username: displayName,
              score: 0,
              createdAt: new Date(),
              updatedAt: new Date(),
            },
          });

          return message.react('✅');
        }
        return;
      }

      // ---------------------------------------------------------------
      // !challenge - Join SQL challenge
      // ---------------------------------------------------------------
      if (CHALLENGE_PATTERN.test(content)) {
        return await handleChallengeJoin(message);
      }

      // ---------------------------------------------------------------
      // !test - DM connectivity test
      // ---------------------------------------------------------------
      if (
        TEST_PATTERN.test(content) &&
        message.channel.type === ChannelType.DM
      ) {
        return message.reply('Le bot recoit bien tes messages prives !');
      }

      // ---------------------------------------------------------------
      // SQL Challenge commands (!indice, !reponse, !sql-progress)
      // ---------------------------------------------------------------
      if (SQL_COMMANDS_PATTERN.test(content)) {
        log.debug('SQL command received', {
          content,
          channelType: message.channel.type,
          guildId: message.guildId || 'DM',
        });

        const lowerContent = content.toLowerCase();

        if (lowerContent === '!indice') {
          return await handleSqlChallengeIndice(message);
        }

        if (lowerContent.startsWith('!reponse')) {
          const sql = content.substring(8).trim();
          return await handleSqlChallengeReponse(message, sql);
        }

        if (lowerContent === '!sql-progress') {
          return await handleSqlProgress(message);
        }
      }

      // ---------------------------------------------------------------
      // Quiz answers (A/B/C/D or 1/2/3/4)
      // ---------------------------------------------------------------
      if (QUIZ_ANSWER_PATTERN.test(content)) {
        if (!message.guildId || !message.channelId) return;

        const session = await getRunningSession(
          message.guildId,
          message.channelId
        );
        if (!session || session.status !== 'running') return;

        // Calculate current question position based on elapsed time
        const now = Date.now();
        const sessionStart = session.startAt
          ? new Date(session.startAt).getTime()
          : now;
        const timeSinceScheduled = Math.floor((now - sessionStart) / 1000);

        let currentPosition = 1;

        if (session.status === 'running') {
          const secondsPerQuestion = 35;
          currentPosition =
            Math.floor(timeSinceScheduled / secondsPerQuestion) + 1;
          currentPosition = Math.min(currentPosition, 50);
        }

        log.debug('Quiz answer received', {
          sessionId: session.id,
          timeSinceStart: timeSinceScheduled,
          currentPosition,
        });

        const question = await prisma.quizSessionQuestion.findFirst({
          where: {
            sessionId: session.id,
            position: currentPosition,
          },
        });

        if (!question) {
          log.debug('No question found', {
            sessionId: session.id,
            position: currentPosition,
          });
          return;
        }

        log.debug('Question found', {
          questionId: question.id,
          position: question.position,
        });

        const labels = parseLabels(content).join(',');

        // Check if user is a participant
        const isParticipant = await prisma.quizParticipant.findFirst({
          where: {
            sessionId: session.id,
            userDiscordId: message.author.id,
          },
        });

        if (!isParticipant) {
          return;
        }

        // Record response (ignore duplicate via unique constraint)
        try {
          await prisma.quizResponse.create({
            data: {
              sessionId: session.id,
              sessionQuestionId: question.id,
              userDiscordId: message.author.id,
              labels,
              points: 0,
              createdAt: new Date(),
              updatedAt: new Date(),
            },
          });
          return message.react('📩');
        } catch (e) {
          // Already answered for this question - silently ignore
          return;
        }
      }
    } catch (e) {
      log.error('messageCreate error', { error: e });
    }
  },
};

export default messageCreateEvent;
