import { API_URL } from '../config';
import type { ApiCategory, ApiQuestion } from '../types/quiz';

/** Erreur levée quand l'API répond autre chose qu'un 2xx. */
export class ApiError extends Error {
  constructor(
    message: string,
    public readonly status?: number,
  ) {
    super(message);
    this.name = 'ApiError';
  }
}

async function request<T>(path: string, signal?: AbortSignal): Promise<T> {
  let response: Response;

  try {
    response = await fetch(`${API_URL}${path}`, {
      signal,
      headers: { Accept: 'application/json' },
    });
  } catch (error) {
    if (error instanceof DOMException && error.name === 'AbortError') {
      throw error;
    }
    throw new ApiError(
      "Impossible de joindre l'API. Vérifie que le serveur Laravel est bien démarré.",
    );
  }

  if (!response.ok) {
    throw new ApiError(`L'API a répondu avec le statut ${response.status}.`, response.status);
  }

  return (await response.json()) as T;
}

/** GET /api/categories */
export function fetchCategories(signal?: AbortSignal): Promise<ApiCategory[]> {
  return request<ApiCategory[]>('/categories', signal);
}

/** GET /api/questions */
export function fetchQuestions(signal?: AbortSignal): Promise<ApiQuestion[]> {
  return request<ApiQuestion[]>('/questions', signal);
}
