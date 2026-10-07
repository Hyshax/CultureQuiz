# Culture Quiz — front-end

Application web de quiz de culture générale, **React + TypeScript**, pensée **mobile first**.
Elle consomme l'API Laravel du dossier `back/`.

## Démarrage

```bash
npm install
cp .env.example .env   # puis ajuste VITE_API_URL si besoin
npm run dev            # http://localhost:5173
```

L'API Laravel doit tourner en parallèle :

```bash
php artisan serve      # http://localhost:8000
```

Scripts disponibles :

| Commande          | Rôle                                            |
| ----------------- | ----------------------------------------------- |
| `npm run dev`     | serveur de développement Vite                   |
| `npm run build`   | vérification TypeScript + build de production   |
| `npm run preview` | sert le build de production en local            |
| `npm run lint`    | vérification TypeScript seule (`tsc --noEmit`)  |

## Configuration (`.env`)

| Variable                  | Défaut                      | Rôle                              |
| ------------------------- | --------------------------- | --------------------------------- |
| `VITE_API_URL`            | `http://localhost:8000/api` | URL de base de l'API              |
| `VITE_QUESTIONS_PER_QUIZ` | `10`                        | nombre de questions par partie    |
| `VITE_TIMER_SECONDS`      | `30`                        | durée du timer de chaque question |

## API consommée

| Méthode | Endpoint          | Utilisation                                        |
| ------- | ----------------- | -------------------------------------------------- |
| `GET`   | `/api/categories` | liste des catégories de la page de sélection        |
| `GET`   | `/api/questions`  | toutes les questions, filtrées côté front           |

**Convention importante :** chaque question porte 10 réponses (`reponse1` … `reponse10`) et
**`reponse1` est toujours la bonne réponse** (cf. le formulaire d'ajout du back-office).
Le front affiche 4 propositions : la bonne plus 3 mauvaises tirées au hasard parmi les 9 autres,
le tout mélangé. La liaison question ↔ catégorie se fait sur le **nom** de la catégorie
(`questions.categorie` contient le libellé, pas l'identifiant).

## Architecture

```
src/
├── components/          # briques d'interface réutilisables (1 composant = 1 CSS Module)
│   ├── AnswerButton     # une proposition, colorée en vert / rouge à la correction
│   ├── CategoryCard     # carte cliquable d'une catégorie
│   ├── ErrorMessage     # erreur + bouton « Réessayer »
│   ├── Loader           # état de chargement
│   ├── Logo             # logo de l'application
│   ├── QuestionCard     # énoncé + les 4 propositions
│   ├── ScoreCard        # score final et message associé
│   └── Timer            # compte à rebours + barre de progression
├── hooks/               # logique réutilisable
│   ├── useCategories    # chargement des catégories
│   ├── useCountdown     # compte à rebours générique
│   └── useQuiz          # déroulé complet d'une partie (machine à états)
├── pages/               # une page = une route
│   ├── HomePage         # logo + titre, clic pour démarrer
│   ├── CategoriesPage   # sélection de la catégorie
│   ├── QuizPage         # déroulé du quiz
│   └── ResultPage       # score final
├── services/api.ts      # appels HTTP à l'API (seul endroit qui connaît `fetch`)
├── types/quiz.ts        # types de l'API et types métier
├── utils/               # fonctions pures (mélange aléatoire, préparation du quiz)
├── styles/global.css    # charte graphique (variables CSS) + styles communs
├── config.ts            # lecture des variables d'environnement
└── App.tsx              # routing
```

### Routing

| Route              | Page             |
| ------------------ | ---------------- |
| `/`                | `HomePage`       |
| `/categories`      | `CategoriesPage` |
| `/quiz/:categorie` | `QuizPage`       |
| `/resultat`        | `ResultPage`     |

Toute autre URL redirige vers `/`. La page de résultat reçoit le score via le `state` de
navigation ; un accès direct à `/resultat` renvoie donc à l'accueil.

### Déroulé d'une partie (`useQuiz`)

`loading` → `playing` → `revealing` → … → `finished`

- **`playing`** : le timer tourne, les 4 propositions sont cliquables.
- **`revealing`** : le clic est pris en compte, la bonne réponse passe en vert et la mauvaise
  réponse choisie en rouge pendant 1,2 s, puis la question suivante s'affiche.
- **timer écoulé sans clic** : la question suivante s'affiche immédiatement, sans point marqué.
- **`finished`** : redirection vers `/resultat` avec le score.

## Parti pris graphique

- **Mobile first** : toutes les règles CSS ciblent d'abord le téléphone, une seule media query
  (`min-width: 768px`) aère la mise en page sur grand écran, où le contenu reste centré dans une
  colonne de largeur maximale fixe.
- **Charte centralisée** : couleurs, typographies, espacements, rayons et ombres sont des
  variables CSS définies dans `styles/global.css` — aucune valeur codée en dur dans les composants.
- **Palette** : fond violet nuit, violet primaire pour les actions, doré pour les accents et le
  score, vert / rouge réservés exclusivement à la correction des réponses.
- **Typographies** : *Baloo 2* pour les titres (ton ludique), *Nunito* pour le texte courant
  (bonne lisibilité sur mobile).
- **Accessibilité** : cibles tactiles d'au moins 3,5 rem de haut, focus clavier visible,
  `role="progressbar"` sur le timer et respect de `prefers-reduced-motion`.

## Points d'attention

- L'API ne propose pas de filtre par catégorie : le front récupère toutes les questions puis
  filtre et mélange localement. Ajouter `GET /api/questions?categorie=…` côté Laravel éviterait
  de transférer l'ensemble des questions à chaque partie.
- Si une catégorie contient moins de 10 questions, la partie se joue sur le nombre disponible et
  le score est calculé sur ce total.
