import axios, { AxiosError } from 'axios';
import { Client, EmbedBuilder, TextChannel } from 'discord.js';
import { log } from './logger';
import { db } from './database';
import { sleep } from '../utils/sleep';

// ---------------------------------------------------------------------------
// Interfaces
// ---------------------------------------------------------------------------

interface FranceTravailToken {
  access_token: string;
  expires_in: number;
  token_type: string;
}

interface FranceTravailOffer {
  id: string;
  intitule: string;
  description?: string;
  dateCreation: string;
  dateActualisation?: string;
  lieuTravail?: {
    libelle?: string;
    latitude?: number;
    longitude?: number;
    codePostal?: string;
    commune?: string;
  };
  entreprise?: {
    nom?: string;
    description?: string;
    logo?: string;
    url?: string;
  };
  typeContrat?: string;
  typeContratLibelle?: string;
  natureContrat?: string;
  experienceExige?: string;
  experienceLibelle?: string;
  salaire?: {
    libelle?: string;
    complement1?: string;
    complement2?: string;
  };
  alternance?: boolean;
  competences?: Array<{
    code?: string;
    libelle?: string;
    exigence?: string;
  }>;
  qualitesProfessionnelles?: Array<{
    libelle?: string;
    description?: string;
  }>;
  origineOffre?: {
    origine?: string;
    urlOrigine?: string;
    partenaires?: Array<{ nom?: string; url?: string }>;
  };
  offresManqueCandidats?: boolean;
  secteurActivite?: string;
  secteurActiviteLibelle?: string;
  qualificationCode?: string;
  qualificationLibelle?: string;
  codeNAF?: string;
  appellationlibelle?: string;
  dureeTravailLibelle?: string;
  dureeTravailLibelleConverti?: string;
  formations?: Array<{
    domaineLibelle?: string;
    niveauLibelle?: string;
    commentaire?: string;
    exigence?: string;
  }>;
  langues?: Array<{ libelle?: string; exigence?: string }>;
  permis?: Array<{ libelle?: string; exigence?: string }>;
  contact?: {
    nom?: string;
    coordonnees1?: string;
    coordonnees2?: string;
    coordonnees3?: string;
    telephone?: string;
    courriel?: string;
    commentaire?: string;
    urlPostulation?: string;
    urlRecruteur?: string;
  };
  nombrePostes?: number;
  accessibleTH?: boolean;
  romeCode?: string;
  romeLibelle?: string;
  deplacementCode?: string;
  deplacementLibelle?: string;
  agence?: {
    courriel?: string;
    telephone?: string;
  };
}

interface FranceTravailSearchResponse {
  resultats: FranceTravailOffer[];
  filtresPossibles?: any[];
}

interface JobOfferConfig {
  id: number;
  guildId: string;
  channelId: string | null;
  isActive: boolean;
  keywords: string;
  departments: string | null;
  contractTypes: string;
  includeRemote: boolean;
  pollInterval: number;
  maxOffersPerPoll: number;
}

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const DEV_ROME_CODES = [
  'M1805', // Etudes et developpement informatique
  'M1802', // Expertise et support en systemes d'information
  'M1810', // Production et exploitation de systemes d'information
  'M1806', // Conseil et maitrise d'ouvrage en systemes d'information
  'M1801', // Administration de systemes d'information
];

const DEV_KEYWORDS_FILTER = [
  'developpeur', 'développeur', 'developer',
  'dev ', 'dev/', 'devops',
  'programmeur', 'programmer',
  'fullstack', 'full-stack', 'full stack',
  'frontend', 'front-end', 'front end',
  'backend', 'back-end', 'back end',
  'javascript', 'typescript', 'react', 'vue', 'angular', 'node',
  'python', 'java', 'php', 'c#', '.net', 'ruby', 'go ', 'golang', 'rust',
  'mobile', 'ios', 'android', 'flutter', 'react native',
  'web ', 'logiciel', 'software',
  'integrateur', 'intégrateur',
  'data engineer', 'data analyst',
];

// ---------------------------------------------------------------------------
// Service
// ---------------------------------------------------------------------------

export class JobOffersService {
  private client: Client | null = null;
  private accessToken: string | null = null;
  private tokenExpiry = 0;
  private pollIntervals = new Map<string, NodeJS.Timeout>();
  private initialized = false;

  private readonly TOKEN_URL =
    'https://entreprise.francetravail.fr/connexion/oauth2/access_token?realm=/partenaire';
  private readonly API_BASE =
    'https://api.francetravail.io/partenaire/offresdemploi/v2';

  // =====================================================================
  // INITIALIZATION
  // =====================================================================

  async initialize(client: Client): Promise<void> {
    if (this.initialized) return;

    this.client = client;

    if (process.env.ENABLE_JOB_OFFERS === 'false') {
      log.info('JobOffersService: disabled by ENABLE_JOB_OFFERS=false');
      return;
    }

    const clientId = process.env.FRANCE_TRAVAIL_CLIENT_ID;
    const clientSecret = process.env.FRANCE_TRAVAIL_CLIENT_SECRET;

    if (!clientId || !clientSecret) {
      log.warn(
        'JobOffersService: FRANCE_TRAVAIL_CLIENT_ID or FRANCE_TRAVAIL_CLIENT_SECRET missing. Service disabled.',
      );
      return;
    }

    try {
      await this.authenticate();
      log.service('JobOffersService', 'initialized successfully');

      await this.startAllPolls();
      this.initialized = true;
    } catch (error) {
      const err = error as Error;
      log.error('JobOffersService: initialization error', { error: err.message });
    }
  }

  // =====================================================================
  // OAUTH2 AUTHENTICATION
  // =====================================================================

  private async authenticate(): Promise<string> {
    // Reuse valid token
    if (this.accessToken && Date.now() < this.tokenExpiry - 60_000) {
      return this.accessToken;
    }

    const clientId = process.env.FRANCE_TRAVAIL_CLIENT_ID;
    const clientSecret = process.env.FRANCE_TRAVAIL_CLIENT_SECRET;

    if (!clientId || !clientSecret) {
      throw new Error('France Travail credentials missing');
    }

    try {
      const response = await axios.post<FranceTravailToken>(
        this.TOKEN_URL,
        new URLSearchParams({
          grant_type: 'client_credentials',
          client_id: clientId,
          client_secret: clientSecret,
          scope: 'api_offresdemploiv2 o2dsoffre',
        }).toString(),
        { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } },
      );

      this.accessToken = response.data.access_token;
      this.tokenExpiry = Date.now() + response.data.expires_in * 1000;

      log.debug('JobOffersService: OAuth2 token obtained');
      return this.accessToken;
    } catch (error) {
      const err = error as AxiosError;
      log.error('JobOffersService: OAuth2 authentication error', {
        status: err.response?.status,
        data: err.response?.data,
        message: err.message,
      });
      throw new Error("Unable to authenticate with France Travail");
    }
  }

  // =====================================================================
  // SEARCH
  // =====================================================================

  async searchOffers(config: JobOfferConfig): Promise<FranceTravailOffer[]> {
    const token = await this.authenticate();

    const keywords = config.keywords
      .split(',')
      .map((k) => k.trim())
      .filter((k) => k.length > 0);

    const allOffers: FranceTravailOffer[] = [];

    for (const keyword of keywords) {
      try {
        const params: Record<string, string> = {
          motsCles: keyword,
          range: '0-14',
          publieeDepuis: '14',
        };

        if (config.contractTypes) params.typeContrat = config.contractTypes;
        if (config.departments) params.departement = config.departments;

        const response = await axios.get<FranceTravailSearchResponse>(
          `${this.API_BASE}/offres/search`,
          {
            params,
            headers: {
              Authorization: `Bearer ${token}`,
              Accept: 'application/json',
            },
          },
        );

        if (response.data.resultats) {
          allOffers.push(...response.data.resultats);
        }

        // Respect the rate limit (3 req/sec)
        await sleep(350);
      } catch (error) {
        const err = error as AxiosError;
        if (err.response?.status !== 204) {
          log.warn(`JobOffersService: search error for "${keyword}" ${err.message}`, {
            status: err.response?.status,
            data: err.response?.data,
          });
        }
      }
    }

    // Deduplicate
    const uniqueOffers = this.deduplicateOffers(allOffers);

    // Filter to keep only dev-related offers
    const filteredOffers = uniqueOffers.filter((offer) => this.isDevOffer(offer));

    // Sort by creation date (newest first)
    filteredOffers.sort(
      (a, b) => new Date(b.dateCreation).getTime() - new Date(a.dateCreation).getTime(),
    );

    return filteredOffers;
  }

  private isDevOffer(offer: FranceTravailOffer): boolean {
    const searchText = [
      offer.intitule,
      offer.description,
      offer.appellationlibelle,
      offer.romeLibelle,
      offer.secteurActiviteLibelle,
      ...(offer.competences?.map((c) => c.libelle) || []),
    ]
      .filter(Boolean)
      .join(' ')
      .toLowerCase();

    return DEV_KEYWORDS_FILTER.some((keyword) =>
      searchText.includes(keyword.toLowerCase()),
    );
  }

  private deduplicateOffers(offers: FranceTravailOffer[]): FranceTravailOffer[] {
    const seen = new Set<string>();
    return offers.filter((offer) => {
      if (seen.has(offer.id)) return false;
      seen.add(offer.id);
      return true;
    });
  }

  // =====================================================================
  // DISCORD POSTING
  // =====================================================================

  async postNewOffers(guildId: string): Promise<number> {
    if (!this.client) throw new Error('Discord client not initialized');

    const prisma = db.client;

    const config = (await prisma.jobOfferConfig.findUnique({
      where: { guildId },
    })) as JobOfferConfig | null;

    if (!config || !config.isActive || !config.channelId) return 0;

    const channel = await this.client.channels.fetch(config.channelId).catch(() => null);
    if (!channel || !(channel instanceof TextChannel)) {
      log.warn(`JobOffersService: channel ${config.channelId} not found or invalid`);
      return 0;
    }

    const offers = await this.searchOffers(config);
    if (offers.length === 0) {
      log.debug('JobOffersService: no new offers found');
      return 0;
    }

    // Filter out already-posted offers
    const postedOfferIds = await prisma.jobOfferPosted.findMany({
      where: { guildId, offerId: { in: offers.map((o) => o.id) } },
      select: { offerId: true },
    });

    const postedSet = new Set(postedOfferIds.map((p) => p.offerId));
    const newOffers = offers.filter((o) => !postedSet.has(o.id));

    if (newOffers.length === 0) {
      log.debug('JobOffersService: all offers already posted');
      return 0;
    }

    const offersToPost = newOffers.slice(0, config.maxOffersPerPoll);
    let posted = 0;

    for (const offer of offersToPost) {
      try {
        const embed = this.buildOfferEmbed(offer);
        const message = await channel.send({ embeds: [embed] });

        await prisma.jobOfferPosted.create({
          data: {
            guildId,
            offerId: offer.id,
            title: offer.intitule.substring(0, 500),
            company: offer.entreprise?.nom || null,
            location: offer.lieuTravail?.libelle || null,
            contractType: offer.typeContratLibelle || offer.typeContrat || null,
            messageId: message.id,
          },
        });

        posted++;

        // Small delay between messages to avoid spam
        await sleep(1000);
      } catch (error) {
        const err = error as Error;
        log.error(`JobOffersService: error posting offer ${offer.id}`, {
          error: err.message,
        });
      }
    }

    if (posted > 0) {
      log.service('JobOffersService', `${posted} offer(s) posted`, { guildId });
    }

    return posted;
  }

  private buildOfferEmbed(offer: FranceTravailOffer): EmbedBuilder {
    const embed = new EmbedBuilder()
      .setColor(0x0066cc)
      .setTitle(`💼 ${offer.intitule}`)
      .setTimestamp(new Date(offer.dateCreation));

    const company = offer.entreprise?.nom || 'Entreprise confidentielle';
    embed.setAuthor({ name: company });

    if (offer.description) {
      const desc =
        offer.description.length > 400
          ? offer.description.substring(0, 397) + '...'
          : offer.description;
      embed.setDescription(desc);
    }

    const fields: Array<{ name: string; value: string; inline: boolean }> = [];

    if (offer.lieuTravail?.libelle) {
      fields.push({ name: '📍 Localisation', value: offer.lieuTravail.libelle, inline: true });
    }

    if (offer.typeContratLibelle) {
      fields.push({ name: '📄 Contrat', value: offer.typeContratLibelle, inline: true });
    }

    if (offer.salaire?.libelle) {
      fields.push({ name: '💰 Salaire', value: offer.salaire.libelle, inline: true });
    }

    if (offer.experienceLibelle) {
      fields.push({ name: '🎓 Experience', value: offer.experienceLibelle, inline: true });
    }

    if (offer.dureeTravailLibelleConverti) {
      fields.push({ name: '⏰ Duree', value: offer.dureeTravailLibelleConverti, inline: true });
    }

    if (offer.competences && offer.competences.length > 0) {
      const skills = offer.competences
        .slice(0, 8)
        .map((c) => `\`${c.libelle}\``)
        .join(' ');
      fields.push({ name: '🛠️ Competences', value: skills, inline: false });
    }

    if (offer.formations && offer.formations.length > 0) {
      const formations = offer.formations
        .map((f) =>
          [f.niveauLibelle, f.domaineLibelle].filter(Boolean).join(' - '),
        )
        .filter((f) => f.length > 0)
        .join('\n');
      if (formations) {
        fields.push({ name: '🎓 Formation', value: formations, inline: false });
      }
    }

    embed.addFields(fields);

    const applyUrl =
      offer.contact?.urlPostulation ||
      offer.contact?.urlRecruteur ||
      offer.origineOffre?.urlOrigine ||
      `https://candidat.francetravail.fr/offres/recherche/detail/${offer.id}`;

    embed.addFields({
      name: '🔗 Postuler',
      value: `[Voir l'offre complete](${applyUrl})`,
      inline: false,
    });

    embed.setFooter({ text: `France Travail | ID: ${offer.id}` });

    if (offer.entreprise?.logo) {
      embed.setThumbnail(offer.entreprise.logo);
    }

    return embed;
  }

  // =====================================================================
  // POLLING
  // =====================================================================

  async startAllPolls(): Promise<void> {
    const prisma = db.client;

    try {
      const configs = (await prisma.jobOfferConfig.findMany({
        where: { isActive: true },
      })) as JobOfferConfig[];

      for (const config of configs) {
        this.startPoll(config.guildId, config.pollInterval);
      }

      if (configs.length > 0) {
        log.service('JobOffersService', `${configs.length} poll(s) started`);
      }
    } catch (error) {
      const err = error as Error;
      log.error('JobOffersService: error starting polls', { error: err.message });
    }
  }

  startPoll(guildId: string, intervalMinutes: number): void {
    this.stopPoll(guildId);

    const intervalMs = intervalMinutes * 60 * 1000;

    // First poll after 10 seconds (let the bot stabilize)
    setTimeout(async () => {
      await this.executePoll(guildId);
    }, 10_000);

    // Then at regular intervals
    const interval = setInterval(async () => {
      await this.executePoll(guildId);
    }, intervalMs);

    this.pollIntervals.set(guildId, interval);
    log.debug(
      `JobOffersService: poll started for guild ${guildId} (every ${intervalMinutes} min)`,
    );
  }

  stopPoll(guildId: string): void {
    const existing = this.pollIntervals.get(guildId);
    if (existing) {
      clearInterval(existing);
      this.pollIntervals.delete(guildId);
      log.debug(`JobOffersService: poll stopped for guild ${guildId}`);
    }
  }

  private async executePoll(guildId: string): Promise<void> {
    try {
      const posted = await this.postNewOffers(guildId);
      if (posted > 0) {
        log.info(
          `JobOffersService: ${posted} new offer(s) posted for guild ${guildId}`,
        );
      }
    } catch (error) {
      const err = error as Error;
      log.error(`JobOffersService: poll error for guild ${guildId}`, {
        error: err.message,
      });
    }
  }

  // =====================================================================
  // CONFIG MANAGEMENT
  // =====================================================================

  async getConfig(guildId: string): Promise<JobOfferConfig | null> {
    return (await db.client.jobOfferConfig.findUnique({
      where: { guildId },
    })) as JobOfferConfig | null;
  }

  async setupConfig(guildId: string, channelId: string): Promise<JobOfferConfig> {
    const config = (await db.client.jobOfferConfig.upsert({
      where: { guildId },
      update: { channelId, isActive: true },
      create: { guildId, channelId, isActive: true },
    })) as JobOfferConfig;

    this.startPoll(guildId, config.pollInterval);
    return config;
  }

  async updateConfig(
    guildId: string,
    updates: Partial<
      Pick<
        JobOfferConfig,
        | 'keywords'
        | 'departments'
        | 'contractTypes'
        | 'includeRemote'
        | 'pollInterval'
        | 'maxOffersPerPoll'
        | 'isActive'
      >
    >,
  ): Promise<JobOfferConfig> {
    const config = (await db.client.jobOfferConfig.update({
      where: { guildId },
      data: updates,
    })) as JobOfferConfig;

    if (config.isActive && config.channelId) {
      this.startPoll(config.guildId, config.pollInterval);
    } else {
      this.stopPoll(guildId);
    }

    return config;
  }

  async disableConfig(guildId: string): Promise<void> {
    await db.client.jobOfferConfig.update({
      where: { guildId },
      data: { isActive: false },
    });
    this.stopPoll(guildId);
  }

  async getStats(
    guildId: string,
  ): Promise<{ totalPosted: number; todayPosted: number; lastPosted: Date | null }> {
    const prisma = db.client;

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const [totalPosted, todayPosted, lastOffer] = await Promise.all([
      prisma.jobOfferPosted.count({ where: { guildId } }),
      prisma.jobOfferPosted.count({
        where: { guildId, postedAt: { gte: today } },
      }),
      prisma.jobOfferPosted.findFirst({
        where: { guildId },
        orderBy: { postedAt: 'desc' },
        select: { postedAt: true },
      }),
    ]);

    return {
      totalPosted,
      todayPosted,
      lastPosted: lastOffer?.postedAt || null,
    };
  }

  // =====================================================================
  // CLEANUP
  // =====================================================================

  async cleanup(): Promise<void> {
    for (const [guildId] of this.pollIntervals) {
      this.stopPoll(guildId);
    }
    this.pollIntervals.clear();
    this.accessToken = null;
    this.initialized = false;
    log.service('JobOffersService', 'cleaned up');
  }
}

// Singleton
export const jobOffersService = new JobOffersService();
