import { Client, Guild, GuildMember } from 'discord.js';
import { db } from './database';
import { log } from './logger';

// ---------------------------------------------------------------------------
// Service
// ---------------------------------------------------------------------------

export class GuildSyncService {
  private client: Client;
  private syncInterval: NodeJS.Timeout | null = null;
  private listenersSetup = false;

  private handlers: {
    guildCreate: ((guild: Guild) => Promise<void>) | null;
    guildDelete: ((guild: Guild) => Promise<void>) | null;
    guildUpdate: ((oldGuild: Guild, newGuild: Guild) => Promise<void>) | null;
    guildMemberAdd: ((member: GuildMember) => Promise<void>) | null;
    guildMemberRemove: ((member: GuildMember) => Promise<void>) | null;
  } = {
    guildCreate: null,
    guildDelete: null,
    guildUpdate: null,
    guildMemberAdd: null,
    guildMemberRemove: null,
  };

  constructor(client: Client) {
    this.client = client;
  }

  // ------------------------------------------------------------------
  // Lifecycle
  // ------------------------------------------------------------------

  async initialize(): Promise<void> {
    log.info('Initializing guild sync service...');

    // Initial sync
    await this.syncAllGuilds();

    // Clear any previous interval
    if (this.syncInterval) {
      clearInterval(this.syncInterval);
    }

    // Automatic sync every 5 minutes
    this.syncInterval = setInterval(() => {
      this.syncAllGuilds().catch((error) => {
        log.error('Error in automatic guild sync', { error });
      });
    }, 5 * 60 * 1000);

    // Listen for Discord events (only once)
    this.setupEventListeners();

    log.info('Guild sync service initialized');
  }

  // ------------------------------------------------------------------
  // Event listeners
  // ------------------------------------------------------------------

  setupEventListeners(): void {
    if (this.listenersSetup) {
      log.warn('Event listeners already set up, skipping...');
      return;
    }

    this.handlers.guildCreate = async (guild: Guild) => {
      log.info(`Bot joined a new guild: ${guild.name} (${guild.id})`);
      await this.syncGuild(guild);
    };

    this.handlers.guildDelete = async (guild: Guild) => {
      log.info(`Bot left guild: ${guild.name} (${guild.id})`);
      await this.markGuildInactive(guild.id);
    };

    this.handlers.guildUpdate = async (_oldGuild: Guild, newGuild: Guild) => {
      log.info(`Guild updated: ${newGuild.name} (${newGuild.id})`);
      await this.syncGuild(newGuild);
    };

    this.handlers.guildMemberAdd = async (member: GuildMember) => {
      await this.updateMemberCount(member.guild);
    };

    this.handlers.guildMemberRemove = async (member: GuildMember) => {
      await this.updateMemberCount(member.guild);
    };

    this.client.on('guildCreate', this.handlers.guildCreate);
    this.client.on('guildDelete', this.handlers.guildDelete);
    this.client.on('guildUpdate', this.handlers.guildUpdate);
    this.client.on('guildMemberAdd', this.handlers.guildMemberAdd);
    this.client.on('guildMemberRemove', this.handlers.guildMemberRemove);

    this.listenersSetup = true;
    log.info('Guild event listeners registered');
  }

  removeEventListeners(): void {
    if (!this.listenersSetup) return;

    if (this.handlers.guildCreate) this.client.off('guildCreate', this.handlers.guildCreate);
    if (this.handlers.guildDelete) this.client.off('guildDelete', this.handlers.guildDelete);
    if (this.handlers.guildUpdate) this.client.off('guildUpdate', this.handlers.guildUpdate);
    if (this.handlers.guildMemberAdd) this.client.off('guildMemberAdd', this.handlers.guildMemberAdd);
    if (this.handlers.guildMemberRemove) this.client.off('guildMemberRemove', this.handlers.guildMemberRemove);

    this.listenersSetup = false;
    log.info('Guild event listeners removed');
  }

  // ------------------------------------------------------------------
  // Sync operations
  // ------------------------------------------------------------------

  async syncAllGuilds(): Promise<void> {
    if (!this.client.isReady()) {
      log.warn('Bot not ready yet, postponing guild sync');
      return;
    }

    log.info('Syncing all guilds...');

    try {
      // Mark every guild as inactive first
      await db.client.guildConfig.updateMany({
        where: { isActive: true },
        data: { isActive: false, updatedAt: new Date() },
      });

      // Sync each currently joined guild
      for (const [_guildId, guild] of this.client.guilds.cache) {
        await this.syncGuild(guild);
      }

      log.info(`${this.client.guilds.cache.size} guild(s) synced`);
    } catch (error) {
      log.error('Error syncing guilds', { error });
    }
  }

  async syncGuild(guild: Guild): Promise<void> {
    try {
      const now = new Date();
      const guildData = {
        guildId: guild.id,
        guildName: guild.name,
        ownerId: guild.ownerId,
        memberCount: guild.memberCount,
        icon: guild.icon,
        isActive: true,
        features: JSON.stringify(guild.features || []),
        lastActivity: now,
        updatedAt: now,
      };

      const existing = await db.client.guildConfig.findUnique({
        where: { guildId: guild.id },
      });

      if (existing) {
        await db.client.guildConfig.update({
          where: { guildId: guild.id },
          data: {
            guildName: guildData.guildName,
            ownerId: guildData.ownerId,
            memberCount: guildData.memberCount,
            icon: guildData.icon,
            isActive: guildData.isActive,
            features: guildData.features,
            lastActivity: guildData.lastActivity,
            updatedAt: guildData.updatedAt,
          },
        });
        log.debug(`Guild updated: ${guild.name}`);
      } else {
        await db.client.guildConfig.create({
          data: {
            guildId: guildData.guildId,
            guildName: guildData.guildName,
            ownerId: guildData.ownerId,
            memberCount: guildData.memberCount,
            icon: guildData.icon,
            isActive: guildData.isActive,
            features: guildData.features,
            lastActivity: guildData.lastActivity,
            createdAt: now,
            updatedAt: now,
          },
        });
        log.info(`New guild added: ${guild.name}`);
      }
    } catch (error) {
      log.error(`Error syncing guild ${guild.name}`, { error });
    }
  }

  async markGuildInactive(guildId: string): Promise<void> {
    try {
      await db.client.guildConfig.updateMany({
        where: { guildId },
        data: { isActive: false, updatedAt: new Date() },
      });
      log.info(`Guild marked as inactive: ${guildId}`);
    } catch (error) {
      log.error(`Error marking guild inactive ${guildId}`, { error });
    }
  }

  async updateMemberCount(guild: Guild): Promise<void> {
    try {
      await db.client.guildConfig.updateMany({
        where: { guildId: guild.id },
        data: {
          memberCount: guild.memberCount,
          lastActivity: new Date(),
          updatedAt: new Date(),
        },
      });
    } catch (error) {
      log.error(`Error updating member count for ${guild.id}`, { error });
    }
  }

  // ------------------------------------------------------------------
  // Cleanup / teardown
  // ------------------------------------------------------------------

  cleanup(): void {
    if (this.syncInterval) {
      clearInterval(this.syncInterval);
      this.syncInterval = null;
    }
    this.removeEventListeners();
    log.info('Guild sync service stopped');
  }
}
