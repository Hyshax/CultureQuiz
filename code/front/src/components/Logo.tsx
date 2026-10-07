import styles from './Logo.module.css';

interface LogoProps {
  /** Taille du logo en pixels (carré). */
  size?: number;
}

/** Logo de l'application, servi depuis `public/logo.svg`. */
export function Logo({ size = 160 }: LogoProps) {
  return (
    <img
      className={styles.logo}
      src="/logo.svg"
      width={size}
      height={size}
      alt="Logo Culture Quiz"
    />
  );
}
