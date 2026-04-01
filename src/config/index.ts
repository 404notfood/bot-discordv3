import { envSchema, type Env } from './env';

/**
 * Configuration globale de l'application.
 * dotenv doit etre charge AVANT l'import de ce module (dans index.ts).
 */

let _config: Env | null = null;

/**
 * Parse et valide les variables d'environnement avec Zod.
 * Lance une erreur fatale si la validation echoue.
 */
function parseConfig(): Env {
  const result = envSchema.safeParse(process.env);

  if (!result.success) {
    const errors = result.error.issues
      .map(issue => `  - ${issue.path.join('.')}: ${issue.message}`)
      .join('\n');

    console.error('=== ERREUR DE CONFIGURATION ===');
    console.error('Variables d\'environnement invalides:\n' + errors);
    process.exit(1);
  }

  return result.data;
}

/**
 * Retourne la configuration validee (singleton).
 * Le premier appel parse et valide les variables d'environnement.
 */
export function getConfig(): Env {
  if (!_config) {
    _config = parseConfig();
  }
  return _config;
}

/**
 * Singleton de configuration, initialise au premier import.
 * Utilisation: `import { config } from '../config';`
 */
export const config = getConfig();

export type { Env };
export { envSchema };
