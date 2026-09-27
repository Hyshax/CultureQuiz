/**
 * Configuration centralisée de l'application.
 * Les valeurs proviennent du fichier .env (préfixe VITE_) avec un repli sur
 * des valeurs par défaut, pour que l'app tourne même sans .env.
 */

function readNumber(value: string | undefined, fallback: number): number {
  const parsed = Number(value);
  return Number.isFinite(parsed) && parsed > 0 ? parsed : fallback;
}

/** URL de base de l'API Laravel, sans slash final. */
export const API_URL = (import.meta.env.VITE_API_URL ?? 'http://localhost:8000/api').replace(
  /\/+$/,
  '',
);

/** Nombre de questions posées dans une partie. */
export const QUESTIONS_PER_QUIZ = readNumber(import.meta.env.VITE_QUESTIONS_PER_QUIZ, 10);

/** Durée du compte à rebours pour chaque question, en secondes. */
export const TIMER_SECONDS = readNumber(import.meta.env.VITE_TIMER_SECONDS, 30);

/** Nombre de propositions affichées par question (dont la bonne réponse). */
export const ANSWERS_PER_QUESTION = 4;

/** Durée d'affichage de la correction (vert / rouge) avant la question suivante, en ms. */
export const REVEAL_DELAY_MS = 1200;
