import { useCallback, useEffect, useState } from 'react';
import { fetchCategories } from '../services/api';
import type { ApiCategory } from '../types/quiz';

interface UseCategoriesResult {
  categories: ApiCategory[];
  isLoading: boolean;
  error: string | null;
  reload: () => void;
}

/** Charge la liste des catégories depuis l'API. */
export function useCategories(): UseCategoriesResult {
  const [categories, setCategories] = useState<ApiCategory[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [reloadToken, setReloadToken] = useState(0);

  const reload = useCallback(() => setReloadToken((token) => token + 1), []);

  useEffect(() => {
    const controller = new AbortController();

    setIsLoading(true);
    setError(null);

    fetchCategories(controller.signal)
      .then((data) => {
        setCategories(data);
        setIsLoading(false);
      })
      .catch((cause: unknown) => {
        if (cause instanceof DOMException && cause.name === 'AbortError') {
          return;
        }
        setError(cause instanceof Error ? cause.message : 'Une erreur est survenue.');
        setIsLoading(false);
      });

    return () => controller.abort();
  }, [reloadToken]);

  return { categories, isLoading, error, reload };
}
