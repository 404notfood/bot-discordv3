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

// ---------------------------------------------------------------------------
// Command definition
// ---------------------------------------------------------------------------

export default {
  data: new SlashCommandBuilder()
    .setName('sql')
    .setDescription('🎯 Entraînement et défis SQL')
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
    const sub = interaction.options.getSubcommand();

    try {
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
