import winston from 'winston';
import DailyRotateFile from 'winston-daily-rotate-file';
import path from 'path';
import fs from 'fs';

// Dossier de logs a la racine du projet
const logsDir = path.join(__dirname, '../../logs');

// Creer le dossier logs s'il n'existe pas
if (!fs.existsSync(logsDir)) {
  fs.mkdirSync(logsDir, { recursive: true });
}

// Format JSON structure pour les fichiers
const fileFormat = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
  winston.format.errors({ stack: true }),
  winston.format.json(),
);

// Format lisible pour la console
const consoleFormat = winston.format.combine(
  winston.format.colorize(),
  winston.format.timestamp({ format: 'HH:mm:ss' }),
  winston.format.printf(({ timestamp, level, message, ...meta }) => {
    const metaKeys = Object.keys(meta);
    const metaStr = metaKeys.length > 0 ? ' ' + JSON.stringify(meta) : '';
    return `${timestamp} [${level}] ${message}${metaStr}`;
  }),
);

// Transport fichier erreurs (rotation quotidienne, retention 14 jours)
const errorTransport = new DailyRotateFile({
  filename: path.join(logsDir, 'error-%DATE%.log'),
  datePattern: 'YYYY-MM-DD',
  level: 'error',
  maxSize: '20m',
  maxFiles: '14d',
  format: fileFormat,
});

// Transport fichier combine (toutes les entrees)
const combinedTransport = new DailyRotateFile({
  filename: path.join(logsDir, 'combined-%DATE%.log'),
  datePattern: 'YYYY-MM-DD',
  maxSize: '20m',
  maxFiles: '14d',
  format: fileFormat,
});

// Transport console
const consoleTransport = new winston.transports.Console({
  format: consoleFormat,
});

// Logger principal Winston
const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: fileFormat,
  transports: [errorTransport, combinedTransport, consoleTransport],
  exitOnError: false,
});

/**
 * Interface de logging avec helpers specialises.
 * Utilisation: `import { log } from '../services/logger';`
 */
export const log = {
  /** Log d'erreur */
  error(message: string, meta?: any): void {
    logger.error(message, meta);
  },

  /** Log d'avertissement */
  warn(message: string, meta?: any): void {
    logger.warn(message, meta);
  },

  /** Log d'information */
  info(message: string, meta?: any): void {
    logger.info(message, meta);
  },

  /** Log de debug */
  debug(message: string, meta?: any): void {
    logger.debug(message, meta);
  },

  /** Log d'execution de commande */
  command(commandName: string, userId: string, guildId: string, success: boolean, meta?: any): void {
    logger.info('Commande executee', {
      commandName,
      userId,
      guildId,
      success,
      ...meta,
    });
  },

  /** Log d'operation base de donnees */
  database(operation: string, success: boolean, meta?: any): void {
    const level = success ? 'debug' : 'error';
    logger.log(level, `Database: ${operation}`, {
      operation,
      success,
      ...meta,
    });
  },

  /** Log de service */
  service(serviceName: string, action: string, meta?: any): void {
    logger.info(`Service ${serviceName}: ${action}`, {
      serviceName,
      action,
      ...meta,
    });
  },

  /** Log WebSocket */
  websocket(event: string, meta?: any): void {
    logger.debug(`WebSocket: ${event}`, {
      event,
      ...meta,
    });
  },

  /** Log API REST */
  api(method: string, endpoint: string, statusCode: number, meta?: any): void {
    const level = statusCode >= 400 ? 'error' : 'info';
    logger.log(level, `API ${method} ${endpoint} [${statusCode}]`, {
      method,
      endpoint,
      statusCode,
      ...meta,
    });
  },
};

export default logger;
