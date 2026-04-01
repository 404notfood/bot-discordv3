import {
  GuildMember,
  EmbedBuilder,
  TextChannel,
} from 'discord.js';
import { db } from '../services/database';
import { log } from '../services/logger';
import { BotEvent } from '../types/event';

// ============================================================
// Phrases d'accroche aleatoires (style dev)
// ============================================================

const WELCOME_TITLES = [
  'Un nouveau dev a rejoint le repo !',
  'git pull --new-member',
  'Nouveau commit sur le serveur !',
  'npm install nouveau-membre',
  'Un nouveau process vient de spawn !',
  'Connection established !',
  'Nouvelle pull request detectee !',
  'Un nouveau thread a ete cree !',
  'sudo useradd --group devs',
  'Build successful : nouveau membre !',
  'Un nouveau container vient de start !',
  'Merge request acceptee !',
  'Deploiement en cours...',
  'Nouvelle instance detectee !',
  'Le compilateur a trouve un nouveau dev !',
  'Un nouveau pixel vient de render !',
  'Handshake reussi !',
  'Socket connecte !',
  'Le serveur scale up !',
  'Nouveau fork du serveur !',
];

const WELCOME_SUBTITLES = [
  '{username} commence a coder ici !',
  '{username} a push son premier commit !',
  '{username} vient de fork le serveur !',
  '{username} a rejoint la team !',
  '{username} est entre dans la matrice !',
  '{username} a deploye son profil !',
  '{username} a lance son premier build !',
  '{username} vient de merge !',
  '{username} a ouvert son premier terminal ici !',
  '{username} est passe en production !',
  '{username} a reussi le handshake !',
  '{username} a clone le serveur avec succes !',
  '{username} est maintenant en mode debug !',
  '{username} vient de docker compose up !',
  '{username} a boot sur le serveur !',
];

// Une chance sur 4 d'avoir une blague dev a la place
const DEV_JOKES = [
  'Pourquoi les developpeurs confondent Halloween et Noel ? Parce que Oct 31 == Dec 25.',
  'Il y a 10 types de personnes : celles qui comprennent le binaire et les autres.',
  'Un QA entre dans un bar. Il commande 1 biere. 0 biere. 99999 bieres. -1 biere. Un lezard.',
  'Pourquoi les devs Java portent des lunettes ? Parce qu\'ils ne C# pas.',
  'Un developpeur mass-delete sa prod un vendredi. On ne l\'a jamais revu.',
  '!false, c\'est funny parce que c\'est true.',
  'Les 3 problemes les plus durs en informatique : nommer les choses, l\'invalidation de cache, et les off-by-one errors.',
  'Le wifi de ma grand-mere s\'appelle "Martin Router King".',
  'Un commit un vendredi a 17h55 ? J\'aime vivre dangereusement.',
  'CSS c\'est facile. Centrer un div, ca par contre...',
  '"Ca marche sur ma machine" - Le dev, juste avant le desastre.',
  'Mon code n\'a pas de bugs, il a des features non documentees.',
  'La definition de la folie : relancer npm install en esperant un resultat different.',
  'Le meilleur debugger au monde : console.log("ICI").',
  'Un jour j\'ai mis un point-virgule en Python. Le compilateur a pleure.',
  'J\'ai mass-supprime node_modules. J\'ai libere 47 Go.',
  'Chers recruteurs, "junior avec 5 ans d\'experience" n\'existe pas.',
  'Le README dit "installation facile". 3 heures plus tard...',
  'Mon code est auto-documente. Personne ne le comprend, moi y compris.',
  'git commit -m "fix" pour la 47e fois.',
];

// ============================================================
// Helpers
// ============================================================

function pick<T>(arr: T[]): T {
  return arr[Math.floor(Math.random() * arr.length)];
}

function getWelcomeTitle(): string {
  return pick(WELCOME_TITLES);
}

function getWelcomeSubtitle(username: string): string {
  return pick(WELCOME_SUBTITLES).replace('{username}', username);
}

function maybeDevJoke(): string | null {
  // 1 chance sur 4
  if (Math.random() < 0.25) {
    return pick(DEV_JOKES);
  }
  return null;
}

// ============================================================
// Event
// ============================================================

const guildMemberAddEvent: BotEvent = {
  name: 'guildMemberAdd',
  once: false,

  async execute(member: GuildMember) {
    if (member.user.bot) return;

    try {
      const config = await db.client.guildConfig.findUnique({
        where: { guildId: member.guild.id },
      });

      if (!config) return;

      // ---------------------------------------------------------------
      // 1. Attribuer le role "Nouvel utilisateur" si configure
      // ---------------------------------------------------------------
      if (config.autoRoles && config.autoRoleId) {
        try {
          const role = member.guild.roles.cache.get(config.autoRoleId);
          if (role) {
            await member.roles.add(role, 'Nouvel utilisateur - attribution automatique');
            log.service('Welcome', `Role "${role.name}" attribue a ${member.user.tag}`);
          } else {
            log.warn(`Welcome: Role auto ${config.autoRoleId} introuvable sur ${member.guild.name}`);
          }
        } catch (err) {
          log.error('Welcome: Erreur attribution role auto', { error: err });
        }
      }

      // ---------------------------------------------------------------
      // 2. Envoyer le message de bienvenue dans le canal
      // ---------------------------------------------------------------
      if (!config.welcomeMessages || !config.welcomeChannelId) return;

      const channel = member.guild.channels.cache.get(config.welcomeChannelId);
      if (!channel || !(channel instanceof TextChannel)) {
        log.warn(`Welcome: Canal ${config.welcomeChannelId} introuvable sur ${member.guild.name}`);
        return;
      }

      const username = member.user.globalName || member.user.username;
      const title = getWelcomeTitle();
      const subtitle = getWelcomeSubtitle(username);
      const joke = maybeDevJoke();

      // Texte au-dessus de l'embed : phrase random + username
      const topText = `**${title}**\n\n${subtitle}`;

      // Embed minimaliste - style Dark Chuch
      const embed = new EmbedBuilder()
        .setColor(0xE67E22)
        .setThumbnail(member.user.displayAvatarURL({ size: 256 }))
        .setDescription(
          [
            `# Bienvenue`,
            `sur le serveur Discord`,
            `**${member.guild.name}**`,
            joke ? `\n> *${joke}*` : '',
          ].filter(Boolean).join('\n')
        );

      await channel.send({ content: topText, embeds: [embed] });

      log.service('Welcome', `Bienvenue envoye pour ${member.user.tag} sur ${member.guild.name}`);
    } catch (error) {
      log.error('Welcome: Erreur guildMemberAdd', { error, guild: member.guild.id });
    }
  },
};

export default guildMemberAddEvent;
