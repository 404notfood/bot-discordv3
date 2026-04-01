import { SlashCommandBuilder, ChatInputCommandInteraction, EmbedBuilder } from 'discord.js';
import { db } from '../../services/database';
import { log } from '../../services/logger';

export default {
  data: new SlashCommandBuilder()
    .setName('sql-clinic')
    .setDescription('🎯 Séries de requêtes SQL à résoudre - Entraînement interactif')
    .addSubcommand((sub) =>
      sub
        .setName('start')
        .setDescription('🚀 Lancer un exercice SQL')
        .addStringOption((o) =>
          o
            .setName('dataset')
            .setDescription("Choisir un dataset d'entraînement")
            .setRequired(true)
            .setAutocomplete(true)
        )
    )
    .addSubcommand((sub) => sub.setName('help').setDescription('❓ Aide et explications sur SQL Clinic')),

  async execute(interaction: ChatInputCommandInteraction): Promise<void> {
    const sub = interaction.options.getSubcommand();

    try {
      // -- Lancer un exercice SQL --
      if (sub === 'start') {
        const dataset = interaction.options.getString('dataset', true);

        const ds = await db.client.$queryRaw<Array<any>>`
          SELECT * FROM sql_clinic_datasets WHERE slug = ${dataset} LIMIT 1
        `.then((r: any) => r[0]);

        if (!ds) {
          await interaction.reply({
            content: "❌ Dataset introuvable. Utilisez l'autocomplétion pour voir les datasets disponibles.",
            ephemeral: true,
          });
          return;
        }

        const tasks = await db.client.$queryRaw<Array<any>>`
          SELECT slug, title, description, points FROM sql_clinic_tasks
          WHERE dataset_id = ${ds.id} ORDER BY points ASC, id ASC
        `;

        if (tasks.length === 0) {
          await interaction.reply({
            content: `❌ Aucune tâche disponible pour le dataset "${ds.name}".`,
            ephemeral: true,
          });
          return;
        }

        const embed = new EmbedBuilder()
          .setColor(0x00aaff)
          .setTitle(`🎯 SQL Clinic — ${ds.name}`)
          .setDescription(
            `${ds.description || ''}\n\n💡 **Comment jouer :**\n\`/sql-clinic solve task:[slug] sql:[votre requête]\``
          )
          .setThumbnail('https://cdn-icons-png.flaticon.com/512/2772/2772128.png')
          .addFields(
            tasks.map((t: any, i: number) => ({
              name: `${i + 1}. ${t.title} (${t.points} pts)`,
              value: `🏷️ \`${t.slug}\`\n📝 ${t.description || 'Aucune description'}`,
              inline: false,
            }))
          )
          .setFooter({ text: `${tasks.length} défis disponibles • Tapez les commandes pour plus d'aide` });

        await interaction.reply({ embeds: [embed] });
        return;
      }

      // -- Aide sur SQL Clinic --
      if (sub === 'help') {
        const embed = new EmbedBuilder()
          .setColor(0x9c27b0)
          .setTitle('🏥 SQL Challenge - Comment jouer ?')
          .setDescription('**Apprenez SQL avec le système de la clinique !**')
          .addFields(
            {
              name: "🎯 Comment s'inscrire",
              value: '`!challenge` dans le canal de challenge\nPour rejoindre la semaine active',
              inline: false,
            },
            {
              name: '💡 Obtenir un indice',
              value: '`!indice` en message privé ou dans le canal\nPour recevoir un indice sur la question actuelle',
              inline: false,
            },
            {
              name: '✅ Soumettre une réponse',
              value: '`!reponse SELECT * FROM patient;`\nPour valider votre requête SQL',
              inline: false,
            },
            {
              name: '📊 Fonctionnement',
              value:
                '• **Progression automatique** : 20 questions par semaine\n• **7 semaines** de difficulté croissante\n• **Points** selon la complexité des questions\n• **Indices illimités** pour vous aider',
              inline: false,
            },
            {
              name: '🏆 Semaines disponibles',
              value:
                '1️⃣ Sélections simples (Débutant)\n2️⃣ Fonctions et tri (Débutant)\n3️⃣ Jointures simples (Intermédiaire)\n4️⃣ Requêtes avancées (Intermédiaire)\n5️⃣ Jointures avancées (Avancé)\n6️⃣ Optimisation et vues (Avancé)\n7️⃣ Cas d\'usage experts (Avancé)',
              inline: false,
            }
          )
          .setFooter({ text: 'Amusez-vous bien en apprenant SQL avec la clinique !' });

        await interaction.reply({ embeds: [embed], ephemeral: true });
        return;
      }

      await interaction.reply({ content: 'Sous-commande inconnue.', ephemeral: true });
    } catch (e) {
      log.error('sql-clinic error:', e);
      await interaction.reply({ content: 'Erreur interne.', ephemeral: true });
    }
  },

  async autocomplete(interaction: any): Promise<void> {
    const focusedOption = interaction.options.getFocused(true);

    if (focusedOption.name === 'dataset') {
      try {
        const datasets = await db.client.$queryRaw<
          Array<{ slug: string; name: string; description: string | null }>
        >`
          SELECT slug, name, description FROM sql_clinic_datasets WHERE is_active = 1 ORDER BY id ASC
        `;

        const filtered = datasets
          .filter(
            (dataset: any) =>
              dataset.slug.toLowerCase().includes(focusedOption.value.toLowerCase()) ||
              dataset.name.toLowerCase().includes(focusedOption.value.toLowerCase())
          )
          .slice(0, 25);

        const choices = filtered.map((dataset: any) => ({
          name: `${dataset.name} (${dataset.slug})`,
          value: dataset.slug,
        }));

        await interaction.respond(choices);
      } catch (error) {
        log.error('SQL Clinic autocomplete error:', error);
        await interaction.respond([]);
      }
    }
  },
};
