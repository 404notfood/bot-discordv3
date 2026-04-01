import {
  Client,
  Collection,
  ChatInputCommandInteraction,
  SlashCommandBuilder,
  SlashCommandSubcommandsOnlyBuilder,
  ClientEvents,
} from 'discord.js';

/**
 * Definition d'une commande slash du bot.
 */
export interface BotCommand {
  /** Donnees de la commande (SlashCommandBuilder) pour l'enregistrement aupres de Discord */
  data: SlashCommandBuilder | SlashCommandSubcommandsOnlyBuilder | Omit<SlashCommandBuilder, 'addSubcommand' | 'addSubcommandGroup'>;
  /** Fonction d'execution de la commande */
  execute: (interaction: ChatInputCommandInteraction) => Promise<void>;
  /** Cooldown en secondes (optionnel, defaut: 3) */
  cooldown?: number;
  /** Categorie pour le classement dans l'aide */
  category?: string;
  /** Commande reservee aux administrateurs du bot */
  adminOnly?: boolean;
  /** Commande reservee aux moderateurs du bot */
  modOnly?: boolean;
}

/**
 * Definition d'un event handler du bot.
 */
export interface BotEvent<K extends keyof ClientEvents = keyof ClientEvents> {
  /** Nom de l'evenement Discord */
  name: K;
  /** Executer une seule fois (once) au lieu de on */
  once?: boolean;
  /** Fonction d'execution de l'event */
  execute: (...args: ClientEvents[K]) => Promise<void> | void;
}

/**
 * Client Discord etendu avec la collection de commandes.
 */
export interface ExtendedClient extends Client {
  commands: Collection<string, BotCommand>;
}
