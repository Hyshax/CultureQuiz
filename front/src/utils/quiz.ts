import { ANSWERS_PER_QUESTION, QUESTIONS_PER_QUIZ } from '../config';
import type { ApiQuestion, QuizQuestion } from '../types/quiz';
import { pickRandom, shuffle } from './random';

/** Compare deux libellés de catégorie sans tenir compte de la casse ni des espaces. */
export function isSameCategory(a: string, b: string): boolean {
  return a.trim().toLocaleLowerCase('fr') === b.trim().toLocaleLowerCase('fr');
}

/** Extrait les 10 réponses d'une question, en ignorant les champs vides. */
function extractAnswers(question: ApiQuestion): string[] {
  return [
    question.reponse1,
    question.reponse2,
    question.reponse3,
    question.reponse4,
    question.reponse5,
    question.reponse6,
    question.reponse7,
    question.reponse8,
    question.reponse9,
    question.reponse10,
  ]
    .map((answer) => (answer ?? '').trim())
    .filter((answer) => answer.length > 0);
}

/**
 * Transforme une question de l'API en question jouable :
 * la bonne réponse (reponse1) plus 3 mauvaises tirées au hasard parmi les 9
 * autres, le tout mélangé.
 */
export function toQuizQuestion(question: ApiQuestion): QuizQuestion {
  const [correctAnswer, ...wrongAnswers] = extractAnswers(question);
  const uniqueWrongAnswers = [...new Set(wrongAnswers)].filter(
    (answer) => answer !== correctAnswer,
  );
  const distractors = pickRandom(uniqueWrongAnswers, ANSWERS_PER_QUESTION - 1);

  return {
    id: question.id,
    categorie: question.categorie,
    label: question.question,
    answers: shuffle([correctAnswer, ...distractors]),
    correctAnswer,
  };
}

/**
 * Prépare une partie : filtre les questions de la catégorie choisie, les
 * mélange, en garde 10 au maximum et prépare les propositions de chacune.
 */
export function buildQuiz(questions: ApiQuestion[], categorie: string): QuizQuestion[] {
  return shuffle(questions.filter((question) => isSameCategory(question.categorie, categorie)))
    .slice(0, QUESTIONS_PER_QUIZ)
    .map(toQuizQuestion);
}
