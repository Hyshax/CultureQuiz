import { Navigate, Route, Routes } from 'react-router-dom';
import { CategoriesPage } from './pages/CategoriesPage';
import { HomePage } from './pages/HomePage';
import { QuizPage } from './pages/QuizPage';
import { ResultPage } from './pages/ResultPage';

/**
 * Routing de l'application :
 * accueil -> catégories -> quiz -> résultat.
 */
export default function App() {
  return (
    <Routes>
      <Route path="/" element={<HomePage />} />
      <Route path="/categories" element={<CategoriesPage />} />
      <Route path="/quiz/:categorie" element={<QuizPage />} />
      <Route path="/resultat" element={<ResultPage />} />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
