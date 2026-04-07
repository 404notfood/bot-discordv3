import { Client, Collection, GatewayIntentBits, Partials } from 'discord.js';

export type BotClient = Client & { commands: Collection<string, any> };

export function createClient(): BotClient {
  const client = new Client({
    intents: [
      GatewayIntentBits.Guilds,
      GatewayIntentBits.GuildMessages,
      GatewayIntentBits.GuildMembers,
      GatewayIntentBits.MessageContent,
      GatewayIntentBits.GuildPresences,
      GatewayIntentBits.DirectMessages,
    ],
    partials: [Partials.Channel, Partials.Message],
  }) as BotClient;

  client.commands = new Collection();

  return client;
}
