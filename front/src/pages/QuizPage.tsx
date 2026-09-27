import { useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { ErrorMessage } from '../components/ErrorMessage';
import { Loader } from '../components/Loader';
import { QuestionCard } from '../components/QuestionCard';
import { Timer } from '../components/Timer';
import { TIMER_SECONDS } from '../config';
import { useCountdown } from '../hooks/useCountdown';
import { useQuiz } from '../hooks/useQuiz';
import type { QuizResult } from '../types/quiz';
import styles from './QuizPage.module.css';

/** Page de jeu : une question à la fois, avec un timer de 30 secondes. */
export function QuizPage() {
  const navigate = useNavigate();
  const { categorie = '' } = useParams<{ categorie: string }>();

  const {
    phase,
    error,
    question,
    questionNumber,
    total,
    score,
    getAnswerState,
    selectAnswer,
    skipQuestion,
    reload,
  } = useQuiz(categorie);

  // Le compte à rebours ne tourne que pendant la phase de réponse et
  // redémarre à chaque nouvelle question.
  const secondsLeft = useCountdown({
    duration: TIMER_SECONDS,
    isRunning: phase === 'playing',
    resetKey: questionNumber,
    onExpire: skipQuestion,
  });

  // Fin de partie : on passe le score à la page de résultat.
  useEffect(() => {
    if (phase !== 'finished') {
      return;
    }

    const result: QuizResult = { categorie, score, total };
    navigate('/resultat', { replace: true, state: result });
  }, [categorie, navigate, phase, score, total]);

  if (phase === 'loading') {
    return (
      <main className="page">
        <Loader message="Préparation du quiz…" />
      </main>
    );
  }

  if (phase === 'error') {
    return (
      <main className={`page ${styles.centered}`}>
        <ErrorMessage message={error ?? 'Une erreur est survenue.'} onRetry={reload} />
        <button
          type="button"
          className="button button--ghost"
          onClick={() => navigate('/categories')}
        >
          Changer de catégorie
        </button>
      </main>
    );
  }

  if (!question) {
    return (
      <main className="page">
        <Loader message="Chargement de la question…" />
      </main>
    );
  }

  return (
    <main className="page">
      <header className={styles.header}>
        <p className={styles.categorie}>{categorie}</p>
        <p className={styles.score}>Score : {score}</p>
      </header>

      <Timer secondsLeft={secondsLeft} duration={TIMER_SECONDS} />

      <QuestionCard
        question={question}
        questionNumber={questionNumber}
        total={total}
        isLocked={phase !== 'playing'}
        getAnswerState={getAnswerState}
        onSelect={selectAnswer}
      />

      <button
        type="button"
        className={`button button--ghost ${styles.quit}`}
        onClick={() => navigate('/categories')}
      >
        Quitter le quiz
      </button>
    </main>
  );
}
