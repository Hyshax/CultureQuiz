import type { AnswerState } from '../types/quiz';
import styles from './AnswerButton.module.css';

interface AnswerButtonProps {
  answer: string;
  state: AnswerState;
  disabled: boolean;
  onSelect: (answer: string) => void;
}

const stateClasses: Record<AnswerState, string> = {
  idle: '',
  correct: styles.correct,
  wrong: styles.wrong,
  muted: styles.muted,
};

/** Une proposition de réponse, colorée en vert ou en rouge après le clic. */
export function AnswerButton({ answer, state, disabled, onSelect }: AnswerButtonProps) {
  return (
    <button
      type="button"
      className={`${styles.answer} ${stateClasses[state]}`}
      disabled={disabled}
      onClick={() => onSelect(answer)}
    >
      <span className={styles.text}>{answer}</span>
    </button>
  );
}
