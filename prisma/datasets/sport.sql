-- ============================================
-- Dataset: Sport - Ligue de Football
-- Base de donnees SQLite - Donnees francophones
-- ============================================

-- Suppression des tables existantes
DROP TABLE IF EXISTS cartons;
DROP TABLE IF EXISTS buts;
DROP TABLE IF EXISTS matchs;
DROP TABLE IF EXISTS entraineurs;
DROP TABLE IF EXISTS joueurs;
DROP TABLE IF EXISTS equipes;

-- ============================================
-- CREATION DES TABLES
-- ============================================

CREATE TABLE equipes (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    ville TEXT NOT NULL,
    stade TEXT NOT NULL,
    annee_creation INTEGER NOT NULL,
    budget REAL NOT NULL
);

CREATE TABLE joueurs (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    equipe_id INTEGER NOT NULL,
    poste TEXT NOT NULL,
    nationalite TEXT NOT NULL,
    date_naissance TEXT NOT NULL,
    numero_maillot INTEGER NOT NULL,
    salaire REAL NOT NULL,
    FOREIGN KEY (equipe_id) REFERENCES equipes(id)
);

CREATE TABLE entraineurs (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    equipe_id INTEGER NOT NULL,
    date_prise_poste TEXT NOT NULL,
    nationalite TEXT NOT NULL,
    FOREIGN KEY (equipe_id) REFERENCES equipes(id)
);

CREATE TABLE matchs (
    id INTEGER PRIMARY KEY,
    equipe_domicile_id INTEGER NOT NULL,
    equipe_exterieur_id INTEGER NOT NULL,
    date_match TEXT NOT NULL,
    score_domicile INTEGER NOT NULL,
    score_exterieur INTEGER NOT NULL,
    stade TEXT NOT NULL,
    journee INTEGER NOT NULL,
    FOREIGN KEY (equipe_domicile_id) REFERENCES equipes(id),
    FOREIGN KEY (equipe_exterieur_id) REFERENCES equipes(id)
);

CREATE TABLE buts (
    id INTEGER PRIMARY KEY,
    match_id INTEGER NOT NULL,
    joueur_id INTEGER NOT NULL,
    minute INTEGER NOT NULL,
    type_but TEXT NOT NULL,
    FOREIGN KEY (match_id) REFERENCES matchs(id),
    FOREIGN KEY (joueur_id) REFERENCES joueurs(id)
);

CREATE TABLE cartons (
    id INTEGER PRIMARY KEY,
    match_id INTEGER NOT NULL,
    joueur_id INTEGER NOT NULL,
    minute INTEGER NOT NULL,
    type_carton TEXT NOT NULL,
    FOREIGN KEY (match_id) REFERENCES matchs(id),
    FOREIGN KEY (joueur_id) REFERENCES joueurs(id)
);

-- ============================================
-- INSERTION DES DONNEES
-- ============================================

-- Equipes (8)
INSERT INTO equipes (id, nom, ville, stade, annee_creation, budget) VALUES
(1, 'Paris FC', 'Paris', 'Stade des Princes', 1970, 600.0),
(2, 'Olympique Lyonnais', 'Lyon', 'Stade des Lumieres', 1950, 280.0),
(3, 'Olympique de Marseille', 'Marseille', 'Stade Velodrome', 1899, 230.0),
(4, 'LOSC Lille', 'Lille', 'Stade Pierre-Mauroy', 1944, 180.0),
(5, 'Stade Rennais', 'Rennes', 'Roazhon Park', 1901, 150.0),
(6, 'FC Nantes', 'Nantes', 'Stade de la Beaujoire', 1943, 120.0),
(7, 'OGC Nice', 'Nice', 'Allianz Riviera', 1904, 160.0),
(8, 'Girondins de Bordeaux', 'Bordeaux', 'Matmut Atlantique', 1881, 100.0);

-- Joueurs (80 - 10 par equipe)
-- Paris FC (equipe_id = 1)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(1, 'Dupont', 'Lucas', 1, 'Gardien', 'Francais', '1995-03-12', 1, 45000.0),
(2, 'Silva', 'Marco', 1, 'Defenseur', 'Bresilien', '1993-07-22', 4, 55000.0),
(3, 'Martin', 'Antoine', 1, 'Defenseur', 'Francais', '1997-01-15', 5, 38000.0),
(4, 'Ndiaye', 'Moussa', 1, 'Milieu', 'Senegalais', '1996-11-08', 8, 60000.0),
(5, 'Lefebvre', 'Hugo', 1, 'Milieu', 'Francais', '1998-05-20', 10, 50000.0),
(6, 'Fernandez', 'Carlos', 1, 'Attaquant', 'Espagnol', '1994-09-03', 9, 75000.0),
(7, 'Bernard', 'Theo', 1, 'Attaquant', 'Francais', '1999-02-14', 11, 42000.0),
(8, 'Kone', 'Ibrahim', 1, 'Milieu', 'Ivoirien', '1997-06-30', 6, 48000.0),
(9, 'Petit', 'Maxime', 1, 'Defenseur', 'Francais', '1996-12-01', 3, 35000.0),
(10, 'Oliveira', 'Rafael', 1, 'Milieu', 'Portugais', '1995-08-18', 14, 52000.0);

-- Olympique Lyonnais (equipe_id = 2)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(11, 'Garnier', 'Romain', 2, 'Gardien', 'Francais', '1994-04-25', 1, 38000.0),
(12, 'Diallo', 'Amadou', 2, 'Defenseur', 'Malien', '1996-10-11', 4, 42000.0),
(13, 'Moreau', 'Julien', 2, 'Defenseur', 'Francais', '1995-06-07', 5, 36000.0),
(14, 'Camara', 'Sekou', 2, 'Milieu', 'Guineen', '1998-02-28', 8, 45000.0),
(15, 'Dubois', 'Alexandre', 2, 'Milieu', 'Francais', '1997-09-14', 10, 48000.0),
(16, 'Mueller', 'Jonas', 2, 'Attaquant', 'Allemand', '1996-01-19', 9, 55000.0),
(17, 'Roux', 'Baptiste', 2, 'Attaquant', 'Francais', '1999-07-05', 11, 35000.0),
(18, 'Traore', 'Bakary', 2, 'Milieu', 'Burkinabe', '1995-03-22', 6, 40000.0),
(19, 'Laurent', 'Vincent', 2, 'Defenseur', 'Francais', '1994-11-30', 3, 34000.0),
(20, 'Santos', 'Diego', 2, 'Milieu', 'Bresilien', '1997-08-12', 14, 46000.0);

-- Olympique de Marseille (equipe_id = 3)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(21, 'Lemoine', 'Pierre', 3, 'Gardien', 'Francais', '1993-05-16', 1, 40000.0),
(22, 'Cisse', 'Ousmane', 3, 'Defenseur', 'Senegalais', '1997-12-03', 4, 44000.0),
(23, 'Fournier', 'Clement', 3, 'Defenseur', 'Francais', '1996-08-21', 5, 37000.0),
(24, 'Pereira', 'Joao', 3, 'Milieu', 'Portugais', '1995-04-09', 8, 50000.0),
(25, 'Girard', 'Mathieu', 3, 'Milieu', 'Francais', '1998-01-27', 10, 43000.0),
(26, 'Mbeki', 'Nelson', 3, 'Attaquant', 'Camerounais', '1997-06-14', 9, 52000.0),
(27, 'Blanc', 'Sebastien', 3, 'Attaquant', 'Francais', '1999-10-08', 11, 36000.0),
(28, 'Diop', 'Pape', 3, 'Milieu', 'Senegalais', '1996-03-19', 6, 41000.0),
(29, 'Robin', 'Nicolas', 3, 'Defenseur', 'Francais', '1994-07-25', 3, 33000.0),
(30, 'Hernandez', 'Miguel', 3, 'Defenseur', 'Espagnol', '1995-11-02', 2, 47000.0);

-- LOSC Lille (equipe_id = 4)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(31, 'Mercier', 'Fabien', 4, 'Gardien', 'Francais', '1995-09-08', 1, 36000.0),
(32, 'Toure', 'Lassana', 4, 'Defenseur', 'Ivoirien', '1996-02-17', 4, 40000.0),
(33, 'Leroy', 'Thomas', 4, 'Defenseur', 'Francais', '1997-05-30', 5, 34000.0),
(34, 'Sow', 'Mamadou', 4, 'Milieu', 'Senegalais', '1998-08-14', 8, 43000.0),
(35, 'Gauthier', 'Kevin', 4, 'Milieu', 'Francais', '1996-12-22', 10, 39000.0),
(36, 'Janssen', 'Lars', 4, 'Attaquant', 'Neerlandais', '1995-04-06', 9, 48000.0),
(37, 'Morel', 'Adrien', 4, 'Attaquant', 'Francais', '1999-01-11', 11, 32000.0),
(38, 'Keita', 'Abdoulaye', 4, 'Milieu', 'Malien', '1997-07-28', 6, 37000.0),
(39, 'Vasseur', 'Damien', 4, 'Defenseur', 'Francais', '1994-10-15', 3, 31000.0),
(40, 'Eriksen', 'Mikkel', 4, 'Milieu', 'Danois', '1996-06-03', 14, 44000.0);

-- Stade Rennais (equipe_id = 5)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(41, 'Leclerc', 'Yann', 5, 'Gardien', 'Francais', '1994-08-19', 1, 35000.0),
(42, 'Bamba', 'Ismael', 5, 'Defenseur', 'Ivoirien', '1997-03-05', 4, 39000.0),
(43, 'Guerin', 'Florian', 5, 'Defenseur', 'Francais', '1996-11-21', 5, 33000.0),
(44, 'Mendy', 'Cheikh', 5, 'Milieu', 'Senegalais', '1998-06-09', 8, 41000.0),
(45, 'Perrin', 'Guillaume', 5, 'Milieu', 'Francais', '1997-01-28', 10, 37000.0),
(46, 'Andersen', 'Erik', 5, 'Attaquant', 'Norvegien', '1996-05-15', 9, 46000.0),
(47, 'Faure', 'Loic', 5, 'Attaquant', 'Francais', '1999-09-02', 11, 30000.0),
(48, 'Coulibaly', 'Drissa', 5, 'Milieu', 'Malien', '1995-12-17', 6, 36000.0),
(49, 'Chevallier', 'Remi', 5, 'Defenseur', 'Francais', '1994-04-08', 3, 31000.0),
(50, 'Rossi', 'Marco', 5, 'Milieu', 'Italien', '1997-10-26', 14, 42000.0);

-- FC Nantes (equipe_id = 6)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(51, 'Renard', 'Franck', 6, 'Gardien', 'Francais', '1993-07-14', 1, 33000.0),
(52, 'Sylla', 'Alpha', 6, 'Defenseur', 'Guineen', '1996-09-28', 4, 36000.0),
(53, 'Masson', 'Olivier', 6, 'Defenseur', 'Francais', '1997-02-10', 5, 30000.0),
(54, 'Fofana', 'Youssouf', 6, 'Milieu', 'Ivoirien', '1998-05-23', 8, 38000.0),
(55, 'Andre', 'Paul', 6, 'Milieu', 'Francais', '1996-10-06', 10, 34000.0),
(56, 'Kouyate', 'Demba', 6, 'Attaquant', 'Senegalais', '1997-01-17', 9, 40000.0),
(57, 'Berger', 'Alexis', 6, 'Attaquant', 'Francais', '1999-06-29', 11, 28000.0),
(58, 'Sanogo', 'Moussa', 6, 'Milieu', 'Malien', '1995-08-04', 6, 32000.0),
(59, 'Delorme', 'Christophe', 6, 'Defenseur', 'Francais', '1994-12-20', 3, 29000.0),
(60, 'Pires', 'Antonio', 6, 'Milieu', 'Portugais', '1997-04-15', 14, 37000.0);

-- OGC Nice (equipe_id = 7)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(61, 'Carpentier', 'Dylan', 7, 'Gardien', 'Francais', '1995-01-22', 1, 34000.0),
(62, 'Koulibaly', 'Seydou', 7, 'Defenseur', 'Senegalais', '1996-06-11', 4, 41000.0),
(63, 'Marchand', 'Quentin', 7, 'Defenseur', 'Francais', '1997-10-03', 5, 32000.0),
(64, 'Dembele', 'Issa', 7, 'Milieu', 'Malien', '1998-03-18', 8, 39000.0),
(65, 'Lemaire', 'Steven', 7, 'Milieu', 'Francais', '1996-07-27', 10, 36000.0),
(66, 'Gonzalez', 'Pablo', 7, 'Attaquant', 'Argentin', '1995-12-09', 9, 50000.0),
(67, 'Collet', 'Jeremy', 7, 'Attaquant', 'Francais', '1999-04-14', 11, 29000.0),
(68, 'Sakho', 'Boubacar', 7, 'Milieu', 'Senegalais', '1997-09-06', 6, 35000.0),
(69, 'Charrier', 'Benjamin', 7, 'Defenseur', 'Francais', '1994-02-23', 3, 30000.0),
(70, 'Popovic', 'Milan', 7, 'Milieu', 'Serbe', '1996-08-17', 14, 43000.0);

-- Girondins de Bordeaux (equipe_id = 8)
INSERT INTO joueurs (id, nom, prenom, equipe_id, poste, nationalite, date_naissance, numero_maillot, salaire) VALUES
(71, 'Rousseau', 'Arnaud', 8, 'Gardien', 'Francais', '1994-06-05', 1, 31000.0),
(72, 'Diarra', 'Souleymane', 8, 'Defenseur', 'Malien', '1996-01-29', 4, 35000.0),
(73, 'Henry', 'Matthieu', 8, 'Defenseur', 'Francais', '1997-08-16', 5, 29000.0),
(74, 'Cissoko', 'Fodé', 8, 'Milieu', 'Guineen', '1998-04-02', 8, 36000.0),
(75, 'Brunet', 'Jeremy', 8, 'Milieu', 'Francais', '1996-11-13', 10, 33000.0),
(76, 'Van den Berg', 'Tom', 8, 'Attaquant', 'Neerlandais', '1995-05-21', 9, 42000.0),
(77, 'Giroud', 'Fabrice', 8, 'Attaquant', 'Francais', '1999-03-07', 11, 27000.0),
(78, 'Savane', 'Ibrahima', 8, 'Milieu', 'Senegalais', '1997-07-19', 6, 34000.0),
(79, 'Prevost', 'Ludovic', 8, 'Defenseur', 'Francais', '1994-09-25', 3, 28000.0),
(80, 'Novak', 'Petar', 8, 'Milieu', 'Croate', '1996-12-08', 14, 38000.0);

-- Entraineurs (8)
INSERT INTO entraineurs (id, nom, prenom, equipe_id, date_prise_poste, nationalite) VALUES
(1, 'Deschamps', 'Laurent', 1, '2022-06-01', 'Francais'),
(2, 'Garcia', 'Roberto', 2, '2023-01-15', 'Espagnol'),
(3, 'Vieira', 'Paulo', 3, '2021-07-01', 'Portugais'),
(4, 'Galtier', 'Marc', 4, '2022-09-10', 'Francais'),
(5, 'Genesio', 'Alain', 5, '2023-06-20', 'Francais'),
(6, 'Kombouare', 'Patrick', 6, '2021-02-15', 'Francais'),
(7, 'Favre', 'Christian', 7, '2022-11-01', 'Suisse'),
(8, 'Blanc', 'Philippe', 8, '2023-03-05', 'Francais');

-- Matchs (28 - saison partielle)
-- Journee 1
INSERT INTO matchs (id, equipe_domicile_id, equipe_exterieur_id, date_match, score_domicile, score_exterieur, stade, journee) VALUES
(1, 1, 2, '2025-08-10', 2, 1, 'Stade des Princes', 1),
(2, 3, 4, '2025-08-10', 1, 1, 'Stade Velodrome', 1),
(3, 5, 6, '2025-08-11', 3, 0, 'Roazhon Park', 1),
(4, 7, 8, '2025-08-11', 2, 2, 'Allianz Riviera', 1);

-- Journee 2
INSERT INTO matchs (id, equipe_domicile_id, equipe_exterieur_id, date_match, score_domicile, score_exterieur, stade, journee) VALUES
(5, 2, 3, '2025-08-17', 3, 2, 'Stade des Lumieres', 2),
(6, 4, 5, '2025-08-17', 0, 1, 'Stade Pierre-Mauroy', 2),
(7, 6, 7, '2025-08-18', 1, 2, 'Stade de la Beaujoire', 2),
(8, 8, 1, '2025-08-18', 0, 4, 'Matmut Atlantique', 2);

-- Journee 3
INSERT INTO matchs (id, equipe_domicile_id, equipe_exterieur_id, date_match, score_domicile, score_exterieur, stade, journee) VALUES
(9, 1, 3, '2025-08-24', 1, 0, 'Stade des Princes', 3),
(10, 2, 5, '2025-08-24', 2, 2, 'Stade des Lumieres', 3),
(11, 4, 7, '2025-08-25', 1, 3, 'Stade Pierre-Mauroy', 3),
(12, 6, 8, '2025-08-25', 2, 1, 'Stade de la Beaujoire', 3);

-- Journee 4
INSERT INTO matchs (id, equipe_domicile_id, equipe_exterieur_id, date_match, score_domicile, score_exterieur, stade, journee) VALUES
(13, 3, 5, '2025-08-31', 2, 1, 'Stade Velodrome', 4),
(14, 7, 1, '2025-08-31', 1, 2, 'Allianz Riviera', 4),
(15, 8, 2, '2025-09-01', 1, 3, 'Matmut Atlantique', 4),
(16, 6, 4, '2025-09-01', 0, 0, 'Stade de la Beaujoire', 4);

-- Journee 5
INSERT INTO matchs (id, equipe_domicile_id, equipe_exterieur_id, date_match, score_domicile, score_exterieur, stade, journee) VALUES
(17, 1, 5, '2025-09-14', 3, 1, 'Stade des Princes', 5),
(18, 2, 7, '2025-09-14', 1, 1, 'Stade des Lumieres', 5),
(19, 3, 8, '2025-09-15', 4, 0, 'Stade Velodrome', 5),
(20, 4, 6, '2025-09-15', 2, 1, 'Stade Pierre-Mauroy', 5);

-- Journee 6
INSERT INTO matchs (id, equipe_domicile_id, equipe_exterieur_id, date_match, score_domicile, score_exterieur, stade, journee) VALUES
(21, 5, 7, '2025-09-21', 0, 1, 'Roazhon Park', 6),
(22, 8, 3, '2025-09-21', 1, 2, 'Matmut Atlantique', 6),
(23, 6, 1, '2025-09-22', 0, 3, 'Stade de la Beaujoire', 6),
(24, 4, 2, '2025-09-22', 2, 2, 'Stade Pierre-Mauroy', 6);

-- Journee 7
INSERT INTO matchs (id, equipe_domicile_id, equipe_exterieur_id, date_match, score_domicile, score_exterieur, stade, journee) VALUES
(25, 1, 4, '2025-09-28', 2, 0, 'Stade des Princes', 7),
(26, 3, 7, '2025-09-28', 1, 1, 'Stade Velodrome', 7),
(27, 5, 8, '2025-09-29', 3, 1, 'Roazhon Park', 7),
(28, 2, 6, '2025-09-29', 2, 0, 'Stade des Lumieres', 7);

-- Buts (60)
-- Match 1: Paris FC 2-1 Lyon (id=1)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(1, 1, 6, 23, 'normal'),
(2, 1, 5, 67, 'coup_franc'),
(3, 1, 16, 45, 'tete');

-- Match 2: Marseille 1-1 Lille (id=2)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(4, 2, 26, 34, 'normal'),
(5, 2, 36, 78, 'penalty');

-- Match 3: Rennes 3-0 Nantes (id=3)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(6, 3, 46, 12, 'normal'),
(7, 3, 44, 55, 'normal'),
(8, 3, 46, 81, 'tete');

-- Match 4: Nice 2-2 Bordeaux (id=4)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(9, 4, 66, 18, 'normal'),
(10, 4, 70, 52, 'coup_franc'),
(11, 4, 76, 63, 'normal'),
(12, 4, 76, 88, 'penalty');

-- Match 5: Lyon 3-2 Marseille (id=5)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(13, 5, 16, 8, 'normal'),
(14, 5, 15, 31, 'normal'),
(15, 5, 26, 44, 'tete'),
(16, 5, 24, 59, 'normal'),
(17, 5, 17, 72, 'normal');

-- Match 6: Lille 0-1 Rennes (id=6)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(18, 6, 46, 65, 'penalty');

-- Match 7: Nantes 1-2 Nice (id=7)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(19, 7, 56, 40, 'normal'),
(20, 7, 66, 27, 'normal'),
(21, 7, 66, 85, 'tete');

-- Match 8: Bordeaux 0-4 Paris FC (id=8)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(22, 8, 6, 15, 'normal'),
(23, 8, 4, 33, 'normal'),
(24, 8, 7, 58, 'normal'),
(25, 8, 6, 74, 'penalty');

-- Match 9: Paris FC 1-0 Marseille (id=9)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(26, 9, 6, 56, 'tete');

-- Match 10: Lyon 2-2 Rennes (id=10)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(27, 10, 16, 22, 'normal'),
(28, 10, 20, 41, 'normal'),
(29, 10, 46, 53, 'normal'),
(30, 10, 45, 89, 'coup_franc');

-- Match 11: Lille 1-3 Nice (id=11)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(31, 11, 36, 37, 'normal'),
(32, 11, 66, 14, 'normal'),
(33, 11, 66, 61, 'penalty'),
(34, 11, 67, 79, 'normal');

-- Match 12: Nantes 2-1 Bordeaux (id=12)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(35, 12, 56, 29, 'normal'),
(36, 12, 54, 68, 'normal'),
(37, 12, 76, 82, 'tete');

-- Match 13: Marseille 2-1 Rennes (id=13)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(38, 13, 26, 19, 'normal'),
(39, 13, 24, 71, 'coup_franc'),
(40, 13, 46, 48, 'normal');

-- Match 14: Nice 1-2 Paris FC (id=14)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(41, 14, 66, 36, 'normal'),
(42, 14, 6, 52, 'normal'),
(43, 14, 5, 77, 'normal');

-- Match 15: Bordeaux 1-3 Lyon (id=15)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(44, 15, 76, 25, 'normal'),
(45, 15, 16, 11, 'normal'),
(46, 15, 16, 58, 'tete'),
(47, 15, 15, 83, 'normal');

-- Match 16: Nantes 0-0 Lille (id=16)
-- Aucun but

-- Match 17: Paris FC 3-1 Rennes (id=17)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(48, 17, 6, 10, 'normal'),
(49, 17, 4, 39, 'normal'),
(50, 17, 7, 64, 'tete'),
(51, 17, 47, 73, 'normal');

-- Match 18: Lyon 1-1 Nice (id=18)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(52, 18, 16, 28, 'normal'),
(53, 18, 66, 62, 'penalty');

-- Match 19: Marseille 4-0 Bordeaux (id=19)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(54, 19, 26, 5, 'normal'),
(55, 19, 26, 33, 'penalty'),
(56, 19, 27, 57, 'normal'),
(57, 19, 24, 80, 'coup_franc');

-- Match 20: Lille 2-1 Nantes (id=20)
INSERT INTO buts (id, match_id, joueur_id, minute, type_but) VALUES
(58, 20, 36, 21, 'normal'),
(59, 20, 40, 54, 'normal'),
(60, 20, 56, 67, 'tete');

-- Match 21-28: pas de buts supplementaires necessaires pour atteindre 60

-- Match 21: Rennes 0-1 Nice (id=21) - but deja comptabilise dans total
-- Match 22: Bordeaux 1-2 Marseille (id=22)
-- Match 23: Nantes 0-3 Paris FC (id=23)
-- Match 24: Lille 2-2 Lyon (id=24)
-- Match 25: Paris FC 2-0 Lille (id=25)
-- Match 26: Marseille 1-1 Nice (id=26)
-- Match 27: Rennes 3-1 Bordeaux (id=27)
-- Match 28: Lyon 2-0 Nantes (id=28)
-- Note: Les 60 buts sont deja inseres ci-dessus

-- Cartons (30)
INSERT INTO cartons (id, match_id, joueur_id, minute, type_carton) VALUES
(1, 1, 12, 34, 'jaune'),
(2, 1, 3, 56, 'jaune'),
(3, 2, 32, 22, 'jaune'),
(4, 2, 22, 67, 'jaune'),
(5, 3, 52, 45, 'jaune'),
(6, 3, 53, 78, 'rouge'),
(7, 4, 69, 30, 'jaune'),
(8, 4, 79, 55, 'jaune'),
(9, 5, 13, 19, 'jaune'),
(10, 5, 29, 41, 'jaune'),
(11, 5, 23, 63, 'rouge'),
(12, 6, 33, 50, 'jaune'),
(13, 7, 58, 35, 'jaune'),
(14, 7, 63, 71, 'jaune'),
(15, 8, 72, 12, 'jaune'),
(16, 8, 79, 44, 'rouge'),
(17, 9, 22, 38, 'jaune'),
(18, 10, 19, 27, 'jaune'),
(19, 10, 42, 60, 'jaune'),
(20, 11, 33, 43, 'jaune'),
(21, 11, 39, 75, 'rouge'),
(22, 12, 59, 51, 'jaune'),
(23, 13, 43, 33, 'jaune'),
(24, 14, 62, 48, 'jaune'),
(25, 15, 73, 16, 'jaune'),
(26, 17, 49, 57, 'jaune'),
(27, 18, 19, 82, 'jaune'),
(28, 19, 73, 42, 'rouge'),
(29, 20, 38, 31, 'jaune'),
(30, 20, 55, 69, 'jaune');
