import * as fs from 'fs';
import * as path from 'path';
import { log } from '../services/logger';
import { BotClient } from './client';

export function loadCommands(client: BotClient): void {
  const commandsDir = path.join(__dirname, '../commands');

  if (!fs.existsSync(commandsDir)) {
    log.warn('Commands directory not found', { path: commandsDir });
    return;
  }

  const categories = fs.readdirSync(commandsDir);

  for (const category of categories) {
    const categoryPath = path.join(commandsDir, category);
    const stat = fs.statSync(categoryPath);

    if (!stat.isDirectory()) {
      continue;
    }

    const commandFiles = fs.readdirSync(categoryPath).filter(
      (file) =>
        (file.endsWith('.ts') || file.endsWith('.js')) &&
        file !== 'index.ts' &&
        file !== 'index.js'
    );

    for (const file of commandFiles) {
      const filePath = path.join(categoryPath, file);

      try {
        // eslint-disable-next-line @typescript-eslint/no-require-imports
        const imported = require(filePath);
        const command = imported.default || imported;

        if (!command.data || !command.execute) {
          log.warn(`Skipping invalid command file: ${file} (missing data or execute)`);
          continue;
        }

        const commandName = command.data.name || command.data.toJSON?.().name;

        if (!commandName) {
          log.warn(`Skipping command file without name: ${file}`);
          continue;
        }

        client.commands.set(commandName, command);
        log.info(`Command loaded: ${commandName} [${category}]`);
      } catch (error) {
        const err = error as Error;
        log.error(`Failed to load command ${file}`, {
          error: err.message,
          stack: err.stack,
        });
      }
    }
  }

  log.info(`Total commands loaded: ${client.commands.size}`);
}
