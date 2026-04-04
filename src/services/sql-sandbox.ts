import { log } from './logger';

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export interface SqlResult {
  columns: string[];
  rows: any[][];
}

export interface SqlValidation {
  success: boolean;
  userResult: SqlResult | null;
  expectedResult: SqlResult | null;
  error?: string;
  executionTimeMs: number;
}

// ---------------------------------------------------------------------------
// Lazy-load better-sqlite3 (native module may not be compiled)
// ---------------------------------------------------------------------------

let Database: any = null;

function getDatabase(): any {
  if (!Database) {
    try {
      // eslint-disable-next-line @typescript-eslint/no-require-imports
      Database = require('better-sqlite3');
    } catch (err) {
      throw new Error(
        'better-sqlite3 non disponible. Installez build-essential puis npm rebuild better-sqlite3'
      );
    }
  }
  return Database;
}

// ---------------------------------------------------------------------------
// Sandbox: execute SQL in an ephemeral SQLite in-memory database
// ---------------------------------------------------------------------------

export class SqlSandbox {
  /**
   * Validate a user's SQL query against the expected SQL query.
   * Both queries are executed in the same SQLite database and results compared.
   *
   * @param schemaSql    - DDL + INSERT statements to set up the dataset
   * @param userSql      - The user's submitted query
   * @param expectedSql  - The reference SQL query to compare against
   * @param timeoutMs    - Max execution time (default 5s)
   */
  static validate(
    schemaSql: string,
    userSql: string,
    expectedSql: string,
    timeoutMs = 5000,
  ): SqlValidation {
    const startTime = Date.now();
    let db: any = null;

    try {
      const DB = getDatabase();

      // Create in-memory database
      db = new DB(':memory:', { timeout: timeoutMs });

      // Security: restrict dangerous operations
      db.pragma('journal_mode = OFF');
      db.pragma('max_page_count = 10000'); // ~40MB max

      // Load the dataset schema and data
      db.exec(schemaSql);

      // Execute the user's query
      const userQuery = userSql.trim().replace(/;+$/, '');

      // Block dangerous statements
      const forbidden = /^\s*(DROP|ALTER|CREATE|INSERT|UPDATE|DELETE|TRUNCATE|ATTACH|DETACH|PRAGMA|VACUUM|REINDEX)\b/i;
      if (forbidden.test(userQuery)) {
        return {
          success: false,
          userResult: null,
          expectedResult: null,
          error: 'Seules les requêtes SELECT sont autorisées.',
          executionTimeMs: Date.now() - startTime,
        };
      }

      const stmt = db.prepare(userQuery);
      const rawRows = stmt.all();
      const executionTimeMs = Date.now() - startTime;

      // Convert user result to our format
      const userColumns = rawRows.length > 0 ? Object.keys(rawRows[0] as object) : [];
      const userRows = rawRows.map((row: any) => userColumns.map((col: string) => row[col]));
      const userResult: SqlResult = { columns: userColumns, rows: userRows };

      // Execute the expected SQL to get the reference result
      const expectedQuery = expectedSql.trim().replace(/;+$/, '');
      const expectedRawRows = db.prepare(expectedQuery).all();
      const expectedColumns = expectedRawRows.length > 0 ? Object.keys(expectedRawRows[0] as object) : [];
      const expectedRows = expectedRawRows.map((row: any) => expectedColumns.map((col: string) => row[col]));
      const expectedResult: SqlResult = { columns: expectedColumns, rows: expectedRows };

      // Compare results
      const success = compareResults(userResult, expectedResult);

      return {
        success,
        userResult,
        expectedResult,
        executionTimeMs,
      };
    } catch (error) {
      const err = error as Error;
      return {
        success: false,
        userResult: null,
        expectedResult: null,
        error: err.message,
        executionTimeMs: Date.now() - startTime,
      };
    } finally {
      if (db) {
        try { db.close(); } catch {}
      }
    }
  }

  /**
   * Execute a query and return results (for preview/testing)
   */
  static execute(schemaSql: string, sql: string): SqlResult {
    const DB = getDatabase();
    let db: any = null;
    try {
      db = new DB(':memory:');
      db.exec(schemaSql);
      const query = sql.trim().replace(/;+$/, '');
      const rows = db.prepare(query).all();
      const columns = rows.length > 0 ? Object.keys(rows[0] as object) : [];
      return {
        columns,
        rows: rows.map((row: any) => columns.map((col: string) => row[col])),
      };
    } finally {
      if (db) {
        try { db.close(); } catch {}
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Compare two result sets (order-insensitive for rows)
// ---------------------------------------------------------------------------

function compareResults(
  user: SqlResult,
  expected: { columns: string[]; rows: any[][] },
): boolean {
  // Compare column count (not names — user might alias differently)
  if (user.columns.length !== expected.columns.length) return false;

  // Compare row count
  if (user.rows.length !== expected.rows.length) return false;

  // Normalize values for comparison
  const normalize = (val: any): string => {
    if (val === null || val === undefined) return 'NULL';
    return String(val).trim().toLowerCase();
  };

  const toSortableRow = (row: any[]): string =>
    row.map(normalize).join('|');

  // Sort both sets for order-insensitive comparison
  const userSorted = user.rows.map(toSortableRow).sort();
  const expectedSorted = expected.rows.map(toSortableRow).sort();

  for (let i = 0; i < userSorted.length; i++) {
    if (userSorted[i] !== expectedSorted[i]) return false;
  }

  return true;
}
