import styles from './CategoryCard.module.css';

interface CategoryCardProps {
  categorie: string;
  onSelect: (categorie: string) => void;
}

/**
 * Emoji associé à une catégorie, pour rendre la liste plus lisible.
 * Les catégories inconnues retombent sur une icône générique.
 */
const CATEGORY_ICONS: Record<string, string> = {
  histoire: '🏛️',
  geographie: '🌍',
  cinema: '🎬',
  sport: '🏅',
  musique: '🎵',
  sciences: '🔬',
  science: '🔬',
  sciencesetnature: '🌱',
  litterature: '📚',
  divertissementetmedias: '📺',
  culturegenerale: '🧠',
  art: '🎨',
  nature: '🌿',
  technologie: '💻',
  cuisine: '🍳',
  jeuxvideo: '🎮',
};

function getIcon(categorie: string): string {
  const key = categorie
    .toLocaleLowerCase('fr')
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/[^a-z]/g, '');

  return CATEGORY_ICONS[key] ?? '❓';
}

/** Carte cliquable représentant une catégorie de quiz. */
export function CategoryCard({ categorie, onSelect }: CategoryCardProps) {
  return (
    <button type="button" className={styles.card} onClick={() => onSelect(categorie)}>
      <span className={styles.icon} aria-hidden="true">
        {getIcon(categorie)}
      </span>
      <span className={styles.name}>{categorie}</span>
      <span className={styles.chevron} aria-hidden="true">
        ›
      </span>
    </button>
  );
}
