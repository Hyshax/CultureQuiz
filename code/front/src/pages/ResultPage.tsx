import { Navigate, useLocation, useNavigate } from 'react-router-dom';
import { ScoreCard } from '../components/ScoreCard';
import type { QuizResult } from '../types/quiz';
import styles from './ResultPage.module.css';

/** Page de score, affichée une fois les 10 questions passées. */
export function ResultPage() {
  const navigate = useNavigate();
  const { state } = useLocation();
  const result = state as QuizResult | null;

  // Accès direct à l'URL sans avoir joué : on repart de l'accueil.
  if (!result) {
    return <Navigate to="/" replace />;
  }

  return (
    <main className={`page ${styles.result}`}>
      <h1 className={styles.title}>Résultat</h1>

      <ScoreCard score={result.score} total={result.total} categorie={result.categorie} />

      <div className={styles.actions}>
        <button
          type="button"
          className="button"
          onClick={() => navigate(`/quiz/${encodeURIComponent(result.categorie)}`)}
        >
          Rejouer cette catégorie
        </button>

        <button
          type="button"
          className="button button--ghost"
          onClick={() => navigate('/categories')}
        >
          Changer de catégorie
        </button>
      </div>
    </main>
  );
}
