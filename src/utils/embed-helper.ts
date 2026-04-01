import { EmbedBuilder, ColorResolvable } from 'discord.js';

/**
 * Couleurs standardisees pour les embeds du bot.
 */
const COLORS = {
  success: 0x2ecc71 as ColorResolvable,   // Vert
  error: 0xe74c3c as ColorResolvable,     // Rouge
  warning: 0xf39c12 as ColorResolvable,   // Orange
  info: 0x3498db as ColorResolvable,      // Bleu
  neutral: 0x95a5a6 as ColorResolvable,   // Gris
  primary: 0x5865f2 as ColorResolvable,   // Blurple Discord
} as const;

export type EmbedType = keyof typeof COLORS;

/**
 * Options pour la creation d'un embed.
 */
interface EmbedOptions {
  title?: string;
  description?: string;
  footer?: string;
  thumbnail?: string;
  timestamp?: boolean;
  fields?: Array<{ name: string; value: string; inline?: boolean }>;
}

/**
 * Cree un EmbedBuilder avec un style et des options coherents.
 */
function createEmbed(type: EmbedType, options: EmbedOptions): EmbedBuilder {
  const embed = new EmbedBuilder().setColor(COLORS[type]);

  if (options.title) embed.setTitle(options.title);
  if (options.description) embed.setDescription(options.description);
  if (options.footer) embed.setFooter({ text: options.footer });
  if (options.thumbnail) embed.setThumbnail(options.thumbnail);
  if (options.timestamp) embed.setTimestamp();

  if (options.fields) {
    for (const field of options.fields) {
      embed.addFields({ name: field.name, value: field.value, inline: field.inline ?? false });
    }
  }

  return embed;
}

/**
 * Helpers pour creer rapidement des embeds types.
 */
export const embedHelper = {
  /** Embed de succes (vert) */
  success(title: string, description?: string, options?: Partial<EmbedOptions>): EmbedBuilder {
    return createEmbed('success', { title: `${title}`, description, ...options });
  },

  /** Embed d'erreur (rouge) */
  error(title: string, description?: string, options?: Partial<EmbedOptions>): EmbedBuilder {
    return createEmbed('error', { title: `${title}`, description, ...options });
  },

  /** Embed d'avertissement (orange) */
  warning(title: string, description?: string, options?: Partial<EmbedOptions>): EmbedBuilder {
    return createEmbed('warning', { title: `${title}`, description, ...options });
  },

  /** Embed d'information (bleu) */
  info(title: string, description?: string, options?: Partial<EmbedOptions>): EmbedBuilder {
    return createEmbed('info', { title: `${title}`, description, ...options });
  },

  /** Embed neutre (gris) */
  neutral(title: string, description?: string, options?: Partial<EmbedOptions>): EmbedBuilder {
    return createEmbed('neutral', { title: `${title}`, description, ...options });
  },

  /** Embed primaire avec la couleur Blurple Discord */
  primary(title: string, description?: string, options?: Partial<EmbedOptions>): EmbedBuilder {
    return createEmbed('primary', { title: `${title}`, description, ...options });
  },

  /** Embed personnalise avec type et options complets */
  custom(type: EmbedType, options: EmbedOptions): EmbedBuilder {
    return createEmbed(type, options);
  },
};

export { COLORS };
