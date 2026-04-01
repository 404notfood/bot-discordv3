/**
 * Unites de temps supportees pour le parsing de durees.
 */
type DurationUnit = 's' | 'm' | 'h' | 'd' | 'w';

/** Multiplicateurs en millisecondes pour chaque unite */
const UNIT_MS: Record<DurationUnit, number> = {
  s: 1_000,
  m: 60_000,
  h: 3_600_000,
  d: 86_400_000,
  w: 604_800_000,
};

/** Labels en francais pour l'affichage */
const UNIT_LABELS: Record<DurationUnit, string> = {
  s: 'seconde(s)',
  m: 'minute(s)',
  h: 'heure(s)',
  d: 'jour(s)',
  w: 'semaine(s)',
};

/**
 * Resultat du parsing d'une duree.
 */
export interface ParsedDuration {
  /** Duree en millisecondes */
  ms: number;
  /** Quantite brute saisie */
  amount: number;
  /** Unite saisie */
  unit: DurationUnit;
  /** Label lisible en francais (ex: "30 minute(s)") */
  label: string;
}

/**
 * Parse une quantite et une unite en duree structuree.
 *
 * @param amount - Nombre positif
 * @param unit - Unite de temps (s, m, h, d, w)
 * @returns ParsedDuration ou null si les parametres sont invalides
 *
 * @example
 * getDuration(30, 'm') // { ms: 1800000, amount: 30, unit: 'm', label: '30 minute(s)' }
 */
export function getDuration(amount: number, unit: string): ParsedDuration | null {
  if (amount <= 0 || !Number.isFinite(amount)) {
    return null;
  }

  const normalizedUnit = unit.toLowerCase() as DurationUnit;

  if (!(normalizedUnit in UNIT_MS)) {
    return null;
  }

  const ms = amount * UNIT_MS[normalizedUnit];
  const label = `${amount} ${UNIT_LABELS[normalizedUnit]}`;

  return { ms, amount, unit: normalizedUnit, label };
}

/**
 * Parse une chaine de type "30m", "2h", "7d" en duree structuree.
 *
 * @param input - Chaine au format "<nombre><unite>"
 * @returns ParsedDuration ou null si le format est invalide
 *
 * @example
 * parseDuration('2h') // { ms: 7200000, amount: 2, unit: 'h', label: '2 heure(s)' }
 */
export function parseDuration(input: string): ParsedDuration | null {
  const match = input.trim().match(/^(\d+)\s*([smhdw])$/i);
  if (!match) return null;

  const amount = parseInt(match[1], 10);
  const unit = match[2].toLowerCase();

  return getDuration(amount, unit);
}

/**
 * Formate une duree en millisecondes vers un texte lisible en francais.
 *
 * @param ms - Duree en millisecondes
 * @returns Texte lisible (ex: "2h 30m 15s")
 */
export function formatDuration(ms: number): string {
  if (ms < 1000) return `${ms}ms`;

  const parts: string[] = [];
  const totalSeconds = Math.floor(ms / 1000);

  const days = Math.floor(totalSeconds / 86400);
  const hours = Math.floor((totalSeconds % 86400) / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;

  if (days > 0) parts.push(`${days}j`);
  if (hours > 0) parts.push(`${hours}h`);
  if (minutes > 0) parts.push(`${minutes}m`);
  if (seconds > 0) parts.push(`${seconds}s`);

  return parts.join(' ') || '0s';
}
