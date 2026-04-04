import { Message, ChannelType } from 'discord.js';
import { db } from '../services/database';
import { log } from '../services/logger';
import { SqlSandbox } from '../services/sql-sandbox';
import { BotEvent } from '../types/event';
import * as fs from 'fs';
import * as path from 'path';

// ---------------------------------------------------------------------------
// Utility functions
// ---------------------------------------------------------------------------

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

/** Load schema SQL for a dataset (from DB field or file) */
function loadSchemaSql(dataset: any): string {
  if (dataset.schema_sql) return dataset.schema_sql;
  const filePath = path.join(process.cwd(), 'prisma/datasets', `${dataset.slug}.sql`);
  if (fs.existsSync(filePath)) {
    return fs.readFileSync(filePath, 'utf-8');
  }
  throw new Error(`Schema SQL introuvable pour le dataset "${dataset.slug}"`);
}

/** Parse CREATE TABLE statements from a schema SQL string and build a readable summary */
function buildSchemaDescription(schemaSql: string): string {
  const tableRegex = /CREATE TABLE\s+(?:IF NOT EXISTS\s+)?(\w+)\s*\(/gi;
  const tables: string[] = [];
  let match;
  while ((match = tableRegex.exec(schemaSql)) !== null) {
    const tableName = match[1];
    let depth = 1;
    let i = match.index + match[0].length;
    while (i < schemaSql.length && depth > 0) {
      if (schemaSql[i] === '(') depth++;
      if (schemaSql[i] === ')') depth--;
      i++;
    }
    const body = schemaSql.substring(match.index + match[0].length, i - 1);
    // Parse columns (skip FOREIGN KEY, PRIMARY KEY, CHECK constraints)
    const parts: string[] = [];
    let current = '';
    let pd = 0;
    for (const ch of body) {
      if (ch === '(') pd++;
      if (ch === ')') pd--;
      if (ch === ',' && pd === 0) { parts.push(current.trim()); current = ''; }
      else current += ch;
    }
    if (current.trim()) parts.push(current.trim());
    const cols = parts
      .filter((c) => !c.startsWith('FOREIGN') && !c.startsWith('PRIMARY') && !c.startsWith('CHECK') && !c.startsWith('UNIQUE') && c.length > 0)
      .map((c) => { const tokens = c.split(/\s+/); return `  ${tokens[0]} ${tokens[1] || ''}`; })
      .join('\n');
    tables.push(`**${tableName}**\n\`\`\`\n${cols}\n\`\`\``);
  }
  return tables.join('\n\n');
}

async function handleChallengeJoin(message: Message) {
  try {
    const prisma = db.client;

    // Check for active session in any guild
    const activeSessions = await prisma.$queryRaw<any[]>`
      SELECT s.*, d.slug as dataset_slug, d.name as dataset_name, d.description as dataset_description, d.schema_sql
      FROM sql_challenge_sessions s
      JOIN sql_clinic_datasets d ON d.id = s.dataset_id
      WHERE s.status = 'active'
      ORDER BY s.id DESC
      LIMIT 1
    `;

    const activeSession = activeSessions[0];

    if (!activeSession) {
      return message.reply(
        "Aucun SQL Challenge n'est actuellement actif. Attendez qu'un administrateur en lance un avec `/sql challenge start` !"
      );
    }

    // Check if user already enrolled
    const existingParticipants = await prisma.$queryRaw<any[]>`
      SELECT * FROM sql_challenge_participants
      WHERE user_discord_id = ${message.author.id}
        AND session_id = ${activeSession.id}
      LIMIT 1
    `;

    if (existingParticipants.length > 0) {
      return message.reply(
        'Vous etes deja inscrit au SQL Challenge ! Ecrivez-moi en prive pour continuer.'
      );
    }

    // Enroll user
    const displayName = message.member?.displayName || message.author.username;
    await prisma.$executeRaw`
      INSERT INTO sql_challenge_participants (session_id, user_discord_id, username, guild_id, current_question, total_points, hints_used, is_finished, joined_at, created_at, updated_at)
      VALUES (${activeSession.id}, ${message.author.id}, ${displayName}, ${message.guildId || ''}, 1, 0, 0, false, NOW(), NOW(), NOW())
    `;

    // Public reply
    await message.reply(
      `**${displayName}** rejoint le SQL Challenge !\nCheck tes DMs pour le schema et la premiere question.`
    );

    // Send schema and instructions via DM
    try {
      let schemaSql: string;
      try {
        schemaSql = loadSchemaSql(activeSession);
      } catch {
        schemaSql = '';
      }

      const schemaDesc = schemaSql ? buildSchemaDescription(schemaSql) : '*Schema non disponible*';

      const instructionsMessage = `**SQL Challenge — ${activeSession.dataset_name || activeSession.title}**

${activeSession.dataset_description || ''}

**Schema des tables :**
${schemaDesc}

**Commandes MP disponibles :**
- \`!reponse SELECT ...\` — Soumettre ta requete SQL
- \`!indice\` — Demander un indice (-2 points)
- \`!sql-progress\` — Voir ta progression actuelle

**Premiere question arrive dans 30 secondes...**`;

      await message.author.send({ content: instructionsMessage });

      // Send first question after 30 seconds
      setTimeout(async () => {
        await sendQuestionToUser(message.author, activeSession, 1);
      }, 30000);
    } catch (dmError) {
      log.error('Error sending DM', { error: dmError, userId: message.author.id });
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
    const prisma = db.client;

    // Get task IDs from session questions_json
    const taskIds: number[] = JSON.parse(session.questions_json || session.questionsJson || '[]');
    const taskId = taskIds[questionNumber - 1];

    if (!taskId) {
      return user.send(`Bravo ! Tu as termine toutes les questions du challenge !`);
    }

    // Load the task from sql_clinic_tasks
    const tasks = await prisma.$queryRaw<any[]>`
      SELECT id, slug, title, description, difficulty, points, hint
      FROM sql_clinic_tasks
      WHERE id = ${taskId}
      LIMIT 1
    `;
    const task = tasks[0];

    if (!task) {
      return user.send('Question introuvable.');
    }

    const totalQuestions = taskIds.length;
    const diffLabel = task.difficulty === 'beginner' ? '🟢 Debutant' : task.difficulty === 'intermediate' ? '🟡 Intermediaire' : '🔴 Avance';

    const questionMessage = `**Question ${questionNumber}/${totalQuestions}** — ${session.title || 'SQL Challenge'}

**${task.title}** ${diffLabel}

**Enonce :** ${task.description}

**Commandes (MP uniquement) :**
- \`!reponse SELECT ...\` — Soumettre ta requete SQL
- \`!indice\` — Demander un indice (-2 points)
- \`!sql-progress\` — Voir ta progression

**${task.points} points par question** — **Penalite indices :** -2 points par indice`;

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

    log.debug('handleSqlChallengeIndice called', { username: message.author.username });

    // Get participant and active session
    const participantInfo = await prisma.$queryRaw<any[]>`
      SELECT p.id, p.session_id, p.current_question, p.total_points, p.hints_used, p.is_finished,
             s.title, s.questions_json, s.total_questions, s.dataset_id
      FROM sql_challenge_participants p
      JOIN sql_challenge_sessions s ON s.id = p.session_id
      WHERE p.user_discord_id = ${message.author.id}
        AND s.status = 'active'
      ORDER BY p.id DESC LIMIT 1
    `;

    const participant = participantInfo[0];

    if (!participant || !participant.id) {
      return message.reply(
        "Vous n'etes pas inscrit au challenge actuel. Tapez `!challenge-sql` dans un canal pour vous inscrire."
      );
    }

    if (participant.is_finished) {
      return message.reply('Vous avez deja termine ce challenge !');
    }

    // Get current task from questions_json
    const taskIds: number[] = JSON.parse(participant.questions_json);
    const currentTaskId = taskIds[participant.current_question - 1];

    if (!currentTaskId) {
      return message.reply('Question introuvable.');
    }

    // Load the task hint
    const tasks = await prisma.$queryRaw<any[]>`
      SELECT id, hint FROM sql_clinic_tasks WHERE id = ${currentTaskId} LIMIT 1
    `;
    const task = tasks[0];

    if (!task || !task.hint) {
      return message.reply("Aucun indice disponible pour cette question.");
    }

    // Check how many hints already used for this question (from responses table)
    const existingResponses = await prisma.$queryRaw<any[]>`
      SELECT hints_used FROM sql_challenge_responses
      WHERE participant_id = ${participant.id} AND question_number = ${participant.current_question}
      ORDER BY id DESC LIMIT 1
    `;
    const currentHintsForQuestion = existingResponses[0]?.hints_used || 0;

    if (currentHintsForQuestion >= 1) {
      return message.reply(
        `Vous avez deja utilise l'indice pour cette question.\n\n**Rappel de l'indice :** ${task.hint}`
      );
    }

    // Record hint usage: update participant hints_used global counter
    await prisma.$executeRaw`
      UPDATE sql_challenge_participants
      SET hints_used = hints_used + 1, last_activity_at = NOW(), updated_at = NOW()
      WHERE id = ${participant.id}
    `;

    // Also track hints for the current question in responses (create a placeholder if needed)
    const hasResponse = existingResponses.length > 0;
    if (!hasResponse) {
      await prisma.$executeRaw`
        INSERT INTO sql_challenge_responses (participant_id, task_id, question_number, submitted_sql, is_correct, points_earned, hints_used, submitted_at, created_at)
        VALUES (${participant.id}, ${currentTaskId}, ${participant.current_question}, '', false, 0, 1, NOW(), NOW())
      `;
    } else {
      await prisma.$executeRaw`
        UPDATE sql_challenge_responses
        SET hints_used = hints_used + 1
        WHERE participant_id = ${participant.id} AND question_number = ${participant.current_question}
          AND id = (SELECT MAX(id) FROM sql_challenge_responses WHERE participant_id = ${participant.id} AND question_number = ${participant.current_question})
      `;
    }

    return message.reply(
      `**Indice :** ${task.hint}\n\n-2 points deduits sur cette question.`
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

    // Get participant and session + dataset
    const participantInfo = await prisma.$queryRaw<any[]>`
      SELECT p.id, p.session_id, p.user_discord_id, p.username, p.guild_id,
             p.current_question, p.total_points, p.hints_used, p.is_finished,
             s.title, s.questions_json, s.total_questions, s.dataset_id, s.channel_id,
             d.slug as dataset_slug, d.schema_sql, d.name as dataset_name
      FROM sql_challenge_participants p
      JOIN sql_challenge_sessions s ON s.id = p.session_id
      JOIN sql_clinic_datasets d ON d.id = s.dataset_id
      WHERE p.user_discord_id = ${message.author.id}
        AND s.status = 'active'
      ORDER BY p.id DESC LIMIT 1
    `;

    const participant = participantInfo[0];

    if (!participant || !participant.id) {
      return message.reply(
        "Vous n'etes pas inscrit au challenge actuel. Tapez `!challenge-sql` dans un canal pour vous inscrire."
      );
    }

    if (participant.is_finished) {
      return message.reply('Vous avez deja termine ce challenge !');
    }

    // Get current task
    const taskIds: number[] = JSON.parse(participant.questions_json);
    const currentTaskId = taskIds[participant.current_question - 1];

    if (!currentTaskId) {
      return message.reply('Question introuvable.');
    }

    const tasks = await prisma.$queryRaw<any[]>`
      SELECT id, slug, title, expected_sql, points, hint
      FROM sql_clinic_tasks WHERE id = ${currentTaskId} LIMIT 1
    `;
    const task = tasks[0];

    if (!task) {
      return message.reply('Question introuvable.');
    }

    // Check if already answered correctly
    const alreadyAnswered = await prisma.$queryRaw<any[]>`
      SELECT * FROM sql_challenge_responses
      WHERE participant_id = ${participant.id} AND question_number = ${participant.current_question} AND is_correct = true
      LIMIT 1
    `;

    if (alreadyAnswered.length > 0) {
      return message.reply(
        'Vous avez deja repondu correctement a cette question ! Prochaine question envoyee...'
      );
    }

    // Load schema and validate using SQLite sandbox
    let schemaSql: string;
    try {
      schemaSql = loadSchemaSql(participant);
    } catch {
      return message.reply('Erreur: schema du dataset introuvable.');
    }

    const validation = SqlSandbox.validate(schemaSql, sql, task.expected_sql);

    // Check hints used for this question
    const hintResponses = await prisma.$queryRaw<any[]>`
      SELECT COALESCE(MAX(hints_used), 0) as hints FROM sql_challenge_responses
      WHERE participant_id = ${participant.id} AND question_number = ${participant.current_question}
    `;
    const hintsUsed = Number(hintResponses[0]?.hints || 0);

    if (validation.success) {
      const basePoints = task.points || 10;
      const hintPenalty = hintsUsed * 2;
      const finalPoints = Math.max(0, basePoints - hintPenalty);

      // Record correct response
      await prisma.$executeRaw`
        INSERT INTO sql_challenge_responses (participant_id, task_id, question_number, submitted_sql, is_correct, points_earned, hints_used, submitted_at, created_at)
        VALUES (${participant.id}, ${currentTaskId}, ${participant.current_question}, ${sql}, true, ${finalPoints}, ${hintsUsed}, NOW(), NOW())
      `;

      // Update participant: add points, advance question
      const nextQuestion = participant.current_question + 1;
      const isLastQuestion = participant.current_question >= taskIds.length;

      await prisma.$executeRaw`
        UPDATE sql_challenge_participants
        SET total_points = total_points + ${finalPoints},
            current_question = ${nextQuestion},
            is_finished = ${isLastQuestion},
            last_activity_at = NOW(),
            updated_at = NOW()
        WHERE id = ${participant.id}
      `;

      const hintText = hintsUsed > 0
        ? ` (${hintsUsed} indice${hintsUsed > 1 ? 's' : ''} utilise${hintsUsed > 1 ? 's' : ''})`
        : '';

      if (isLastQuestion) {
        // Challenge finished!
        const finalTotalPoints = participant.total_points + finalPoints;

        // Calculate finish position
        const finishPosResult = await prisma.$queryRaw<any[]>`
          SELECT COUNT(*) as cnt FROM sql_challenge_participants
          WHERE session_id = ${participant.session_id} AND is_finished = true AND id != ${participant.id}
        `;
        const finishPosition = (Number(finishPosResult[0]?.cnt) || 0) + 1;

        // Get top 5
        const top5 = await prisma.$queryRaw<any[]>`
          SELECT username, total_points
          FROM sql_challenge_participants
          WHERE session_id = ${participant.session_id}
          ORDER BY total_points DESC
          LIMIT 5
        `;

        // Private congratulation
        await message.reply(
          `**Correct !** +**${finalPoints} points**${hintText}\n\n` +
          `**Felicitations !** Tu as termine le SQL Challenge avec **${finalTotalPoints} points** !\n` +
          `Tu es le **${finishPosition}${finishPosition === 1 ? 'er' : 'eme'}** a finir !`
        );

        // Public announcement in the challenge channel
        try {
          if (participant.guild_id && participant.channel_id) {
            const guild = await message.client.guilds.fetch(participant.guild_id);
            if (guild) {
              const channel = await guild.channels.fetch(participant.channel_id).catch(() => null);
              if (channel && channel.isTextBased() && 'send' in channel) {
                const displayName = guild.members.cache.get(message.author.id)?.displayName || message.author.username;

                let publicMsg = `🏁 **${displayName}** est le **${finishPosition}${finishPosition === 1 ? 'er' : 'eme'}** a finir le SQL Challenge avec **${finalTotalPoints} points** !\n\n`;

                if (top5.length > 0) {
                  publicMsg += `**Top 5 actuel :**\n`;
                  top5.forEach((u: any, index: number) => {
                    const medal = index === 0 ? '🥇' : index === 1 ? '🥈' : index === 2 ? '🥉' : `**${index + 1}.**`;
                    publicMsg += `${medal} **${u.username}** — ${u.total_points} pts\n`;
                  });
                }

                await (channel as any).send(publicMsg);
              }
            }
          }
        } catch (err) {
          log.error('Error sending public announcement', { error: err });
        }
      } else {
        // Send next question
        await message.reply(
          `**Correct !** +**${finalPoints} points**${hintText}\n\n` +
          `**Question ${participant.current_question}** terminee ! Prochaine question dans 3 secondes...`
        );

        setTimeout(async () => {
          await sendQuestionToUser(message.author, participant, nextQuestion);
        }, 3000);
      }
    } else {
      // Incorrect response — record it
      await prisma.$executeRaw`
        INSERT INTO sql_challenge_responses (participant_id, task_id, question_number, submitted_sql, is_correct, points_earned, hints_used, submitted_at, created_at)
        VALUES (${participant.id}, ${currentTaskId}, ${participant.current_question}, ${sql}, false, 0, ${hintsUsed}, NOW(), NOW())
      `;

      // Update last activity
      await prisma.$executeRaw`
        UPDATE sql_challenge_participants SET last_activity_at = NOW(), updated_at = NOW() WHERE id = ${participant.id}
      `;

      let errorMsg = 'Reponse incorrecte. Reessaye !';
      if (validation.error) {
        errorMsg += `\n\n**Erreur SQL :**\n\`\`\`\n${validation.error}\n\`\`\``;
      } else {
        // Give hints about what's wrong
        const userRows = validation.userResult?.rows.length || 0;
        const expectedRows = validation.expectedResult?.rows.length || 0;
        const userCols = validation.userResult?.columns.length || 0;
        const expectedCols = validation.expectedResult?.columns.length || 0;

        if (userCols !== expectedCols) {
          errorMsg += `\n📏 **Colonnes :** vous avez ${userCols}, attendu ${expectedCols}`;
        }
        if (userRows !== expectedRows) {
          errorMsg += `\n📋 **Lignes :** vous avez ${userRows}, attendu ${expectedRows}`;
        }
        if (userCols === expectedCols && userRows === expectedRows) {
          errorMsg += `\n🔍 Le nombre de colonnes et lignes est correct, mais les **valeurs** different.`;
        }
      }
      errorMsg += `\n\nTape \`!indice\` pour un indice (-2 points)`;

      await message.reply(errorMsg);
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

    const participantInfos = await prisma.$queryRaw<any[]>`
      SELECT p.current_question, p.total_points, p.hints_used, p.is_finished,
             s.title, s.total_questions
      FROM sql_challenge_participants p
      JOIN sql_challenge_sessions s ON s.id = p.session_id
      WHERE p.user_discord_id = ${message.author.id} AND s.status = 'active'
      ORDER BY p.id DESC LIMIT 1
    `;

    const info = participantInfos[0];

    if (!info) {
      return message.reply("Vous n'etes pas inscrit au challenge actuel.");
    }

    const questionDisplay = info.is_finished
      ? `${info.total_questions}/${info.total_questions}`
      : `${info.current_question}/${info.total_questions}`;

    const progress = `**Ta progression — ${info.title}**

**Question actuelle :** ${questionDisplay}
**Points totaux :** ${info.total_points}
**Indices utilises :** ${info.hints_used}
**Statut :** ${info.is_finished ? '✅ Termine' : '⏳ En cours'}

${!info.is_finished ? 'Continue comme ca !' : 'Bravo pour avoir termine !'}`;

    return message.reply(progress);
  } catch (error) {
    log.error('Error in handleSqlProgress', { error });
    return message.reply(
      'Erreur lors de la recuperation de votre progression.'
    );
  }
}

// ---------------------------------------------------------------------------
// Message patterns for fast filtering
// ---------------------------------------------------------------------------

const PARTICIPE_PATTERN = /^!participe$/i;
const CHALLENGE_PATTERN = /^!challenge-sql$/i;
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
    // Tracking activite + retrait du role "Nouvel utilisateur"
    // ------------------------------------------------------------------
    if (message.guild && message.member) {
      try {
        // Mise a jour du compteur de messages et derniere activite
        await db.client.guildMember.upsert({
          where: {
            guildId_userId: {
              guildId: message.guild.id,
              userId: message.author.id,
            },
          },
          update: {
            messageCount: { increment: 1 },
            lastActiveAt: new Date(),
            username: message.author.username,
            displayName: message.member.displayName,
          },
          create: {
            guildId: message.guild.id,
            userId: message.author.id,
            username: message.author.username,
            displayName: message.member.displayName,
            roles: message.member.roles.cache.map((r) => r.id).join(','),
            joinedAt: message.member.joinedAt || new Date(),
            isBot: message.author.bot,
            messageCount: 1,
            lastActiveAt: new Date(),
          },
        });
      } catch (err) {
        log.debug('Erreur tracking activite membre', { error: err });
      }

      try {
        // Retrait du role "Nouvel utilisateur" et/ou "En Preavis" au message
        const guildConfig = await db.client.guildConfig.findUnique({
          where: { guildId: message.guild.id },
          select: { autoRoles: true, autoRoleId: true, preavisRoleId: true },
        });

        // Retrait du role "Nouvel utilisateur" au premier message
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

        // Retrait du role "En Preavis" si le membre parle
        if (guildConfig?.preavisRoleId) {
          const hasPreavisRole = message.member.roles.cache.has(guildConfig.preavisRoleId);
          if (hasPreavisRole) {
            await message.member.roles.remove(
              guildConfig.preavisRoleId,
              'Membre actif - retrait du role En Preavis'
            );
            log.service('Audit', `Role En Preavis retire de ${message.author.tag} (membre actif)`);

            // Envoyer un petit DM sympa
            try {
              await message.author.send(
                `🎉 Super ! Tu as parle sur **${message.guild!.name}** donc ton preavis a ete annule. Content de te voir actif parmi nous !`
              );
            } catch {
              // DMs fermes, pas grave
            }
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
