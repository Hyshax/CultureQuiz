import { useNavigate } from 'react-router-dom';
import { CategoryCard } from '../components/CategoryCard';
import { ErrorMessage } from '../components/ErrorMessage';
import { Loader } from '../components/Loader';
import { useCategories } from '../hooks/useCategories';
import styles from './CategoriesPage.module.css';

/** Page de sélection de la catégorie, alimentée par GET /api/categories. */
export function CategoriesPage() {
  const navigate = useNavigate();
  const { categories, isLoading, error, reload } = useCategories();

  const startQuiz = (categorie: string) => {
    navigate(`/quiz/${encodeURIComponent(categorie)}`);
  };

  return (
    <main className="page">
      <header className={styles.header}>
        <h1 className={styles.title}>Choisis ta catégorie</h1>
        <p className={styles.subtitle}>Une catégorie, 10 questions chronométrées.</p>
      </header>

      {isLoading && <Loader message="Chargement des catégories…" />}

      {!isLoading && error && <ErrorMessage message={error} onRetry={reload} />}

      {!isLoading && !error && categories.length === 0 && (
        <ErrorMessage
          message="Aucune catégorie n'est disponible pour le moment."
          onRetry={reload}
        />
      )}

      {!isLoading && !error && categories.length > 0 && (
        <ul className={styles.list}>
          {categories.map((categorie) => (
            <li key={categorie.id}>
              <CategoryCard categorie={categorie.categorie} onSelect={startQuiz} />
            </li>
          ))}
        </ul>
      )}

      <button type="button" className="button button--ghost" onClick={() => navigate('/')}>
        Retour à l&apos;accueil
      </button>
    </main>
  );
}
