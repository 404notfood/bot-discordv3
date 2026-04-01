import { REST, Routes } from 'discord.js';
import { config } from 'dotenv';
import * as fs from 'fs';
import * as path from 'path';

config();

const TOKEN = process.env.BOT_TOKEN!;
const CLIENT_ID = process.env.CLIENT_ID!;
const GUILD_ID = process.env.GUILD_ID;

if (!TOKEN || !CLIENT_ID) {
  console.error('BOT_TOKEN or CLIENT_ID missing in .env');
  process.exit(1);
}

async function loadCommands(): Promise<any[]> {
  const commands: any[] = [];
  const commandsPath = path.join(__dirname, 'commands');

  if (!fs.existsSync(commandsPath)) {
    console.error('Commands directory not found:', commandsPath);
    process.exit(1);
  }

  const categories = fs.readdirSync(commandsPath);

  for (const category of categories) {
    const categoryPath = path.join(commandsPath, category);
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

        if (command?.data?.toJSON) {
          commands.push(command.data.toJSON());
          console.log(`  + ${command.data.name}`);
        } else if (command?.data) {
          commands.push(command.data);
          console.log(`  + ${command.data.name || file}`);
        } else {
          console.warn(`  ? Skipping ${file} (no data property)`);
        }
      } catch (error) {
        console.error(`  x Error loading ${file}:`, (error as Error).message);
      }
    }
  }

  return commands;
}

async function deploy(): Promise<void> {
  try {
    console.log('Loading commands...\n');
    const commands = await loadCommands();

    console.log(`\nDeploying ${commands.length} commands...`);

    const rest = new REST({ version: '10' }).setToken(TOKEN);

    if (GUILD_ID) {
      await rest.put(Routes.applicationGuildCommands(CLIENT_ID, GUILD_ID), {
        body: commands,
      });
      console.log(
        `${commands.length} commands deployed to guild ${GUILD_ID}`
      );
    } else {
      await rest.put(Routes.applicationCommands(CLIENT_ID), {
        body: commands,
      });
      console.log(`${commands.length} commands deployed globally`);
    }
  } catch (error) {
    console.error('Deployment error:', error);
    process.exit(1);
  }
}

deploy();
