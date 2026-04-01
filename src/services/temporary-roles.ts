import { Client } from 'discord.js';
import { db } from './database';
import { log } from './logger';

export interface GiveTemporaryRoleOptions {
  userId: string;
  guildId: string;
  roleId: string;
  durationMs: number;
  reason?: string | null;
  source?: string;
  grantedBy?: string | null;
}

export interface GiveTemporaryRoleResult {
  success: boolean;
  action: 'granted' | 'extended';
  expiresAt: Date;
  roleId?: bigint;
}

export interface RemoveTemporaryRoleResult {
  success: boolean;
  removed: boolean;
}

export interface CleanupResult {
  cleaned: number;
  errors: number;
}

export interface TemporaryRoleStats {
  active: Array<{ source: string | null; _count: { id: number } }>;
  expired: Array<{ source: string | null; _count: { id: number } }>;
  total: number;
}

export interface ListTemporaryRolesFilters {
  userId?: string;
  guildId?: string;
  roleId?: string;
  source?: string;
  activeOnly?: boolean;
}

// ---------------------------------------------------------------------------
// Service
// ---------------------------------------------------------------------------

export class TemporaryRolesService {
  private cleanupInterval: NodeJS.Timeout | null = null;
  private isInitialized = false;

  // ------------------------------------------------------------------
  // Lifecycle
  // ------------------------------------------------------------------

  async initialize(): Promise<void> {
    if (this.isInitialized) return;

    try {
      await db.initialize();

      // Start automatic cleanup every 5 minutes
      this.startCleanupInterval();

      this.isInitialized = true;
      log.service('TemporaryRolesService', 'initialized');
    } catch (error) {
      log.error('Error initializing TemporaryRolesService', { error });
      throw error;
    }
  }

  // ------------------------------------------------------------------
  // Grant a temporary role (or extend if already active)
  // ------------------------------------------------------------------

  async giveTemporaryRole(
    client: Client,
    options: GiveTemporaryRoleOptions,
  ): Promise<GiveTemporaryRoleResult> {
    try {
      const {
        userId,
        guildId,
        roleId,
        durationMs,
        reason,
        source = 'manual',
        grantedBy,
      } = options;

      if (!userId || !guildId || !roleId || !durationMs) {
        throw new Error('Missing parameters for temporary role assignment');
      }

      const guild = await client.guilds.fetch(guildId).catch(() => null);
      if (!guild) throw new Error(`Guild ${guildId} not found`);

      const role = guild.roles.cache.get(roleId);
      if (!role) throw new Error(`Role ${roleId} not found on guild`);

      const member = await guild.members.fetch(userId).catch(() => null);
      if (!member) throw new Error(`Member ${userId} not found on guild`);

      // Check for an existing active temporary role entry
      const existingRole = await db.client.temporaryRole.findFirst({
        where: { userId, guildId, roleId, isActive: true },
      });

      if (existingRole) {
        // Extend the duration instead of creating a new entry
        const newExpiresAt = new Date(Date.now() + durationMs);
        await db.client.temporaryRole.update({
          where: { id: existingRole.id },
          data: {
            expiresAt: newExpiresAt,
            reason: reason || existingRole.reason,
            updatedAt: new Date(),
          },
        });

        log.info(
          `Temporary role extended: ${role.name} for ${member.user.username} until ${newExpiresAt.toISOString()}`,
        );

        return { success: true, action: 'extended', expiresAt: newExpiresAt, roleId: existingRole.id };
      }

      // Add the Discord role
      await member.roles.add(role);

      const expiresAt = new Date(Date.now() + durationMs);

      // Persist to database
      const result = await db.client.temporaryRole.create({
        data: {
          userId,
          guildId,
          roleId,
          reason,
          source,
          grantedBy,
          expiresAt,
          isActive: true,
          roleName: role.name,
        },
      });

      log.info(
        `Temporary role granted: ${role.name} to ${member.user.username} until ${expiresAt.toISOString()}`,
      );

      return { success: true, action: 'granted', expiresAt, roleId: result.id };
    } catch (error) {
      log.error('Error assigning temporary role', { error });
      throw error;
    }
  }

  // ------------------------------------------------------------------
  // Remove a temporary role
  // ------------------------------------------------------------------

  async removeTemporaryRole(
    client: Client,
    userId: string,
    guildId: string,
    roleId: string,
    removedBy?: string | null,
  ): Promise<RemoveTemporaryRoleResult> {
    try {
      const guild = await client.guilds.fetch(guildId).catch(() => null);
      const member = guild ? await guild.members.fetch(userId).catch(() => null) : null;
      const role = guild ? guild.roles.cache.get(roleId) : null;

      // Mark as removed in database
      const result = await db.client.temporaryRole.updateMany({
        where: { userId, guildId, roleId, isActive: true },
        data: {
          isActive: false,
          removedAt: new Date(),
          removedBy,
          updatedAt: new Date(),
        },
      });

      // Remove the Discord role if possible
      if (member && role && member.roles.cache.has(roleId)) {
        await member.roles.remove(role);
        log.info(`Temporary role removed: ${role.name} from ${member.user.username}`);
      }

      return { success: true, removed: result.count > 0 };
    } catch (error) {
      log.error('Error removing temporary role', { error });
      throw error;
    }
  }

  // ------------------------------------------------------------------
  // Cleanup expired roles
  // ------------------------------------------------------------------

  async cleanupExpiredRoles(client: Client): Promise<CleanupResult> {
    try {
      const expiredRoles = await db.client.temporaryRole.findMany({
        where: {
          isActive: true,
          expiresAt: { lte: new Date() },
        },
        orderBy: { expiresAt: 'asc' },
        take: 100,
      });

      if (expiredRoles.length === 0) return { cleaned: 0, errors: 0 };

      let cleaned = 0;
      let errors = 0;

      for (const tempRole of expiredRoles) {
        try {
          const guild = await client.guilds.fetch(tempRole.guildId).catch(() => null);
          const member = guild
            ? await guild.members.fetch(tempRole.userId).catch(() => null)
            : null;
          const role = guild ? guild.roles.cache.get(tempRole.roleId) : null;

          if (member && role && member.roles.cache.has(tempRole.roleId)) {
            await member.roles.remove(role);
          }

          await db.client.temporaryRole.update({
            where: { id: tempRole.id },
            data: {
              isActive: false,
              removedAt: new Date(),
              updatedAt: new Date(),
            },
          });

          cleaned++;

          if (role) {
            log.info(`Expired role cleaned: ${role.name} (${tempRole.userId})`);
          }
        } catch (error) {
          log.error(`Error cleaning role ${tempRole.id}`, { error });
          errors++;
        }
      }

      if (cleaned > 0) {
        log.info(`Auto-cleanup: ${cleaned} role(s) removed, ${errors} error(s)`);
      }

      return { cleaned, errors };
    } catch (error) {
      log.error('Error during role cleanup', { error });
      return { cleaned: 0, errors: 1 };
    }
  }

  // ------------------------------------------------------------------
  // List temporary roles
  // ------------------------------------------------------------------

  async listTemporaryRoles(filters: ListTemporaryRolesFilters = {}): Promise<any[]> {
    try {
      const where: any = {};

      if (filters.userId) where.userId = filters.userId;
      if (filters.guildId) where.guildId = filters.guildId;
      if (filters.roleId) where.roleId = filters.roleId;
      if (filters.source) where.source = filters.source;

      if (filters.activeOnly) {
        where.isActive = true;
        where.expiresAt = { gt: new Date() };
      }

      return await db.client.temporaryRole.findMany({
        where,
        orderBy: { expiresAt: 'desc' },
        take: 50,
      });
    } catch (error) {
      log.error('Error listing temporary roles', { error });
      throw error;
    }
  }

  // ------------------------------------------------------------------
  // Stats
  // ------------------------------------------------------------------

  async getStats(guildId?: string | null): Promise<TemporaryRoleStats> {
    try {
      const where: any = {};
      if (guildId) where.guildId = guildId;

      const [activeRoles, expiredRoles, totalRoles] = await Promise.all([
        db.client.temporaryRole.groupBy({
          by: ['source'],
          where: { ...where, isActive: true, expiresAt: { gt: new Date() } },
          _count: { id: true },
        }),
        db.client.temporaryRole.groupBy({
          by: ['source'],
          where: { ...where, isActive: true, expiresAt: { lte: new Date() } },
          _count: { id: true },
        }),
        db.client.temporaryRole.count({ where }),
      ]);

      return { active: activeRoles, expired: expiredRoles, total: totalRoles };
    } catch (error) {
      log.error('Error fetching temporary role stats', { error });
      throw error;
    }
  }

  // ------------------------------------------------------------------
  // Interval management
  // ------------------------------------------------------------------

  startCleanupInterval(client?: Client): void {
    if (this.cleanupInterval) {
      clearInterval(this.cleanupInterval);
    }

    // Cleanup every 5 minutes
    this.cleanupInterval = setInterval(() => {
      const activeClient = client || (global as any).client;
      if (activeClient) {
        this.cleanupExpiredRoles(activeClient).catch((error) => {
          log.error('Error in automatic cleanup', { error });
        });
      }
    }, 5 * 60 * 1000);

    log.info('Automatic temporary-role cleanup started (5 min interval)');
  }

  stopCleanupInterval(): void {
    if (this.cleanupInterval) {
      clearInterval(this.cleanupInterval);
      this.cleanupInterval = null;
      log.info('Automatic temporary-role cleanup stopped');
    }
  }

  // ------------------------------------------------------------------
  // Duration helper
  // ------------------------------------------------------------------

  static getDuration(amount: number, unit: 'minutes' | 'hours' | 'days' | 'weeks'): number {
    const multipliers: Record<string, number> = {
      minutes: 60 * 1000,
      hours: 60 * 60 * 1000,
      days: 24 * 60 * 60 * 1000,
      weeks: 7 * 24 * 60 * 60 * 1000,
    };
    return amount * (multipliers[unit] || multipliers.hours);
  }

  // ------------------------------------------------------------------
  // Cleanup / teardown
  // ------------------------------------------------------------------

  async cleanup(): Promise<void> {
    this.stopCleanupInterval();
  }
}

// Singleton instance
export const temporaryRolesService = new TemporaryRolesService();
