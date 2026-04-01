import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import { Client } from 'discord.js';
import { authenticateToken } from './middleware/auth';
import { errorHandler } from './middleware/error-handler';
import { createApiRoutes } from './routes';
import { log } from '../services/logger';

export class BotApiServer {
  private app: Express;
  private client: Client;
  private port: number;
  private server: any;

  constructor(client: Client) {
    this.client = client;
    this.port = parseInt(process.env.BOT_API_PORT || '3008', 10);
    this.app = express();

    this.setupMiddleware();
    this.setupRoutes();
    this.setupErrorHandling();
  }

  private setupMiddleware(): void {
    // CORS configuration
    const allowedOrigins = (
      process.env.CORS_ALLOWED_ORIGINS || 'http://localhost:3000'
    )
      .split(',')
      .map((o) => o.trim());

    this.app.use(
      cors({
        origin: (origin: any, callback: any) => {
          if (
            !origin ||
            allowedOrigins.includes(origin) ||
            allowedOrigins.includes('*')
          ) {
            callback(null, true);
          } else {
            callback(new Error('Non autorise par CORS'));
          }
        },
        credentials: true,
      })
    );

    // Body parsers
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));

    // Request logger (skip /health to reduce noise)
    this.app.use((req, res, next) => {
      const start = Date.now();
      res.on('finish', () => {
        const duration = Date.now() - start;
        if (req.path !== '/health') {
          log.api(req.method, req.path, res.statusCode, { duration });
        }
      });
      next();
    });
  }

  private setupRoutes(): void {
    // Public health check
    this.app.get('/health', (req: Request, res: Response) => {
      res.json({
        status: 'online',
        timestamp: new Date().toISOString(),
        uptime: process.uptime(),
        bot: {
          ready: this.client?.isReady() || false,
          guilds: this.client?.guilds?.cache?.size || 0,
          ping: this.client?.ws?.ping || 0,
        },
      });
    });

    // Protected API routes
    this.app.use('/api', authenticateToken, createApiRoutes(this.client));

    // 404 handler
    this.app.use((req: Request, res: Response) => {
      log.api(req.method, req.path, 404);
      res.status(404).json({
        error: 'Route non trouvee',
        path: req.path,
        timestamp: new Date().toISOString(),
      });
    });
  }

  private setupErrorHandling(): void {
    this.app.use(errorHandler);
  }

  start(): Promise<void> {
    return new Promise((resolve, reject) => {
      try {
        this.server = this.app.listen(this.port, '127.0.0.1', () => {
          log.info(`API REST started on port ${this.port}`);
          resolve();
        });

        this.server.on('error', (error: any) => {
          if (error.code === 'EADDRINUSE') {
            log.error(`Port ${this.port} is already in use`);
          } else {
            log.error('API server error', { error: error.message });
          }
          reject(error);
        });
      } catch (error) {
        const err = error as Error;
        log.error('API start error', { error: err.message });
        reject(error);
      }
    });
  }

  stop(): Promise<void> {
    return new Promise((resolve) => {
      if (this.server) {
        this.server.close(() => {
          log.info('API REST stopped');
          resolve();
        });
      } else {
        resolve();
      }
    });
  }

  getApp(): Express {
    return this.app;
  }
}
