import { log } from '../services/logger';
import { BotClient } from './client';
import { BotEvent } from '../types/event';
import events from '../events';

export function loadEvents(client: BotClient): void {
  for (const event of events) {
    if (event.once) {
      client.once(event.name, (...args: any[]) => event.execute(...args));
      log.info(`Event registered (once): ${event.name}`);
    } else {
      client.on(event.name, (...args: any[]) => event.execute(...args));
      log.info(`Event registered: ${event.name}`);
    }
  }

  log.info(`Total events registered: ${events.length}`);
}
