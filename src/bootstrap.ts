import { envSchema } from './config/env';
import { log } from './services/logger';
import { db } from './services/database';
import { createClient, BotClient } from './core/client';
import { loadCommands } from './core/command-loader';
import { loadEvents } from './core/event-loader';
import { GuildSyncService } from './services/guild-sync';
import { temporaryRolesService } from './services/temporary-roles';
import { jobOffersService } from './services/job-offers';
import { BotWebSocketServer } from './services/websocket';
import { challengeScheduler } from './services/cron-challenges';
import { tickQuizScheduler } from './services/quiz-runner';
import { BotApiServer } from './api';

let client: BotClient;
let wsServer: BotWebSocketServer | undefined;
let apiServer: BotApiServer | undefined;
let guildSyncService: GuildSyncService | undefined;
let quizSchedulerInterval: ReturnType<typeof setInterval> | undefined;

export async function bootstrap(): Promise<BotClient> {
  try {
    log.info('Starting Taureau Celtique v3...');

    // 1. Validate environment variables
    log.info('Validating environment configuration...');
    const env = envSchema.parse(process.env);
    log.info('Environment configuration valid');

    // 2. Initialize database
    log.info('Connecting to database...');
    const dbConnected = await db.initialize();
    if (!dbConnected) {
      log.error('Failed to connect to database');
      process.exit(1);
    }
    log.info('Database initialized');

    // 3. Create Discord client
    log.info('Creating Discord client...');
    client = createClient();

    // 4. Load commands
    log.info('Loading commands...');
    loadCommands(client);
    log.info(`${client.commands.size} commands loaded`);

    // 5. Load events
    log.info('Loading events...');
    loadEvents(client);

    // 6. Login to Discord
    log.info('Connecting to Discord...');
    const token = process.env.BOT_TOKEN;
    if (!token) {
      log.error('BOT_TOKEN missing in .env');
      process.exit(1);
    }
    await client.login(token);

    // 7. On ready: start services
    client.once('ready', async () => {
      log.info(`Bot connected: ${client.user?.tag}`);

      // Guild sync
      try {
        guildSyncService = new GuildSyncService(client);
        await guildSyncService.syncAllGuilds();
        log.info('Guild sync complete');
      } catch (error) {
        const err = error as Error;
        log.error('Guild sync error', { error: err.message });
      }

      // Temporary roles service
      try {
        await temporaryRolesService.initialize();
        temporaryRolesService.startCleanupInterval(client);
        log.info('Temporary roles service started');
      } catch (error) {
        const err = error as Error;
        log.error('Temporary roles service error', { error: err.message });
      }

      // Job offers service
      try {
        await jobOffersService.initialize(client);
        log.info('Job offers service started');
      } catch (error) {
        const err = error as Error;
        log.error('Job offers service error', { error: err.message });
      }

      // Challenge scheduler (auto-announce + auto-close + role transfer)
      try {
        challengeScheduler.start(client);
        log.info('Challenge scheduler service started');
      } catch (error) {
        const err = error as Error;
        log.error('Challenge scheduler error', { error: err.message });
      }

      // Quiz scheduler (check for sessions to start every 10s)
      try {
        quizSchedulerInterval = setInterval(() => {
          tickQuizScheduler(client).catch((err) =>
            log.error('Quiz scheduler tick error', { error: err })
          );
        }, 10_000);
        log.info('Quiz scheduler started (10s interval)');
      } catch (error) {
        const err = error as Error;
        log.error('Quiz scheduler error', { error: err.message });
      }

      // WebSocket server
      try {
        wsServer = new BotWebSocketServer(client);
        wsServer.start();
        log.info('WebSocket server started');
      } catch (error) {
        const err = error as Error;
        log.error('WebSocket server error', { error: err.message });
      }

      // REST API server
      try {
        apiServer = new BotApiServer(client);
        await apiServer.start();
        log.info('REST API server started');
      } catch (error) {
        const err = error as Error;
        log.error('REST API server error', { error: err.message });
      }

      log.info('Taureau Celtique v3 fully operational');
    });

    return client;
  } catch (error) {
    const err = error as Error;
    log.error('Initialization error', {
      error: err.message,
      stack: err.stack,
    });
    process.exit(1);
  }
}

export async function shutdown(signal: string): Promise<void> {
  log.info(`Signal ${signal} received, shutting down...`);

  try {
    // Stop API server
    if (apiServer) {
      await apiServer.stop();
    }

    // Stop WebSocket server
    if (wsServer) {
      wsServer.stop();
    }

    // Stop quiz scheduler
    if (quizSchedulerInterval) {
      clearInterval(quizSchedulerInterval);
    }

    // Stop challenge scheduler
    challengeScheduler.stop();

    // Stop temporary roles service
    await temporaryRolesService.cleanup();

    // Stop job offers service
    await jobOffersService.cleanup();

    // Disconnect Discord client
    if (client) {
      client.destroy();
    }

    // Close database connection
    await db.cleanup();

    log.info('Shutdown complete');
    process.exit(0);
  } catch (error) {
    const err = error as Error;
    log.error('Shutdown error', { error: err.message });
    process.exit(1);
  }
}

export { client, wsServer, apiServer, guildSyncService };
