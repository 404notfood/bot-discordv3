import WebSocket, { WebSocketServer } from 'ws';
import jwt from 'jsonwebtoken';
import { EventEmitter } from 'events';
import { Client } from 'discord.js';
import { log } from './logger';
import { IncomingMessage } from 'http';

// ---------------------------------------------------------------------------
// Interfaces
// ---------------------------------------------------------------------------

interface ClientInfo {
  id: string;
  ws: WebSocket;
  user: any;
  connectedAt: Date;
  lastPing: number;
  subscriptions?: string[];
}

interface BotActionEvent {
  clientId: string;
  action: string;
  params: any;
  user: any;
}

// ---------------------------------------------------------------------------
// Service
// ---------------------------------------------------------------------------

export class BotWebSocketServer extends EventEmitter {
  private client: Client;
  private wss: WebSocketServer | null = null;
  private clients = new Map<string, ClientInfo>();
  private port: number;
  private jwtSecret: string;
  private statusInterval: NodeJS.Timeout | null = null;
  private metricsInterval: NodeJS.Timeout | null = null;
  private cleanupInterval: NodeJS.Timeout | null = null;

  constructor(client: Client) {
    super();
    this.client = client;
    this.port = parseInt(
      process.env.WS_PORT || process.env.BOT_WS_PORT || '3009',
      10,
    );
    this.jwtSecret =
      process.env.WS_JWT_SECRET ||
      process.env.BOT_JWT_SECRET ||
      process.env.BOT_API_TOKEN ||
      'default-secret';
  }

  // =====================================================================
  // START / STOP
  // =====================================================================

  start(): this {
    this.wss = new WebSocketServer({
      port: this.port,
      host: '127.0.0.1', // Force IPv4
      verifyClient: this.verifyClient.bind(this),
    });

    this.wss.on('connection', this.handleConnection.bind(this));

    // Broadcast bot status every 5 seconds
    this.statusInterval = setInterval(() => {
      this.broadcastBotStatus();
    }, 5_000);

    // Broadcast metrics every 30 seconds
    this.metricsInterval = setInterval(() => {
      this.broadcastMetrics();
    }, 30_000);

    // Auto-clean inactive clients every 60 seconds
    this.cleanupInterval = setInterval(() => {
      this.cleanupInactiveClients();
    }, 60_000);

    log.info(`WebSocket Server started on port ${this.port}`);
    return this;
  }

  stop(): void {
    if (this.statusInterval) {
      clearInterval(this.statusInterval);
      this.statusInterval = null;
    }
    if (this.metricsInterval) {
      clearInterval(this.metricsInterval);
      this.metricsInterval = null;
    }
    if (this.cleanupInterval) {
      clearInterval(this.cleanupInterval);
      this.cleanupInterval = null;
    }

    // Close all client connections
    this.clients.forEach((client) => {
      try {
        client.ws.close(1000, 'Server shutting down');
      } catch {
        // Ignore close errors
      }
    });
    this.clients.clear();

    if (this.wss) {
      this.wss.close();
      this.wss = null;
    }

    log.info('WebSocket Server stopped');
  }

  // =====================================================================
  // JWT VERIFICATION
  // =====================================================================

  private verifyClient(info: { req: IncomingMessage }): boolean {
    try {
      const url = new URL(info.req.url || '', 'http://localhost');
      const token = url.searchParams.get('token');

      if (!token) {
        log.warn('WebSocket: missing token');
        return false;
      }

      jwt.verify(token, this.jwtSecret);
      return true;
    } catch (error) {
      const err = error as Error;
      log.warn('WebSocket: invalid token', { error: err.message });
      return false;
    }
  }

  // =====================================================================
  // CONNECTION HANDLING
  // =====================================================================

  private handleConnection(ws: WebSocket, req: IncomingMessage): void {
    const clientId = this.generateClientId();
    const url = new URL(req.url || '', 'http://localhost');
    const token = url.searchParams.get('token');

    try {
      const decoded = jwt.verify(token!, this.jwtSecret);

      const clientInfo: ClientInfo = {
        id: clientId,
        ws,
        user: decoded,
        connectedAt: new Date(),
        lastPing: Date.now(),
      };

      this.clients.set(clientId, clientInfo);
      log.info(
        `WebSocket client connected: ${clientId} (${(decoded as any).type || 'dashboard'})`,
      );

      // Send initial data
      this.sendToClient(ws, 'connection', {
        clientId,
        connectedAt: clientInfo.connectedAt,
        botStatus: this.getBotStatus(),
      });

      // Message handler
      ws.on('message', (message) => {
        this.handleMessage(clientId, message);
      });

      // Pong handler
      ws.on('pong', () => {
        const c = this.clients.get(clientId);
        if (c) c.lastPing = Date.now();
      });

      // Cleanup on close
      ws.on('close', () => {
        this.clients.delete(clientId);
        log.info(`WebSocket client disconnected: ${clientId}`);
      });

      // Error handler
      ws.on('error', (error) => {
        log.error(`WebSocket error for client ${clientId}`, { error });
        this.clients.delete(clientId);
      });
    } catch (error) {
      log.error('WebSocket: error during connection', { error });
      ws.close(1008, 'Invalid token');
    }
  }

  // =====================================================================
  // MESSAGE ROUTING
  // =====================================================================

  private handleMessage(clientId: string, message: WebSocket.RawData): void {
    try {
      const data = JSON.parse(message.toString());
      const client = this.clients.get(clientId);
      if (!client) return;

      log.debug(`Message received from ${clientId}`, { type: data.type });

      switch (data.type) {
        case 'ping':
          this.sendToClient(client.ws, 'pong', { timestamp: Date.now() });
          break;

        case 'subscribe':
          this.handleSubscription(clientId, data.channels || []);
          break;

        case 'get_status':
          this.sendToClient(client.ws, 'bot_status', this.getBotStatus());
          break;

        case 'get_metrics':
          this.sendToClient(client.ws, 'metrics', this.getMetrics());
          break;

        case 'get_logs':
          this.sendToClient(client.ws, 'logs', this.getRecentLogs());
          break;

        case 'bot_action':
          this.handleBotAction(clientId, data.action, data.params);
          break;

        default:
          this.sendToClient(client.ws, 'error', {
            message: 'Unknown message type',
            type: data.type,
          });
      }
    } catch (error) {
      log.error(`Error handling message from ${clientId}`, { error });
      const client = this.clients.get(clientId);
      if (client) {
        this.sendToClient(client.ws, 'error', {
          message: 'Error processing message',
        });
      }
    }
  }

  private handleSubscription(clientId: string, channels: string[]): void {
    const client = this.clients.get(clientId);
    if (!client) return;

    client.subscriptions = channels;

    this.sendToClient(client.ws, 'subscribed', {
      channels,
      message: `Subscribed to ${channels.length} channel(s)`,
    });

    log.debug(`Client ${clientId} subscribed to channels`, { channels });
  }

  private handleBotAction(clientId: string, action: string, params: any): void {
    const client = this.clients.get(clientId);
    if (!client) return;

    log.info(`Bot action requested by ${clientId}`, { action, params });

    this.emit('bot_action', {
      clientId,
      action,
      params,
      user: client.user,
    } as BotActionEvent);
  }

  // =====================================================================
  // SEND / BROADCAST
  // =====================================================================

  private sendToClient(ws: WebSocket, type: string, data: any): void {
    if (ws.readyState === WebSocket.OPEN) {
      try {
        ws.send(JSON.stringify({ type, data, timestamp: Date.now() }));
      } catch (error) {
        log.error('Error sending WebSocket message', { error });
      }
    }
  }

  broadcast(type: string, data: any, channelFilter: string | null = null): void {
    const message = JSON.stringify({ type, data, timestamp: Date.now() });
    let sentCount = 0;

    this.clients.forEach((client, clientId) => {
      if (
        channelFilter &&
        client.subscriptions &&
        !client.subscriptions.includes(channelFilter)
      ) {
        return;
      }

      if (client.ws.readyState === WebSocket.OPEN) {
        try {
          client.ws.send(message);
          sentCount++;
        } catch (error) {
          log.error(`Broadcast error for ${clientId}`, { error });
        }
      }
    });

    // Don't log routine broadcasts (status / metrics)
    if (sentCount > 0 && type !== 'bot_status' && type !== 'metrics') {
      log.debug(`Broadcast ${type} sent to ${sentCount} client(s)`);
    }
  }

  broadcastBotStatus(): void {
    if (this.clients.size === 0) return;
    this.broadcast('bot_status', this.getBotStatus(), 'bot_status');
  }

  broadcastMetrics(): void {
    if (this.clients.size === 0) return;
    this.broadcast('metrics', this.getMetrics(), 'metrics');
  }

  broadcastCommandLog(commandData: {
    user: any;
    command: string;
    success: boolean;
    server?: any;
    channel?: any;
  }): void {
    this.broadcast(
      'command_log',
      {
        user: commandData.user,
        command: commandData.command,
        success: commandData.success,
        timestamp: new Date(),
        server: commandData.server,
        channel: commandData.channel,
      },
      'command_logs',
    );
  }

  broadcastModerationAction(actionData: {
    type: string;
    target: any;
    moderator: any;
    reason?: string;
    server: any;
  }): void {
    this.broadcast(
      'moderation',
      {
        type: actionData.type,
        target: actionData.target,
        moderator: actionData.moderator,
        reason: actionData.reason,
        timestamp: new Date(),
        server: actionData.server,
      },
      'moderation',
    );
  }

  // =====================================================================
  // STATUS / METRICS
  // =====================================================================

  private getBotStatus(): any {
    if (!this.client || !this.client.isReady()) {
      return {
        status: 'offline',
        uptime: 0,
        guilds: 0,
        users: 0,
        ping: 0,
        memory: process.memoryUsage(),
      };
    }

    return {
      status: 'online',
      uptime: process.uptime(),
      guilds: this.client.guilds.cache.size,
      users: this.client.users.cache.size,
      ping: this.client.ws.ping,
      memory: process.memoryUsage(),
      shardCount: this.client.shard?.count || 1,
      timestamp: Date.now(),
    };
  }

  private getMetrics(): any {
    const metrics: any = {
      websocket: {
        connectedClients: this.clients.size,
        activeConnections: Array.from(this.clients.values()).filter(
          (c) => c.ws.readyState === WebSocket.OPEN,
        ).length,
      },
      system: {
        memory: process.memoryUsage(),
        cpu: process.cpuUsage(),
        uptime: process.uptime(),
      },
    };

    if (this.client && this.client.isReady()) {
      metrics.bot = {
        guilds: this.client.guilds.cache.size,
        users: this.client.users.cache.size,
        channels: this.client.channels.cache.size,
        ping: this.client.ws.ping,
      };
    }

    return metrics;
  }

  private getRecentLogs(): any {
    return {
      logs: [],
      total: 0,
      message: 'Log retrieval not yet implemented',
    };
  }

  // =====================================================================
  // UTILITIES
  // =====================================================================

  private generateClientId(): string {
    return `client_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  generateToken(payload: any, expiresIn: string = '1h'): string {
    return jwt.sign(payload, this.jwtSecret, { expiresIn } as any);
  }

  private cleanupInactiveClients(): void {
    const now = Date.now();
    const timeout = 60_000; // 1 minute

    this.clients.forEach((client, clientId) => {
      if (now - client.lastPing > timeout) {
        log.debug(`Cleaning up inactive client: ${clientId}`);
        client.ws.terminate();
        this.clients.delete(clientId);
      }
    });
  }
}
