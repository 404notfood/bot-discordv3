import { Router, Response } from 'express';
import { Client, ChannelType, Role } from 'discord.js';
import { AuthRequest } from '../middleware/auth';
import { log } from '../../services/logger';

export function createGuildsRouter(client: Client): Router {
  const router = Router();

  // GET /api/guilds - List all guilds
  router.get('/', async (req: AuthRequest, res: Response) => {
    try {
      if (!client?.isReady()) {
        log.api(req.method, req.path, 503, { error: 'Bot offline' });
        return res.status(503).json({ error: 'Bot hors ligne' });
      }

      const guilds = client.guilds.cache.map((guild) => ({
        guild_id: guild.id,
        guild_name: guild.name,
        member_count: guild.memberCount,
        icon: guild.iconURL(),
        owner_id: guild.ownerId,
        created_at: guild.createdAt.toISOString(),
      }));

      log.api(req.method, req.path, 200, { guildsCount: guilds.length });
      res.json({ guilds });
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message });
      res.status(500).json({ error: 'Erreur lors de la recuperation des serveurs' });
    }
  });

  // GET /api/guilds/:id/channels - Guild channels
  router.get('/:id/channels', async (req: AuthRequest, res: Response) => {
    const id = req.params.id as string;

    try {
      if (!client?.isReady()) {
        log.api(req.method, req.path, 503, { error: 'Bot offline' });
        return res.status(503).json({ error: 'Bot hors ligne' });
      }

      const guild = client.guilds.cache.get(id);
      if (!guild) {
        log.api(req.method, req.path, 404, { guildId: id });
        return res.status(404).json({ error: 'Serveur non trouve' });
      }

      const channels = guild.channels.cache
        .filter(
          (channel) =>
            channel.type === ChannelType.GuildText ||
            channel.type === ChannelType.GuildVoice ||
            channel.type === ChannelType.GuildCategory
        )
        .map((channel) => ({
          id: channel.id,
          name: channel.name,
          type:
            channel.type === ChannelType.GuildText
              ? 'text'
              : channel.type === ChannelType.GuildVoice
                ? 'voice'
                : 'category',
          position: channel.position,
          parent: channel.parent
            ? { id: channel.parent.id, name: channel.parent.name }
            : null,
          topic: (channel as any).topic || null,
          nsfw: (channel as any).nsfw || false,
          userLimit: (channel as any).userLimit || null,
        }))
        .sort((a, b) => a.position - b.position);

      log.api(req.method, req.path, 200, {
        guildId: id,
        channelsCount: channels.length,
      });
      res.json({ success: true, channels });
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message, guildId: id });
      res.status(500).json({ error: 'Erreur lors de la recuperation des canaux' });
    }
  });

  // GET /api/guilds/:id/members - Paginated members (max 50)
  router.get('/:id/members', async (req: AuthRequest, res: Response) => {
    const id = req.params.id as string;
    const limit = Math.min(parseInt(req.query.limit as string) || 50, 50);
    const after = (req.query.after as string) || undefined;

    try {
      if (!client?.isReady()) {
        log.api(req.method, req.path, 503, { error: 'Bot offline' });
        return res.status(503).json({ error: 'Bot hors ligne' });
      }

      const guild = client.guilds.cache.get(id);
      if (!guild) {
        log.api(req.method, req.path, 404, { guildId: id });
        return res.status(404).json({ error: 'Serveur non trouve' });
      }

      const fetchOptions: any = { limit };
      if (after) {
        fetchOptions.after = after;
      }

      const fetchedMembers = await guild.members.fetch(fetchOptions);

      const membersArray =
        fetchedMembers instanceof Map
          ? Array.from(fetchedMembers.values())
          : [fetchedMembers];

      const members = membersArray.slice(0, limit).map((member: any) => ({
        id: member.user.id,
        username: member.user.username,
        displayName: member.displayName,
        avatar: member.user.avatarURL(),
        joinedAt: member.joinedAt?.toISOString(),
        roles: member.roles.cache
          .filter((role: Role) => role.id !== guild.id)
          .map((role: Role) => ({
            id: role.id,
            name: role.name,
            color: role.hexColor,
          })),
        status: member.presence?.status || 'offline',
        isBot: member.user.bot,
        permissions: member.permissions.toArray(),
      }));

      const lastMemberId =
        members.length > 0 ? members[members.length - 1].id : null;

      log.api(req.method, req.path, 200, {
        guildId: id,
        membersCount: members.length,
      });
      res.json({
        success: true,
        members,
        total: guild.memberCount,
        pagination: {
          limit,
          returned: members.length,
          hasMore: members.length === limit,
          nextAfter: lastMemberId,
        },
      });
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message, guildId: id });
      res.status(500).json({ error: 'Erreur lors de la recuperation des membres' });
    }
  });

  // GET /api/guilds/:id/roles - Guild roles
  router.get('/:id/roles', async (req: AuthRequest, res: Response) => {
    const id = req.params.id as string;

    try {
      if (!client?.isReady()) {
        log.api(req.method, req.path, 503, { error: 'Bot offline' });
        return res.status(503).json({ error: 'Bot hors ligne' });
      }

      const guild = client.guilds.cache.get(id);
      if (!guild) {
        log.api(req.method, req.path, 404, { guildId: id });
        return res.status(404).json({ error: 'Serveur non trouve' });
      }

      const roles = guild.roles.cache
        .filter((role) => role.id !== guild.id)
        .map((role) => ({
          id: role.id,
          name: role.name,
          color: role.hexColor,
          position: role.position,
          permissions: role.permissions.toArray(),
          mentionable: role.mentionable,
          hoisted: role.hoist,
          managed: role.managed,
          members: role.members.size,
        }))
        .sort((a, b) => b.position - a.position);

      log.api(req.method, req.path, 200, {
        guildId: id,
        rolesCount: roles.length,
      });
      res.json({ success: true, roles });
    } catch (error) {
      const err = error as Error;
      log.api(req.method, req.path, 500, { error: err.message, guildId: id });
      res.status(500).json({ error: 'Erreur lors de la recuperation des roles' });
    }
  });

  return router;
}
