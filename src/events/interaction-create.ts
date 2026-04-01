import {
  AutocompleteInteraction,
  ChatInputCommandInteraction,
  Collection,
  Interaction,
} from 'discord.js';
import { db } from '../services/database';
import { log } from '../services/logger';
import { BotEvent } from '../types/event';
import { BotClient } from '../core/client';

interface CommandWithAutocomplete {
  execute: (interaction: ChatInputCommandInteraction) => Promise<void>;
  autocomplete?: (interaction: AutocompleteInteraction) => Promise<void>;
}

const interactionCreateEvent: BotEvent = {
  name: 'interactionCreate',
  async execute(interaction: Interaction) {
    const client = interaction.client as BotClient;

    // Handle autocomplete interactions
    if (interaction.isAutocomplete()) {
      const command = client.commands.get(
        interaction.commandName
      ) as CommandWithAutocomplete | undefined;

      if (!command || !command.autocomplete) {
        return;
      }

      try {
        await command.autocomplete(interaction);
      } catch (error) {
        log.error(`Autocomplete error for ${interaction.commandName}`, {
          error,
          userId: interaction.user.id,
          guildId: interaction.guildId,
        });
      }
      return;
    }

    // Handle slash commands only
    if (!interaction.isChatInputCommand()) {
      return;
    }

    const command = client.commands.get(
      interaction.commandName
    ) as CommandWithAutocomplete | undefined;

    if (!command) {
      log.warn('Command not found', { commandName: interaction.commandName });
      return;
    }

    const startTime = Date.now();

    try {
      // Log command execution to database
      await db.logCommand({
        commandName: interaction.commandName,
        userId: interaction.user.id,
        serverId: interaction.guild?.id,
        channelId: interaction.channel?.id,
        success: true,
        executionTime: 0,
      });

      // Execute the command
      await command.execute(interaction);

      const executionTime = Date.now() - startTime;

      log.command(
        interaction.commandName,
        interaction.user.id,
        interaction.guild?.id || 'DM',
        true,
        { executionTime }
      );
    } catch (error) {
      const executionTime = Date.now() - startTime;
      const err = error as Error;

      log.error(`Command execution error: ${interaction.commandName}`, {
        error: err.message,
        stack: err.stack,
        userId: interaction.user.id,
        guildId: interaction.guild?.id,
        channelId: interaction.channel?.id,
        executionTime,
      });

      // Log error to database
      await db.logCommand({
        commandName: interaction.commandName,
        userId: interaction.user.id,
        serverId: interaction.guild?.id,
        channelId: interaction.channel?.id,
        success: false,
        executionTime,
        errorMessage: err.message,
      });

      // Reply with error message to user
      const replyContent = {
        content: "Erreur lors de l'execution de la commande.",
        ephemeral: true,
      };

      try {
        if (interaction.replied || interaction.deferred) {
          await interaction.followUp(replyContent);
        } else {
          await interaction.reply(replyContent);
        }
      } catch (replyError) {
        log.error('Error sending error reply', { replyError });
      }
    }
  },
};

export default interactionCreateEvent;
