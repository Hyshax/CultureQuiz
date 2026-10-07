import styles from './ScoreCard.module.css';

interface ScoreCardProps {
  score: number;
  total: number;
  categorie: string;
}

/** Message de fin adapté au pourcentage de bonnes réponses. */
function getFeedback(ratio: number): { title: string; emoji: string } {
  if (ratio === 1) {
    return { title: 'Sans faute, bravo !', emoji: '🏆' };
  }
  if (ratio >= 0.7) {
    return { title: 'Très belle culture !', emoji: '🎉' };
  }
  if (ratio >= 0.4) {
    return { title: 'Pas mal, continue !', emoji: '👍' };
  }
  return { title: 'Il y a de la marge…', emoji: '💪' };
}

/** Carte de résultat affichée à la fin des questions. */
export function ScoreCard({ score, total, categorie }: ScoreCardProps) {
  const ratio = total > 0 ? score / total : 0;
  const { title, emoji } = getFeedback(ratio);

  return (
    <section className={styles.card}>
      <span className={styles.emoji} aria-hidden="true">
        {emoji}
      </span>

      <h2 className={styles.title}>{title}</h2>

      <p className={styles.score}>
        <strong className={styles.scoreValue}>{score}</strong>
        <span className={styles.scoreTotal}>/ {total}</span>
      </p>

      <p className={styles.detail}>
        Catégorie <strong className={styles.detailCategorie}>{categorie}</strong> —{' '}
        {Math.round(ratio * 100)} % de bonnes réponses
      </p>
    </section>
  );
}
