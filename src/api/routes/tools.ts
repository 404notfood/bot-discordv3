import { Router, Response } from 'express';
import { Client } from 'discord.js';
import { AuthRequest } from '../middleware/auth';
import { log } from '../../services/logger';
import { db } from '../../services/database';
import * as fs from 'fs';
import * as path from 'path';

export function createToolsRouter(client: Client): Router {
  const router = Router();

  // GET /api/logs - Filtered log entries
  router.get('/logs', async (req: AuthRequest, res: Response) => {
    try {
      const level = (req.query.level as string) || 'all';
      const limit = Math.min(parseInt(req.query.limit as string) || 100, 500);

      const logsDir = path.join(__dirname, '../../../logs');
      let allLogs: Array<{
        timestamp: string;
        level: string;
        message: string;
        source: string;
      }> = [];

      if (fs.existsSync(logsDir)) {
        const files = fs.readdirSync(logsDir);
        const recentFiles = files
          .filter(
            (f) =>
              (f.startsWith('combined-') || f.startsWith('error-')) &&
              f.endsWith('.log')
          )
          .sort()
          .reverse()
          .slice(0, 3);

        for (const file of recentFiles) {
          const filePath = path.join(logsDir, file);
          if (fs.existsSync(filePath)) {
            const content = fs.readFileSync(filePath, 'utf8');
            const lines = content
              .split('\n')
              .filter((line) => line.trim())
              .slice(-limit);

            const parsedLogs = lines.map((line) => {
              try {
                const parsed = JSON.parse(line);
                return {
                  timestamp: parsed.timestamp || new Date().toISOString(),
                  level: parsed.level || 'info',
                  message: parsed.message || line,
                  source: 'bot',
                  ...parsed,
                };
              } catch {
                let logLevel = 'info';
                if (line.toLowerCase().includes('error')) logLevel = 'error';
                else if (line.toLowerCase().includes('warn')) logLevel = 'warn';
                else if (line.toLowerCase().includes('debug')) logLevel = 'debug';

                return {
                  timestamp: new Date().toISOString(),
                  level: logLevel,
                  message: line,
                  source: 'bot',
                };
              }
            });

            allLogs = allLogs.concat(parsedLogs);
          }
        }
      }

      // Filter by log level
      if (level !== 'all') {
        allLogs = allLogs.filter((entry) => entry.level === level);
      }

      // Sort by timestamp descending and limit
      allLogs.sort(
        (a, b) =>
          new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime()
      );
      allLogs = allLogs.slice(0, limit);

      log.api(req.method, req.path, 200, { logsCount: allLogs.length });
      res.json({
        success: true,
        logs: allLogs,
        total: allLogs.length,
        level,
        limit,
        timestamp: new Date().toISOString(),
      });
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({
        success: false,
        error: 'Erreur lors de la lecture des logs',
        logs: [],
        total: 0,
      });
    }
  });

  // GET /api/health - Health check (detailed)
  router.get('/health', async (req: AuthRequest, res: Response) => {
    try {
      const startTime = Date.now();

      // Test DB connectivity
      let dbPing = 0;
      try {
        const dbStart = Date.now();
        await db.client.$queryRaw`SELECT 1`;
        dbPing = Date.now() - dbStart;
      } catch {
        dbPing = -1;
      }

      const responseTime = Date.now() - startTime;

      const healthData = {
        bot_ping: client?.ws?.ping || 0,
        discord_ping: client?.ws?.ping || 0,
        db_ping: dbPing,
        response_time: responseTime,
        status: client?.isReady() ? 'online' : 'offline',
        timestamp: new Date().toISOString(),
      };

      log.api(req.method, req.path, 200, healthData);
      res.json(healthData);
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({ error: 'Erreur lors du health check' });
    }
  });

  // POST /api/execute - Run system tests
  router.post('/execute', async (req: AuthRequest, res: Response) => {
    try {
      const results = [];

      // Test Discord connection
      results.push({
        test: 'Connexion Discord',
        status: client?.isReady() ? 'success' : 'error',
        message: client?.isReady() ? 'Bot connecte' : 'Bot deconnecte',
        details: {
          ping: client?.ws?.ping || 0,
          guilds: client?.guilds?.cache?.size || 0,
        },
      });

      // Test database connection
      try {
        await db.client.$queryRaw`SELECT 1`;
        results.push({
          test: 'Base de donnees',
          status: 'success',
          message: 'Connexion DB reussie',
        });
      } catch (dbError) {
        const err = dbError as Error;
        results.push({
          test: 'Base de donnees',
          status: 'error',
          message: 'Erreur de connexion DB',
          error: err.message,
        });
      }

      // Test memory usage
      const memory = process.memoryUsage();
      const memoryUsagePercent = (memory.heapUsed / memory.heapTotal) * 100;
      results.push({
        test: 'Utilisation memoire',
        status: memoryUsagePercent < 80 ? 'success' : 'warning',
        message: `Memoire utilisee: ${Math.round(memoryUsagePercent)}%`,
        details: {
          heapUsed: Math.round(memory.heapUsed / 1024 / 1024) + ' MB',
          heapTotal: Math.round(memory.heapTotal / 1024 / 1024) + ' MB',
        },
      });

      // Report uptime
      const uptimeHours = process.uptime() / 3600;
      results.push({
        test: 'Uptime',
        status: 'success',
        message: `Bot actif depuis ${Math.round(uptimeHours * 10) / 10}h`,
        details: { uptime: process.uptime() },
      });

      const summary = {
        success: true,
        timestamp: new Date().toISOString(),
        total_tests: results.length,
        passed: results.filter((r) => r.status === 'success').length,
        failed: results.filter((r) => r.status === 'error').length,
        warnings: results.filter((r) => r.status === 'warning').length,
        results,
      };

      log.api(req.method, req.path, 200, summary);
      res.json(summary);
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({ error: 'Erreur lors des tests systeme' });
    }
  });

  return router;
}
