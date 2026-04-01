import { BotEvent } from '../types/event';
import readyEvent from './ready';
import interactionCreateEvent from './interaction-create';
import messageCreateEvent from './message-create';
import guildMemberAddEvent from './guild-member-add';

const events: BotEvent[] = [
  readyEvent,
  interactionCreateEvent,
  messageCreateEvent,
  guildMemberAddEvent,
];

export default events;
