-- ============================================
-- Dataset: E-Commerce (SQL Clinic)
-- Base de donnees SQLite - Donnees francophones
-- ============================================

-- Suppression des tables existantes
DROP TABLE IF EXISTS avis;
DROP TABLE IF EXISTS lignes_commande;
DROP TABLE IF EXISTS commandes;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS categories;

-- ============================================
-- CREATION DES TABLES
-- ============================================

CREATE TABLE categories (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    description TEXT
);

CREATE TABLE produits (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    description TEXT,
    prix REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    categorie_id INTEGER NOT NULL,
    date_ajout TEXT NOT NULL,
    FOREIGN KEY (categorie_id) REFERENCES categories(id)
);

CREATE TABLE clients (
    id INTEGER PRIMARY KEY,
    prenom TEXT NOT NULL,
    nom TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    ville TEXT NOT NULL,
    date_inscription TEXT NOT NULL
);

CREATE TABLE commandes (
    id INTEGER PRIMARY KEY,
    client_id INTEGER NOT NULL,
    date_commande TEXT NOT NULL,
    statut TEXT NOT NULL,
    montant_total REAL NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE lignes_commande (
    id INTEGER PRIMARY KEY,
    commande_id INTEGER NOT NULL,
    produit_id INTEGER NOT NULL,
    quantite INTEGER NOT NULL,
    prix_unitaire REAL NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commandes(id),
    FOREIGN KEY (produit_id) REFERENCES produits(id)
);

CREATE TABLE avis (
    id INTEGER PRIMARY KEY,
    produit_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    note INTEGER NOT NULL CHECK(note BETWEEN 1 AND 5),
    commentaire TEXT,
    date_avis TEXT NOT NULL,
    FOREIGN KEY (produit_id) REFERENCES produits(id),
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

-- ============================================
-- INSERTION DES DONNEES
-- ============================================

-- Categories (6)
INSERT INTO categories (id, nom, description) VALUES
(1, 'Electronique', 'Smartphones, ordinateurs, accessoires et gadgets electroniques'),
(2, 'Vetements', 'Mode homme, femme et enfant'),
(3, 'Maison', 'Decoration, mobilier et equipement de la maison'),
(4, 'Livres', 'Romans, essais, bandes dessinees et manuels'),
(5, 'Sport', 'Equipements sportifs, vetements de sport et accessoires'),
(6, 'Alimentation', 'Epicerie fine, produits bio et specialites regionales');

-- Produits (25)
INSERT INTO produits (id, nom, description, prix, stock, categorie_id, date_ajout) VALUES
(1,  'Smartphone Galaxy S24',       'Smartphone Samsung derniere generation 128Go',           899.99,  45, 1, '2025-09-15'),
(2,  'Casque Bluetooth ProSound',   'Casque sans fil avec reduction de bruit active',         149.90,  120, 1, '2025-10-01'),
(3,  'Clavier Mecanique RGB',       'Clavier gaming switches Cherry MX Blue',                 89.99,   78, 1, '2025-10-20'),
(4,  'Ecran 27 pouces 4K',          'Moniteur IPS 27 pouces resolution 4K HDR',               349.00,  30, 1, '2025-11-05'),
(5,  'Veste en cuir homme',         'Veste en cuir veritable coupe ajustee',                  189.00,  25, 2, '2025-09-20'),
(6,  'Robe ete fleurie',            'Robe legere motif floral taille S a XL',                 49.90,   60, 2, '2025-10-10'),
(7,  'Jean slim femme',             'Jean stretch coupe slim bleu fonce',                     59.90,   85, 2, '2025-10-15'),
(8,  'Pull en laine merinos',       'Pull col rond 100% laine merinos',                       79.00,   40, 2, '2025-11-01'),
(9,  'Lampe de bureau LED',         'Lampe articulee avec variateur de luminosite',            39.90,   150, 3, '2025-09-25'),
(10, 'Canape 3 places gris',        'Canape confortable tissu gris clair pieds bois',         599.00,  12, 3, '2025-10-05'),
(11, 'Service a cafe 6 tasses',     'Service en porcelaine blanche avec soucoupes',            34.90,   65, 3, '2025-10-25'),
(12, 'Tapis berbere 200x300',       'Tapis artisanal motifs geometriques',                    129.00,  20, 3, '2025-11-10'),
(13, 'Le Petit Prince',             'Antoine de Saint-Exupery edition illustree',              12.90,   200, 4, '2025-09-10'),
(14, 'Sapiens',                     'Yuval Noah Harari - Une breve histoire de humanite',      24.90,   90, 4, '2025-09-18'),
(15, 'La Nuit des temps',           'Rene Barjavel roman de science-fiction',                  8.50,    110, 4, '2025-10-12'),
(16, 'Guide SQL pour debutants',    'Apprendre le SQL pas a pas avec exercices',               29.90,   55, 4, '2025-11-20'),
(17, 'Velo elliptique ProFit',      'Velo elliptique magnetique 16 niveaux',                  449.00,  15, 5, '2025-09-30'),
(18, 'Halteres reglables 20kg',     'Paire d halteres ajustables de 2 a 20kg',                69.90,   40, 5, '2025-10-08'),
(19, 'Tapis de yoga premium',       'Tapis antiderapant epaisseur 6mm',                       29.90,   95, 5, '2025-10-22'),
(20, 'Raquette de tennis Wilson',   'Raquette intermediaire cordee 280g',                      85.00,   35, 5, '2025-11-15'),
(21, 'Coffret chocolats artisanaux','Assortiment 24 chocolats fins origine France',            39.90,   80, 6, '2025-09-12'),
(22, 'Huile d olive vierge extra',  'Huile d olive bio premiere pression a froid 75cl',        15.90,   140, 6, '2025-10-03'),
(23, 'Confiture de figues maison',  'Confiture artisanale figues de Provence 340g',            7.50,    95, 6, '2025-10-18'),
(24, 'Cafe en grains Arabica',      'Cafe 100% Arabica torrefaction artisanale 1kg',           18.90,   70, 6, '2025-11-02'),
(25, 'Panier garni provencal',      'Assortiment de specialites provencales',                  54.90,   30, 6, '2025-11-25');

-- Clients (20)
INSERT INTO clients (id, prenom, nom, email, ville, date_inscription) VALUES
(1,  'Marie',     'Dupont',      'marie.dupont@email.fr',        'Paris',          '2025-06-15'),
(2,  'Thomas',    'Martin',      'thomas.martin@email.fr',       'Lyon',           '2025-07-02'),
(3,  'Sophie',    'Bernard',     'sophie.bernard@email.fr',      'Marseille',      '2025-07-18'),
(4,  'Lucas',     'Petit',       'lucas.petit@email.fr',         'Toulouse',       '2025-08-01'),
(5,  'Camille',   'Durand',      'camille.durand@email.fr',      'Nice',           '2025-08-10'),
(6,  'Antoine',   'Leroy',       'antoine.leroy@email.fr',       'Nantes',         '2025-08-22'),
(7,  'Emma',      'Moreau',      'emma.moreau@email.fr',         'Strasbourg',     '2025-09-01'),
(8,  'Hugo',      'Simon',       'hugo.simon@email.fr',          'Montpellier',    '2025-09-10'),
(9,  'Lea',       'Laurent',     'lea.laurent@email.fr',         'Bordeaux',       '2025-09-15'),
(10, 'Nathan',    'Lefebvre',    'nathan.lefebvre@email.fr',     'Lille',          '2025-09-25'),
(11, 'Chloe',     'Michel',      'chloe.michel@email.fr',        'Rennes',         '2025-10-01'),
(12, 'Maxime',    'Garcia',      'maxime.garcia@email.fr',       'Paris',          '2025-10-08'),
(13, 'Julie',     'David',       'julie.david@email.fr',         'Lyon',           '2025-10-12'),
(14, 'Alexandre', 'Bertrand',    'alexandre.bertrand@email.fr',  'Marseille',      '2025-10-20'),
(15, 'Manon',     'Roux',        'manon.roux@email.fr',          'Toulouse',       '2025-10-28'),
(16, 'Romain',    'Vincent',     'romain.vincent@email.fr',      'Nice',           '2025-11-05'),
(17, 'Ines',      'Fournier',    'ines.fournier@email.fr',       'Bordeaux',       '2025-11-12'),
(18, 'Louis',     'Morel',       'louis.morel@email.fr',         'Nantes',         '2025-11-18'),
(19, 'Clara',     'Girard',      'clara.girard@email.fr',        'Paris',          '2025-11-25'),
(20, 'Theo',      'Bonnet',      'theo.bonnet@email.fr',         'Strasbourg',     '2025-12-01');

-- Commandes (30)
INSERT INTO commandes (id, client_id, date_commande, statut, montant_total) VALUES
(1,  1,  '2025-10-05', 'livree',   949.89),
(2,  2,  '2025-10-08', 'livree',   189.00),
(3,  3,  '2025-10-12', 'livree',   74.80),
(4,  1,  '2025-10-18', 'livree',   149.90),
(5,  5,  '2025-10-22', 'livree',   639.00),
(6,  4,  '2025-10-28', 'livree',   54.70),
(7,  7,  '2025-11-02', 'livree',   299.70),
(8,  6,  '2025-11-05', 'livree',   85.00),
(9,  8,  '2025-11-08', 'expediee', 518.90),
(10, 9,  '2025-11-10', 'livree',   109.80),
(11, 10, '2025-11-12', 'livree',   899.99),
(12, 3,  '2025-11-15', 'annulee',  349.00),
(13, 11, '2025-11-18', 'livree',   159.80),
(14, 2,  '2025-11-20', 'livree',   79.80),
(15, 12, '2025-11-22', 'expediee', 449.00),
(16, 13, '2025-11-25', 'livree',   42.40),
(17, 14, '2025-11-28', 'livree',   239.80),
(18, 1,  '2025-12-01', 'en_cours', 129.00),
(19, 15, '2025-12-03', 'livree',   119.80),
(20, 5,  '2025-12-05', 'annulee',  89.99),
(21, 16, '2025-12-08', 'en_cours', 969.89),
(22, 17, '2025-12-10', 'expediee', 54.90),
(23, 8,  '2025-12-12', 'livree',   199.80),
(24, 18, '2025-12-15', 'en_cours', 349.00),
(25, 19, '2025-12-18', 'livree',   47.40),
(26, 20, '2025-12-20', 'expediee', 139.80),
(27, 6,  '2025-12-22', 'en_cours', 598.00),
(28, 9,  '2025-12-25', 'livree',   79.00),
(29, 12, '2025-12-28', 'annulee',  29.90),
(30, 4,  '2025-12-30', 'en_cours', 174.80);

-- Lignes de commande (50)
INSERT INTO lignes_commande (id, commande_id, produit_id, quantite, prix_unitaire) VALUES
(1,  1,  1,  1, 899.99),
(2,  1,  6,  1, 49.90),
(3,  2,  5,  1, 189.00),
(4,  3,  22, 2, 15.90),
(5,  3,  23, 3, 7.50),
(6,  3,  24, 1, 18.90),
(7,  4,  2,  1, 149.90),
(8,  5,  10, 1, 599.00),
(9,  5,  9,  1, 39.90),
(10, 6,  13, 2, 12.90),
(11, 6,  15, 1, 8.50),
(12, 6,  16, 1, 29.90),
(13, 7,  19, 2, 29.90),
(14, 7,  7,  2, 59.90),
(15, 7,  8,  1, 79.00),
(16, 8,  20, 1, 85.00),
(17, 9,  17, 1, 449.00),
(18, 9,  18, 1, 69.90),
(19, 10, 19, 1, 29.90),
(20, 10, 8,  1, 79.00),
(21, 11, 1,  1, 899.99),
(22, 12, 4,  1, 349.00),
(23, 13, 7,  1, 59.90),
(24, 13, 6,  2, 49.90),
(25, 14, 22, 3, 15.90),
(26, 14, 23, 2, 7.50),
(27, 14, 21, 1, 39.90),
(28, 15, 17, 1, 449.00),
(29, 16, 23, 3, 7.50),
(30, 16, 22, 1, 15.90),
(31, 17, 3,  1, 89.99),
(32, 17, 2,  1, 149.90),
(33, 18, 12, 1, 129.00),
(34, 19, 7,  2, 59.90),
(35, 20, 3,  1, 89.99),
(36, 21, 1,  1, 899.99),
(37, 21, 18, 1, 69.90),
(38, 22, 25, 1, 54.90),
(39, 23, 6,  2, 49.90),
(40, 23, 8,  1, 79.00),
(41, 23, 19, 1, 29.90),
(42, 24, 4,  1, 349.00),
(43, 25, 23, 2, 7.50),
(44, 25, 22, 1, 15.90),
(45, 25, 24, 1, 18.90),
(46, 26, 18, 2, 69.90),
(47, 27, 10, 1, 599.00),
(48, 28, 8,  1, 79.00),
(49, 29, 19, 1, 29.90),
(50, 30, 20, 1, 85.00),
(51, 30, 3,  1, 89.99);

-- Avis (15)
INSERT INTO avis (id, produit_id, client_id, note, commentaire, date_avis) VALUES
(1,  1,  1,  5, 'Excellent smartphone, tres rapide et belle qualite photo.',                     '2025-10-20'),
(2,  2,  1,  4, 'Bon casque, confortable mais un peu lourd pour de longues sessions.',           '2025-10-25'),
(3,  5,  2,  5, 'Superbe veste, le cuir est de tres bonne qualite. Je recommande.',              '2025-10-18'),
(4,  10, 5,  3, 'Canape correct mais les coussins s affaissent un peu vite.',                    '2025-11-10'),
(5,  13, 4,  5, 'Un classique intemporel, cette edition illustree est magnifique.',               '2025-11-05'),
(6,  1,  10, 4, 'Tres bon telephone mais l autonomie pourrait etre meilleure.',                  '2025-11-20'),
(7,  17, 8,  4, 'Bon rapport qualite prix pour un usage regulier a la maison.',                  '2025-11-18'),
(8,  19, 7,  5, 'Parfait pour le yoga, antiderapant et tres confortable.',                       '2025-11-12'),
(9,  21, 3,  5, 'Des chocolats delicieux, parfaits pour offrir.',                                '2025-10-30'),
(10, 7,  11, 3, 'Taille un peu petit, prendre une taille au dessus.',                            '2025-11-25'),
(11, 3,  14, 4, 'Clavier agreable a utiliser, les switches sont satisfaisants.',                  '2025-12-05'),
(12, 22, 2,  5, 'Huile d olive excellente, gout fruite remarquable.',                            '2025-11-28'),
(13, 16, 13, 4, 'Tres bon livre pour debuter le SQL, exercices pratiques bien faits.',            '2025-12-01'),
(14, 8,  9,  2, 'La laine bouloche apres quelques lavages, decevant pour le prix.',              '2025-12-10'),
(15, 20, 6,  4, 'Bonne raquette pour joueur intermediaire, bonne prise en main.',                '2025-12-08');