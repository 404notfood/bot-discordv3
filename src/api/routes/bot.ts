import { Router, Response } from 'express';
import { Client } from 'discord.js';
import { AuthRequest } from '../middleware/auth';
import { log } from '../../services/logger';

export function createBotRouter(client: Client): Router {
  const router = Router();

  // GET /api/status - Full bot status
  router.get('/status', (req: AuthRequest, res: Response) => {
    try {
      const status = {
        status: client?.isReady() ? 'online' : 'offline',
        guilds: client?.guilds?.cache?.size || 0,
        users: client?.users?.cache?.size || 0,
        channels: client?.channels?.cache?.size || 0,
        uptime: client?.uptime || 0,
        ping: client?.ws?.ping || 0,
        memory: process.memoryUsage(),
        timestamp: new Date().toISOString(),
        ready: client?.isReady() || false,
      };

      log.api(req.method, req.path, 200);
      res.json(status);
    } catch (error) {
      log.api(req.method, req.path, 500, { error });
      res.status(500).json({ error: 'Erreur lors de la recuperation du statut' });
    }
  });

  // POST /api/start - Start the bot
  router.post('/start', async (req: AuthRequest, res: Response) => {
    try {
      if (client?.isReady()) {
        log.api(req.method, req.path, 200, { message: 'Bot already online' });
        return res.json({
          success: true,
          message: 'Bot deja en ligne',
        });
      }

      if (!client?.token) {
        const token = process.env.BOT_TOKEN;
        if (!token) {
          log.api(req.method, req.path, 500, { error: 'BOT_TOKEN missing' });
          return res.status(500).json({
            success: false,
            error: 'BOT_TOKEN non configure',
          });
        }

        await client.login(token);
      }

      log.api(req.method, req.path, 200, { message: 'Bot started' });
      res.json({
        success: true,
        message: 'Bot demarre avec succes',
      });
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({
        success: false,
        error: 'Erreur lors du demarrage',
        details: err.message,
      });
    }
  });

  // POST /api/stop - Stop the bot
  router.post('/stop', async (req: AuthRequest, res: Response) => {
    try {
      if (!client?.isReady()) {
        log.api(req.method, req.path, 200, { message: 'Bot already stopped' });
        return res.json({
          success: true,
          message: 'Bot deja arrete',
        });
      }

      await client.destroy();
      log.api(req.method, req.path, 200, { message: 'Bot stopped' });
      res.json({
        success: true,
        message: 'Bot arrete avec succes',
      });

      setTimeout(() => {
        process.exit(0);
      }, 1000);
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({
        success: false,
        error: "Erreur lors de l'arret",
        details: err.message,
      });
    }
  });

  // POST /api/restart - Restart the bot
  router.post('/restart', (req: AuthRequest, res: Response) => {
    try {
      log.api(req.method, req.path, 200, { message: 'Restart in progress' });
      res.json({
        success: true,
        message: 'Redemarrage en cours...',
      });

      setTimeout(() => {
        process.exit(0);
      }, 2000);
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({
        success: false,
        error: 'Erreur lors du redemarrage',
        details: err.message,
      });
    }
  });

  return router;
}
