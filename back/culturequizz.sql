
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `culturequizz` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `culturequizz`;
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `categorie` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Histoire','2026-09-22 10:28:56','2026-09-22 10:28:56'),(2,'Cinéma','2026-09-22 10:28:57','2026-09-22 10:28:57'),(3,'Sport','2026-09-22 10:28:57','2026-09-22 10:28:57'),(4,'Littérature','2026-09-22 10:36:01','2026-09-22 10:36:01'),(5,'Sciences et Nature','2026-09-22 10:36:01','2026-09-22 10:36:01'),(6,'Divertissement et Médias','2026-09-22 10:36:01','2026-09-22 10:36:01'),(7,'Culture générale','2026-09-22 10:36:01','2026-09-22 10:36:01');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `parties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parties` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `idjoueur` int NOT NULL,
  `score` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `parties` WRITE;
/*!40000 ALTER TABLE `parties` DISABLE KEYS */;
/*!40000 ALTER TABLE `parties` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `categorie` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse6` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse7` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse8` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse9` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reponse10` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Histoire','En quelle année a eu lieu la prise de la Bastille ?','1789','1776','1792','1804','1815','1830','1848','1799','1770','1685','2026-09-22 10:28:56','2026-09-22 10:28:56'),(2,'Histoire','Qui fut le premier empereur des Français ?','Napoléon Bonaparte','Louis XVI','Charlemagne','Napoléon III','Louis XIV','Robespierre','Clovis','Henri IV','François Ier','Philippe Auguste','2026-09-22 10:28:56','2026-09-22 10:28:56'),(3,'Histoire','Quel mur est tombé en 1989 ?','Le mur de Berlin','La Grande Muraille de Chine','Le mur d\'Hadrien','Le mur des Lamentations','Le mur de l\'Atlantique','La ligne Maginot','Le mur d\'Antonin','Le mur de Nicosie','Le limes germanique','Le mur de Belfast','2026-09-22 10:28:56','2026-09-22 10:28:56'),(4,'Histoire','Qui atteint les Amériques en 1492 ?','Christophe Colomb','Vasco de Gama','Fernand de Magellan','Marco Polo','Amerigo Vespucci','Jacques Cartier','Leif Erikson','James Cook','Hernán Cortés','Francis Drake','2026-09-22 10:28:56','2026-09-22 10:28:56'),(5,'Histoire','Quelle civilisation a construit le Machu Picchu ?','Les Incas','Les Mayas','Les Aztèques','Les Olmèques','Les Toltèques','Les Nazcas','Les Mochicas','Les Chimús','Les Zapotèques','Les Guaranis','2026-09-22 10:28:56','2026-09-22 10:28:56'),(6,'Histoire','En quelle année s\'est terminée la Seconde Guerre mondiale ?','1945','1918','1939','1944','1946','1940','1943','1941','1919','1950','2026-09-22 10:28:56','2026-09-22 10:28:56'),(7,'Histoire','Quel roi de France était surnommé « le Roi-Soleil » ?','Louis XIV','Louis XIII','Louis XV','Louis XVI','François Ier','Henri IV','Charles X','Philippe le Bel','Saint Louis','Louis XI','2026-09-22 10:28:57','2026-09-22 10:28:57'),(8,'Histoire','Quelle reine d\'Égypte a régné aux côtés de Marc Antoine ?','Cléopâtre VII','Néfertiti','Hatchepsout','Nitocris','Bérénice','Arsinoé II','Ânkhesenamon','Tiyi','Sobekneferou','Cléopâtre Séléné','2026-09-22 10:28:57','2026-09-22 10:28:57'),(9,'Histoire','Quel événement déclenche la Première Guerre mondiale en 1914 ?','L\'assassinat de l\'archiduc François-Ferdinand','L\'invasion de la Pologne','Le naufrage du Lusitania','La bataille de Verdun','Le traité de Versailles','La révolution russe','L\'incendie du Reichstag','La chute de l\'Empire ottoman','La crise de Cuba','Le blocus de Berlin','2026-09-22 10:28:57','2026-09-22 10:28:57'),(10,'Histoire','Qui a lancé l\'Appel du 18 Juin 1940 ?','Charles de Gaulle','Philippe Pétain','Winston Churchill','Georges Clemenceau','Jean Moulin','Léon Blum','Paul Reynaud','Édouard Daladier','Maurice Thorez','René Coty','2026-09-22 10:28:57','2026-09-22 10:28:57'),(11,'Cinéma','Qui a réalisé « Pulp Fiction » ?','Quentin Tarantino','Martin Scorsese','Steven Spielberg','David Fincher','Ridley Scott','Christopher Nolan','Joel Coen','Tim Burton','Wes Anderson','Paul Thomas Anderson','2026-09-22 10:28:57','2026-09-22 10:28:57'),(12,'Cinéma','Quel film a remporté l\'Oscar du meilleur film en 2020 ?','Parasite','1917','Joker','Green Book','Roma','La La Land','Nomadland','The Irishman','Once Upon a Time in Hollywood','Moonlight','2026-09-22 10:28:57','2026-09-22 10:28:57'),(13,'Cinéma','Dans quel film de la saga Star Wars entend-on « Je suis ton père » ?','L\'Empire contre-attaque','Un nouvel espoir','Le Retour du Jedi','La Menace fantôme','L\'Attaque des clones','La Revanche des Sith','Le Réveil de la Force','Les Derniers Jedi','Rogue One','Solo','2026-09-22 10:28:57','2026-09-22 10:28:57'),(14,'Cinéma','Quel acteur incarne Jack Dawson dans « Titanic » ?','Leonardo DiCaprio','Brad Pitt','Matt Damon','Tom Cruise','Johnny Depp','Ben Affleck','Ethan Hawke','Christian Bale','Keanu Reeves','Joaquin Phoenix','2026-09-22 10:28:57','2026-09-22 10:28:57'),(15,'Cinéma','Quel studio a produit « Le Roi Lion » en 1994 ?','Disney','Pixar','DreamWorks','Warner Bros.','Universal','Illumination','Studio Ghibli','Sony Pictures Animation','Blue Sky Studios','Paramount','2026-09-22 10:28:57','2026-09-22 10:28:57'),(16,'Cinéma','Qui a composé la musique de « Star Wars » ?','John Williams','Hans Zimmer','Ennio Morricone','Danny Elfman','Howard Shore','James Horner','Alexandre Desplat','Michael Giacchino','Vangelis','Jerry Goldsmith','2026-09-22 10:28:57','2026-09-22 10:28:57'),(17,'Cinéma','Quel festival décerne la Palme d\'or ?','Le Festival de Cannes','La Mostra de Venise','La Berlinale','Le Festival de Deauville','Les Oscars','Les César','Le Festival de Sundance','Le Festival de Toronto','Le Festival de Locarno','Les Golden Globes','2026-09-22 10:28:57','2026-09-22 10:28:57'),(18,'Cinéma','Qui a réalisé « Le Voyage de Chihiro » ?','Hayao Miyazaki','Isao Takahata','Makoto Shinkai','Mamoru Hosoda','Satoshi Kon','Katsuhiro Ōtomo','Gorō Miyazaki','Hideaki Anno','Naoko Yamada','Osamu Tezuka','2026-09-22 10:28:57','2026-09-22 10:28:57'),(19,'Cinéma','Quel acteur joue Iron Man dans les films Marvel ?','Robert Downey Jr.','Chris Evans','Chris Hemsworth','Mark Ruffalo','Jeremy Renner','Paul Rudd','Benedict Cumberbatch','Tom Holland','Sebastian Stan','Don Cheadle','2026-09-22 10:28:57','2026-09-22 10:28:57'),(20,'Cinéma','Dans « Matrix », quelle pilule Neo choisit-il ?','La pilule rouge','La pilule bleue','La pilule verte','La pilule jaune','La pilule blanche','La pilule noire','La pilule violette','La pilule orange','Les deux pilules','Aucune des deux','2026-09-22 10:28:57','2026-09-22 10:28:57'),(21,'Sport','Combien de joueurs composent une équipe de football sur le terrain ?','11','10','12','9','13','15','7','8','14','5','2026-09-22 10:28:57','2026-09-22 10:28:57'),(22,'Sport','Quel pays a remporté la Coupe du monde de football 2018 ?','La France','La Croatie','Le Brésil','L\'Allemagne','L\'Argentine','L\'Espagne','L\'Italie','La Belgique','L\'Angleterre','Le Portugal','2026-09-22 10:28:57','2026-09-22 10:28:57'),(23,'Sport','Tous les combien d\'années ont lieu les Jeux olympiques d\'été ?','Tous les 4 ans','Tous les 2 ans','Tous les 3 ans','Tous les 5 ans','Tous les 6 ans','Tous les 8 ans','Tous les 10 ans','Tous les ans','Tous les 7 ans','Tous les 12 ans','2026-09-22 10:28:57','2026-09-22 10:28:57'),(24,'Sport','Quel sport Rafael Nadal pratique-t-il ?','Le tennis','Le golf','Le badminton','Le squash','Le tennis de table','Le padel','Le basket-ball','Le handball','Le volley-ball','L\'escrime','2026-09-22 10:28:57','2026-09-22 10:28:57'),(25,'Sport','Quelle est la distance officielle d\'un marathon ?','42,195 km','21,097 km','40 km','45 km','50 km','26 km','30 km','35 km','43,5 km','100 km','2026-09-22 10:28:57','2026-09-22 10:28:57'),(26,'Sport','Dans quel sport marque-t-on un « touchdown » ?','Le football américain','Le rugby','Le hockey sur glace','Le basket-ball','Le baseball','Le cricket','Le football','Le handball','Le water-polo','La crosse','2026-09-22 10:28:57','2026-09-22 10:28:57'),(27,'Sport','Quel pays a organisé les Jeux olympiques d\'été de 2024 ?','La France','Le Japon','Les États-Unis','L\'Australie','Le Brésil','La Chine','Le Royaume-Uni','L\'Italie','L\'Espagne','L\'Allemagne','2026-09-22 10:28:57','2026-09-22 10:28:57'),(28,'Sport','Combien de points vaut un tir à trois points au basket-ball ?','3 points','1 point','2 points','4 points','5 points','6 points','7 points','8 points','10 points','0 point','2026-09-22 10:28:57','2026-09-22 10:28:57'),(29,'Sport','De quelle couleur est le maillot du leader du Tour de France ?','Jaune','Vert','Blanc','À pois rouges','Rose','Arc-en-ciel','Bleu','Rouge','Noir','Orange','2026-09-22 10:28:57','2026-09-22 10:28:57'),(30,'Sport','Dans quel sport parle-t-on d\'un « birdie » ?','Le golf','Le tennis','Le badminton','Le cricket','Le baseball','Le hockey','Le bowling','Le curling','Le polo','Le squash','2026-09-22 10:28:57','2026-09-22 10:28:57'),(31,'Littérature','Qui a écrit « Les Misérables » ?','Victor Hugo','Émile Zola','Gustave Flaubert','Honoré de Balzac','Alexandre Dumas','Stendhal','Guy de Maupassant','Jules Verne','Marcel Proust','Albert Camus','2026-09-22 10:36:01','2026-09-22 10:36:01'),(32,'Littérature','Quel roman commence par « Longtemps, je me suis couché de bonne heure » ?','Du côté de chez Swann','Madame Bovary','L\'Étranger','Germinal','Le Rouge et le Noir','Voyage au bout de la nuit','La Peste','Bel-Ami','Le Père Goriot','Les Liaisons dangereuses','2026-09-22 10:36:01','2026-09-22 10:36:01'),(33,'Littérature','Qui est l\'autrice de la saga « Harry Potter » ?','J. K. Rowling','Stephenie Meyer','Suzanne Collins','Rick Riordan','C. S. Lewis','J. R. R. Tolkien','Philip Pullman','Roald Dahl','Ursula K. Le Guin','Neil Gaiman','2026-09-22 10:36:01','2026-09-22 10:36:01'),(34,'Littérature','Dans quelle pièce de Shakespeare apparaît le personnage d\'Ophélie ?','Hamlet','Macbeth','Othello','Le Roi Lear','Roméo et Juliette','La Tempête','Jules César','Le Songe d\'une nuit d\'été','Beaucoup de bruit pour rien','Richard III','2026-09-22 10:36:01','2026-09-22 10:36:01'),(35,'Littérature','Qui a écrit « Le Petit Prince » ?','Antoine de Saint-Exupéry','Jean de La Fontaine','Charles Perrault','Marcel Pagnol','Jules Verne','Albert Camus','Romain Gary','André Gide','Jean Giono','Boris Vian','2026-09-22 10:36:01','2026-09-22 10:36:01'),(36,'Littérature','Quel écrivain a créé le détective Sherlock Holmes ?','Arthur Conan Doyle','Agatha Christie','Edgar Allan Poe','Maurice Leblanc','Georges Simenon','Gaston Leroux','Raymond Chandler','Dashiell Hammett','Wilkie Collins','Charles Dickens','2026-09-22 10:36:01','2026-09-22 10:36:01'),(37,'Littérature','Qui a écrit le roman « 1984 » ?','George Orwell','Aldous Huxley','Ray Bradbury','Philip K. Dick','H. G. Wells','Isaac Asimov','Margaret Atwood','Evgueni Zamiatine','Anthony Burgess','Kurt Vonnegut','2026-09-22 10:36:01','2026-09-22 10:36:01'),(38,'Littérature','Quel poète français a écrit « Les Fleurs du mal » ?','Charles Baudelaire','Arthur Rimbaud','Paul Verlaine','Stéphane Mallarmé','Alfred de Musset','Victor Hugo','Guillaume Apollinaire','Paul Éluard','Alphonse de Lamartine','Gérard de Nerval','2026-09-22 10:36:01','2026-09-22 10:36:01'),(39,'Littérature','Qui a écrit « Madame Bovary » ?','Gustave Flaubert','Émile Zola','Honoré de Balzac','Stendhal','Guy de Maupassant','Victor Hugo','Alexandre Dumas','Marcel Proust','Alphonse Daudet','Prosper Mérimée','2026-09-22 10:36:01','2026-09-22 10:36:01'),(40,'Littérature','Dans « L\'Odyssée », quel héros cherche à rentrer à Ithaque ?','Ulysse','Achille','Hector','Agamemnon','Énée','Pâris','Ménélas','Ajax','Persée','Thésée','2026-09-22 10:36:01','2026-09-22 10:36:01'),(41,'Sciences et Nature','Quel est le symbole chimique de l\'or ?','Au','Ag','Fe','Or','Go','Cu','Pb','Sn','Hg','Zn','2026-09-22 10:36:01','2026-09-22 10:36:01'),(42,'Sciences et Nature','Combien de planètes compte le système solaire ?','8','7','9','10','6','11','12','5','13','4','2026-09-22 10:36:01','2026-09-22 10:36:01'),(43,'Sciences et Nature','Quel organe pompe le sang dans le corps humain ?','Le cœur','Le foie','Les poumons','Les reins','Le cerveau','L\'estomac','La rate','Le pancréas','Les intestins','La vessie','2026-09-22 10:36:01','2026-09-22 10:36:01'),(44,'Sciences et Nature','Quelle est la planète la plus proche du Soleil ?','Mercure','Vénus','Mars','La Terre','Jupiter','Saturne','Uranus','Neptune','Pluton','Cérès','2026-09-22 10:36:01','2026-09-22 10:36:01'),(45,'Sciences et Nature','Quel gaz les plantes absorbent-elles pour la photosynthèse ?','Le dioxyde de carbone','L\'oxygène','L\'azote','L\'hydrogène','Le méthane','L\'hélium','L\'ozone','Le monoxyde de carbone','L\'argon','Le dioxyde de soufre','2026-09-22 10:36:01','2026-09-22 10:36:01'),(46,'Sciences et Nature','Quel est le plus grand animal du monde ?','La baleine bleue','L\'éléphant d\'Afrique','Le cachalot','Le requin-baleine','La girafe','L\'orque','Le rhinocéros blanc','L\'hippopotame','Le calmar géant','Le crocodile marin','2026-09-22 10:36:01','2026-09-22 10:36:01'),(47,'Sciences et Nature','Quelle est la vitesse de la lumière dans le vide, en valeur arrondie ?','300 000 km/s','150 000 km/s','30 000 km/s','3 000 km/s','1 000 km/s','3 000 000 km/s','340 m/s','100 000 km/s','500 000 km/s','750 000 km/s','2026-09-22 10:36:01','2026-09-22 10:36:01'),(48,'Sciences et Nature','Combien d\'os compte le squelette d\'un adulte ?','206','180','212','250','300','150','198','220','320','106','2026-09-22 10:36:01','2026-09-22 10:36:01'),(49,'Sciences et Nature','Quel est le plus grand désert chaud du monde ?','Le Sahara','Le désert de Gobi','Le désert d\'Atacama','Le désert du Kalahari','Le désert de Mojave','Le désert d\'Arabie','Le désert de Sonora','Le désert du Namib','Le désert du Thar','Le Grand Désert de Victoria','2026-09-22 10:36:01','2026-09-22 10:36:01'),(50,'Sciences et Nature','Quel scientifique a formulé la théorie de la relativité ?','Albert Einstein','Isaac Newton','Galilée','Niels Bohr','Stephen Hawking','Marie Curie','Max Planck','Nikola Tesla','Charles Darwin','Louis Pasteur','2026-09-22 10:36:01','2026-09-22 10:36:01'),(51,'Divertissement et Médias','Quel réseau social avait pour logo un petit oiseau bleu ?','Twitter','Facebook','Instagram','TikTok','Snapchat','LinkedIn','YouTube','Pinterest','Reddit','WhatsApp','2026-09-22 10:36:01','2026-09-22 10:36:01'),(52,'Divertissement et Médias','Dans quel jeu vidéo incarne-t-on un plombier moustachu ?','Super Mario','Sonic','The Legend of Zelda','Minecraft','Fortnite','Pac-Man','Donkey Kong','Crash Bandicoot','Rayman','Mega Man','2026-09-22 10:36:01','2026-09-22 10:36:01'),(53,'Divertissement et Médias','Quelle plateforme de streaming a produit la série « Stranger Things » ?','Netflix','Amazon Prime Video','Disney+','Apple TV+','HBO','Canal+','Hulu','Paramount+','Crunchyroll','YouTube','2026-09-22 10:36:01','2026-09-22 10:36:01'),(54,'Divertissement et Médias','Quel groupe britannique a chanté « Hey Jude » ?','Les Beatles','Les Rolling Stones','Queen','Pink Floyd','Led Zeppelin','The Who','Oasis','Coldplay','The Kinks','Radiohead','2026-09-22 10:36:01','2026-09-22 10:36:01'),(55,'Divertissement et Médias','Comment s\'appelle le personnage principal de la série « Breaking Bad » ?','Walter White','Jesse Pinkman','Saul Goodman','Gus Fring','Hank Schrader','Tony Soprano','Don Draper','Dexter Morgan','Rick Grimes','Michael Scott','2026-09-22 10:36:01','2026-09-22 10:36:01'),(56,'Divertissement et Médias','Quelle entreprise a créé la console Switch ?','Nintendo','Sony','Microsoft','Sega','Atari','Valve','Apple','Samsung','LG','Philips','2026-09-22 10:36:01','2026-09-22 10:36:01'),(57,'Divertissement et Médias','Quel chanteur est surnommé « le roi de la pop » ?','Michael Jackson','Elvis Presley','Prince','Freddie Mercury','David Bowie','Justin Timberlake','James Brown','Stevie Wonder','Bruno Mars','Usher','2026-09-22 10:36:01','2026-09-22 10:36:01'),(58,'Divertissement et Médias','Quel site de vidéos en ligne a été racheté par Google en 2006 ?','YouTube','Dailymotion','Vimeo','Twitch','Netflix','Facebook','TikTok','Instagram','Snapchat','Flickr','2026-09-22 10:36:01','2026-09-22 10:36:01'),(59,'Divertissement et Médias','Quel super-héros protège la ville de Gotham City ?','Batman','Superman','Spider-Man','Iron Man','Flash','Wonder Woman','Green Lantern','Daredevil','Captain America','Thor','2026-09-22 10:36:01','2026-09-22 10:36:01'),(60,'Divertissement et Médias','Quelle console de jeu est fabriquée par Sony ?','La PlayStation','La Xbox','La Switch','La Wii','La Game Boy','La Dreamcast','La Mega Drive','La Nintendo 64','La GameCube','La Steam Deck','2026-09-22 10:36:01','2026-09-22 10:36:01'),(61,'Culture générale','Quelle est la capitale de la France ?','Paris','Lyon','Marseille','Bordeaux','Toulouse','Lille','Nantes','Nice','Strasbourg','Montpellier','2026-09-22 10:36:01','2026-09-22 10:36:01'),(62,'Culture générale','Combien de jours compte une année bissextile ?','366','365','364','360','367','368','370','355','362','372','2026-09-22 10:36:01','2026-09-22 10:36:01'),(63,'Culture générale','De quelle couleur est le disque au centre du drapeau du Japon ?','Rouge','Bleu','Vert','Noir','Jaune','Orange','Blanc','Violet','Rose','Gris','2026-09-22 10:36:01','2026-09-22 10:36:01'),(64,'Culture générale','Quel est le plus grand océan du monde ?','L\'océan Pacifique','L\'océan Atlantique','L\'océan Indien','L\'océan Arctique','L\'océan Austral','La mer Méditerranée','La mer des Caraïbes','La mer de Chine','La mer du Nord','La mer Noire','2026-09-22 10:36:01','2026-09-22 10:36:01'),(65,'Culture générale','Qui a peint « La Joconde » ?','Léonard de Vinci','Michel-Ange','Raphaël','Botticelli','Le Caravage','Rembrandt','Pablo Picasso','Vincent van Gogh','Claude Monet','Salvador Dalí','2026-09-22 10:36:01','2026-09-22 10:36:01'),(66,'Culture générale','Quel animal est surnommé « le roi des animaux » ?','Le lion','Le tigre','L\'éléphant','Le loup','L\'ours','Le gorille','Le léopard','La panthère','Le rhinocéros','L\'aigle','2026-09-22 10:36:01','2026-09-22 10:36:01'),(67,'Culture générale','Combien de minutes y a-t-il dans une heure ?','60','30','45','90','100','120','50','75','24','12','2026-09-22 10:36:01','2026-09-22 10:36:01'),(68,'Culture générale','Quelle monnaie utilise-t-on en France ?','L\'euro','Le franc','Le dollar','La livre sterling','Le yen','Le franc suisse','La couronne','Le peso','Le rouble','Le yuan','2026-09-22 10:36:01','2026-09-22 10:36:01'),(69,'Culture générale','Quel est le plus haut sommet du monde ?','L\'Everest','Le mont Blanc','Le K2','Le Kilimandjaro','Le mont Fuji','L\'Aconcagua','Le Cervin','Le Denali','L\'Elbrouz','Le mont Olympe','2026-09-22 10:36:01','2026-09-22 10:36:01'),(70,'Culture générale','Combien de côtés compte un hexagone ?','6','5','7','8','4','3','9','10','12','2','2026-09-22 10:36:01','2026-09-22 10:36:01');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

