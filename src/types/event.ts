export interface BotEvent {
  name: string;
  once?: boolean;
  execute: (...args: any[]) => Promise<any> | any;
}
