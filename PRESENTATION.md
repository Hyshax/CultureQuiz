# Soutenance Culture Quiz — trame et texte

16 slides, environ 20 minutes dont 3 de démonstration. Pour chaque slide : ce qui est
affiché, et le texte à dire. Le texte est écrit pour être parlé, pas lu mot à mot — retiens
les idées et les chiffres, le reste viendra tout seul.

Les six points imposés par le sujet sont couverts dans cet ordre : choix graphique (slide 4),
endpoints et langage (5–6), stockage (7–9), architecture (10–11), extrait de code (12–13),
difficultés (14).

---

## Slide 1 — Couverture · 20 s

*Affiché : le logo, « Culture Quiz », ton nom.*

> Bonjour. Je vais vous présenter Culture Quiz, une application web de quiz de culture
> générale. On choisit une catégorie, on répond à dix questions chronométrées, et on obtient
> son score. Elle a été pensée en priorité pour le mobile.

---

## Slide 2 — Au programme · 25 s

*Affiché : les six points, avec leur durée.*

> Je vais suivre les six points demandés : d'abord le choix graphique, ensuite l'API et
> pourquoi j'ai choisi ce langage, puis le stockage des données, l'architecture de
> l'application, un extrait de code, et enfin les difficultés que j'ai rencontrées. Je
> terminerai par une démonstration.

---

## Slide 3 — Le projet en quatre chiffres · 45 s

*Affiché : 7 catégories, 70 questions, 4 propositions sur 10 réponses, 30 secondes.*

> Quatre chiffres résument le cahier des charges. Sept catégories, soixante-dix questions en
> base, dix par partie. Trente secondes par question. Et surtout : quatre propositions
> affichées, tirées parmi dix réponses.
>
> C'est la contrainte la plus spécifique du sujet, et c'est elle qui structure à la fois le
> modèle de données et le code que je vous montrerai tout à l'heure : chaque question porte
> dix réponses en base, mais le joueur n'en voit que quatre, dont la bonne.

---

## Slide 4 — Mobile first · 2 min 30

*Affiché : le principe, et la seule media query du projet.*

> Premier point : le choix graphique.
>
> Le sujet demandait du mobile first. Pour moi ce n'est pas une taille d'écran, c'est une
> façon d'écrire le CSS. Toutes mes règles ciblent d'abord le téléphone. Il n'y a qu'une
> seule media query dans tout le projet, à 768 pixels, et elle ne fait qu'aérer la mise en
> page sur grand écran. Le contenu reste centré dans une colonne : même sur un ordinateur,
> l'application garde son allure d'app mobile.
>
> Concrètement ça veut dire une seule colonne, aucun défilement horizontal, et des boutons
> d'au moins trois centimètres et demi de haut, pour qu'on puisse répondre au pouce sans
> viser.
>
> Sur la charte : les couleurs, les typographies et les espacements sont tous des variables
> CSS dans un seul fichier. Aucune valeur n'est codée en dur dans les composants — si je
> change la couleur primaire à un endroit, toute l'application change. Le fond est un violet
> nuit qui met en valeur les couleurs vives, le doré signale les deux informations à suivre,
> le timer et le score. Et surtout : le vert et le rouge ne servent qu'à une chose, la
> correction des réponses. Nulle part ailleurs. C'est ce qui rend le feedback lisible
> instantanément.
>
> Pour les polices, Baloo 2 pour les titres, arrondie et un peu ludique, et Nunito pour le
> texte, très lisible en petite taille. D'ailleurs ce diaporama utilise exactement la même
> charte que l'application.
>
> Enfin, l'accessibilité : le focus clavier reste visible, le timer est annoncé aux lecteurs
> d'écran, et les animations se désactivent pour qui en fait la demande dans son système.

---

## Slide 5 — Les endpoints · 1 min 15

*Affiché : le tableau des cinq routes.*

> Deuxième point : l'API.
>
> Elle expose cinq routes. Les deux en doré sont celles qu'utilise le front : une pour
> récupérer les catégories, une pour récupérer les questions. Les trois autres — création,
> modification, suppression — complètent le CRUD, mais l'application n'en a pas besoin pour
> jouer.
>
> J'ai aussi fait un petit back-office en Blade : des formulaires pour ajouter une catégorie
> ou une question directement depuis le navigateur, sans Postman ni phpMyAdmin.

*Si tu as l'onglet ouvert : montre le JSON brut de `/api/categories` ici, deux secondes.*

---

## Slide 6 — Pourquoi Laravel · 2 min

*Affiché : les cinq raisons, plus la carte « Et honnêtement ».*

> Pourquoi PHP et Laravel pour cette API ?
>
> Eloquent, l'ORM, me donne tout le CRUD sans écrire une ligne de SQL. Le routage d'API tient
> en trois fichiers : une route, un contrôleur, une réponse JSON. Le CORS est géré nativement,
> et ça c'était indispensable : mon front tourne sur le port 5173 et l'API sur le 8000, donc
> sans configuration CORS le navigateur bloquerait toutes les requêtes. Les vues Blade m'ont
> donné le back-office gratuitement. Et `artisan serve` me permet de développer sans
> configurer Apache.
>
> Et puis, honnêtement : c'est le framework que je maîtrisais le mieux. Le vrai nouveau sujet
> de ce projet, c'était React et TypeScript. J'ai préféré investir mon temps là où j'avais
> quelque chose à apprendre.
>
> On peut me poser la question inverse : pourquoi pas Node, pour rester en TypeScript des
> deux côtés ? C'est l'argument le plus sérieux, et il est bon — un seul langage, des types
> partagés. Mais avec Express j'aurais dû assembler moi-même l'ORM, la validation, le CORS et
> le back-office. Laravel me les donnait déjà.

**Si on te demande pourquoi il n'y a pas de filtre par catégorie dans l'API** (c'est la
question la plus probable) :

> Aujourd'hui le front récupère les soixante-dix questions et filtre localement. À cette
> échelle ça fonctionne très bien, et c'est un choix, pas un oubli. Mais la bonne évolution
> serait un paramètre `?categorie=` sur la route : moins de données transférées, et le tirage
> des dix questions remonterait côté serveur.

---

## Slide 7 — Le modèle de données · 1 min 15

*Affiché : la ligne de la table `questions`, avec `reponse1` en doré.*

> Troisième point : le stockage. C'est du MySQL, avec deux tables utiles : `categories` et
> `questions`.
>
> La particularité est là : les dix réponses ne sont pas dans une table séparée, ce sont dix
> colonnes de la table `questions` — `reponse1` jusqu'à `reponse10`. Et il n'y a pas de
> colonne « bonne réponse » : par convention, c'est toujours `reponse1`. Le formulaire de
> saisie l'indique d'ailleurs littéralement : son premier champ s'appelle « Réponse 1, bonne
> réponse ».
>
> Le front reçoit donc les dix réponses, en tire trois fausses au hasard, ajoute la bonne, et
> mélange le tout avant d'afficher.

---

## Slide 8 — Un choix assumé · 1 min 15

*Affiché : ce qu'on y gagne / ce qu'on y perd.*

> Ce modèle est un arbitrage, et je préfère en parler avant qu'on me le reproche.
>
> Ce que j'y gagne : une seule requête, aucune jointure, un formulaire de saisie évident, et
> le nombre de réponses garanti par le schéma — le sujet en imposait exactement dix.
>
> Ce que j'y perds, et c'est réel : le modèle n'est pas normalisé. Passer à douze réponses
> demanderait une migration. La position de la bonne réponse est une convention, pas une
> contrainte de base de données — rien n'empêche quelqu'un de se tromper de champ. Et la
> catégorie est liée par son libellé, pas par une clé étrangère : si je renomme une
> catégorie, ses questions deviennent orphelines.
>
> Pour une vraie application, j'écrirais une table `reponses` avec une colonne
> « est correcte », et un `categorie_id` en clé étrangère.

---

## Slide 9 — Le seeder · 45 s

*Affiché : `php artisan db:seed`, et les trois bénéfices.*

> Dernier point sur les données : comment la base est remplie. Plutôt que de saisir
> soixante-dix questions dans un formulaire, je les ai décrites dans un seeder Laravel.
>
> Trois avantages : c'est versionné, les questions sont dans Git et se relisent comme du
> code ; c'est rejouable, relancer la commande ne crée aucun doublon ; et c'est
> reproductible, la base se reconstruit à l'identique sur n'importe quelle machine — sans même
> avoir besoin de l'export SQL.

---

## Slide 10 — L'architecture · 1 min 30

*Affiché : l'arborescence, et la règle du projet.*

> Quatrième point : l'architecture du front.
>
> La règle que je me suis fixée tient en une phrase : un composant affiche, un hook décide, un
> service parle au réseau.
>
> Concrètement : `pages` contient une page par route. `components` les briques d'affichage,
> avec un fichier CSS par composant — les CSS Modules garantissent qu'aucun nom de classe ne
> peut entrer en collision. `hooks` porte la logique. `services` est le seul endroit de tout
> le projet qui connaît `fetch` : si l'API change d'adresse, je modifie un fichier. `utils`
> regroupe des fonctions pures, `types` les types de l'API et du métier, `styles` la charte.
>
> L'exemple le plus parlant : la page du quiz ne contient ni `fetch` ni `setInterval`. Elle
> assemble quatre choses — le hook de partie, le hook de compte à rebours, le timer et la
> carte de question.
>
> Côté navigation, quatre routes : accueil, catégories, quiz, résultat. Le score passe d'une
> page à l'autre par l'état de navigation, et si on arrive directement sur la page de résultat
> sans avoir joué, on est renvoyé à l'accueil.

---

## Slide 11 — La machine à états · 1 min 15

*Affiché : loading → playing ⇄ revealing → finished.*

> Le déroulé d'une partie est une petite machine à états, et tout tient dans un seul hook
> d'environ cent cinquante lignes.
>
> `loading`, les questions arrivent de l'API. `playing`, le timer tourne et on peut cliquer.
> `revealing`, la réponse se colore en vert ou en rouge pendant une seconde et deux dixièmes.
> Puis on repart en `playing` pour la question suivante, et ainsi de suite dix fois, jusqu'à
> `finished` où le score devient définitif.
>
> Deux détails qui comptent. Si le timer arrive à zéro sans clic, on enchaîne immédiatement,
> sans point marqué — c'était demandé dans le sujet. Et cet état `revealing` sert aussi à
> empêcher de cliquer deux fois pendant la correction : les boutons sont désactivés.

---

## Slide 12 — L'extrait de code · 1 min 45

*Affiché : la fonction `toQuizQuestion`.*

> Cinquième point, un extrait de code. J'ai choisi celui-ci parce que c'est le cœur de
> l'énoncé : dix réponses en base, quatre affichées dont la bonne.

*Laisse trois secondes de lecture avant de continuer.*

> La fonction reçoit une question telle que l'API la renvoie. La première ligne sépare la
> bonne réponse — `reponse1` — des neuf autres. Ensuite je dédoublonne les mauvaises réponses
> et j'en tire trois au hasard. Et la ligne en doré, en bas : je remets la bonne réponse avec
> les trois mauvaises, et je mélange. Le joueur reçoit quatre propositions dans un ordre
> différent à chaque partie.

---

## Slide 13 — Ce que cet extrait montre · 45 s

*Affiché : les quatre points.*

> Quatre choses sur ce code.
>
> C'est une fonction pure : mêmes entrées, même sortie, aucun effet de bord. Je peux la tester
> sans React et sans API.
>
> Le dédoublonnage n'est pas cosmétique : sans lui, une question dont deux réponses sont
> identiques afficherait deux fois la même proposition — donc potentiellement deux bonnes
> réponses.
>
> Le typage, c'est tout l'intérêt de TypeScript ici : un type décrit ce que renvoie l'API, un
> autre ce dont l'affichage a besoin. La frontière entre les deux est explicite. Si un champ
> est renommé côté back, la compilation échoue — en JavaScript, la page afficherait
> « undefined » en production sans prévenir.
>
> Enfin, cette préparation se fait une fois par partie, pas à chaque rendu. C'est ce qui
> m'amène aux difficultés.

---

## Slide 14 — Les difficultés · 1 min 30

*Affiché : les trois difficultés.*

> **À réécrire avec tes mots et tes essais ratés — le jury cherche du vécu, pas une liste.
> La trame ci-dessous est là pour t'appuyer, pas pour être récitée.**

> Trois vraies difficultés.
>
> La première, le timer. Un `setInterval` dans un composant React se relance à chaque rendu si
> on n'y prend pas garde : mon compte à rebours redémarrait tout seul. Il a fallu l'isoler
> dans un hook dédié, le nettoyer quand le composant disparaît, et stocker la fonction de fin
> dans une référence pour qu'elle ne relance pas l'intervalle.
>
> La deuxième, justement, les propositions qui se remélangeaient. Mon premier réflexe avait
> été de tirer les quatre réponses au moment de l'affichage. Résultat : elles changeaient de
> place à chaque rendu, sous les doigts du joueur. J'ai déplacé le tirage dans la préparation
> de la partie.
>
> La troisième, le double-clic. Pendant la seconde de correction, rien n'empêchait de répondre
> une deuxième fois et de marquer deux points. C'est de là qu'est né l'état `revealing`.

---

## Slide 15 — Démonstration · 3 min

*Bascule sur le navigateur, en mode responsive mobile (F12, icône téléphone).*

Ordre à suivre :

1. l'accueil : logo et titre ;
2. les catégories — ouvre l'onglet Réseau pour montrer qu'elles viennent de l'API ;
3. une bonne réponse → vert ;
4. une mauvaise → rouge, et la bonne apparaît en vert ;
5. **laisse le timer s'écouler sans cliquer** → passage automatique ;
6. termine la partie → l'écran de score.

Ne commente pas chaque clic. Le moment le plus démonstratif est le timer qui s'épuise : laisse
le silence faire.

**À vérifier dix minutes avant de passer** : MySQL démarré, `php artisan serve` lancé,
`npm run dev` lancé, la page déjà ouverte.

---

## Slide 16 — Merci · 20 s

*Affiché : le lien du dépôt.*

> Voilà pour Culture Quiz. Tout est sur ce dépôt : le front React, l'API Laravel, l'export SQL
> de la base et un document qui détaille mes choix techniques. Je suis à vous pour les
> questions.

---

## Les questions du jury

Ces réponses n'ont plus de slide dédiée : garde-les en tête.

| La question | La réponse, en une phrase |
| --- | --- |
| Comment avez-vous réparti les missions ? | Projet réalisé seul. La base et l'API d'abord, puis le front, puis le contenu — pour que le front ait toujours de vraies données à afficher. |
| Pourquoi React **avec** TypeScript ? | Le contrat avec l'API est typé : un champ renommé côté back casse la compilation, pas la page en production. |
| Pourquoi pas Redux ou un état global ? | L'état d'une partie ne vit que dans une seule page. Un hook suffit ; Redux serait de la complexité gratuite. |
| Pourquoi CSS Modules et pas Tailwind ? | Zéro dépendance, le style reste à côté de son composant, et les noms de classes ne peuvent pas entrer en collision. |
| Et si on triche via l'onglet Réseau ? | C'est possible, la bonne réponse transite en clair. Pour un jeu avec classement, il faudrait valider la réponse côté serveur. |
| Moins de 10 questions dans une catégorie ? | La partie se joue sur le nombre disponible, et le score est calculé sur ce total. |
| Pourquoi pas de filtre par catégorie dans l'API ? | Voir le texte de la slide 6. |

Le détail des choix techniques et des alternatives écartées est dans
[`CHOIX-TECHNIQUES.md`](CHOIX-TECHNIQUES.md).

---

## Le minutage

| Slides | Durée cumulée |
| --- | --- |
| 1–3 · introduction | 1 min 30 |
| 4 · choix graphique | 4 min |
| 5–6 · l'API | 7 min 15 |
| 7–9 · le stockage | 10 min 30 |
| 10–11 · l'architecture | 13 min 15 |
| 12–13 · le code | 15 min 45 |
| 14 · les difficultés | 17 min 15 |
| 15 · la démo | 20 min 15 |
| 16 · merci | 20 min 35 |

Prévois deux à trois minutes de battement : on parle toujours plus vite qu'à la répétition, et
le jury interrompt. Si tu dois couper, la slide 9 (le seeder) et la slide 13 (les points du
code) sont les plus faciles à raccourcir.
