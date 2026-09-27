# Choix techniques

Projet réalisé **seul** : conception de la base, API, front-end, contenu du quiz et
documentation. L'ordre de travail a été back d'abord (base, API et back-office de saisie),
puis le front, puis le contenu des questions — de cette façon le front a toujours eu de
vraies données à afficher.

Ce document justifie chaque choix technique et, surtout, **ce qui a été écarté et pourquoi**.

## Vue d'ensemble

| Besoin | Retenu | Écarté |
| --- | --- | --- |
| Interface | React 18 + TypeScript | *(imposé par le sujet)* |
| Outil de build | Vite | Create React App, Next.js |
| Navigation | React Router | affichage conditionnel, Next.js |
| Styles | CSS Modules + variables CSS | Tailwind, styled-components, CSS global, MUI/Bootstrap |
| État | hooks maison | Redux, Zustand, Context API |
| Appels HTTP | `fetch` | Axios |
| API | Laravel 8 (PHP) | Express (Node), FastAPI (Python) |
| Base de données | MySQL | PostgreSQL, SQLite, fichier JSON |
| Remplissage | seeder Laravel | saisie manuelle, `INSERT` écrits à la main |

---

## Front-end

### React + TypeScript

Imposé par le sujet (« l'application doit être réalisée en React avec TypeScript, pas en
JavaScript »). Ce qu'apporte concrètement TypeScript ici : **le contrat avec l'API est typé**.
`ApiQuestion` décrit ce que renvoie Laravel, `QuizQuestion` ce dont l'affichage a besoin. Si un
champ est renommé côté back, la compilation échoue — en JavaScript, la page afficherait
`undefined` en production sans prévenir.

### Vite plutôt que Create React App

CRA n'est plus maintenu et n'est plus recommandé par l'équipe React. Vite démarre en moins
d'une seconde, recharge à chaud instantanément, et gère TypeScript sans configuration.

**Et pourquoi pas Next.js ?** Next apporte le rendu côté serveur et un routage par fichiers.
Ici l'application est une SPA qui consomme une API externe : il n'y a rien à pré-rendre, et
Next imposerait de faire tourner un serveur Node **en plus** du serveur Laravel. Deux serveurs
au lieu d'un, pour aucun bénéfice.

### React Router plutôt qu'un affichage conditionnel

On aurait pu garder un `useState('accueil' | 'categories' | 'quiz')` et afficher la bonne page.
C'est plus court à écrire, mais on perd l'URL : pas de bouton retour du navigateur, pas de
rechargement possible, pas de lien partageable. Avec quatre écrans, un routeur est justifié.

### CSS Modules plutôt que Tailwind ou styled-components

- **Zéro dépendance** : les CSS Modules sont natifs dans Vite.
- **Pas de collision de noms** : chaque classe est préfixée à la compilation, `.card` dans
  `CategoryCard` n'entre jamais en conflit avec `.card` ailleurs.
- **Le style reste à côté de son composant** : un composant = un fichier `.module.css`.

**Pourquoi pas Tailwind ?** Les classes utilitaires s'accumulent dans le JSX et rendent la
lecture difficile. Surtout, le barème note « le design est cohérent (charte graphique,
polices…) » : une charte centralisée en variables CSS (`--color-primary`, `--font-title`…) se
montre et s'explique en trente secondes à l'oral, ce qui est plus parlant qu'une suite de
`px-4 py-2 rounded-xl`.

**Pourquoi pas styled-components ?** Une dépendance supplémentaire et du CSS généré à
l'exécution, pour un gain nul à cette échelle.

**Et pourquoi pas du CSS global tout simplement ?** Parce qu'avec une dizaine de composants,
les noms de classes finissent par se marcher dessus.

### Aucune bibliothèque de composants (MUI, Bootstrap…)

Un kit tout fait aurait donné une interface générique et reconnaissable, alors que le sujet
note explicitement la cohérence graphique. Faire les composants à la main permet un vrai
mobile first (cibles tactiles, une seule colonne) et évite d'embarquer plusieurs centaines de
kilo-octets pour utiliser quatre boutons.

### Hooks maison plutôt que Redux ou Zustand

L'état d'une partie (question courante, score, phase) ne vit que dans **une seule page** et
disparaît quand la partie se termine. Rien n'est partagé entre des écrans éloignés. Un
gestionnaire d'état global serait de la complexité gratuite : `useQuiz` fait tenir toute la
logique dans un hook testable d'environ 150 lignes.

Le seul état qui traverse une frontière — le score envoyé à la page de résultat — passe par le
`state` de navigation de React Router.

### `fetch` plutôt qu'Axios

`fetch` est natif : aucune dépendance, et `AbortController` permet d'annuler proprement une
requête quand l'utilisateur quitte la page avant la fin du chargement. Axios serait utile pour
des intercepteurs (jetons d'authentification, retentatives) — il n'y a ni l'un ni l'autre ici.

---

## Back-end

### Laravel (PHP) plutôt qu'Express ou FastAPI

- **Eloquent** donne le CRUD sans écrire une ligne de SQL.
- **Le routage d'API est immédiat** : `routes/api.php`, un contrôleur, `response()->json()`.
- **Le CORS est natif** (`config/cors.php`) — indispensable, le front tournant sur le port
  5173 et l'API sur le 8000.
- **Les vues Blade offrent un back-office gratuit** : on saisit les questions dans un
  formulaire, sans Postman ni phpMyAdmin.
- **`php artisan serve`** : pas de configuration Apache pour développer.

**Pourquoi pas Node/Express, pour rester en TypeScript des deux côtés ?** C'est l'argument le
plus sérieux contre Laravel : un seul langage, des types partagés entre front et back. Mais
avec Express il faut tout assembler soi-même — ORM, validation, CORS, back-office — là où
Laravel le fournit. Le temps gagné sur l'API a été réinvesti sur React et TypeScript, qui
étaient la vraie nouveauté du projet.

### MySQL plutôt que PostgreSQL, SQLite ou un fichier JSON

Le rendu demande **un export de la base de données** : un dump SQL est la réponse naturelle, et
Laragon fournit MySQL et phpMyAdmin d'origine.

**SQLite** aurait suffi techniquement (un seul fichier, zéro serveur), mais l'export attendu et
la démonstration du stockage sont plus parlants avec un vrai SGBD. **PostgreSQL** n'apporte
rien ici : aucune fonctionnalité avancée n'est utilisée. **Un fichier JSON** servi par l'API
aurait été le plus rapide, mais ce ne serait plus une base de données.

### Dix colonnes de réponses plutôt qu'une table `reponses`

Le schéma stocke `reponse1` … `reponse10` dans la table `questions`, et **`reponse1` est
toujours la bonne réponse**.

- **Avantages** : une seule requête sans jointure, un formulaire de saisie évident, et le
  nombre de réponses garanti par le schéma — l'énoncé impose exactement 10 réponses.
- **Limites, assumées** : le modèle n'est pas normalisé ; passer à 12 réponses imposerait une
  migration ; et la position de la bonne réponse est une convention, pas une contrainte de
  base. Une table `reponses(id, question_id, texte, est_correcte)` serait plus propre et
  permettrait plusieurs bonnes réponses.

### `questions.categorie` en texte plutôt qu'une clé étrangère

Même logique : le libellé (« Histoire ») est stocké directement, ce qui évite une jointure et
simplifie le formulaire. La contrepartie est réelle : renommer une catégorie orpheline toutes
ses questions, et rien n'empêche une faute de frappe de créer une catégorie fantôme. Un
`categorie_id` avec clé étrangère serait le choix correct pour une vraie application.

### Un seeder plutôt qu'une saisie manuelle

Les 70 questions sont décrites dans `QuizSeeder.php` et insérées par `php artisan db:seed`.
C'est **versionné** (les questions sont dans Git, relisibles et modifiables comme du code),
**rejouable** sans créer de doublons, et ça reconstruit la base sur n'importe quelle machine.
Saisir 70 questions à la main dans un formulaire aurait pris des heures et n'aurait laissé
aucune trace dans le dépôt.

---

## Ce que je changerais avec plus de temps

1. **Un endpoint filtré** : `GET /api/questions?categorie=…`. Aujourd'hui le front récupère les
   70 questions et filtre localement — correct à cette échelle, intenable avec des milliers de
   questions.
2. **Un vrai schéma relationnel** : table `reponses` avec `est_correcte`, et `categorie_id` en
   clé étrangère.
3. **La validation de la réponse côté serveur** : actuellement la bonne réponse est envoyée au
   navigateur, donc visible dans l'onglet Réseau. Sans enjeu pour un quiz de culture générale,
   rédhibitoire pour un jeu avec classement.
4. **Des tests** : `toQuizQuestion` et `buildQuiz` sont des fonctions pures, idéales pour
   quelques tests unitaires (Vitest), et des tests Feature Laravel sur les deux endpoints.
