import { Router, Response } from 'express';
import { Client } from 'discord.js';
import { AuthRequest } from '../middleware/auth';
import { log } from '../../services/logger';
import { db } from '../../services/database';

export function createStatsRouter(client: Client): Router {
  const router = Router();

  // GET /api/stats - Current stats
  router.get('/', async (req: AuthRequest, res: Response) => {
    try {
      const stats = {
        bot: {
          ready: client?.isReady() || false,
          uptime: process.uptime(),
          ping: client?.ws?.ping || 0,
          guilds: client?.guilds?.cache?.size || 0,
          users: client?.users?.cache?.size || 0,
          channels: client?.channels?.cache?.size || 0,
        },
        system: {
          memory: process.memoryUsage(),
          cpu: process.cpuUsage(),
          platform: process.platform,
          nodeVersion: process.version,
        },
      };

      log.api(req.method, req.path, 200);
      res.json(stats);
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({ error: 'Erreur lors de la recuperation des statistiques' });
    }
  });

  // GET /api/stats/detailed - Detailed stats (7-day window)
  router.get('/detailed', async (req: AuthRequest, res: Response) => {
    try {
      // Command stats grouped by name (last 7 days)
      const commandStats = await db.client.commandLog.groupBy({
        by: ['commandName'],
        where: {
          createdAt: {
            gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000),
          },
        },
        _count: {
          commandName: true,
        },
        orderBy: {
          _count: {
            commandName: 'desc',
          },
        },
      });

      // Guild aggregate stats
      const guildStats = await db.client.guildConfig.aggregate({
        where: { isActive: true },
        _count: { guildId: true },
        _sum: { memberCount: true },
        _avg: { memberCount: true },
      });

      // Command totals
      const totalCommands = await db.client.commandLog.count();
      const commandsToday = await db.client.commandLog.count({
        where: {
          createdAt: {
            gte: new Date(new Date().setHours(0, 0, 0, 0)),
          },
        },
      });
      const commandsThisWeek = await db.client.commandLog.count({
        where: {
          createdAt: {
            gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000),
          },
        },
      });

      const stats = {
        commands: {
          total_executed: totalCommands,
          today: commandsToday,
          this_week: commandsThisWeek,
          by_command: commandStats.map((stat: any) => ({
            command_name: stat.commandName,
            usage_count: stat._count.commandName,
          })),
        },
        guilds: {
          total_guilds: guildStats._count.guildId,
          total_members: guildStats._sum.memberCount || 0,
          avg_members_per_guild: Math.round(guildStats._avg.memberCount || 0),
        },
        uptime_seconds: process.uptime(),
        memory_usage: process.memoryUsage(),
        performance: {
          response_time: client?.ws?.ping || 0,
          cpu_usage: process.cpuUsage(),
        },
      };

      log.api(req.method, req.path, 200);
      res.json(stats);
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res
        .status(500)
        .json({ error: 'Erreur lors de la recuperation des statistiques detaillees' });
    }
  });

  // GET /api/stats/leaderboard - Command leaderboard
  router.get('/leaderboard', async (req: AuthRequest, res: Response) => {
    try {
      const limit = Math.min(parseInt(req.query.limit as string) || 20, 50);

      const leaderboard = await db.client.commandLog.groupBy({
        by: ['userId'],
        _count: { userId: true },
        orderBy: { _count: { userId: 'desc' } },
        take: limit,
      });

      log.api(req.method, req.path, 200, { entries: leaderboard.length });
      res.json({
        success: true,
        leaderboard: leaderboard.map((entry: any, index: number) => ({
          rank: index + 1,
          userId: entry.userId,
          commandCount: entry._count.userId,
        })),
      });
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({ error: 'Erreur lors de la recuperation du leaderboard' });
    }
  });

  return router;
}
