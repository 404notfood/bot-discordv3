import { BotEvent } from '../types/event';
import readyEvent from './ready';
import interactionCreateEvent from './interaction-create';
import messageCreateEvent from './message-create';

const events: BotEvent[] = [
  readyEvent,
  interactionCreateEvent,
  messageCreateEvent,
];

export default events;
