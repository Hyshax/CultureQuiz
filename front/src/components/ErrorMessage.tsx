import styles from './ErrorMessage.module.css';

interface ErrorMessageProps {
  message: string;
  /** Si fourni, un bouton « Réessayer » est affiché. */
  onRetry?: () => void;
}

/** Message d'erreur commun (API injoignable, catégorie vide…). */
export function ErrorMessage({ message, onRetry }: ErrorMessageProps) {
  return (
    <div className={styles.wrapper} role="alert">
      <span className={styles.icon} aria-hidden="true">
        !
      </span>
      <p className={styles.message}>{message}</p>
      {onRetry && (
        <button type="button" className="button" onClick={onRetry}>
          Réessayer
        </button>
      )}
    </div>
  );
}
