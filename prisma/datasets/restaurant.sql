-- ============================================
-- Dataset Restaurant Le Gourmet
-- SQLite schema + données
-- ============================================

-- serveurs
CREATE TABLE serveurs (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    date_embauche TEXT,
    salaire REAL,
    experience_annees INTEGER
);

INSERT INTO serveurs (id, nom, prenom, date_embauche, salaire, experience_annees) VALUES
(1, 'Dupont',    'Marc',      '2018-03-15', 2200, 8),
(2, 'Laurent',   'Sophie',    '2019-09-01', 2100, 6),
(3, 'Martin',    'Antoine',   '2020-06-10', 1950, 4),
(4, 'Bernard',   'Claire',    '2017-01-20', 2400, 10),
(5, 'Moreau',    'Lucas',     '2021-04-05', 1850, 3),
(6, 'Petit',     'Julie',     '2022-08-12', 1800, 2),
(7, 'Roux',      'Nicolas',   '2016-11-03', 2500, 12),
(8, 'Fournier',  'Camille',   '2023-02-28', 1750, 1);

-- tables_resto
CREATE TABLE tables_resto (
    id INTEGER PRIMARY KEY,
    numero INTEGER NOT NULL,
    capacite INTEGER NOT NULL,
    emplacement TEXT NOT NULL
);

INSERT INTO tables_resto (id, numero, capacite, emplacement) VALUES
(1,  1,  2, 'salle'),
(2,  2,  2, 'salle'),
(3,  3,  4, 'salle'),
(4,  4,  4, 'salle'),
(5,  5,  6, 'salle'),
(6,  6,  8, 'salon_prive'),
(7,  7,  2, 'terrasse'),
(8,  8,  4, 'terrasse'),
(9,  9,  4, 'terrasse'),
(10, 10, 6, 'terrasse'),
(11, 11, 8, 'salon_prive'),
(12, 12, 2, 'terrasse');

-- categories_plats
CREATE TABLE categories_plats (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL
);

INSERT INTO categories_plats (id, nom) VALUES
(1, 'Entrée'),
(2, 'Plat principal'),
(3, 'Dessert'),
(4, 'Boisson'),
(5, 'Apéritif');

-- plats
CREATE TABLE plats (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    categorie_id INTEGER NOT NULL,
    prix REAL NOT NULL,
    est_vegetarien INTEGER DEFAULT 0,
    est_disponible INTEGER DEFAULT 1,
    FOREIGN KEY (categorie_id) REFERENCES categories_plats(id)
);

INSERT INTO plats (id, nom, categorie_id, prix, est_vegetarien, est_disponible) VALUES
-- Entrées
(1,  'Soupe à l''oignon gratinée',    1, 9.50,  1, 1),
(2,  'Salade niçoise',                 1, 12.00, 1, 1),
(3,  'Terrine de campagne',            1, 11.00, 0, 1),
(4,  'Foie gras maison',               1, 18.50, 0, 1),
(5,  'Salade de chèvre chaud',         1, 13.00, 1, 1),
(6,  'Escargots de Bourgogne',         1, 14.00, 0, 0),
-- Plats principaux
(7,  'Entrecôte grillée sauce béarnaise', 2, 24.00, 0, 1),
(8,  'Magret de canard au miel',       2, 22.50, 0, 1),
(9,  'Filet de bar au beurre blanc',   2, 21.00, 0, 1),
(10, 'Blanquette de veau',             2, 19.50, 0, 1),
(11, 'Coq au vin',                     2, 20.00, 0, 1),
(12, 'Risotto aux champignons',        2, 17.00, 1, 1),
(13, 'Confit de canard',               2, 21.50, 0, 1),
(14, 'Steak tartare',                  2, 19.00, 0, 0),
(15, 'Bouillabaisse',                  2, 26.00, 0, 1),
(16, 'Ratatouille provençale',         2, 15.50, 1, 1),
-- Desserts
(17, 'Crème brûlée',                   3, 8.50,  1, 1),
(18, 'Tarte tatin',                    3, 9.00,  1, 1),
(19, 'Mousse au chocolat',             3, 8.00,  1, 1),
(20, 'Île flottante',                  3, 7.50,  1, 1),
(21, 'Fondant au chocolat',            3, 10.00, 1, 1),
(22, 'Profiteroles',                   3, 9.50,  1, 0),
(23, 'Assiette de fromages',           3, 12.00, 1, 1),
-- Boissons
(24, 'Eau minérale',                   4, 3.50,  1, 1),
(25, 'Coca-Cola',                      4, 4.00,  1, 1),
(26, 'Jus d''orange frais',            4, 5.00,  1, 1),
(27, 'Café expresso',                  4, 2.50,  1, 1),
(28, 'Thé parfumé',                    4, 3.00,  1, 1),
-- Apéritifs
(29, 'Kir royal',                      5, 9.00,  1, 1),
(30, 'Planche apéritive mixte',        5, 16.00, 0, 1);

-- reservations
CREATE TABLE reservations (
    id INTEGER PRIMARY KEY,
    nom_client TEXT NOT NULL,
    telephone TEXT,
    date_reservation TEXT NOT NULL,
    heure TEXT NOT NULL,
    nb_personnes INTEGER NOT NULL,
    table_id INTEGER,
    statut TEXT NOT NULL DEFAULT 'confirmee',
    FOREIGN KEY (table_id) REFERENCES tables_resto(id)
);

INSERT INTO reservations (id, nom_client, telephone, date_reservation, heure, nb_personnes, table_id, statut) VALUES
(1,  'Lemaire',    '0601020304', '2024-12-20', '19:30', 2, 1,  'confirmee'),
(2,  'Garnier',    '0611223344', '2024-12-20', '20:00', 4, 3,  'confirmee'),
(3,  'Chevalier',  '0622334455', '2024-12-20', '20:30', 6, 5,  'terminee'),
(4,  'Rousseau',   '0633445566', '2024-12-21', '12:00', 2, 7,  'confirmee'),
(5,  'Fontaine',   '0644556677', '2024-12-21', '12:30', 4, 8,  'annulee'),
(6,  'Mercier',    '0655667788', '2024-12-21', '19:00', 8, 6,  'confirmee'),
(7,  'Lambert',    '0666778899', '2024-12-21', '20:00', 2, 2,  'terminee'),
(8,  'Bonnet',     '0677889900', '2024-12-22', '12:00', 4, 4,  'confirmee'),
(9,  'Girard',     '0688990011', '2024-12-22', '12:30', 6, 10, 'confirmee'),
(10, 'Morel',      '0699001122', '2024-12-22', '19:30', 2, 12, 'terminee'),
(11, 'Lefebvre',   '0610111213', '2024-12-22', '20:00', 4, 9,  'annulee'),
(12, 'Duval',      '0620212223', '2024-12-23', '12:00', 8, 11, 'confirmee'),
(13, 'Renaud',     '0630313233', '2024-12-23', '19:00', 2, 1,  'confirmee'),
(14, 'Picard',     '0640414243', '2024-12-23', '19:30', 4, 3,  'terminee'),
(15, 'Andre',      '0650515253', '2024-12-23', '20:00', 2, 7,  'confirmee'),
(16, 'Clement',    '0660616263', '2024-12-24', '12:00', 6, 5,  'confirmee'),
(17, 'Nicolas',    '0670717273', '2024-12-24', '19:00', 4, 4,  'annulee'),
(18, 'Leclerc',    '0680818283', '2024-12-24', '19:30', 8, 6,  'confirmee'),
(19, 'Guillaume',  '0690919293', '2024-12-24', '20:00', 2, 2,  'terminee'),
(20, 'Perrin',     '0601122334', '2024-12-25', '12:00', 4, 8,  'confirmee'),
(21, 'Blanc',      '0612233445', '2024-12-25', '12:30', 2, 12, 'confirmee'),
(22, 'Masson',     '0623344556', '2024-12-25', '19:00', 6, 10, 'terminee'),
(23, 'Caron',      '0634455667', '2024-12-25', '19:30', 4, 9,  'confirmee'),
(24, 'Muller',     '0645566778', '2024-12-25', '20:00', 8, 11, 'annulee'),
(25, 'Barbier',    '0656677889', '2024-12-26', '19:00', 2, 1,  'confirmee');

-- commandes
CREATE TABLE commandes (
    id INTEGER PRIMARY KEY,
    table_id INTEGER NOT NULL,
    serveur_id INTEGER NOT NULL,
    date_commande TEXT NOT NULL,
    montant_total REAL,
    statut TEXT NOT NULL DEFAULT 'en_cours',
    FOREIGN KEY (table_id) REFERENCES tables_resto(id),
    FOREIGN KEY (serveur_id) REFERENCES serveurs(id)
);

INSERT INTO commandes (id, table_id, serveur_id, date_commande, montant_total, statut) VALUES
(1,  1, 1, '2024-12-20', 54.00,  'payee'),
(2,  3, 2, '2024-12-20', 87.50,  'payee'),
(3,  5, 4, '2024-12-20', 132.00, 'payee'),
(4,  7, 3, '2024-12-20', 45.00,  'payee'),
(5,  2, 1, '2024-12-20', 62.50,  'payee'),
(6,  6, 7, '2024-12-21', 198.00, 'payee'),
(7,  8, 5, '2024-12-21', 76.00,  'payee'),
(8,  2, 2, '2024-12-21', 48.50,  'payee'),
(9,  4, 3, '2024-12-21', 95.00,  'payee'),
(10, 10, 4, '2024-12-21', 110.50, 'payee'),
(11, 1, 1, '2024-12-22', 58.00,  'payee'),
(12, 12, 6, '2024-12-22', 39.50,  'payee'),
(13, 9, 5, '2024-12-22', 88.00,  'payee'),
(14, 3, 2, '2024-12-22', 72.00,  'payee'),
(15, 11, 7, '2024-12-22', 175.50, 'payee'),
(16, 1, 1, '2024-12-23', 42.00,  'servie'),
(17, 7, 3, '2024-12-23', 55.50,  'payee'),
(18, 3, 4, '2024-12-23', 96.00,  'payee'),
(19, 5, 2, '2024-12-23', 145.00, 'payee'),
(20, 4, 6, '2024-12-23', 68.00,  'payee'),
(21, 6, 7, '2024-12-24', 210.50, 'payee'),
(22, 5, 4, '2024-12-24', 128.00, 'payee'),
(23, 2, 1, '2024-12-24', 51.00,  'servie'),
(24, 8, 5, '2024-12-24', 83.50,  'payee'),
(25, 10, 3, '2024-12-24', 99.00,  'payee'),
(26, 12, 6, '2024-12-25', 44.00,  'payee'),
(27, 9, 2, '2024-12-25', 91.50,  'payee'),
(28, 8, 5, '2024-12-25', 78.00,  'payee'),
(29, 11, 7, '2024-12-25', 185.00, 'servie'),
(30, 1, 1, '2024-12-25', 56.50,  'en_cours'),
(31, 3, 4, '2024-12-25', 105.00, 'en_cours'),
(32, 7, 3, '2024-12-26', 47.00,  'en_cours'),
(33, 4, 6, '2024-12-26', 72.50,  'en_cours'),
(34, 6, 7, '2024-12-26', 195.00, 'en_cours'),
(35, 2, 8, '2024-12-26', 38.50,  'en_cours');

-- lignes_commande
CREATE TABLE lignes_commande (
    id INTEGER PRIMARY KEY,
    commande_id INTEGER NOT NULL,
    plat_id INTEGER NOT NULL,
    quantite INTEGER NOT NULL,
    prix_unitaire REAL NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commandes(id),
    FOREIGN KEY (plat_id) REFERENCES plats(id)
);

INSERT INTO lignes_commande (id, commande_id, plat_id, quantite, prix_unitaire) VALUES
-- Commande 1 (table 1, 54.00)
(1,  1, 2,  1, 12.00),
(2,  1, 7,  1, 24.00),
(3,  1, 17, 1, 8.50),
(4,  1, 27, 1, 2.50),
(5,  1, 26, 1, 5.00),
-- Commande 2 (table 3, 87.50)
(6,  2, 4,  1, 18.50),
(7,  2, 8,  2, 22.50),
(8,  2, 18, 1, 9.00),
(9,  2, 19, 1, 8.00),
(10, 2, 24, 2, 3.50),
-- Commande 3 (table 5, 132.00)
(11, 3, 1,  2, 9.50),
(12, 3, 11, 2, 20.00),
(13, 3, 15, 1, 26.00),
(14, 3, 21, 2, 10.00),
(15, 3, 29, 2, 9.00),
-- Commande 4 (table 7, 45.00)
(16, 4, 5,  1, 13.00),
(17, 4, 12, 1, 17.00),
(18, 4, 20, 1, 7.50),
(19, 4, 24, 1, 3.50),
-- Commande 5 (table 2, 62.50)
(20, 5, 3,  1, 11.00),
(21, 5, 9,  1, 21.00),
(22, 5, 17, 1, 8.50),
(23, 5, 30, 1, 16.00),
(24, 5, 27, 2, 2.50),
-- Commande 6 (table 6, 198.00)
(25, 6, 4,  2, 18.50),
(26, 6, 7,  2, 24.00),
(27, 6, 8,  2, 22.50),
(28, 6, 13, 1, 21.50),
(29, 6, 21, 2, 10.00),
(30, 6, 29, 3, 9.00),
-- Commande 7 (table 8, 76.00)
(31, 7, 2,  1, 12.00),
(32, 7, 10, 2, 19.50),
(33, 7, 19, 1, 8.00),
(34, 7, 25, 2, 4.00),
(35, 7, 27, 2, 2.50),
-- Commande 8 (table 2, 48.50)
(36, 8, 1,  1, 9.50),
(37, 8, 16, 1, 15.50),
(38, 8, 18, 1, 9.00),
(39, 8, 28, 2, 3.00),
(40, 8, 24, 1, 3.50),
-- Commande 9 (table 4, 95.00)
(41, 9, 5,  2, 13.00),
(42, 9, 11, 2, 20.00),
(43, 9, 23, 1, 12.00),
(44, 9, 25, 2, 4.00),
-- Commande 10 (table 10, 110.50)
(45, 10, 3,  2, 11.00),
(46, 10, 8,  1, 22.50),
(47, 10, 15, 1, 26.00),
(48, 10, 17, 2, 8.50),
(49, 10, 29, 1, 9.00),
-- Commande 11 (table 1, 58.00)
(50, 11, 2,  1, 12.00),
(51, 11, 13, 1, 21.50),
(52, 11, 19, 1, 8.00),
(53, 11, 30, 1, 16.00),
-- Commande 12 (table 12, 39.50)
(54, 12, 1,  1, 9.50),
(55, 12, 12, 1, 17.00),
(56, 12, 28, 1, 3.00),
(57, 12, 27, 2, 2.50),
(58, 12, 25, 1, 4.00),
-- Commande 13 (table 9, 88.00)
(59, 13, 4,  1, 18.50),
(60, 13, 9,  1, 21.00),
(61, 13, 7,  1, 24.00),
(62, 13, 17, 1, 8.50),
(63, 13, 29, 1, 9.00),
-- Commande 14 (table 3, 72.00)
(64, 14, 5,  1, 13.00),
(65, 14, 10, 1, 19.50),
(66, 14, 8,  1, 22.50),
(67, 14, 20, 1, 7.50),
(68, 14, 27, 2, 2.50),
-- Commande 15 (table 11, 175.50)
(69, 15, 4,  2, 18.50),
(70, 15, 11, 3, 20.00),
(71, 15, 21, 2, 10.00),
(72, 15, 23, 1, 12.00),
(73, 15, 29, 3, 9.00),
-- Commande 16 (table 1, 42.00)
(74, 16, 1,  1, 9.50),
(75, 16, 16, 1, 15.50),
(76, 16, 17, 1, 8.50),
(77, 16, 24, 1, 3.50),
-- Commande 17 (table 7, 55.50)
(78, 17, 2,  1, 12.00),
(79, 17, 9,  1, 21.00),
(80, 17, 19, 1, 8.00),
(81, 17, 26, 1, 5.00),
(82, 17, 27, 2, 2.50),
-- Commande 18 (table 3, 96.00)
(83, 18, 3,  2, 11.00),
(84, 18, 7,  1, 24.00),
(85, 18, 13, 1, 21.50),
(86, 18, 17, 1, 8.50),
(87, 18, 29, 2, 9.00),
-- Commande 19 (table 5, 145.00)
(88, 19, 4,  1, 18.50),
(89, 19, 15, 2, 26.00),
(90, 19, 8,  1, 22.50),
(91, 19, 21, 2, 10.00),
(92, 19, 24, 3, 3.50),
-- Commande 20 (table 4, 68.00)
(93,  20, 5,  1, 13.00),
(94,  20, 11, 1, 20.00),
(95,  20, 18, 1, 9.00),
(96,  20, 30, 1, 16.00),
(97,  20, 27, 2, 2.50),
-- Commande 21 (table 6, 210.50)
(98,  21, 4,  2, 18.50),
(99,  21, 7,  3, 24.00),
(100, 21, 13, 2, 21.50),
(101, 21, 21, 1, 10.00),
(102, 21, 29, 2, 9.00),
-- Commande 22 (table 5, 128.00)
(103, 22, 1,  2, 9.50),
(104, 22, 8,  2, 22.50),
(105, 22, 10, 1, 19.50),
(106, 22, 17, 2, 8.50),
(107, 22, 24, 2, 3.50),
-- Commande 23 (table 2, 51.00)
(108, 23, 2,  1, 12.00),
(109, 23, 12, 1, 17.00),
(110, 23, 20, 1, 7.50),
(111, 23, 29, 1, 9.00),
(112, 23, 26, 1, 5.00),
-- Commande 24 (table 8, 83.50)
(113, 24, 3,  1, 11.00),
(114, 24, 9,  1, 21.00),
(115, 24, 7,  1, 24.00),
(116, 24, 19, 1, 8.00),
(117, 24, 30, 1, 16.00),
-- Commande 25 (table 10, 99.00)
(118, 25, 5,  2, 13.00),
(119, 25, 11, 1, 20.00),
(120, 25, 15, 1, 26.00),
(121, 25, 17, 1, 8.50),
(122, 25, 27, 2, 2.50),
-- Commande 26 (table 12, 44.00)
(123, 26, 1,  1, 9.50),
(124, 26, 16, 1, 15.50),
(125, 26, 20, 1, 7.50),
(126, 26, 28, 2, 3.00),
-- Commande 27 (table 9, 91.50)
(127, 27, 4,  1, 18.50),
(128, 27, 8,  1, 22.50),
(129, 27, 10, 1, 19.50),
(130, 27, 21, 1, 10.00),
(131, 27, 29, 1, 9.00),
-- Commande 28 (table 8, 78.00)
(132, 28, 2,  1, 12.00),
(133, 28, 7,  1, 24.00),
(134, 28, 13, 1, 21.50),
(135, 28, 17, 1, 8.50),
(136, 28, 25, 2, 4.00),
-- Commande 29 (table 11, 185.00)
(137, 29, 3,  3, 11.00),
(138, 29, 11, 3, 20.00),
(139, 29, 8,  1, 22.50),
(140, 29, 23, 1, 12.00),
(141, 29, 29, 3, 9.00),
-- Commande 30 (table 1, 56.50)
(142, 30, 5,  1, 13.00),
(143, 30, 9,  1, 21.00),
(144, 30, 19, 1, 8.00),
(145, 30, 29, 1, 9.00),
(146, 30, 26, 1, 5.00),
-- Commande 31 (table 3, 105.00)
(147, 31, 4,  1, 18.50),
(148, 31, 7,  1, 24.00),
(149, 31, 15, 1, 26.00),
(150, 31, 21, 1, 10.00),
(151, 31, 29, 2, 9.00),
-- Commande 32 (table 7, 47.00)
(152, 32, 1,  1, 9.50),
(153, 32, 12, 1, 17.00),
(154, 32, 17, 1, 8.50),
(155, 32, 25, 1, 4.00),
(156, 32, 24, 1, 3.50),
(157, 32, 28, 1, 3.00),
-- Commande 33 (table 4, 72.50)
(158, 33, 2,  1, 12.00),
(159, 33, 8,  1, 22.50),
(160, 33, 18, 1, 9.00),
(161, 33, 29, 2, 9.00),
(162, 33, 27, 2, 2.50),
-- Commande 34 (table 6, 195.00)
(163, 34, 4,  2, 18.50),
(164, 34, 7,  2, 24.00),
(165, 34, 11, 2, 20.00),
(166, 34, 21, 2, 10.00),
(167, 34, 23, 1, 12.00),
(168, 34, 29, 2, 9.00),
-- Commande 35 (table 2, 38.50)
(169, 35, 1,  1, 9.50),
(170, 35, 16, 1, 15.50),
(171, 35, 28, 1, 3.00),
(172, 35, 27, 2, 2.50),
(173, 35, 25, 1, 4.00);
