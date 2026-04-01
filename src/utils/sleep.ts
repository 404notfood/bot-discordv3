/**
 * Pause l'execution pendant la duree specifiee en millisecondes.
 */
export function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}
