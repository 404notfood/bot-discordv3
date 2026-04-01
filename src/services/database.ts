import { PrismaClient } from '../generated/prisma/client';
import { log } from './logger';

/**
 * Gestionnaire de base de donnees singleton utilisant Prisma avec PostgreSQL.
 */
class DatabaseManager {
  private static instance: DatabaseManager;
  private prisma: PrismaClient;
  private isConnected = false;

  private constructor() {
    this.prisma = new PrismaClient();
  }

  /**
   * Retourne l'instance singleton du DatabaseManager.
   */
  static getInstance(): DatabaseManager {
    if (!DatabaseManager.instance) {
      DatabaseManager.instance = new DatabaseManager();
    }
    return DatabaseManager.instance;
  }

  /**
   * Acces direct au client Prisma pour les requetes personnalisees.
   */
  get client(): PrismaClient {
    return this.prisma;
  }

  /**
   * Initialise la connexion a la base de donnees.
   * Retourne true si la connexion est etablie avec succes.
   */
  async initialize(): Promise<boolean> {
    if (this.isConnected) return true;

    try {
      log.info('Initialisation de la base de donnees (Prisma + PostgreSQL)...');

      // Test de connexion
      await this.prisma.$queryRawUnsafe('SELECT 1');

      this.isConnected = true;
      log.info('Base de donnees connectee (PostgreSQL)');
      return true;
    } catch (error) {
      const err = error as Error;
      log.error('Erreur de connexion a la base de donnees', {
        error: err.message,
        stack: err.stack,
      });
      return false;
    }
  }

  /**
   * Cree ou met a jour les informations d'un serveur Discord.
   */
  async createOrUpdateServer(serverData: {
    id: string;
    name: string;
    memberCount?: number;
    icon?: string | null;
  }): Promise<void> {
    try {
      await this.prisma.guildConfig.upsert({
        where: { guildId: serverData.id },
        update: {
          guildName: serverData.name,
          memberCount: serverData.memberCount || 0,
          icon: serverData.icon,
          updatedAt: new Date(),
        },
        create: {
          guildId: serverData.id,
          guildName: serverData.name,
          memberCount: serverData.memberCount || 0,
          icon: serverData.icon,
          isActive: true,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      });

      log.database('createOrUpdateServer', true, { guildId: serverData.id });
    } catch (error) {
      log.database('createOrUpdateServer', false, { error });
      throw error;
    }
  }

  /**
   * Enregistre l'execution d'une commande dans les logs.
   */
  async logCommand(commandData: {
    commandName: string;
    userId: string;
    serverId?: string;
    channelId?: string;
    options?: any;
    success: boolean;
    executionTime?: number;
    errorMessage?: string;
  }): Promise<void> {
    try {
      await this.prisma.commandLog.create({
        data: {
          commandName: commandData.commandName,
          userId: commandData.userId,
          guildId: commandData.serverId,
          channelId: commandData.channelId,
          options: commandData.options || undefined,
          success: commandData.success,
          executionTime: commandData.executionTime,
          errorMessage: commandData.errorMessage,
          createdAt: new Date(),
        },
      });

      log.command(
        commandData.commandName,
        commandData.userId,
        commandData.serverId || 'DM',
        commandData.success,
        { executionTime: commandData.executionTime },
      );
    } catch (error) {
      log.database('logCommand', false, { error });
    }
  }

  /**
   * Recupere les permissions d'un utilisateur (admin/moderateur).
   */
  async getUserPermissions(
    userId: string,
    serverId?: string | null,
  ): Promise<Array<{
    id: bigint;
    userId: string;
    adminLevel: string;
    guildId: string | null;
  }>> {
    try {
      const where: Record<string, unknown> = { userId };

      if (serverId) {
        where.OR = [{ guildId: serverId }, { guildId: null }];
      }

      const admins = await this.prisma.botAdmin.findMany({
        where,
        select: {
          id: true,
          userId: true,
          adminLevel: true,
          guildId: true,
        },
      });

      return admins;
    } catch (error) {
      log.database('getUserPermissions', false, { error, userId, serverId });
      return [];
    }
  }

  /**
   * Recupere les statistiques d'un serveur.
   */
  async getServerStats(serverId: string): Promise<{
    guildConfig: unknown;
    projectsCount: number;
    commandsToday: number;
  }> {
    try {
      const todayStart = new Date();
      todayStart.setHours(0, 0, 0, 0);

      const [guildConfig, projectsCount, commandsToday] = await Promise.all([
        this.prisma.guildConfig.findUnique({
          where: { guildId: serverId },
        }),
        this.prisma.project.count({
          where: {
            guildId: serverId,
            isActive: true,
          },
        }),
        this.prisma.commandLog.count({
          where: {
            guildId: serverId,
            createdAt: { gte: todayStart },
          },
        }),
      ]);

      return { guildConfig, projectsCount, commandsToday };
    } catch (error) {
      log.database('getServerStats', false, { error, serverId });
      throw error;
    }
  }

  /**
   * Ferme proprement la connexion a la base de donnees.
   */
  async cleanup(): Promise<void> {
    if (!this.isConnected) return;

    try {
      await this.prisma.$disconnect();
      this.isConnected = false;
      log.info('Connexion base de donnees fermee');
    } catch (error) {
      log.error('Erreur lors de la fermeture de la connexion Prisma', { error });
    }
  }

  /**
   * Indique si la base de donnees est disponible.
   */
  isAvailable(): boolean {
    return this.isConnected;
  }

  /**
   * Retourne les statistiques du pool de connexion.
   */
  static getPoolStats(): { initialized: boolean; clientExists: boolean } {
    return {
      initialized: DatabaseManager.instance?.isConnected || false,
      clientExists: !!DatabaseManager.instance?.prisma,
    };
  }
}

/** Instance singleton du gestionnaire de base de donnees */
export const db = DatabaseManager.getInstance();
export { DatabaseManager };
