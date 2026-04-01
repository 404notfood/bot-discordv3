import { config } from 'dotenv';
config();

import { bootstrap, shutdown } from './bootstrap';
import { log } from './services/logger';

// Start the bot
bootstrap();

// Graceful shutdown handlers
process.on('SIGINT', () => shutdown('SIGINT'));
process.on('SIGTERM', () => shutdown('SIGTERM'));

// Unhandled error handlers
process.on('unhandledRejection', (reason, promise) => {
  log.error('Unhandled Rejection', { reason, promise });
});

process.on('uncaughtException', (error) => {
  log.error('Uncaught Exception', {
    error: error.message,
    stack: error.stack,
  });
  shutdown('UNCAUGHT_EXCEPTION');
});
