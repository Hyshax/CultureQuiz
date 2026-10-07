import { useCallback, useEffect, useRef, useState } from 'react';
import { REVEAL_DELAY_MS } from '../config';
import { fetchQuestions } from '../services/api';
import type { AnswerState, QuizQuestion } from '../types/quiz';
import { buildQuiz } from '../utils/quiz';

/**
 * Étapes d'une partie :
 * - `loading`   : les questions sont en cours de chargement ;
 * - `error`     : l'API est injoignable ou la catégorie est vide ;
 * - `playing`   : le joueur répond, le timer tourne ;
 * - `revealing` : la réponse cliquée est colorée avant la question suivante ;
 * - `finished`  : les questions sont épuisées, le score est définitif.
 */
export type QuizPhase = 'loading' | 'error' | 'playing' | 'revealing' | 'finished';

interface UseQuizResult {
  phase: QuizPhase;
  error: string | null;
  /** Question courante, `null` tant que la partie n'est pas prête. */
  question: QuizQuestion | null;
  /** Numéro de la question affichée (1 pour la première). */
  questionNumber: number;
  /** Nombre total de questions de la partie. */
  total: number;
  score: number;
  /** Couleur à appliquer à une proposition. */
  getAnswerState: (answer: string) => AnswerState;
  /** À appeler quand le joueur clique sur une proposition. */
  selectAnswer: (answer: string) => void;
  /** À appeler quand le timer atteint zéro sans réponse. */
  skipQuestion: () => void;
  /** Relance le chargement (bouton « Réessayer »). */
  reload: () => void;
}

/** Orchestre une partie complète pour une catégorie donnée. */
export function useQuiz(categorie: string): UseQuizResult {
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [score, setScore] = useState(0);
  const [phase, setPhase] = useState<QuizPhase>('loading');
  const [error, setError] = useState<string | null>(null);
  const [reloadToken, setReloadToken] = useState(0);

  const revealTimeoutRef = useRef<number | null>(null);

  const clearRevealTimeout = useCallback(() => {
    if (revealTimeoutRef.current !== null) {
      window.clearTimeout(revealTimeoutRef.current);
      revealTimeoutRef.current = null;
    }
  }, []);

  // Chargement des questions puis préparation de la partie.
  useEffect(() => {
    const controller = new AbortController();

    setPhase('loading');
    setError(null);
    setQuestions([]);
    setCurrentIndex(0);
    setSelectedAnswer(null);
    setScore(0);

    fetchQuestions(controller.signal)
      .then((data) => {
        const quiz = buildQuiz(data, categorie);

        if (quiz.length === 0) {
          setError(`Aucune question n'est encore disponible pour la catégorie « ${categorie} ».`);
          setPhase('error');
          return;
        }

        setQuestions(quiz);
        setPhase('playing');
      })
      .catch((cause: unknown) => {
        if (cause instanceof DOMException && cause.name === 'AbortError') {
          return;
        }
        setError(cause instanceof Error ? cause.message : 'Une erreur est survenue.');
        setPhase('error');
      });

    return () => controller.abort();
  }, [categorie, reloadToken]);

  // Sécurité : on n'oublie jamais un minuteur en cours au démontage.
  useEffect(() => clearRevealTimeout, [clearRevealTimeout]);

  const goToNextQuestion = useCallback(() => {
    clearRevealTimeout();
    setSelectedAnswer(null);

    if (currentIndex >= questions.length - 1) {
      setPhase('finished');
      return;
    }

    setCurrentIndex(currentIndex + 1);
    setPhase('playing');
  }, [clearRevealTimeout, currentIndex, questions.length]);

  const selectAnswer = useCallback(
    (answer: string) => {
      if (phase !== 'playing') {
        return;
      }

      const currentQuestion = questions[currentIndex];
      if (!currentQuestion) {
        return;
      }

      setSelectedAnswer(answer);
      setPhase('revealing');

      if (answer === currentQuestion.correctAnswer) {
        setScore((previous) => previous + 1);
      }

      // On laisse le temps de voir la couleur avant de changer de question.
      revealTimeoutRef.current = window.setTimeout(goToNextQuestion, REVEAL_DELAY_MS);
    },
    [currentIndex, goToNextQuestion, phase, questions],
  );

  // Timer écoulé : on enchaîne immédiatement sur la question suivante.
  const skipQuestion = useCallback(() => {
    if (phase !== 'playing') {
      return;
    }
    goToNextQuestion();
  }, [goToNextQuestion, phase]);

  const getAnswerState = useCallback(
    (answer: string): AnswerState => {
      if (phase !== 'revealing') {
        return 'idle';
      }
      if (answer === questions[currentIndex]?.correctAnswer) {
        return 'correct';
      }
      if (answer === selectedAnswer) {
        return 'wrong';
      }
      return 'muted';
    },
    [currentIndex, phase, questions, selectedAnswer],
  );

  const reload = useCallback(() => setReloadToken((token) => token + 1), []);

  return {
    phase,
    error,
    question: questions[currentIndex] ?? null,
    questionNumber: currentIndex + 1,
    total: questions.length,
    score,
    getAnswerState,
    selectAnswer,
    skipQuestion,
    reload,
  };
}
