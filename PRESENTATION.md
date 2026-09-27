# Soutenance Culture Quiz — trame (20 minutes)

Les six points imposés par le sujet sont couverts dans l'ordre ci-dessous. Les durées sont
indicatives : elles laissent une marge pour les questions et la démo finale.

---

## 0. Introduction (1 min)

Le projet, le groupe, et le plan de la présentation en une phrase chacun.

> Culture Quiz est une application web de quiz de culture générale, pensée en priorité pour
> le mobile. On choisit une catégorie, on répond à 10 questions chronométrées, on obtient
> son score.

---

## 1. Le choix graphique (3 min)

**Le principe : mobile first, pas « responsive après coup ».**

- Toutes les règles CSS ciblent d'abord le téléphone. Une seule *media query*
  (`min-width: 768px`) élargit la mise en page sur grand écran, où le contenu reste centré
  dans une colonne de largeur fixe : l'application garde son allure d'app mobile.
- Cibles tactiles d'au moins 3,5 rem de haut, une seule colonne, aucun défilement horizontal.

**La charte est centralisée** dans `front/src/styles/global.css` : couleurs, typographies,
espacements, rayons et ombres sont des variables CSS. Aucune valeur n'est codée en dur dans
les composants — changer `--color-primary` change toute l'application.

| Élément | Choix | Pourquoi |
| --- | --- | --- |
| Fond | violet nuit | ambiance « jeu », repose l'œil, met en valeur les couleurs vives |
| Primaire | violet | boutons et actions |
| Accent | doré | le timer et le score, les deux informations à suivre |
| Vert / rouge | correction | réservés exclusivement au feedback de réponse |
| Titres | Baloo 2 | arrondie, ton ludique |
| Texte | Nunito | très lisible en petite taille sur mobile |

**Accessibilité** : focus clavier visible, `role="progressbar"` sur le timer, respect de
`prefers-reduced-motion` pour les animations.

**Le logo** est un SVG fait main (globe + point d'interrogation) : net à toutes les tailles,
quelques kilo-octets, et il sert aussi de favicon.

---

## 2. Les endpoints de l'API et le choix du langage (4 min)

### Les endpoints utilisés par le front

| Méthode | Endpoint | Rôle |
| --- | --- | --- |
| `GET` | `/api/categories` | alimente la page de sélection |
| `GET` | `/api/questions` | alimente les parties |

L'API expose aussi le CRUD complet des questions (`POST`, `PUT`, `DELETE`) et un back-office
Blade pour saisir le contenu sans outil externe.

### Pourquoi PHP / Laravel

- **Eloquent** : les modèles `Categorie` et `Question` donnent le CRUD sans écrire de SQL.
- **Le routage d'API est immédiat** : `routes/api.php`, un contrôleur, `response()->json()`.
- **Le CORS est géré nativement** (`config/cors.php`), indispensable puisque le front tourne
  sur le port 5173 et l'API sur le 8000.
- **Un back-office gratuit** : les vues Blade permettent d'ajouter des questions sans
  passer par Postman ni phpMyAdmin.
- **`php artisan serve`** : pas de configuration Apache pour développer.
- Et, honnêtement : c'est le framework que le groupe maîtrisait le mieux, ce qui a permis de
  concentrer le temps sur le front, qui portait la vraie nouveauté (React + TypeScript).

> **Question probable du jury : pourquoi pas de filtre par catégorie dans l'API ?**
> Aujourd'hui le front récupère les 70 questions et filtre localement. Ça fonctionne à cette
> échelle, mais la bonne évolution est `GET /api/questions?categorie=...` : moins de données
> transférées, et le tirage des questions remonterait côté serveur.

---

## 3. Le stockage des données et ses particularités (3 min)

**MySQL**, deux tables utiles : `categories` et `questions`.

La particularité du modèle : **les 10 réponses sont 10 colonnes** (`reponse1` … `reponse10`)
plutôt qu'une table `reponses` liée par une clé étrangère. Et **`reponse1` est toujours la
bonne réponse** — il n'y a pas de colonne `est_correcte`.

Assumez ce choix, et montrez que vous en connaissez les limites :

- **Avantages** : une seule requête pour tout récupérer, aucune jointure, un formulaire de
  saisie très simple, et le nombre de réponses est garanti par le schéma.
- **Limites** : le modèle n'est pas normalisé ; passer à 12 réponses imposerait une migration ;
  la position de la bonne réponse est une convention, pas une contrainte de base. Un correcteur
  attentif notera qu'une table `reponses(id, question_id, texte, est_correcte)` serait plus
  propre.
- **La liaison question ↔ catégorie** se fait sur le **libellé** (`questions.categorie`
  contient « Histoire »), pas sur un `categorie_id`. Même remarque : simple, mais renommer une
  catégorie orpheline toutes ses questions.

**Le remplissage** : plutôt que de saisir 70 questions à la main, elles sont décrites dans un
*seeder* Laravel (`database/seeders/QuizSeeder.php`), rejouable avec `php artisan db:seed`
sans créer de doublons. C'est versionné, relisible en groupe, et ça reconstruit la base sur
n'importe quelle machine.

---

## 4. L'architecture de l'application (4 min)

### Le découpage

```
src/
├── pages/        une page = une route
├── components/   briques d'affichage réutilisables (1 composant = 1 CSS Module)
├── hooks/        la logique réutilisable
├── services/     les appels HTTP — le seul endroit qui connaît fetch
├── utils/        des fonctions pures (mélange, préparation du quiz)
├── types/        les types de l'API et les types métier
└── styles/       la charte graphique
```

**La règle suivie** : un composant affiche, un hook décide, un service parle au réseau.
`QuizPage` ne contient aucun `fetch` ni aucun `setInterval` — elle assemble `useQuiz`,
`useCountdown`, `Timer` et `QuestionCard`.

### Le routing

`/` → `/categories` → `/quiz/:categorie` → `/resultat`, avec React Router.
Le score transite par le `state` de navigation ; un accès direct à `/resultat` renvoie à
l'accueil.

### Le déroulé d'une partie — une machine à états dans `useQuiz`

```
loading → playing ⇄ revealing → … → finished
```

- `playing` : le timer tourne, les propositions sont cliquables ;
- `revealing` : la bonne réponse passe en vert, la mauvaise réponse choisie en rouge, pendant
  1,2 s, puis on enchaîne ;
- timer écoulé sans clic : question suivante immédiatement, sans point ;
- `finished` : redirection vers la page de score.

Cette phase `revealing` est aussi ce qui **empêche de cliquer deux fois** pendant la
correction.

---

## 5. Un extrait de code (3 min)

**Suggestion : `front/src/utils/quiz.ts`, la fonction `toQuizQuestion`.** C'est le cœur de
l'énoncé (« 10 réponses par question mais 4 affichées dont la bonne ») et elle se lit en
trente secondes :

```ts
export function toQuizQuestion(question: ApiQuestion): QuizQuestion {
  const [correctAnswer, ...wrongAnswers] = extractAnswers(question);
  const uniqueWrongAnswers = [...new Set(wrongAnswers)].filter(
    (answer) => answer !== correctAnswer,
  );
  const distractors = pickRandom(uniqueWrongAnswers, ANSWERS_PER_QUESTION - 1);

  return {
    id: question.id,
    categorie: question.categorie,
    label: question.question,
    answers: shuffle([correctAnswer, ...distractors]),
    correctAnswer,
  };
}
```

Les points à souligner :

- **c'est une fonction pure** : mêmes entrées, même sortie, testable sans React ni API ;
- **le dédoublonnage** (`new Set`) évite d'afficher deux fois la même proposition ;
- **le typage** : `ApiQuestion` décrit ce que renvoie l'API, `QuizQuestion` ce dont
  l'affichage a besoin. La frontière entre les deux est explicite, c'est tout l'intérêt de
  TypeScript ici ;
- la préparation se fait **une fois par partie**, pas à chaque rendu : les propositions ne
  se remélangent pas sous les doigts du joueur.

*Variante si le jury préfère du React : `useCountdown`, pour parler du nettoyage de
l'intervalle et de la `ref` sur le callback.*

---

## 6. Les difficultés rencontrées (2 min)

À adapter — voici celles réellement traversées :

1. **Le timer.** Un `setInterval` dans un composant React se relance à chaque rendu si on n'y
   prend pas garde. Il a fallu l'isoler dans un hook, le nettoyer au démontage, et stocker le
   callback de fin dans une `ref` pour ne pas redémarrer le compte à rebours à chaque fois que
   le parent se redessine.
2. **Les propositions qui se remélangeaient.** Premier réflexe : tirer les 4 réponses au
   moment de l'affichage. Résultat : elles changeaient de place à chaque rendu. Le tirage a été
   déplacé dans la préparation de la partie.
3. **Éviter le double-clic pendant la correction.** D'où l'état `revealing`, qui désactive les
   boutons pendant la seconde d'affichage de la couleur.
4. **Les accents dans les URLs.** `/quiz/Cinéma` passe par `encodeURIComponent`, et la
   comparaison de catégories ignore la casse et les espaces.
5. **L'environnement.** Base vide au départ (le dump ne contenait que la structure), et le
   `root` de Laragon n'a pas de mot de passe, contrairement à ce que supposait le `.env`.

---

## 7. Démonstration (3 min)

Ordre conseillé, **en mode responsive mobile** (F12 → icône téléphone) :

1. l'accueil : logo, titre ;
2. la liste des catégories — préciser qu'elle vient de l'API, onglet Réseau à l'appui ;
3. une bonne réponse → vert ;
4. une mauvaise réponse → rouge, et la bonne apparaît en vert ;
5. **laisser le timer s'écouler** sans cliquer → passage automatique ;
6. finir la partie → l'écran de score.

**À vérifier 10 minutes avant de passer** : MySQL démarré, `php artisan serve` lancé,
`npm run dev` lancé, et la page déjà ouverte dans le navigateur.

---

## Questions à anticiper

| Question | Réponse courte |
| --- | --- |
| Pourquoi React **avec** TypeScript ? | Le contrat avec l'API est typé : un champ renommé côté back casse la compilation, pas la page en production. |
| Pourquoi pas de gestion d'état globale (Redux…) ? | L'état d'une partie ne concerne qu'une seule page. Un hook suffit ; Redux serait de la complexité gratuite. |
| Comment savez-vous quelle réponse est la bonne ? | Par convention, `reponse1`. Le front la reçoit, mais l'affiche mélangée aux autres. |
| Et si un tricheur regarde la réponse dans l'onglet Réseau ? | C'est possible : la bonne réponse transite en clair. Pour un vrai jeu, il faudrait valider la réponse côté serveur. |
| Que se passe-t-il si une catégorie a moins de 10 questions ? | La partie se joue sur le nombre disponible et le score est calculé sur ce total. |
| Pourquoi CSS Modules et pas Tailwind / styled-components ? | Zéro dépendance supplémentaire, le style reste à côté de son composant, et les noms de classes ne peuvent pas entrer en collision. |

---

## Organisation du travail

Le projet a été réalisé **seul** : base de données, API, front-end, contenu du quiz et
documentation. C'est aussi ce qu'il faut répondre à la question « comment avez-vous réparti les
missions » — en enchaînant sur l'ordre de travail : le back d'abord (base, API, back-office de
saisie), puis le front, puis le contenu, pour que le front ait toujours de vraies données à
afficher.

Le détail des choix techniques et des alternatives écartées est dans
[`CHOIX-TECHNIQUES.md`](CHOIX-TECHNIQUES.md) : c'est la matière des parties 1 à 3 ci-dessus.

Gardez deux à trois minutes de battement pour les questions du jury.
