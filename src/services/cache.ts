import { log } from './logger';

/**
 * Entree individuelle dans le cache.
 */
interface CacheEntry<T> {
  data: T;
  expiry: number;
  createdAt: number;
}

/**
 * Statistiques du cache.
 */
export interface CacheStats {
  /** Nombre d'entrees actuellement en cache */
  size: number;
  /** Nombre maximum d'entrees autorisees */
  maxSize: number;
  /** TTL par defaut en millisecondes */
  defaultTtl: number;
  /** Nombre total de hits depuis la creation */
  hits: number;
  /** Nombre total de misses depuis la creation */
  misses: number;
}

/**
 * Options de configuration du CacheManager.
 */
interface CacheManagerOptions {
  /** Nom du cache (pour les logs) */
  name?: string;
  /** TTL par defaut en millisecondes (defaut: 30 minutes) */
  defaultTtl?: number;
  /** Nombre maximum d'entrees (defaut: 100) */
  maxEntries?: number;
}

/**
 * Gestionnaire de cache generique en memoire avec TTL et eviction automatique.
 *
 * @example
 * const cache = new CacheManager<ApiResponse>({ name: 'github', defaultTtl: 60_000 });
 * cache.set('trending', data);
 * const cached = cache.get('trending');
 */
export class CacheManager<T = unknown> {
  private readonly store = new Map<string, CacheEntry<T>>();
  private readonly name: string;
  private readonly defaultTtl: number;
  private readonly maxEntries: number;
  private hits = 0;
  private misses = 0;

  constructor(options: CacheManagerOptions = {}) {
    this.name = options.name || 'default';
    this.defaultTtl = options.defaultTtl || 30 * 60 * 1000; // 30 minutes
    this.maxEntries = options.maxEntries || 100;
  }

  /**
   * Recupere une valeur du cache. Retourne null si absente ou expiree.
   */
  get(key: string): T | null {
    const entry = this.store.get(key);

    if (!entry) {
      this.misses++;
      return null;
    }

    // Verifier l'expiration
    if (Date.now() > entry.expiry) {
      this.store.delete(key);
      this.misses++;
      return null;
    }

    this.hits++;
    return entry.data;
  }

  /**
   * Stocke une valeur dans le cache.
   *
   * @param key - Cle de cache
   * @param data - Donnees a stocker
   * @param ttl - TTL en millisecondes (optionnel, utilise le TTL par defaut)
   */
  set(key: string, data: T, ttl?: number): void {
    // Nettoyer les entrees expirees avant d'ajouter
    this.cleanup();

    // Evincer les plus anciennes si le cache est plein
    if (this.store.size >= this.maxEntries) {
      this.evict(Math.ceil(this.maxEntries * 0.2)); // Supprimer 20%
    }

    const expiry = Date.now() + (ttl ?? this.defaultTtl);
    this.store.set(key, { data, expiry, createdAt: Date.now() });
  }

  /**
   * Supprime les entrees expirees du cache.
   *
   * @returns Nombre d'entrees supprimees
   */
  cleanup(): number {
    const now = Date.now();
    let cleaned = 0;

    for (const [key, entry] of this.store.entries()) {
      if (now > entry.expiry) {
        this.store.delete(key);
        cleaned++;
      }
    }

    if (cleaned > 0) {
      log.debug(`Cache [${this.name}]: ${cleaned} entree(s) expiree(s) nettoyee(s)`);
    }

    return cleaned;
  }

  /**
   * Evince les N entrees les plus anciennes du cache.
   *
   * @param count - Nombre d'entrees a evincer
   * @returns Nombre d'entrees effectivement evincees
   */
  evict(count: number): number {
    const sorted = Array.from(this.store.entries())
      .sort((a, b) => a[1].createdAt - b[1].createdAt);

    const toRemove = sorted.slice(0, count);

    for (const [key] of toRemove) {
      this.store.delete(key);
    }

    if (toRemove.length > 0) {
      log.debug(`Cache [${this.name}]: ${toRemove.length} entree(s) evincee(s)`);
    }

    return toRemove.length;
  }

  /**
   * Supprime une cle specifique du cache.
   *
   * @returns true si la cle existait
   */
  delete(key: string): boolean {
    return this.store.delete(key);
  }

  /**
   * Vide entierement le cache.
   */
  clear(): void {
    const size = this.store.size;
    this.store.clear();
    this.hits = 0;
    this.misses = 0;

    if (size > 0) {
      log.debug(`Cache [${this.name}]: vide (${size} entree(s) supprimee(s))`);
    }
  }

  /**
   * Retourne les statistiques du cache.
   */
  getStats(): CacheStats {
    return {
      size: this.store.size,
      maxSize: this.maxEntries,
      defaultTtl: this.defaultTtl,
      hits: this.hits,
      misses: this.misses,
    };
  }

  /**
   * Verifie si une cle existe et n'est pas expiree.
   */
  has(key: string): boolean {
    const entry = this.store.get(key);
    if (!entry) return false;

    if (Date.now() > entry.expiry) {
      this.store.delete(key);
      return false;
    }

    return true;
  }
}
