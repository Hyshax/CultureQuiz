/** Renvoie une copie mélangée du tableau (algorithme de Fisher-Yates). */
export function shuffle<T>(items: readonly T[]): T[] {
  const result = [...items];

  for (let i = result.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [result[i], result[j]] = [result[j], result[i]];
  }

  return result;
}

/** Renvoie `count` éléments tirés au hasard, sans répétition. */
export function pickRandom<T>(items: readonly T[], count: number): T[] {
  return shuffle(items).slice(0, count);
}
