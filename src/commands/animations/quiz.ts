import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder, Client } from 'discord.js';
import { db } from '../../services/database';
import { PermissionsManager } from '../../services/permissions';
import { log } from '../../services/logger';

/**
 * Programme les rappels de countdown avant le démarrage du quiz
 */
function scheduleCountdownReminders(client: Client, sessionId: number, channel: any, startAt: Date): void {
  const now = Date.now();
  const startTime = startAt.getTime();

  const countdownMessages = [
    { time: 4 * 60 * 1000, message: '🕐 **4 minutes** avant le grand show ! Tapez `!participe` si vous vous sentez l\'âme d\'un génie... ou d\'un kamikaze ! 🧠💣' },
    { time: 3 * 60 * 1000, message: '🕒 **3 minutes** restantes ! C\'est le moment de faire un dernier café ☕ ou de paniquer silencieusement ! Tapez `!participe` ! 😰' },
    { time: 2 * 60 * 1000, message: '🕓 **2 minutes** ! L\'heure de vérité approche... Vos neurones sont-ils prêts au combat ? Tapez `!participe` ! ⚔️🧠' },
    { time: 60 * 1000, message: '🕘 **1 minute** ! Dernière chance de rejoindre l\'arène intellectuelle ! Tapez `!participe` maintenant ou pleurez plus tard ! 😭🎯' },
    { time: 30 * 1000, message: '🕧 **30 secondes** ! Les derniers courageux peuvent encore monter à bord du Titanic... euh... du quiz ! `!participe` vite ! 🚢⚡' },
    { time: 10 * 1000, message: '⚡ **10 secondes** ! Préparez vos neurones, réveillez vos synapses, et que le meilleur développeur gagne ! 🧠🔥🚀' },
  ];

  countdownMessages.forEach(({ time, message }) => {
    const delay = startTime - now - time;
    if (delay > 0) {
      setTimeout(async () => {
        try {
          const session = await db.client.quizSession.findUnique({
            where: { id: sessionId },
            select: { status: true },
          });

          if (session && (session.status === 'scheduled' || session.status === 'announced')) {
            await channel.send(message);
          }
        } catch (error) {
          log.error('Erreur countdown reminder:', error);
        }
      }, delay);
    }
  });
}

export default {
  data: new SlashCommandBuilder()
    .setName('quiz')
    .setDescription('Quiz développeur configurable')
    .addSubcommand((sub) =>
      sub
        .setName('start')
        .setDescription('Lancer un quiz maintenant')
        .addStringOption((o) =>
          o.setName('theme').setDescription('Thème du quiz').setRequired(false).setAutocomplete(true)
        )
        .addIntegerOption((o) =>
          o.setName('count').setDescription('Nombre de questions (1-20)').setRequired(false).setMinValue(1).setMaxValue(20)
        )
        .addStringOption((o) =>
          o
            .setName('difficulty')
            .setDescription('Difficulté du quiz')
            .setRequired(false)
            .addChoices(
              { name: 'Toutes difficultés', value: 'all' },
              { name: 'Facile 🟢', value: 'easy' },
              { name: 'Moyen 🟡', value: 'medium' },
              { name: 'Difficile 🔴', value: 'hard' }
            )
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('schedule')
        .setDescription('Programmer un quiz')
        .addStringOption((o) =>
          o.setName('datetime').setDescription('Date/heure ISO ex: 2025-08-29T19:00:00Z').setRequired(true)
        )
        .addStringOption((o) =>
          o.setName('theme').setDescription('Thème du quiz').setRequired(false).setAutocomplete(true)
        )
        .addStringOption((o) =>
          o
            .setName('difficulty')
            .setDescription('Difficulté du quiz')
            .setRequired(false)
            .addChoices(
              { name: 'Toutes difficultés', value: 'all' },
              { name: 'Facile 🟢', value: 'easy' },
              { name: 'Moyen 🟡', value: 'medium' },
              { name: 'Difficile 🔴', value: 'hard' }
            )
        )
    )
    .addSubcommand((sub) =>
      sub
        .setName('config')
        .setDescription('Configurer les canaux et mentions')
        .addChannelOption((o) => o.setName('quiz_channel').setDescription('Canal du quiz').setRequired(true))
        .addChannelOption((o) => o.setName('announce_channel').setDescription("Canal d'annonce").setRequired(false))
        .addBooleanOption((o) => o.setName('mention_everyone').setDescription("Mentionner @everyone à l'annonce"))
    )
    .addSubcommand((sub) =>
      sub
        .setName('rewards')
        .setDescription('Configurer les récompenses pour les gagnants')
        .addRoleOption((o) => o.setName('winner_role').setDescription('Rôle à attribuer au gagnant').setRequired(false))
        .addIntegerOption((o) =>
          o.setName('duration_days').setDescription('Durée en jours (1-30)').setRequired(false).setMinValue(1).setMaxValue(30)
        )
        .addStringOption((o) => o.setName('message').setDescription('Message de félicitation personnalisé').setRequired(false))
        .addBooleanOption((o) => o.setName('active').setDescription('Activer/désactiver les récompenses').setRequired(false))
    )
    .addSubcommand((sub) => sub.setName('points').setDescription('Afficher le système de points du quiz')),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    if (!(await PermissionsManager.requireAdmin(interaction))) {
      return;
    }

    if (!interaction.guildId) {
      await interaction.reply({ content: 'Cette commande doit être utilisée dans un serveur.', ephemeral: true });
      return;
    }

    const sub = interaction.options.getSubcommand();

    try {
      // -- Configuration des canaux --
      if (sub === 'config') {
        const quizChannel = interaction.options.getChannel('quiz_channel', true);
        const announceChannel = interaction.options.getChannel('announce_channel');
        const mentionEveryone = interaction.options.getBoolean('mention_everyone');

        await db.client.quizConfig.upsert({
          where: { guildId: interaction.guildId },
          update: {
            quizChannelId: quizChannel.id,
            announceChannelId: announceChannel?.id || null,
            mentionEveryone: mentionEveryone || false,
            updatedAt: new Date(),
          },
          create: {
            guildId: interaction.guildId,
            quizChannelId: quizChannel.id,
            announceChannelId: announceChannel?.id || null,
            mentionEveryone: mentionEveryone || false,
          },
        });

        await interaction.reply({ content: 'Configuration enregistrée ✅', ephemeral: true });
        return;
      }

      // -- Configuration des récompenses --
      if (sub === 'rewards') {
        const winnerRole = interaction.options.getRole('winner_role');
        const durationDays = interaction.options.getInteger('duration_days');
        const message = interaction.options.getString('message');
        const active = interaction.options.getBoolean('active');

        if (winnerRole === null && durationDays === null && message === null && active === null) {
          await interaction.reply({
            content: 'Aucune configuration de récompense trouvée. (Fonctionnalité en développement)',
            ephemeral: true,
          });
          return;
        }

        await interaction.reply({
          content: 'Configuration des récompenses en cours de développement. Utilisez les rôles temporaires avec /give-temp-role.',
          ephemeral: true,
        });
        return;
      }

      // -- Système de points --
      if (sub === 'points') {
        const pointsEmbed = new EmbedBuilder()
          .setColor(0x00aaff)
          .setTitle('📊 Système de Points du Quiz')
          .setDescription('**Le scoring est basé sur la difficulté et la vitesse de réponse**')
          .addFields(
            {
              name: '🎯 Points de Base',
              value: '🟢 **Facile**: 10 points\n🟡 **Moyen**: 15 points\n🔴 **Difficile**: 25 points',
              inline: true,
            },
            {
              name: '⚡ Bonus Vitesse',
              value: '**0-2s**: +50% des points\n**2-10s**: +30% → +10% (dégressif)\n**10-30s**: +5% → 0% (dégressif)\n**30s+**: Aucun bonus',
              inline: true,
            },
            {
              name: "🏆 Départage en cas d'égalité",
              value: '1️⃣ **Score total**\n2️⃣ **Nombre de bonnes réponses**\n3️⃣ **Temps de réponse moyen**',
              inline: false,
            },
            {
              name: '📈 Exemples de Scores',
              value:
                '**Question difficile (25pts) répondue en 1s**: 37.5pts\n**Question facile (10pts) répondue en 5s**: 12pts\n**Question moyenne (15pts) répondue en 25s**: 15.4pts',
              inline: false,
            }
          )
          .setFooter({ text: 'Plus vous êtes rapide et précis, plus vous gagnez de points !' });

        await interaction.reply({ embeds: [pointsEmbed], ephemeral: true });
        return;
      }

      // -- Lancer un quiz immédiat --
      if (sub === 'start') {
        const theme = interaction.options.getString('theme');
        const count = interaction.options.getInteger('count') || 20;
        const difficulty = interaction.options.getString('difficulty') || 'all';

        const cfg = await db.client.quizConfig.findUnique({
          where: { guildId: interaction.guildId },
        });

        if (!cfg?.quizChannelId) {
          await interaction.reply({ content: 'Canal de quiz non configuré.', ephemeral: true });
          return;
        }

        const quizChannel = await interaction.client.channels.fetch(cfg.quizChannelId).catch(() => null);
        if (!quizChannel || !quizChannel.isTextBased()) {
          await interaction.reply({ content: 'Canal de quiz introuvable ou inaccessible.', ephemeral: true });
          return;
        }

        const title = theme ? `Quiz Thème: ${theme.toUpperCase()}` : 'Quiz Développeur';
        const difficultyNames: Record<string, string> = {
          all: 'Toute',
          easy: 'Facile',
          medium: 'Medium',
          hard: 'Difficile',
        };

        const channelName = 'isTextBased' in quizChannel ? (quizChannel as any).name || 'quiz' : 'quiz';
        const rules = new EmbedBuilder()
          .setColor(0x0099ff)
          .setTitle(`📣 ${title}`)
          .setDescription(
            `Le quiz commence dans 5 minutes sur **#${channelName}**. Tapez \`!participe\` pour vous inscrire. Répondez avec les lettres (A,B,C,D) ou chiffres (1,2,3,4). Plusieurs réponses possibles selon la question.`
          )
          .addFields(
            {
              name: 'Règles',
              value: '1. Pas de spam\n2. 1 ou plusieurs réponses par question\n3. Respect et fair-play',
            },
            {
              name: 'Configuration',
              value: `📝 **${count} questions**\n🎯 **Difficulté :** ${difficultyNames[difficulty]}`,
              inline: true,
            },
            { name: 'Début', value: '⏱️ 5 minutes', inline: true }
          );

        // Envoyer l'annonce dans le canal d'annonce si configuré
        const announceChannel = cfg.announceChannelId
          ? await interaction.client.channels.fetch(cfg.announceChannelId).catch(() => null)
          : null;

        if (announceChannel && 'send' in announceChannel && announceChannel.isTextBased()) {
          await (announceChannel as any).send({
            content: cfg.mentionEveryone ? '@everyone' : undefined,
            embeds: [rules],
          });
        }
        if ('send' in quizChannel) {
          await (quizChannel as any).send({ embeds: [rules] });
        }

        // Annuler les sessions en cours
        await db.client.quizSession.updateMany({
          where: {
            guildId: interaction.guildId,
            channelId: cfg.quizChannelId,
            status: { in: ['announced', 'running', 'scheduled'] },
          },
          data: {
            status: 'cancelled',
            updatedAt: new Date(),
          },
        });

        // Créer la nouvelle session
        const now = new Date();
        const startAt = new Date(now.getTime() + 5 * 60 * 1000);

        const session = await db.client.quizSession.create({
          data: {
            guildId: interaction.guildId,
            channelId: cfg.quizChannelId,
            themeSlug: theme || null,
            questionCount: count,
            startAt,
            status: 'scheduled',
            createdAt: now,
            updatedAt: now,
          },
        });

        // Programmer les rappels de countdown
        scheduleCountdownReminders(interaction.client, Number(session.id), quizChannel, startAt);

        await interaction.reply({ content: 'Quiz programmé dans 5 minutes ✅', ephemeral: true });
        return;
      }

      // -- Programmer un quiz --
      if (sub === 'schedule') {
        const theme = interaction.options.getString('theme');
        const dt = interaction.options.getString('datetime', true);

        const cfg = await db.client.quizConfig.findUnique({
          where: { guildId: interaction.guildId },
        });

        if (!cfg?.quizChannelId) {
          await interaction.reply({ content: 'Canal de quiz non configuré.', ephemeral: true });
          return;
        }

        // Annuler les sessions existantes
        await db.client.quizSession.updateMany({
          where: {
            guildId: interaction.guildId,
            channelId: cfg.quizChannelId,
            status: { in: ['announced', 'running', 'scheduled'] },
          },
          data: {
            status: 'cancelled',
            updatedAt: new Date(),
          },
        });

        // Créer la session programmée
        await db.client.quizSession.create({
          data: {
            guildId: interaction.guildId,
            channelId: cfg.quizChannelId,
            themeSlug: theme || null,
            questionCount: 20,
            startAt: new Date(dt),
            status: 'scheduled',
            createdAt: new Date(),
            updatedAt: new Date(),
          },
        });

        await interaction.reply({ content: 'Quiz programmé ✅', ephemeral: true });
        return;
      }

      await interaction.reply({ content: 'Sous-commande inconnue.', ephemeral: true });
    } catch (e) {
      log.error('quiz command error:', e);
      await interaction.reply({ content: 'Erreur lors du traitement.', ephemeral: true });
    }
  },

  async autocomplete(interaction: any): Promise<void> {
    const focusedOption = interaction.options.getFocused(true);

    if (focusedOption.name === 'theme') {
      try {
        const themes = await db.client.$queryRaw<Array<{ slug: string; name: string; question_count: number }>>`
          SELECT t.slug, t.name, COUNT(q.id) as question_count
          FROM quiz_themes t
          LEFT JOIN quiz_questions q ON q.theme_id = t.id AND q.is_active = 1
          WHERE t.is_active = 1
          GROUP BY t.id, t.slug, t.name
          HAVING question_count > 0
          ORDER BY t.name ASC
        `;

        const filtered = themes
          .filter(
            (theme: any) =>
              theme.name.toLowerCase().includes(focusedOption.value.toLowerCase()) ||
              theme.slug.toLowerCase().includes(focusedOption.value.toLowerCase())
          )
          .slice(0, 25);

        const choices = filtered.map((theme: any) => ({
          name: `${theme.name} (${theme.question_count} questions)`,
          value: theme.slug,
        }));

        await interaction.respond(choices);
      } catch (error) {
        log.error('Autocomplete error:', error);
        await interaction.respond([]);
      }
    }
  },
};
