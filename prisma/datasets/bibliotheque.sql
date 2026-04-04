-- ============================================
-- Dataset: Bibliotheque Municipale (SQL Clinic)
-- Base de donnees SQLite - Donnees francophones
-- ============================================

-- Suppression des tables existantes
DROP TABLE IF EXISTS emprunts;
DROP TABLE IF EXISTS livres;
DROP TABLE IF EXISTS adherents;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS auteurs;

-- ============================================
-- CREATION DES TABLES
-- ============================================

CREATE TABLE auteurs (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    nationalite TEXT NOT NULL,
    date_naissance TEXT NOT NULL
);

CREATE TABLE genres (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    description TEXT
);

CREATE TABLE livres (
    id INTEGER PRIMARY KEY,
    titre TEXT NOT NULL,
    auteur_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    annee_publication INTEGER NOT NULL,
    isbn TEXT NOT NULL,
    pages INTEGER NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (auteur_id) REFERENCES auteurs(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE adherents (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    email TEXT NOT NULL,
    ville TEXT NOT NULL,
    date_inscription TEXT NOT NULL,
    abonnement TEXT NOT NULL CHECK(abonnement IN ('standard', 'premium', 'etudiant'))
);

CREATE TABLE emprunts (
    id INTEGER PRIMARY KEY,
    adherent_id INTEGER NOT NULL,
    livre_id INTEGER NOT NULL,
    date_emprunt TEXT NOT NULL,
    date_retour_prevue TEXT NOT NULL,
    date_retour_effective TEXT,
    FOREIGN KEY (adherent_id) REFERENCES adherents(id),
    FOREIGN KEY (livre_id) REFERENCES livres(id)
);

-- ============================================
-- INSERTION DES DONNEES
-- ============================================

-- Auteurs (8)
INSERT INTO auteurs (id, nom, prenom, nationalite, date_naissance) VALUES
(1, 'Hugo', 'Victor', 'Francaise', '1802-02-26'),
(2, 'Zola', 'Emile', 'Francaise', '1840-04-02'),
(3, 'Camus', 'Albert', 'Francaise', '1913-11-07'),
(4, 'de Beauvoir', 'Simone', 'Francaise', '1908-01-09'),
(5, 'Murakami', 'Haruki', 'Japonaise', '1949-01-12'),
(6, 'Orwell', 'George', 'Britannique', '1903-06-25'),
(7, 'Garcia Marquez', 'Gabriel', 'Colombienne', '1927-03-06'),
(8, 'Christie', 'Agatha', 'Britannique', '1890-09-15');

-- Genres (6)
INSERT INTO genres (id, nom, description) VALUES
(1, 'Roman', 'Oeuvres de fiction narratives longues'),
(2, 'Science-fiction', 'Recits bases sur des avancees scientifiques ou technologiques'),
(3, 'Policier', 'Enquetes, mysteres et suspense'),
(4, 'Philosophie', 'Reflexions sur l''existence, la morale et la societe'),
(5, 'Poesie', 'Oeuvres en vers ou en prose poetique'),
(6, 'Fantasy', 'Recits dans des univers imaginaires avec elements magiques');

-- Livres (30)
INSERT INTO livres (id, titre, auteur_id, genre_id, annee_publication, isbn, pages, stock) VALUES
(1, 'Les Miserables', 1, 1, 1862, '978-2-07-040850-4', 1900, 4),
(2, 'Notre-Dame de Paris', 1, 1, 1831, '978-2-07-041239-6', 940, 3),
(3, 'Les Contemplations', 1, 5, 1856, '978-2-07-041279-2', 380, 2),
(4, 'Germinal', 2, 1, 1885, '978-2-07-036024-6', 592, 5),
(5, 'L''Assommoir', 2, 1, 1877, '978-2-07-036880-8', 508, 2),
(6, 'Nana', 2, 1, 1880, '978-2-07-036025-3', 480, 3),
(7, 'Au Bonheur des Dames', 2, 1, 1883, '978-2-07-036884-6', 520, 1),
(8, 'L''Etranger', 3, 4, 1942, '978-2-07-036024-5', 186, 6),
(9, 'La Peste', 3, 1, 1947, '978-2-07-036042-9', 352, 4),
(10, 'Le Mythe de Sisyphe', 3, 4, 1942, '978-2-07-032288-5', 192, 2),
(11, 'La Chute', 3, 4, 1956, '978-2-07-036120-4', 153, 3),
(12, 'Le Deuxieme Sexe', 4, 4, 1949, '978-2-07-032351-6', 408, 2),
(13, 'Les Mandarins', 4, 1, 1954, '978-2-07-036786-3', 576, 1),
(14, 'Memoires d''une jeune fille rangee', 4, 1, 1958, '978-2-07-036793-1', 474, 3),
(15, 'Kafka sur le rivage', 5, 1, 2002, '978-2-264-03887-3', 638, 4),
(16, '1Q84 Livre 1', 5, 2, 2009, '978-2-264-05699-0', 550, 3),
(17, 'La Ballade de l''impossible', 5, 1, 1987, '978-2-02-024360-4', 382, 2),
(18, 'Chroniques de l''oiseau a ressort', 5, 1, 1994, '978-2-02-063020-0', 720, 1),
(19, '1984', 6, 2, 1949, '978-2-07-036822-8', 376, 5),
(20, 'La Ferme des animaux', 6, 1, 1945, '978-2-07-036024-7', 150, 4),
(21, 'Cent ans de solitude', 7, 1, 1967, '978-2-02-006020-7', 468, 3),
(22, 'L''Amour aux temps du cholera', 7, 1, 1985, '978-2-246-38831-9', 485, 2),
(23, 'Chronique d''une mort annoncee', 7, 1, 1981, '978-2-246-25981-7', 120, 4),
(24, 'Le Meurtre de Roger Ackroyd', 8, 3, 1926, '978-2-7024-2587-3', 312, 3),
(25, 'Dix Petits Negres', 8, 3, 1939, '978-2-7024-2141-7', 220, 5),
(26, 'Le Crime de l''Orient-Express', 8, 3, 1934, '978-2-7024-2149-3', 256, 4),
(27, 'Mort sur le Nil', 8, 3, 1937, '978-2-7024-2261-2', 340, 2),
(28, 'Les Quatre', 8, 3, 1927, '978-2-7024-2703-7', 224, 1),
(29, 'L''Homme qui plantait des arbres', 1, 1, 1953, '978-2-07-040850-5', 52, 6),
(30, '1Q84 Livre 2', 5, 2, 2009, '978-2-264-05700-3', 580, 3);

-- Adherents (25)
INSERT INTO adherents (id, nom, prenom, email, ville, date_inscription, abonnement) VALUES
(1, 'Dupont', 'Marie', 'marie.dupont@email.fr', 'Paris', '2022-01-15', 'premium'),
(2, 'Martin', 'Lucas', 'lucas.martin@email.fr', 'Lyon', '2022-03-20', 'standard'),
(3, 'Bernard', 'Sophie', 'sophie.bernard@email.fr', 'Marseille', '2022-05-10', 'etudiant'),
(4, 'Petit', 'Thomas', 'thomas.petit@email.fr', 'Paris', '2022-06-01', 'standard'),
(5, 'Durand', 'Emma', 'emma.durand@email.fr', 'Toulouse', '2022-07-15', 'premium'),
(6, 'Leroy', 'Hugo', 'hugo.leroy@email.fr', 'Nice', '2022-08-22', 'etudiant'),
(7, 'Moreau', 'Camille', 'camille.moreau@email.fr', 'Nantes', '2022-09-05', 'standard'),
(8, 'Simon', 'Jules', 'jules.simon@email.fr', 'Strasbourg', '2022-10-12', 'premium'),
(9, 'Laurent', 'Lea', 'lea.laurent@email.fr', 'Bordeaux', '2023-01-08', 'etudiant'),
(10, 'Lefebvre', 'Antoine', 'antoine.lefebvre@email.fr', 'Paris', '2023-02-14', 'standard'),
(11, 'Michel', 'Clara', 'clara.michel@email.fr', 'Lyon', '2023-03-22', 'premium'),
(12, 'Garcia', 'Noah', 'noah.garcia@email.fr', 'Marseille', '2023-04-18', 'etudiant'),
(13, 'David', 'Alice', 'alice.david@email.fr', 'Lille', '2023-05-30', 'standard'),
(14, 'Bertrand', 'Louis', 'louis.bertrand@email.fr', 'Toulouse', '2023-06-25', 'standard'),
(15, 'Roux', 'Manon', 'manon.roux@email.fr', 'Nice', '2023-07-10', 'premium'),
(16, 'Vincent', 'Gabriel', 'gabriel.vincent@email.fr', 'Nantes', '2023-08-15', 'etudiant'),
(17, 'Fournier', 'Jade', 'jade.fournier@email.fr', 'Bordeaux', '2023-09-20', 'standard'),
(18, 'Girard', 'Raphael', 'raphael.girard@email.fr', 'Paris', '2023-10-05', 'premium'),
(19, 'Bonnet', 'Ines', 'ines.bonnet@email.fr', 'Strasbourg', '2023-11-12', 'etudiant'),
(20, 'Mercier', 'Ethan', 'ethan.mercier@email.fr', 'Lyon', '2024-01-08', 'standard'),
(21, 'Blanc', 'Chloe', 'chloe.blanc@email.fr', 'Marseille', '2024-02-20', 'premium'),
(22, 'Guerin', 'Maxime', 'maxime.guerin@email.fr', 'Lille', '2024-03-15', 'standard'),
(23, 'Boyer', 'Lina', 'lina.boyer@email.fr', 'Toulouse', '2024-04-22', 'etudiant'),
(24, 'Faure', 'Adam', 'adam.faure@email.fr', 'Paris', '2024-05-30', 'standard'),
(25, 'Lemoine', 'Sarah', 'sarah.lemoine@email.fr', 'Nice', '2024-06-10', 'premium');

-- Emprunts (40)
-- Dates de reference: aujourd'hui ~ 2026-04-04
-- date_retour_prevue = date_emprunt + 21 jours
-- Certains rendus (date_retour_effective renseignee), d'autres en cours, certains en retard
INSERT INTO emprunts (id, adherent_id, livre_id, date_emprunt, date_retour_prevue, date_retour_effective) VALUES
(1,  1,  1,  '2025-06-01', '2025-06-22', '2025-06-20'),
(2,  1,  8,  '2025-07-10', '2025-07-31', '2025-07-28'),
(3,  2,  4,  '2025-06-15', '2025-07-06', '2025-07-10'),
(4,  3,  19, '2025-07-01', '2025-07-22', '2025-07-20'),
(5,  4,  24, '2025-08-05', '2025-08-26', '2025-08-25'),
(6,  5,  15, '2025-08-20', '2025-09-10', '2025-09-08'),
(7,  6,  21, '2025-09-01', '2025-09-22', '2025-09-30'),
(8,  7,  9,  '2025-09-15', '2025-10-06', '2025-10-05'),
(9,  8,  12, '2025-10-01', '2025-10-22', '2025-10-18'),
(10, 9,  25, '2025-10-10', '2025-10-31', '2025-10-29'),
(11, 10, 2,  '2025-11-01', '2025-11-22', '2025-11-20'),
(12, 11, 16, '2025-11-15', '2025-12-06', '2025-12-04'),
(13, 12, 6,  '2025-12-01', '2025-12-22', '2025-12-20'),
(14, 13, 26, '2025-12-10', '2025-12-31', '2025-12-28'),
(15, 14, 11, '2026-01-05', '2026-01-26', '2026-01-24'),
(16, 15, 22, '2026-01-15', '2026-02-05', '2026-02-03'),
(17, 1,  3,  '2026-01-20', '2026-02-10', '2026-02-08'),
(18, 2,  19, '2026-02-01', '2026-02-22', '2026-02-20'),
(19, 3,  8,  '2026-02-10', '2026-03-03', '2026-03-01'),
(20, 4,  14, '2026-02-15', '2026-03-08', '2026-03-06'),
(21, 5,  27, '2026-02-20', '2026-03-13', '2026-03-12'),
(22, 16, 1,  '2026-02-25', '2026-03-18', '2026-03-15'),
(23, 17, 20, '2026-03-01', '2026-03-22', '2026-03-20'),
(24, 18, 5,  '2026-03-05', '2026-03-26', '2026-03-24'),
(25, 19, 10, '2026-03-08', '2026-03-29', '2026-03-28'),
(26, 20, 23, '2026-03-10', '2026-03-31', '2026-03-30'),
(27, 21, 17, '2026-03-12', '2026-04-02', '2026-04-01'),
(28, 22, 29, '2026-03-14', '2026-04-04', NULL),
(29, 23, 7,  '2026-03-15', '2026-04-05', NULL),
(30, 24, 13, '2026-03-16', '2026-04-06', NULL),
(31, 25, 30, '2026-03-18', '2026-04-08', NULL),
(32, 1,  21, '2026-03-20', '2026-04-10', NULL),
(33, 2,  26, '2026-03-20', '2026-04-10', NULL),
(34, 6,  4,  '2026-03-22', '2026-04-12', NULL),
(35, 8,  18, '2026-03-25', '2026-04-15', NULL),
(36, 11, 9,  '2026-03-25', '2026-04-15', NULL),
(37, 10, 15, '2025-12-15', '2026-01-05', NULL),
(38, 3,  25, '2026-01-10', '2026-01-31', NULL),
(39, 14, 28, '2026-02-01', '2026-02-22', NULL),
(40, 7,  16, '2026-02-15', '2026-03-08', NULL);
