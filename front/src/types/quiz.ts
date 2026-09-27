/**
 * Types métier du quiz.
 * `ApiCategory` et `ApiQuestion` décrivent exactement ce que renvoie l'API
 * Laravel ; `QuizQuestion` est la forme préparée pour l'affichage.
 */

/** Catégorie telle que renvoyée par GET /api/categories. */
export interface ApiCategory {
  id: number;
  categorie: string;
  created_at: string | null;
  updated_at: string | null;
}

/**
 * Question telle que renvoyée par GET /api/questions.
 * Par convention de l'API, `reponse1` est toujours la bonne réponse
 * (cf. le formulaire d'ajout du back-office : « Réponse 1 (bonne réponse) »).
 */
export interface ApiQuestion {
  id: number;
  categorie: string;
  question: string;
  reponse1: string;
  reponse2: string;
  reponse3: string;
  reponse4: string;
  reponse5: string;
  reponse6: string;
  reponse7: string;
  reponse8: string;
  reponse9: string;
  reponse10: string;
  created_at?: string | null;
  updated_at?: string | null;
}

/** Question prête à être jouée : 4 propositions mélangées dont la bonne. */
export interface QuizQuestion {
  id: number;
  categorie: string;
  label: string;
  /** Les 4 propositions affichées, déjà mélangées. */
  answers: string[];
  /** La bonne réponse, présente dans `answers`. */
  correctAnswer: string;
}

/** État d'une proposition, qui pilote sa couleur à l'écran. */
export type AnswerState = 'idle' | 'correct' | 'wrong' | 'muted';

/** Résultat d'une partie, transmis à la page de score. */
export interface QuizResult {
  categorie: string;
  score: number;
  total: number;
}
