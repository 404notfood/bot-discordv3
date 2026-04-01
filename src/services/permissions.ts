import { CommandInteraction } from 'discord.js';
import { db } from './database';
import { log } from './logger';

/**
 * Gestionnaire de permissions du bot.
 * Verifie les niveaux d'acces (admin, moderateur) via la table bot_admins.
 */
export class PermissionsManager {
  /**
   * Verifie si un utilisateur est administrateur du bot.
   * Un admin global (guildId null ou adminLevel 'global') a acces a tous les serveurs.
   */
  static async isUserAdmin(userId: string, guildId?: string | null): Promise<boolean> {
    try {
      // Verifier admin global
      const globalAdmin = await db.client.botAdmin.findFirst({
        where: {
          userId,
          OR: [{ guildId: null }, { adminLevel: 'global' }],
        },
      });

      if (globalAdmin) return true;

      // Verifier admin de serveur specifique
      if (guildId) {
        const serverAdmin = await db.client.botAdmin.findFirst({
          where: { userId, guildId },
        });

        if (serverAdmin) return true;
      }

      return false;
    } catch (error) {
      log.error('Erreur verification admin', { error, userId, guildId });
      return false;
    }
  }

  /**
   * Verifie si un utilisateur est moderateur du bot.
   * Un admin est automatiquement considere comme moderateur.
   */
  static async isUserModerator(userId: string, guildId?: string | null): Promise<boolean> {
    try {
      // Un admin est aussi moderateur
      if (await this.isUserAdmin(userId, guildId)) return true;

      // Verifier moderateur global
      const moderator = await db.client.botAdmin.findFirst({
        where: {
          userId,
          adminLevel: 'moderator',
        },
      });

      if (moderator) return true;

      // Verifier moderateur de serveur specifique
      if (guildId) {
        const serverMod = await db.client.botAdmin.findFirst({
          where: {
            userId,
            guildId,
            adminLevel: { in: ['moderator', 'server'] },
          },
        });

        if (serverMod) return true;
      }

      return false;
    } catch (error) {
      log.error('Erreur verification moderateur', { error, userId, guildId });
      return false;
    }
  }

  /**
   * Middleware de commande: exige le niveau administrateur.
   * Repond automatiquement avec un message d'erreur si l'acces est refuse.
   *
   * @returns true si l'utilisateur est admin, false sinon
   */
  static async requireAdmin(interaction: CommandInteraction): Promise<boolean> {
    const { id: userId, username } = interaction.user;
    const guildId = interaction.guildId;

    log.info(`Verification admin: ${username} (${userId}) sur ${guildId || 'DM'}`);

    const isAdmin = await this.isUserAdmin(userId, guildId);

    if (!isAdmin) {
      log.warn(`Acces refuse pour ${username} (${userId})`);
      await interaction.reply({
        content: `Cette commande est reservee aux administrateurs du bot.\nVotre ID: ${userId}`,
        ephemeral: true,
      });
      return false;
    }

    log.info(`Acces accorde pour ${username} (${userId})`);
    return true;
  }

  /**
   * Middleware de commande: exige le niveau moderateur.
   * Repond automatiquement avec un message d'erreur si l'acces est refuse.
   *
   * @returns true si l'utilisateur est moderateur ou admin, false sinon
   */
  static async requireModerator(interaction: CommandInteraction): Promise<boolean> {
    const { id: userId } = interaction.user;
    const guildId = interaction.guildId;

    const isMod = await this.isUserModerator(userId, guildId);

    if (!isMod) {
      await interaction.reply({
        content: 'Cette commande est reservee aux moderateurs/administrateurs du bot.',
        ephemeral: true,
      });
      return false;
    }

    return true;
  }
}
