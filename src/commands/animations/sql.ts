import {
  SlashCommandBuilder,
  ChatInputCommandInteraction,
  EmbedBuilder,
  AutocompleteInteraction,
} from 'discord.js';
import { db } from '../../services/database';
import { SqlSandbox } from '../../services/sql-sandbox';
import { log } from '../../services/logger';
import * as fs from 'fs';
import * as path from 'path';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Load schema SQL for a dataset (from file or DB field) */
function loadSchemaSql(dataset: any): string {
  // If schemaSql is stored in the DB, use it directly
  if (dataset.schema_sql) return dataset.schema_sql;

  // Fallback: load from prisma/datasets/<slug>.sql
  const filePath = path.join(process.cwd(), 'prisma/datasets', `${dataset.slug}.sql`);
  if (fs.existsSync(filePath)) {
    return fs.readFileSync(filePath, 'utf-8');
  }

  throw new Error(`Schema SQL introuvable pour le dataset "${dataset.slug}"`);
}

const DIFFICULTY_LABELS: Record<string, string> = {
  beginner: '🟢 Débutant',
  intermediate: '🟡 Intermédiaire',
  advanced: '🔴 Avancé',
};

// ---------------------------------------------------------------------------
// Subcommand handlers
// ---------------------------------------------------------------------------

/** /sql train — list datasets and tasks */
async function handleTrain(interaction: ChatInputCommandInteraction): Promise<void> {
  const datasetSlug = interaction.options.getString('dataset', true);

  const ds = await db.client.$queryRaw<Array<any>>`
    SELECT * FROM sql_clinic_datasets WHERE slug = ${datasetSlug} AND is_active = true LIMIT 1
  `.then((r: any) => r[0]);

  if (!ds) {
    await interaction.reply({ content: '❌ Dataset introuvable.', flags: 64 });
    return;
  }

  // Get tasks with user's completion status
  const tasks = await db.client.$queryRaw<Array<any>>`
    SELECT t.id, t.slug, t.title, t.description, t.difficulty, t.points,
           s.is_correct as solved
    FROM sql_clinic_tasks t
    LEFT JOIN sql_clinic_submissions s
      ON s.task_id = t.id AND s.user_discord_id = ${interaction.user.id}
    WHERE t.dataset_id = ${ds.id}
    ORDER BY t.sort_order ASC, t.id ASC
  `;

  if (tasks.length === 0) {
    await interaction.reply({ content: `❌ Aucun exercice disponible pour "${ds.name}".`, flags: 64 });
    return;
  }

  const solvedCount = tasks.filter((t: any) => t.solved).length;

  const embed = new EmbedBuilder()
    .setColor(0x2ecc71)
    .setTitle(`📝 SQL Training — ${ds.name}`)
    .setDescription(
      `${ds.description || ''}\n\n` +
      `📊 **Progression :** ${solvedCount}/${tasks.length} exercices résolus\n\n` +
      `💡 Pour résoudre un exercice :\n\`/sql solve exercice:[slug] requete:[votre SQL]\``
    );

  // Group by difficulty
  for (const diff of ['beginner', 'intermediate', 'advanced']) {
    const filtered = tasks.filter((t: any) => t.difficulty === diff);
    if (filtered.length === 0) continue;

    const lines = filtered.map((t: any) => {
      const icon = t.solved ? '✅' : '⬜';
      return `${icon} \`${t.slug}\` — **${t.title}** (${t.points} pts)`;
    });

    embed.addFields({
      name: DIFFICULTY_LABELS[diff] || diff,
      value: lines.join('\n'),
      inline: false,
    });
  }

  embed.setFooter({ text: `${tasks.length} exercices • Dataset: ${ds.slug}` });
  await interaction.reply({ embeds: [embed] });
}

/** /sql solve — submit a SQL answer */
async function handleSolve(interaction: ChatInputCommandInteraction): Promise<void> {
  const taskSlug = interaction.options.getString('exercice', true);
  const userSql = interaction.options.getString('requete', true);

  await interaction.deferReply({ flags: 64 });

  // Load task + dataset
  const task = await db.client.$queryRaw<Array<any>>`
    SELECT t.*, d.slug as dataset_slug, d.schema_sql, d.name as dataset_name
    FROM sql_clinic_tasks t
    JOIN sql_clinic_datasets d ON d.id = t.dataset_id
    WHERE t.slug = ${taskSlug}
    LIMIT 1
  `.then((r: any) => r[0]);

  if (!task) {
    await interaction.editReply({ content: '❌ Exercice introuvable. Vérifiez le slug.' });
    return;
  }

  // Check if already solved
  const existing = await db.client.$queryRaw<Array<any>>`
    SELECT is_correct FROM sql_clinic_submissions
    WHERE task_id = ${task.id} AND user_discord_id = ${interaction.user.id}
  `.then((r: any) => r[0]);

  if (existing?.is_correct) {
    await interaction.editReply({ content: '✅ Vous avez déjà résolu cet exercice !' });
    return;
  }

  // Load schema and validate
  let schemaSql: string;
  try {
    schemaSql = loadSchemaSql(task);
  } catch (err) {
    log.error('Schema load error', { err, slug: task.dataset_slug });
    await interaction.editReply({ content: '❌ Erreur de chargement du dataset.' });
    return;
  }

  const validation = SqlSandbox.validate(schemaSql, userSql, task.expected_sql);

  // Save submission (upsert)
  await db.client.$executeRaw`
    INSERT INTO sql_clinic_submissions (task_id, user_discord_id, submitted_sql, result_snapshot, is_correct, awarded_points, submitted_at, created_at, updated_at)
    VALUES (${task.id}, ${interaction.user.id}, ${userSql}, ${JSON.stringify(validation.userResult)}::jsonb, ${validation.success}, ${validation.success ? task.points : 0}, NOW(), NOW(), NOW())
    ON CONFLICT (task_id, user_discord_id) DO UPDATE SET
      submitted_sql = EXCLUDED.submitted_sql,
      result_snapshot = EXCLUDED.result_snapshot,
      is_correct = EXCLUDED.is_correct,
      awarded_points = EXCLUDED.awarded_points,
      submitted_at = NOW(),
      updated_at = NOW()
  `;

  if (validation.success) {
    const embed = new EmbedBuilder()
      .setColor(0x2ecc71)
      .setTitle('✅ Bonne réponse !')
      .setDescription(`Bravo ! Vous avez résolu **${task.title}** et gagné **${task.points} pts** !`)
      .addFields(
        { name: '⏱️ Temps', value: `${validation.executionTimeMs}ms`, inline: true },
        { name: '📊 Lignes', value: `${validation.userResult?.rows.length || 0}`, inline: true },
      );

    await interaction.editReply({ embeds: [embed] });
  } else {
    const embed = new EmbedBuilder()
      .setColor(0xe74c3c)
      .setTitle('❌ Mauvaise réponse');

    if (validation.error) {
      embed.setDescription(`**Erreur SQL :**\n\`\`\`\n${validation.error}\n\`\`\``);
    } else {
      const userRows = validation.userResult?.rows.length || 0;
      const expectedRows = validation.expectedResult?.rows.length || 0;
      const userCols = validation.userResult?.columns.length || 0;
      const expectedCols = validation.expectedResult?.columns.length || 0;

      let hint = 'Votre résultat ne correspond pas au résultat attendu.\n\n';
      if (userCols !== expectedCols) {
        hint += `📏 **Colonnes :** vous avez ${userCols}, attendu ${expectedCols}\n`;
      }
      if (userRows !== expectedRows) {
        hint += `📋 **Lignes :** vous avez ${userRows}, attendu ${expectedRows}\n`;
      }
      if (userCols === expectedCols && userRows === expectedRows) {
        hint += '🔍 Le nombre de colonnes et lignes est correct, mais les **valeurs** diffèrent.\n';
      }

      // Show user's first 5 rows
      if (validation.userResult && validation.userResult.rows.length > 0) {
        const header = validation.userResult.columns.join(' | ');
        const preview = validation.userResult.rows
          .slice(0, 5)
          .map((r: any[]) => r.map((v) => (v === null ? 'NULL' : String(v))).join(' | '))
          .join('\n');
        hint += `\n**Votre résultat :**\n\`\`\`\n${header}\n${preview}\n\`\`\``;
      }

      embed.setDescription(hint);
    }

    embed.addFields({ name: '⏱️ Temps', value: `${validation.executionTimeMs}ms`, inline: true });
    embed.setFooter({ text: 'Réessayez avec /sql solve' });

    await interaction.editReply({ embeds: [embed] });
  }
}

/** /sql leaderboard — show top users */
async function handleLeaderboard(interaction: ChatInputCommandInteraction): Promise<void> {
  const datasetSlug = interaction.options.getString('dataset');

  const title = datasetSlug
    ? `🏆 Classement SQL — ${datasetSlug}`
    : '🏆 Classement SQL Global';

  let topUsers: Array<any>;

  if (datasetSlug) {
    topUsers = await db.client.$queryRaw<Array<any>>`
      SELECT
        s.user_discord_id,
        SUM(s.awarded_points) as total_points,
        COUNT(CASE WHEN s.is_correct = true THEN 1 END) as solved_count
      FROM sql_clinic_submissions s
      JOIN sql_clinic_tasks t ON t.id = s.task_id
      WHERE s.is_correct = true
        AND t.dataset_id = (SELECT id FROM sql_clinic_datasets WHERE slug = ${datasetSlug})
      GROUP BY s.user_discord_id
      ORDER BY total_points DESC
      LIMIT 15
    `;
  } else {
    topUsers = await db.client.$queryRaw<Array<any>>`
      SELECT
        s.user_discord_id,
        SUM(s.awarded_points) as total_points,
        COUNT(CASE WHEN s.is_correct = true THEN 1 END) as solved_count
      FROM sql_clinic_submissions s
      WHERE s.is_correct = true
      GROUP BY s.user_discord_id
      ORDER BY total_points DESC
      LIMIT 15
    `;
  }

  if (topUsers.length === 0) {
    await interaction.reply({ content: '📊 Aucune soumission correcte pour le moment.', flags: 64 });
    return;
  }

  const lines = await Promise.all(
    topUsers.map(async (user: any, i: number) => {
      const medal = i === 0 ? '🥇' : i === 1 ? '🥈' : i === 2 ? '🥉' : `**${i + 1}.**`;
      let displayName = `<@${user.user_discord_id}>`;
      try {
        const member = await interaction.guild?.members.fetch(user.user_discord_id);
        if (member) displayName = member.displayName;
      } catch {}
      return `${medal} ${displayName} — **${Number(user.total_points)}** pts (${Number(user.solved_count)} résolus)`;
    })
  );

  const embed = new EmbedBuilder()
    .setColor(0xf1c40f)
    .setTitle(title)
    .setDescription(lines.join('\n'));

  await interaction.reply({ embeds: [embed] });
}

/** /sql schema — show dataset tables */
async function handleSchema(interaction: ChatInputCommandInteraction): Promise<void> {
  const datasetSlug = interaction.options.getString('dataset', true);

  const ds = await db.client.$queryRaw<Array<any>>`
    SELECT * FROM sql_clinic_datasets WHERE slug = ${datasetSlug} AND is_active = true LIMIT 1
  `.then((r: any) => r[0]);

  if (!ds) {
    await interaction.reply({ content: '❌ Dataset introuvable.', flags: 64 });
    return;
  }

  let schemaSql: string;
  try {
    schemaSql = loadSchemaSql(ds);
  } catch {
    await interaction.reply({ content: '❌ Schema introuvable pour ce dataset.', flags: 64 });
    return;
  }

  // Extract CREATE TABLE statements (handle nested parentheses)
  const createStatements: string[] = [];
  const tableRegex = /CREATE TABLE\s+(?:IF NOT EXISTS\s+)?(\w+)\s*\(/gi;
  let match;
  while ((match = tableRegex.exec(schemaSql)) !== null) {
    // Find matching closing parenthesis (handle nesting)
    let depth = 1;
    let i = match.index + match[0].length;
    while (i < schemaSql.length && depth > 0) {
      if (schemaSql[i] === '(') depth++;
      if (schemaSql[i] === ')') depth--;
      i++;
    }
    createStatements.push(schemaSql.substring(match.index, i));
  }

  const embed = new EmbedBuilder()
    .setColor(0x3498db)
    .setTitle(`📐 Schema — ${ds.name}`)
    .setDescription(`${ds.description || ''}\n\nVoici les tables disponibles pour vos requêtes :`);

  for (const stmt of createStatements) {
    const tableName = stmt.match(/CREATE TABLE\s+(?:IF NOT EXISTS\s+)?(\w+)/i)?.[1] || 'table';
    // Extract everything between the outer parentheses
    const outerMatch = stmt.match(/\(([\s\S]+)\)$/);
    const colBlock = outerMatch ? outerMatch[1] : '';

    // Split on commas that are NOT inside parentheses
    const parts: string[] = [];
    let current = '';
    let parenDepth = 0;
    for (const ch of colBlock) {
      if (ch === '(') parenDepth++;
      if (ch === ')') parenDepth--;
      if (ch === ',' && parenDepth === 0) {
        parts.push(current.trim());
        current = '';
      } else {
        current += ch;
      }
    }
    if (current.trim()) parts.push(current.trim());

    const cols = parts
      .filter((c) => !c.startsWith('FOREIGN') && !c.startsWith('PRIMARY') && !c.startsWith('CHECK') && c.length > 0)
      .map((c) => {
        const tokens = c.split(/\s+/);
        return `  ${tokens[0]} ${tokens[1] || ''}`;
      })
      .join('\n');

    if (cols) {
      embed.addFields({
        name: `📊 ${tableName}`,
        value: `\`\`\`\n${cols}\n\`\`\``,
        inline: true,
      });
    }
  }

  await interaction.reply({ embeds: [embed], flags: 64 });
}

/** /sql challenge start — admin: launch a SQL challenge */
async function handleChallengeStart(interaction: ChatInputCommandInteraction): Promise<void> {
  const { PermissionsManager } = await import('../../services/permissions');
  if (!(await PermissionsManager.requireAdmin(interaction))) return;

  const datasetSlug = interaction.options.getString('dataset', true);
  const channel = interaction.options.getChannel('salon');

  await interaction.deferReply({ flags: 64 });

  // Check dataset
  const ds = await db.client.$queryRaw<Array<any>>`
    SELECT * FROM sql_clinic_datasets WHERE slug = ${datasetSlug} AND is_active = true LIMIT 1
  `.then((r: any) => r[0]);

  if (!ds) {
    await interaction.editReply({ content: '❌ Dataset introuvable.' });
    return;
  }

  // Get tasks for this dataset, ordered by difficulty
  const tasks = await db.client.$queryRaw<Array<any>>`
    SELECT id, slug, title, difficulty, points
    FROM sql_clinic_tasks
    WHERE dataset_id = ${ds.id}
    ORDER BY sort_order ASC, id ASC
  `;

  if (tasks.length === 0) {
    await interaction.editReply({ content: '❌ Aucun exercice disponible pour ce dataset.' });
    return;
  }

  // Close any active session for this guild
  await db.client.$executeRaw`
    UPDATE sql_challenge_sessions SET status = 'completed', ended_at = NOW(), updated_at = NOW()
    WHERE guild_id = ${interaction.guildId} AND status = 'active'
  `;

  const targetChannelId = channel?.id || interaction.channelId;
  const taskIds = tasks.map((t: any) => Number(t.id));

  // Create new session
  await db.client.$executeRaw`
    INSERT INTO sql_challenge_sessions (guild_id, dataset_id, title, channel_id, questions_json, total_questions, status, started_at, created_at, updated_at)
    VALUES (${interaction.guildId}, ${ds.id}, ${`SQL Challenge — ${ds.name}`}, ${targetChannelId}, ${JSON.stringify(taskIds)}, ${tasks.length}, 'active', NOW(), NOW(), NOW())
  `;

  // Announce in channel
  const announceChannel = channel
    ? await interaction.client.channels.fetch(channel.id).catch(() => null)
    : interaction.channel;

  if (announceChannel && announceChannel.isTextBased() && 'send' in announceChannel) {
    const embed = new EmbedBuilder()
      .setColor(0x00aaff)
      .setTitle(`🏥 SQL Challenge — ${ds.name}`)
      .setDescription(
        `${ds.description || ''}\n\n` +
        `**${tasks.length} questions** à résoudre en MP avec le bot !\n\n` +
        `**Comment participer :**\n` +
        `Tapez \`!challenge-sql\` dans ce canal pour vous inscrire.\n` +
        `Le bot vous enverra le schéma et les questions en MP.\n\n` +
        `**Commandes MP :**\n` +
        `• \`!reponse SELECT ...\` — Soumettre votre requête\n` +
        `• \`!indice\` — Demander un indice (-2 pts)\n` +
        `• \`!sql-progress\` — Voir votre progression`
      )
      .setFooter({ text: 'Bonne chance à tous !' });

    await (announceChannel as any).send({ embeds: [embed] });
  }

  await interaction.editReply({ content: `✅ SQL Challenge lancé avec ${tasks.length} questions sur le dataset **${ds.name}** !` });
}

/** /sql challenge stop — admin: stop active challenge */
async function handleChallengeStop(interaction: ChatInputCommandInteraction): Promise<void> {
  const { PermissionsManager } = await import('../../services/permissions');
  if (!(await PermissionsManager.requireAdmin(interaction))) return;

  await db.client.$executeRaw`
    UPDATE sql_challenge_sessions SET status = 'completed', ended_at = NOW(), updated_at = NOW()
    WHERE guild_id = ${interaction.guildId} AND status = 'active'
  `;

  await interaction.reply({ content: '✅ SQL Challenge arrêté.', flags: 64 });
}

/** /sql challenge resend — resend schema + current question DM to all participants */
async function handleChallengeResend(interaction: ChatInputCommandInteraction): Promise<void> {
  const { PermissionsManager } = await import('../../services/permissions');
  if (!(await PermissionsManager.requireAdmin(interaction))) return;

  const reset = interaction.options.getBoolean('reset') ?? false;

  await interaction.deferReply({ flags: 64 });

  // Active session for this guild
  const session = await db.client.$queryRaw<Array<any>>`
    SELECT s.*, d.slug as dataset_slug, d.name as dataset_name,
           d.description as dataset_description, d.schema_sql
    FROM sql_challenge_sessions s
    JOIN sql_clinic_datasets d ON d.id = s.dataset_id
    WHERE s.guild_id = ${interaction.guildId} AND s.status = 'active'
    ORDER BY s.id DESC LIMIT 1
  `.then((r: any) => r[0]);

  if (!session) {
    await interaction.editReply({ content: '❌ Aucun SQL Challenge actif.' });
    return;
  }

  // Optional reset: put everyone back to question 1, clear responses
  if (reset) {
    await db.client.$executeRaw`
      DELETE FROM sql_challenge_responses
      WHERE participant_id IN (
        SELECT id FROM sql_challenge_participants WHERE session_id = ${session.id}
      )
    `;
    await db.client.$executeRaw`
      UPDATE sql_challenge_participants
      SET current_question = 1, total_points = 0, hints_used = 0,
          is_finished = false, last_activity_at = NOW(), updated_at = NOW()
      WHERE session_id = ${session.id}
    `;
  }

  // Load schema once
  let schemaSql = '';
  try {
    schemaSql = loadSchemaSql({ slug: session.dataset_slug, schema_sql: session.schema_sql });
  } catch (err) {
    log.error('Resend: schema load error', { err });
  }

  // Build schema description (CREATE TABLE summaries)
  function buildSchemaDescription(sql: string): string {
    const tableRegex = /CREATE TABLE\s+(?:IF NOT EXISTS\s+)?(\w+)\s*\(/gi;
    const tables: string[] = [];
    let match;
    while ((match = tableRegex.exec(sql)) !== null) {
      const tableName = match[1];
      let depth = 1;
      let i = match.index + match[0].length;
      while (i < sql.length && depth > 0) {
        if (sql[i] === '(') depth++;
        if (sql[i] === ')') depth--;
        i++;
      }
      const body = sql.substring(match.index + match[0].length, i - 1);
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

  const schemaDesc = schemaSql ? buildSchemaDescription(schemaSql) : '*Schema non disponible*';

  // Fetch participants
  const participants = await db.client.$queryRaw<Array<any>>`
    SELECT id, user_discord_id, username, current_question, is_finished
    FROM sql_challenge_participants
    WHERE session_id = ${session.id}
  `;

  if (participants.length === 0) {
    await interaction.editReply({ content: '❌ Aucun participant inscrit.' });
    return;
  }

  // Load all task IDs for the session
  const taskIds: number[] = JSON.parse(session.questions_json);
  const totalQuestions = taskIds.length;

  let success = 0;
  let failed = 0;

  for (const p of participants) {
    try {
      const user = await interaction.client.users.fetch(p.user_discord_id);

      const instructionsMessage = `**SQL Challenge — ${session.dataset_name || session.title}** *(renvoi)*

${session.dataset_description || ''}

**Schema des tables :**
${schemaDesc}

**Commandes MP disponibles :**
- \`!reponse SELECT ...\` — Soumettre ta requete SQL
- \`!indice\` — Demander un indice (-2 points)
- \`!sql-progress\` — Voir ta progression actuelle`;

      await user.send({ content: instructionsMessage });

      // Send current question
      const qNum = p.is_finished ? totalQuestions : (p.current_question || 1);
      const taskId = taskIds[qNum - 1];
      if (taskId) {
        const taskRows = await db.client.$queryRaw<Array<any>>`
          SELECT id, slug, title, description, difficulty, points, hint
          FROM sql_clinic_tasks WHERE id = ${taskId} LIMIT 1
        `;
        const task = taskRows[0];
        if (task) {
          const diffLabel = task.difficulty === 'beginner' ? '🟢 Debutant'
            : task.difficulty === 'intermediate' ? '🟡 Intermediaire'
            : '🔴 Avance';

          const questionMessage = `**Question ${qNum}/${totalQuestions}** — ${session.title || 'SQL Challenge'}

**${task.title}** ${diffLabel}

**Enonce :** ${task.description}

**Commandes (MP uniquement) :**
- \`!reponse SELECT ...\` — Soumettre ta requete SQL
- \`!indice\` — Demander un indice (-2 points)
- \`!sql-progress\` — Voir ta progression

**${task.points} points par question** — **Penalite indices :** -2 points par indice`;

          await user.send({ content: questionMessage });
        }
      }

      success++;
    } catch (err) {
      log.error('Resend DM failed', { userId: p.user_discord_id, err });
      failed++;
    }
  }

  await interaction.editReply({
    content: `✅ Renvoi termine : **${success}** envoye(s), **${failed}** echec(s)${reset ? ' — progression reinitialisee.' : '.'}`,
  });
}

/** /sql challenge stats — show challenge leaderboard */
async function handleChallengeStats(interaction: ChatInputCommandInteraction): Promise<void> {
  const session = await db.client.$queryRaw<Array<any>>`
    SELECT * FROM sql_challenge_sessions
    WHERE guild_id = ${interaction.guildId} AND status = 'active'
    ORDER BY id DESC LIMIT 1
  `.then((r: any) => r[0]);

  if (!session) {
    await interaction.reply({ content: '❌ Aucun SQL Challenge actif.', flags: 64 });
    return;
  }

  const participants = await db.client.$queryRaw<Array<any>>`
    SELECT username, total_points, current_question, is_finished, hints_used
    FROM sql_challenge_participants
    WHERE session_id = ${session.id}
    ORDER BY total_points DESC, current_question DESC
    LIMIT 15
  `;

  const totalParticipants = participants.length;
  const finished = participants.filter((p: any) => p.is_finished).length;

  const embed = new EmbedBuilder()
    .setColor(0x00aaff)
    .setTitle(`📊 ${session.title}`)
    .addFields(
      { name: '👥 Participants', value: totalParticipants.toString(), inline: true },
      { name: '🏁 Terminés', value: finished.toString(), inline: true },
      { name: '📝 Questions', value: session.total_questions.toString(), inline: true },
    );

  if (participants.length > 0) {
    const lines = participants.map((p: any, i: number) => {
      const medal = i === 0 ? '🥇' : i === 1 ? '🥈' : i === 2 ? '🥉' : `**${i + 1}.**`;
      const status = p.is_finished ? '✅' : `Q${p.current_question}/${session.total_questions}`;
      return `${medal} **${p.username}** — ${p.total_points} pts (${status})`;
    });
    embed.addFields({ name: '🏆 Classement', value: lines.join('\n'), inline: false });
  }

  await interaction.reply({ embeds: [embed] });
}

// ---------------------------------------------------------------------------
// Command definition
// ---------------------------------------------------------------------------

export default {
  data: new SlashCommandBuilder()
    .setName('sql')
    .setDescription('🎯 Entraînement et défis SQL')
    .addSubcommandGroup((group) =>
      group
        .setName('challenge')
        .setDescription('🏥 Challenge SQL interactif en MP')
        .addSubcommand((sub) =>
          sub
            .setName('start')
            .setDescription('🚀 Lancer un SQL Challenge (admin)')
            .addStringOption((o) =>
              o
                .setName('dataset')
                .setDescription('Dataset pour le challenge')
                .setRequired(true)
                .setAutocomplete(true)
            )
            .addChannelOption((o) =>
              o
                .setName('salon')
                .setDescription("Canal d'annonce (optionnel)")
                .setRequired(false)
            )
        )
        .addSubcommand((sub) =>
          sub.setName('stop').setDescription('⏹️ Arrêter le challenge actif (admin)')
        )
        .addSubcommand((sub) =>
          sub
            .setName('resend')
            .setDescription('📨 Renvoyer le schéma + question courante en MP à tous les inscrits (admin)')
            .addBooleanOption((o) =>
              o
                .setName('reset')
                .setDescription('Réinitialiser la progression de tous les participants à la question 1')
                .setRequired(false)
            )
        )
        .addSubcommand((sub) =>
          sub.setName('stats').setDescription('📊 Classement du challenge actif')
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('train')
        .setDescription('📝 Voir les exercices SQL disponibles')
        .addStringOption((o) =>
          o
            .setName('dataset')
            .setDescription("Choisir un dataset d'entraînement")
            .setRequired(true)
            .setAutocomplete(true)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('solve')
        .setDescription('✅ Soumettre une requête SQL')
        .addStringOption((o) =>
          o
            .setName('exercice')
            .setDescription("Slug de l'exercice")
            .setRequired(true)
            .setAutocomplete(true)
        )
        .addStringOption((o) =>
          o
            .setName('requete')
            .setDescription('Votre requête SQL')
            .setRequired(true)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('leaderboard')
        .setDescription('🏆 Classement des meilleurs joueurs')
        .addStringOption((o) =>
          o
            .setName('dataset')
            .setDescription('Filtrer par dataset (optionnel)')
            .setRequired(false)
            .setAutocomplete(true)
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('schema')
        .setDescription('📐 Voir le schéma des tables du dataset')
        .addStringOption((o) =>
          o
            .setName('dataset')
            .setDescription('Choisir un dataset')
            .setRequired(true)
            .setAutocomplete(true)
        )
    ),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const group = interaction.options.getSubcommandGroup();
    const sub = interaction.options.getSubcommand();

    try {
      if (group === 'challenge') {
        switch (sub) {
          case 'start': await handleChallengeStart(interaction); break;
          case 'stop': await handleChallengeStop(interaction); break;
          case 'resend': await handleChallengeResend(interaction); break;
          case 'stats': await handleChallengeStats(interaction); break;
        }
        return;
      }

      switch (sub) {
        case 'train':
          await handleTrain(interaction);
          break;
        case 'solve':
          await handleSolve(interaction);
          break;
        case 'leaderboard':
          await handleLeaderboard(interaction);
          break;
        case 'schema':
          await handleSchema(interaction);
          break;
        default:
          await interaction.reply({ content: 'Sous-commande inconnue.', flags: 64 });
      }
    } catch (error) {
      log.error('SQL command error', { error, sub });
      const content = '❌ Erreur lors du traitement de la commande SQL.';
      if (interaction.deferred || interaction.replied) {
        await interaction.editReply({ content });
      } else {
        await interaction.reply({ content, flags: 64 });
      }
    }
  },

  async autocomplete(interaction: AutocompleteInteraction): Promise<void> {
    const focusedOption = interaction.options.getFocused(true);

    try {
      if (focusedOption.name === 'dataset') {
        const datasets = await db.client.$queryRaw<Array<any>>`
          SELECT slug, name FROM sql_clinic_datasets WHERE is_active = true ORDER BY id ASC
        `;

        const filtered = datasets
          .filter((d: any) =>
            d.slug.toLowerCase().includes(focusedOption.value.toLowerCase()) ||
            d.name.toLowerCase().includes(focusedOption.value.toLowerCase())
          )
          .slice(0, 25);

        await interaction.respond(
          filtered.map((d: any) => ({ name: `${d.name} (${d.slug})`, value: d.slug }))
        );
      } else if (focusedOption.name === 'exercice') {
        // Get all task slugs across datasets
        const tasks = await db.client.$queryRaw<Array<any>>`
          SELECT t.slug, t.title, t.difficulty, d.name as dataset_name
          FROM sql_clinic_tasks t
          JOIN sql_clinic_datasets d ON d.id = t.dataset_id
          WHERE d.is_active = true
          ORDER BY t.sort_order ASC, t.id ASC
        `;

        const filtered = tasks
          .filter((t: any) =>
            t.slug.toLowerCase().includes(focusedOption.value.toLowerCase()) ||
            t.title.toLowerCase().includes(focusedOption.value.toLowerCase())
          )
          .slice(0, 25);

        await interaction.respond(
          filtered.map((t: any) => ({
            name: `${t.title} [${t.dataset_name}] (${t.difficulty})`,
            value: t.slug,
          }))
        );
      }
    } catch (error) {
      log.error('SQL autocomplete error', { error });
      await interaction.respond([]);
    }
  },
};
