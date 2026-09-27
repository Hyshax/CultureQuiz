import styles from './Loader.module.css';

interface LoaderProps {
  message?: string;
}

/** Indicateur de chargement affiché pendant les appels à l'API. */
export function Loader({ message = 'Chargement…' }: LoaderProps) {
  return (
    <div className={styles.wrapper} role="status" aria-live="polite">
      <span className={styles.spinner} />
      <p className={styles.message}>{message}</p>
    </div>
  );
}
