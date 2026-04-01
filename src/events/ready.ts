import { Client, ActivityType } from 'discord.js';
import { log } from '../services/logger';
import { BotEvent } from '../types/event';

const readyEvent: BotEvent = {
  name: 'ready',
  once: true,
  async execute(client: Client<true>) {
    log.info(`Bot connected: ${client.user.tag}`);

    client.user.setActivity('Taureau Celtique v3', {
      type: ActivityType.Watching,
    });

    log.info('Activity status set');
  },
};

export default readyEvent;
