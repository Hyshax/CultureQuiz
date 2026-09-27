# Culture Quiz

Application web de quiz de culture générale, **mobile first**, réalisée dans le cadre du TP TypeScript.

- **Front-end** : React 18 + TypeScript + Vite ([`front/`](front))
- **Back-end / API** : Laravel 8 + MySQL ([`back/`](back))

L'utilisateur choisit une catégorie, répond à 10 questions chronométrées à 30 secondes
chacune, et découvre son score à la fin de la partie.

## Installation

### Prérequis

- PHP 8.x et MySQL (via [Laragon](https://laragon.org/) ou WAMP/XAMPP)
- Node.js 18 ou plus

### 1. Base de données

Le dump crée la base et la remplit (7 catégories, 70 questions) :

```bash
mysql -u root < back/culturequizz.sql
```

Ou, pour repartir d'une base vide et la remplir avec le jeu de questions :

```bash
php artisan migrate
php artisan db:seed
```

### 2. API

```bash
cd back
cp .env.example .env    # puis renseigner DB_DATABASE, DB_USERNAME, DB_PASSWORD
php artisan serve       # http://localhost:8000
```

> Avec Laragon, l'utilisateur `root` n'a pas de mot de passe : laisser `DB_PASSWORD=` vide.

### 3. Front-end

```bash
cd front
npm install
cp .env.example .env    # VITE_API_URL pointe sur http://localhost:8000/api
npm run dev             # http://localhost:5173
```

## Endpoints de l'API

| Méthode | Endpoint          | Rôle                                   |
| ------- | ----------------- | -------------------------------------- |
| `GET`   | `/api/categories` | liste des catégories                    |
| `GET`   | `/api/questions`  | liste des questions et de leurs réponses |
| `POST`  | `/api/questions`  | ajout d'une question                    |
| `PUT`   | `/api/questions/{id}` | modification d'une question          |
| `DELETE`| `/api/questions/{id}` | suppression d'une question           |

Un back-office Blade permet également de saisir le contenu sans passer par l'API :
`/listecategories`, `/createcategorie`, `/listequestions`, `/createquestion`.

**Convention** : chaque question porte 10 réponses (`reponse1` … `reponse10`) et
**`reponse1` est toujours la bonne réponse**. Le front en affiche 4 : la bonne plus trois
mauvaises tirées au hasard, l'ensemble mélangé à chaque partie.

## Contenu de la base

7 catégories de 10 questions : Histoire, Cinéma, Sport, Littérature, Sciences et Nature,
Divertissement et Médias, Culture générale.

## Documentation

- [`front/README.md`](front/README.md) — architecture détaillée du front, charte graphique
- [`PRESENTATION.md`](PRESENTATION.md) — trame de la soutenance orale
- [`CHOIX-TECHNIQUES.md`](CHOIX-TECHNIQUES.md) — justification des choix techniques
