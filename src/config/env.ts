import { z } from 'zod';

const envSchema = z.object({
  // Application
  APP_NAME: z.string().default('Taureau Celtique'),
  NODE_ENV: z.enum(['development', 'production']).default('development'),
  LOG_LEVEL: z.string().default('info'),

  // Discord
  BOT_TOKEN: z.string().min(1),
  CLIENT_ID: z.string().min(1),
  GUILD_ID: z.string().min(1),
  OWNER_USER_ID: z.string().min(1),
  LOG_CHANNEL_ID: z.string().optional(),

  // API & WebSocket
  BOT_API_PORT: z.coerce.number().default(3008),
  BOT_API_TOKEN: z.string().min(1),
  BOT_WS_PORT: z.coerce.number().default(3009),
  BOT_JWT_SECRET: z.string().min(1),

  // Database
  DATABASE_URL: z.string().min(1),

  // Dashboard
  DASHBOARD_URL: z.string().optional(),
  CORS_ALLOWED_ORIGINS: z.string().optional(),

  // France Travail
  FRANCE_TRAVAIL_CLIENT_ID: z.string().optional(),
  FRANCE_TRAVAIL_CLIENT_SECRET: z.string().optional(),

  // External APIs
  YOUTUBE_API_KEY: z.string().optional(),
  GITHUB_TOKEN: z.string().optional(),
  DEVTO_API_KEY: z.string().optional(),
  STACKOVERFLOW_API_KEY: z.string().optional(),

  // Features
  ENABLE_JOB_OFFERS: z.string().transform(v => v === 'true').default('true'),
  ENABLE_STUDI_MODERATION: z.string().transform(v => v === 'true').default('true'),
});

export type Env = z.infer<typeof envSchema>;
export { envSchema };
