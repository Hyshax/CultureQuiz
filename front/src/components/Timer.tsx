import styles from './Timer.module.css';

interface TimerProps {
  secondsLeft: number;
  duration: number;
}

/** Compte à rebours affiché en haut de chaque question. */
export function Timer({ secondsLeft, duration }: TimerProps) {
  const ratio = duration > 0 ? secondsLeft / duration : 0;
  const isUrgent = secondsLeft <= 5;

  return (
    <div className={styles.timer}>
      <div className={styles.head}>
        <span className={styles.label}>Temps restant</span>
        <span className={`${styles.value} ${isUrgent ? styles.urgent : ''}`} aria-live="off">
          {secondsLeft}s
        </span>
      </div>

      <div
        className={styles.track}
        role="progressbar"
        aria-label="Temps restant pour répondre"
        aria-valuemin={0}
        aria-valuemax={duration}
        aria-valuenow={secondsLeft}
      >
        <div
          className={`${styles.bar} ${isUrgent ? styles.barUrgent : ''}`}
          style={{ width: `${ratio * 100}%` }}
        />
      </div>
    </div>
  );
}
