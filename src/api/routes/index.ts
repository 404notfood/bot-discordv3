import { Router } from 'express';
import { Client } from 'discord.js';
import { createBotRouter } from './bot';
import { createGuildsRouter } from './guilds';
import { createStatsRouter } from './stats';
import { createToolsRouter } from './tools';

export function createApiRoutes(client: Client): Router {
  const router = Router();

  // Bot status/control routes at /api root
  router.use('/', createBotRouter(client));

  // Guild data routes
  router.use('/guilds', createGuildsRouter(client));

  // Stats routes
  router.use('/stats', createStatsRouter(client));

  // Tools routes (logs, health, execute)
  router.use('/', createToolsRouter(client));

  return router;
}
