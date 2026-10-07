<?php

namespace Database\Seeders;

use App\Models\Categorie;
use App\Models\Question;
use Illuminate\Database\Seeder;

/**
 * Jeu de données de départ : 3 catégories de 10 questions.
 *
 * Pour chaque question, la première réponse du tableau est la BONNE réponse
 * (elle est enregistrée dans la colonne `reponse1`, comme le veut la
 * convention de l'API) ; les neuf suivantes sont les mauvaises réponses,
 * parmi lesquelles le front en tire trois au hasard.
 */
class QuizSeeder extends Seeder
{
    private const QUIZ = [
        'Histoire' => [
            [
                'En quelle année a eu lieu la prise de la Bastille ?',
                ['1789', '1776', '1792', '1804', '1815', '1830', '1848', '1799', '1770', '1685'],
            ],
            [
                'Qui fut le premier empereur des Français ?',
                [
                    'Napoléon Bonaparte', 'Louis XVI', 'Charlemagne', 'Napoléon III', 'Louis XIV',
                    'Robespierre', 'Clovis', 'Henri IV', 'François Ier', 'Philippe Auguste',
                ],
            ],
            [
                'Quel mur est tombé en 1989 ?',
                [
                    'Le mur de Berlin', 'La Grande Muraille de Chine', 'Le mur d\'Hadrien',
                    'Le mur des Lamentations', 'Le mur de l\'Atlantique', 'La ligne Maginot',
                    'Le mur d\'Antonin', 'Le mur de Nicosie', 'Le limes germanique',
                    'Le mur de Belfast',
                ],
            ],
            [
                'Qui atteint les Amériques en 1492 ?',
                [
                    'Christophe Colomb', 'Vasco de Gama', 'Fernand de Magellan', 'Marco Polo',
                    'Amerigo Vespucci', 'Jacques Cartier', 'Leif Erikson', 'James Cook',
                    'Hernán Cortés', 'Francis Drake',
                ],
            ],
            [
                'Quelle civilisation a construit le Machu Picchu ?',
                [
                    'Les Incas', 'Les Mayas', 'Les Aztèques', 'Les Olmèques', 'Les Toltèques',
                    'Les Nazcas', 'Les Mochicas', 'Les Chimús', 'Les Zapotèques', 'Les Guaranis',
                ],
            ],
            [
                'En quelle année s\'est terminée la Seconde Guerre mondiale ?',
                ['1945', '1918', '1939', '1944', '1946', '1940', '1943', '1941', '1919', '1950'],
            ],
            [
                'Quel roi de France était surnommé « le Roi-Soleil » ?',
                [
                    'Louis XIV', 'Louis XIII', 'Louis XV', 'Louis XVI', 'François Ier', 'Henri IV',
                    'Charles X', 'Philippe le Bel', 'Saint Louis', 'Louis XI',
                ],
            ],
            [
                'Quelle reine d\'Égypte a régné aux côtés de Marc Antoine ?',
                [
                    'Cléopâtre VII', 'Néfertiti', 'Hatchepsout', 'Nitocris', 'Bérénice',
                    'Arsinoé II', 'Ânkhesenamon', 'Tiyi', 'Sobekneferou', 'Cléopâtre Séléné',
                ],
            ],
            [
                'Quel événement déclenche la Première Guerre mondiale en 1914 ?',
                [
                    'L\'assassinat de l\'archiduc François-Ferdinand', 'L\'invasion de la Pologne',
                    'Le naufrage du Lusitania', 'La bataille de Verdun', 'Le traité de Versailles',
                    'La révolution russe', 'L\'incendie du Reichstag', 'La chute de l\'Empire ottoman',
                    'La crise de Cuba', 'Le blocus de Berlin',
                ],
            ],
            [
                'Qui a lancé l\'Appel du 18 Juin 1940 ?',
                [
                    'Charles de Gaulle', 'Philippe Pétain', 'Winston Churchill',
                    'Georges Clemenceau', 'Jean Moulin', 'Léon Blum', 'Paul Reynaud',
                    'Édouard Daladier', 'Maurice Thorez', 'René Coty',
                ],
            ],
        ],

        'Cinéma' => [
            [
                'Qui a réalisé « Pulp Fiction » ?',
                [
                    'Quentin Tarantino', 'Martin Scorsese', 'Steven Spielberg', 'David Fincher',
                    'Ridley Scott', 'Christopher Nolan', 'Joel Coen', 'Tim Burton',
                    'Wes Anderson', 'Paul Thomas Anderson',
                ],
            ],
            [
                'Quel film a remporté l\'Oscar du meilleur film en 2020 ?',
                [
                    'Parasite', '1917', 'Joker', 'Green Book', 'Roma', 'La La Land', 'Nomadland',
                    'The Irishman', 'Once Upon a Time in Hollywood', 'Moonlight',
                ],
            ],
            [
                'Dans quel film de la saga Star Wars entend-on « Je suis ton père » ?',
                [
                    'L\'Empire contre-attaque', 'Un nouvel espoir', 'Le Retour du Jedi',
                    'La Menace fantôme', 'L\'Attaque des clones', 'La Revanche des Sith',
                    'Le Réveil de la Force', 'Les Derniers Jedi', 'Rogue One', 'Solo',
                ],
            ],
            [
                'Quel acteur incarne Jack Dawson dans « Titanic » ?',
                [
                    'Leonardo DiCaprio', 'Brad Pitt', 'Matt Damon', 'Tom Cruise', 'Johnny Depp',
                    'Ben Affleck', 'Ethan Hawke', 'Christian Bale', 'Keanu Reeves',
                    'Joaquin Phoenix',
                ],
            ],
            [
                'Quel studio a produit « Le Roi Lion » en 1994 ?',
                [
                    'Disney', 'Pixar', 'DreamWorks', 'Warner Bros.', 'Universal', 'Illumination',
                    'Studio Ghibli', 'Sony Pictures Animation', 'Blue Sky Studios', 'Paramount',
                ],
            ],
            [
                'Qui a composé la musique de « Star Wars » ?',
                [
                    'John Williams', 'Hans Zimmer', 'Ennio Morricone', 'Danny Elfman',
                    'Howard Shore', 'James Horner', 'Alexandre Desplat', 'Michael Giacchino',
                    'Vangelis', 'Jerry Goldsmith',
                ],
            ],
            [
                'Quel festival décerne la Palme d\'or ?',
                [
                    'Le Festival de Cannes', 'La Mostra de Venise', 'La Berlinale',
                    'Le Festival de Deauville', 'Les Oscars', 'Les César',
                    'Le Festival de Sundance', 'Le Festival de Toronto',
                    'Le Festival de Locarno', 'Les Golden Globes',
                ],
            ],
            [
                'Qui a réalisé « Le Voyage de Chihiro » ?',
                [
                    'Hayao Miyazaki', 'Isao Takahata', 'Makoto Shinkai', 'Mamoru Hosoda',
                    'Satoshi Kon', 'Katsuhiro Ōtomo', 'Gorō Miyazaki', 'Hideaki Anno',
                    'Naoko Yamada', 'Osamu Tezuka',
                ],
            ],
            [
                'Quel acteur joue Iron Man dans les films Marvel ?',
                [
                    'Robert Downey Jr.', 'Chris Evans', 'Chris Hemsworth', 'Mark Ruffalo',
                    'Jeremy Renner', 'Paul Rudd', 'Benedict Cumberbatch', 'Tom Holland',
                    'Sebastian Stan', 'Don Cheadle',
                ],
            ],
            [
                'Dans « Matrix », quelle pilule Neo choisit-il ?',
                [
                    'La pilule rouge', 'La pilule bleue', 'La pilule verte', 'La pilule jaune',
                    'La pilule blanche', 'La pilule noire', 'La pilule violette',
                    'La pilule orange', 'Les deux pilules', 'Aucune des deux',
                ],
            ],
        ],

        'Sport' => [
            [
                'Combien de joueurs composent une équipe de football sur le terrain ?',
                ['11', '10', '12', '9', '13', '15', '7', '8', '14', '5'],
            ],
            [
                'Quel pays a remporté la Coupe du monde de football 2018 ?',
                [
                    'La France', 'La Croatie', 'Le Brésil', 'L\'Allemagne', 'L\'Argentine',
                    'L\'Espagne', 'L\'Italie', 'La Belgique', 'L\'Angleterre', 'Le Portugal',
                ],
            ],
            [
                'Tous les combien d\'années ont lieu les Jeux olympiques d\'été ?',
                [
                    'Tous les 4 ans', 'Tous les 2 ans', 'Tous les 3 ans', 'Tous les 5 ans',
                    'Tous les 6 ans', 'Tous les 8 ans', 'Tous les 10 ans', 'Tous les ans',
                    'Tous les 7 ans', 'Tous les 12 ans',
                ],
            ],
            [
                'Quel sport Rafael Nadal pratique-t-il ?',
                [
                    'Le tennis', 'Le golf', 'Le badminton', 'Le squash', 'Le tennis de table',
                    'Le padel', 'Le basket-ball', 'Le handball', 'Le volley-ball', 'L\'escrime',
                ],
            ],
            [
                'Quelle est la distance officielle d\'un marathon ?',
                [
                    '42,195 km', '21,097 km', '40 km', '45 km', '50 km', '26 km', '30 km',
                    '35 km', '43,5 km', '100 km',
                ],
            ],
            [
                'Dans quel sport marque-t-on un « touchdown » ?',
                [
                    'Le football américain', 'Le rugby', 'Le hockey sur glace', 'Le basket-ball',
                    'Le baseball', 'Le cricket', 'Le football', 'Le handball', 'Le water-polo',
                    'La crosse',
                ],
            ],
            [
                'Quel pays a organisé les Jeux olympiques d\'été de 2024 ?',
                [
                    'La France', 'Le Japon', 'Les États-Unis', 'L\'Australie', 'Le Brésil',
                    'La Chine', 'Le Royaume-Uni', 'L\'Italie', 'L\'Espagne', 'L\'Allemagne',
                ],
            ],
            [
                'Combien de points vaut un tir à trois points au basket-ball ?',
                [
                    '3 points', '1 point', '2 points', '4 points', '5 points', '6 points',
                    '7 points', '8 points', '10 points', '0 point',
                ],
            ],
            [
                'De quelle couleur est le maillot du leader du Tour de France ?',
                [
                    'Jaune', 'Vert', 'Blanc', 'À pois rouges', 'Rose', 'Arc-en-ciel', 'Bleu',
                    'Rouge', 'Noir', 'Orange',
                ],
            ],
            [
                'Dans quel sport parle-t-on d\'un « birdie » ?',
                [
                    'Le golf', 'Le tennis', 'Le badminton', 'Le cricket', 'Le baseball',
                    'Le hockey', 'Le bowling', 'Le curling', 'Le polo', 'Le squash',
                ],
            ],
        ],

        'Littérature' => [
            [
                'Qui a écrit « Les Misérables » ?',
                [
                    'Victor Hugo', 'Émile Zola', 'Gustave Flaubert', 'Honoré de Balzac',
                    'Alexandre Dumas', 'Stendhal', 'Guy de Maupassant', 'Jules Verne',
                    'Marcel Proust', 'Albert Camus',
                ],
            ],
            [
                'Quel roman commence par « Longtemps, je me suis couché de bonne heure » ?',
                [
                    'Du côté de chez Swann', 'Madame Bovary', 'L\'Étranger', 'Germinal',
                    'Le Rouge et le Noir', 'Voyage au bout de la nuit', 'La Peste', 'Bel-Ami',
                    'Le Père Goriot', 'Les Liaisons dangereuses',
                ],
            ],
            [
                'Qui est l\'autrice de la saga « Harry Potter » ?',
                [
                    'J. K. Rowling', 'Stephenie Meyer', 'Suzanne Collins', 'Rick Riordan',
                    'C. S. Lewis', 'J. R. R. Tolkien', 'Philip Pullman', 'Roald Dahl',
                    'Ursula K. Le Guin', 'Neil Gaiman',
                ],
            ],
            [
                'Dans quelle pièce de Shakespeare apparaît le personnage d\'Ophélie ?',
                [
                    'Hamlet', 'Macbeth', 'Othello', 'Le Roi Lear', 'Roméo et Juliette',
                    'La Tempête', 'Jules César', 'Le Songe d\'une nuit d\'été',
                    'Beaucoup de bruit pour rien', 'Richard III',
                ],
            ],
            [
                'Qui a écrit « Le Petit Prince » ?',
                [
                    'Antoine de Saint-Exupéry', 'Jean de La Fontaine', 'Charles Perrault',
                    'Marcel Pagnol', 'Jules Verne', 'Albert Camus', 'Romain Gary', 'André Gide',
                    'Jean Giono', 'Boris Vian',
                ],
            ],
            [
                'Quel écrivain a créé le détective Sherlock Holmes ?',
                [
                    'Arthur Conan Doyle', 'Agatha Christie', 'Edgar Allan Poe', 'Maurice Leblanc',
                    'Georges Simenon', 'Gaston Leroux', 'Raymond Chandler', 'Dashiell Hammett',
                    'Wilkie Collins', 'Charles Dickens',
                ],
            ],
            [
                'Qui a écrit le roman « 1984 » ?',
                [
                    'George Orwell', 'Aldous Huxley', 'Ray Bradbury', 'Philip K. Dick',
                    'H. G. Wells', 'Isaac Asimov', 'Margaret Atwood', 'Evgueni Zamiatine',
                    'Anthony Burgess', 'Kurt Vonnegut',
                ],
            ],
            [
                'Quel poète français a écrit « Les Fleurs du mal » ?',
                [
                    'Charles Baudelaire', 'Arthur Rimbaud', 'Paul Verlaine', 'Stéphane Mallarmé',
                    'Alfred de Musset', 'Victor Hugo', 'Guillaume Apollinaire', 'Paul Éluard',
                    'Alphonse de Lamartine', 'Gérard de Nerval',
                ],
            ],
            [
                'Qui a écrit « Madame Bovary » ?',
                [
                    'Gustave Flaubert', 'Émile Zola', 'Honoré de Balzac', 'Stendhal',
                    'Guy de Maupassant', 'Victor Hugo', 'Alexandre Dumas', 'Marcel Proust',
                    'Alphonse Daudet', 'Prosper Mérimée',
                ],
            ],
            [
                'Dans « L\'Odyssée », quel héros cherche à rentrer à Ithaque ?',
                [
                    'Ulysse', 'Achille', 'Hector', 'Agamemnon', 'Énée', 'Pâris', 'Ménélas',
                    'Ajax', 'Persée', 'Thésée',
                ],
            ],
        ],

        'Sciences et Nature' => [
            [
                'Quel est le symbole chimique de l\'or ?',
                ['Au', 'Ag', 'Fe', 'Or', 'Go', 'Cu', 'Pb', 'Sn', 'Hg', 'Zn'],
            ],
            [
                'Combien de planètes compte le système solaire ?',
                ['8', '7', '9', '10', '6', '11', '12', '5', '13', '4'],
            ],
            [
                'Quel organe pompe le sang dans le corps humain ?',
                [
                    'Le cœur', 'Le foie', 'Les poumons', 'Les reins', 'Le cerveau', 'L\'estomac',
                    'La rate', 'Le pancréas', 'Les intestins', 'La vessie',
                ],
            ],
            [
                'Quelle est la planète la plus proche du Soleil ?',
                [
                    'Mercure', 'Vénus', 'Mars', 'La Terre', 'Jupiter', 'Saturne', 'Uranus',
                    'Neptune', 'Pluton', 'Cérès',
                ],
            ],
            [
                'Quel gaz les plantes absorbent-elles pour la photosynthèse ?',
                [
                    'Le dioxyde de carbone', 'L\'oxygène', 'L\'azote', 'L\'hydrogène', 'Le méthane',
                    'L\'hélium', 'L\'ozone', 'Le monoxyde de carbone', 'L\'argon',
                    'Le dioxyde de soufre',
                ],
            ],
            [
                'Quel est le plus grand animal du monde ?',
                [
                    'La baleine bleue', 'L\'éléphant d\'Afrique', 'Le cachalot', 'Le requin-baleine',
                    'La girafe', 'L\'orque', 'Le rhinocéros blanc', 'L\'hippopotame',
                    'Le calmar géant', 'Le crocodile marin',
                ],
            ],
            [
                'Quelle est la vitesse de la lumière dans le vide, en valeur arrondie ?',
                [
                    '300 000 km/s', '150 000 km/s', '30 000 km/s', '3 000 km/s', '1 000 km/s',
                    '3 000 000 km/s', '340 m/s', '100 000 km/s', '500 000 km/s', '750 000 km/s',
                ],
            ],
            [
                'Combien d\'os compte le squelette d\'un adulte ?',
                ['206', '180', '212', '250', '300', '150', '198', '220', '320', '106'],
            ],
            [
                'Quel est le plus grand désert chaud du monde ?',
                [
                    'Le Sahara', 'Le désert de Gobi', 'Le désert d\'Atacama',
                    'Le désert du Kalahari', 'Le désert de Mojave', 'Le désert d\'Arabie',
                    'Le désert de Sonora', 'Le désert du Namib', 'Le désert du Thar',
                    'Le Grand Désert de Victoria',
                ],
            ],
            [
                'Quel scientifique a formulé la théorie de la relativité ?',
                [
                    'Albert Einstein', 'Isaac Newton', 'Galilée', 'Niels Bohr', 'Stephen Hawking',
                    'Marie Curie', 'Max Planck', 'Nikola Tesla', 'Charles Darwin',
                    'Louis Pasteur',
                ],
            ],
        ],

        'Divertissement et Médias' => [
            [
                'Quel réseau social avait pour logo un petit oiseau bleu ?',
                [
                    'Twitter', 'Facebook', 'Instagram', 'TikTok', 'Snapchat', 'LinkedIn',
                    'YouTube', 'Pinterest', 'Reddit', 'WhatsApp',
                ],
            ],
            [
                'Dans quel jeu vidéo incarne-t-on un plombier moustachu ?',
                [
                    'Super Mario', 'Sonic', 'The Legend of Zelda', 'Minecraft', 'Fortnite',
                    'Pac-Man', 'Donkey Kong', 'Crash Bandicoot', 'Rayman', 'Mega Man',
                ],
            ],
            [
                'Quelle plateforme de streaming a produit la série « Stranger Things » ?',
                [
                    'Netflix', 'Amazon Prime Video', 'Disney+', 'Apple TV+', 'HBO', 'Canal+',
                    'Hulu', 'Paramount+', 'Crunchyroll', 'YouTube',
                ],
            ],
            [
                'Quel groupe britannique a chanté « Hey Jude » ?',
                [
                    'Les Beatles', 'Les Rolling Stones', 'Queen', 'Pink Floyd', 'Led Zeppelin',
                    'The Who', 'Oasis', 'Coldplay', 'The Kinks', 'Radiohead',
                ],
            ],
            [
                'Comment s\'appelle le personnage principal de la série « Breaking Bad » ?',
                [
                    'Walter White', 'Jesse Pinkman', 'Saul Goodman', 'Gus Fring', 'Hank Schrader',
                    'Tony Soprano', 'Don Draper', 'Dexter Morgan', 'Rick Grimes', 'Michael Scott',
                ],
            ],
            [
                'Quelle entreprise a créé la console Switch ?',
                [
                    'Nintendo', 'Sony', 'Microsoft', 'Sega', 'Atari', 'Valve', 'Apple', 'Samsung',
                    'LG', 'Philips',
                ],
            ],
            [
                'Quel chanteur est surnommé « le roi de la pop » ?',
                [
                    'Michael Jackson', 'Elvis Presley', 'Prince', 'Freddie Mercury', 'David Bowie',
                    'Justin Timberlake', 'James Brown', 'Stevie Wonder', 'Bruno Mars', 'Usher',
                ],
            ],
            [
                'Quel site de vidéos en ligne a été racheté par Google en 2006 ?',
                [
                    'YouTube', 'Dailymotion', 'Vimeo', 'Twitch', 'Netflix', 'Facebook', 'TikTok',
                    'Instagram', 'Snapchat', 'Flickr',
                ],
            ],
            [
                'Quel super-héros protège la ville de Gotham City ?',
                [
                    'Batman', 'Superman', 'Spider-Man', 'Iron Man', 'Flash', 'Wonder Woman',
                    'Green Lantern', 'Daredevil', 'Captain America', 'Thor',
                ],
            ],
            [
                'Quelle console de jeu est fabriquée par Sony ?',
                [
                    'La PlayStation', 'La Xbox', 'La Switch', 'La Wii', 'La Game Boy',
                    'La Dreamcast', 'La Mega Drive', 'La Nintendo 64', 'La GameCube',
                    'La Steam Deck',
                ],
            ],
        ],

        'Culture générale' => [
            [
                'Quelle est la capitale de la France ?',
                [
                    'Paris', 'Lyon', 'Marseille', 'Bordeaux', 'Toulouse', 'Lille', 'Nantes',
                    'Nice', 'Strasbourg', 'Montpellier',
                ],
            ],
            [
                'Combien de jours compte une année bissextile ?',
                ['366', '365', '364', '360', '367', '368', '370', '355', '362', '372'],
            ],
            [
                'De quelle couleur est le disque au centre du drapeau du Japon ?',
                [
                    'Rouge', 'Bleu', 'Vert', 'Noir', 'Jaune', 'Orange', 'Blanc', 'Violet',
                    'Rose', 'Gris',
                ],
            ],
            [
                'Quel est le plus grand océan du monde ?',
                [
                    'L\'océan Pacifique', 'L\'océan Atlantique', 'L\'océan Indien',
                    'L\'océan Arctique', 'L\'océan Austral', 'La mer Méditerranée',
                    'La mer des Caraïbes', 'La mer de Chine', 'La mer du Nord', 'La mer Noire',
                ],
            ],
            [
                'Qui a peint « La Joconde » ?',
                [
                    'Léonard de Vinci', 'Michel-Ange', 'Raphaël', 'Botticelli', 'Le Caravage',
                    'Rembrandt', 'Pablo Picasso', 'Vincent van Gogh', 'Claude Monet',
                    'Salvador Dalí',
                ],
            ],
            [
                'Quel animal est surnommé « le roi des animaux » ?',
                [
                    'Le lion', 'Le tigre', 'L\'éléphant', 'Le loup', 'L\'ours', 'Le gorille',
                    'Le léopard', 'La panthère', 'Le rhinocéros', 'L\'aigle',
                ],
            ],
            [
                'Combien de minutes y a-t-il dans une heure ?',
                ['60', '30', '45', '90', '100', '120', '50', '75', '24', '12'],
            ],
            [
                'Quelle monnaie utilise-t-on en France ?',
                [
                    'L\'euro', 'Le franc', 'Le dollar', 'La livre sterling', 'Le yen',
                    'Le franc suisse', 'La couronne', 'Le peso', 'Le rouble', 'Le yuan',
                ],
            ],
            [
                'Quel est le plus haut sommet du monde ?',
                [
                    'L\'Everest', 'Le mont Blanc', 'Le K2', 'Le Kilimandjaro', 'Le mont Fuji',
                    'L\'Aconcagua', 'Le Cervin', 'Le Denali', 'L\'Elbrouz', 'Le mont Olympe',
                ],
            ],
            [
                'Combien de côtés compte un hexagone ?',
                ['6', '5', '7', '8', '4', '3', '9', '10', '12', '2'],
            ],
        ],
    ];

    /**
     * Remplit les tables `categories` et `questions`.
     *
     * Le seeder est rejouable : les catégories et les questions déjà
     * présentes sont mises à jour plutôt que dupliquées.
     *
     * @return void
     */
    public function run()
    {
        foreach (self::QUIZ as $categorie => $questions) {
            Categorie::firstOrCreate(['categorie' => $categorie]);

            foreach ($questions as [$intitule, $reponses]) {
                $donnees = ['categorie' => $categorie];

                foreach ($reponses as $index => $reponse) {
                    $donnees['reponse' . ($index + 1)] = $reponse;
                }

                Question::updateOrCreate(['question' => $intitule], $donnees);
            }
        }
    }
}
