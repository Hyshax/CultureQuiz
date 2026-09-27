import { useNavigate } from 'react-router-dom';
import { Logo } from '../components/Logo';
import styles from './HomePage.module.css';

/**
 * Page d'accueil : logo + titre de l'application.
 * Un clic n'importe où sur la page mène à la sélection des catégories.
 */
export function HomePage() {
  const navigate = useNavigate();
  const goToCategories = () => navigate('/categories');

  return (
    <main
      className={`page ${styles.home}`}
      onClick={goToCategories}
      role="button"
      tabIndex={0}
      aria-label="Commencer, choisir une catégorie"
      onKeyDown={(event) => {
        if (event.key === 'Enter' || event.key === ' ') {
          event.preventDefault();
          goToCategories();
        }
      }}
    >
      <div className={styles.content}>
        <Logo />

        <h1 className={styles.title}>
          Culture <span className={styles.titleAccent}>Quiz</span>
        </h1>

        <p className={styles.tagline}>10 questions, 30 secondes chacune. Prêt ?</p>
      </div>

      <p className={styles.hint}>Appuie sur l&apos;écran pour commencer</p>
    </main>
  );
}
