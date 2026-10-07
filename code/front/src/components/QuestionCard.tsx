import type { AnswerState, QuizQuestion } from '../types/quiz';
import { AnswerButton } from './AnswerButton';
import styles from './QuestionCard.module.css';

interface QuestionCardProps {
  question: QuizQuestion;
  questionNumber: number;
  total: number;
  /** Les propositions ne sont plus cliquables pendant la correction. */
  isLocked: boolean;
  getAnswerState: (answer: string) => AnswerState;
  onSelect: (answer: string) => void;
}

/** Carte contenant l'énoncé et les 4 propositions de réponse. */
export function QuestionCard({
  question,
  questionNumber,
  total,
  isLocked,
  getAnswerState,
  onSelect,
}: QuestionCardProps) {
  return (
    <section className={styles.card}>
      <p className={styles.counter}>
        Question {questionNumber} / {total}
      </p>

      <h2 className={styles.label}>{question.label}</h2>

      <ul className={styles.answers}>
        {question.answers.map((answer) => (
          <li key={answer}>
            <AnswerButton
              answer={answer}
              state={getAnswerState(answer)}
              disabled={isLocked}
              onSelect={onSelect}
            />
          </li>
        ))}
      </ul>
    </section>
  );
}
