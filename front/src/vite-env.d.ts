/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_URL?: string;
  readonly VITE_QUESTIONS_PER_QUIZ?: string;
  readonly VITE_TIMER_SECONDS?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
