import { useEffect, useRef, useState } from 'react';

interface UseCountdownOptions {
  /** Durée du compte à rebours, en secondes. */
  duration: number;
  /** Le compte à rebours n'avance que lorsque cette valeur est vraie. */
  isRunning: boolean;
  /** Changer cette clé relance le compte à rebours à `duration`. */
  resetKey: string | number;
  /** Appelé une seule fois lorsque le compteur atteint zéro. */
  onExpire: () => void;
}

/**
 * Compte à rebours réutilisable : renvoie le nombre de secondes restantes et
 * prévient le composant parent quand le temps est écoulé.
 */
export function useCountdown({
  duration,
  isRunning,
  resetKey,
  onExpire,
}: UseCountdownOptions): number {
  const [secondsLeft, setSecondsLeft] = useState(duration);

  // Garde la dernière version du callback sans relancer l'intervalle.
  const onExpireRef = useRef(onExpire);
  useEffect(() => {
    onExpireRef.current = onExpire;
  }, [onExpire]);

  // Nouvelle question (ou nouvelle durée) : on repart du début.
  useEffect(() => {
    setSecondsLeft(duration);
  }, [duration, resetKey]);

  useEffect(() => {
    if (!isRunning) {
      return;
    }

    const intervalId = window.setInterval(() => {
      setSecondsLeft((previous) => Math.max(0, previous - 1));
    }, 1000);

    return () => window.clearInterval(intervalId);
  }, [isRunning, resetKey]);

  useEffect(() => {
    if (isRunning && secondsLeft === 0) {
      onExpireRef.current();
    }
  }, [isRunning, secondsLeft]);

  return secondsLeft;
}
