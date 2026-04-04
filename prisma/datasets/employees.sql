-- departements
CREATE TABLE departements (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    localisation TEXT
);

INSERT INTO departements (id, nom, localisation) VALUES
(1, 'Informatique', 'Paris - La Défense'),
(2, 'Marketing', 'Paris - Opéra'),
(3, 'Ressources Humaines', 'Lyon'),
(4, 'Finance', 'Paris - La Défense'),
(5, 'Commercial', 'Marseille');

-- employes
CREATE TABLE employes (
    id INTEGER PRIMARY KEY,
    prenom TEXT NOT NULL,
    nom TEXT NOT NULL,
    email TEXT,
    date_embauche TEXT,
    salaire REAL,
    departement_id INTEGER,
    poste TEXT,
    FOREIGN KEY (departement_id) REFERENCES departements(id)
);

INSERT INTO employes (id, prenom, nom, email, date_embauche, salaire, departement_id, poste) VALUES
(1,  'Jean',      'Dupont',     'jean.dupont@entreprise.fr',     '2018-03-15', 62000, 1, 'Chef de projet'),
(2,  'Marie',     'Laurent',    'marie.laurent@entreprise.fr',   '2019-07-01', 55000, 1, 'Développeuse senior'),
(3,  'Pierre',    'Martin',     'pierre.martin@entreprise.fr',   '2020-01-10', 42000, 1, 'Développeur junior'),
(4,  'Sophie',    'Bernard',    'sophie.bernard@entreprise.fr',  '2017-09-20', 48000, 1, 'Analyste données'),
(5,  'Lucas',     'Moreau',     'lucas.moreau@entreprise.fr',    '2021-06-01', 38000, 1, 'Développeur junior'),
(6,  'Camille',   'Petit',      'camille.petit@entreprise.fr',   '2016-04-12', 72000, 1, 'Architecte logiciel'),
(7,  'Antoine',   'Roux',       'antoine.roux@entreprise.fr',    '2019-11-05', 45000, 2, 'Chargé de communication'),
(8,  'Émilie',    'Fournier',   'emilie.fournier@entreprise.fr', '2018-02-28', 58000, 2, 'Responsable marketing'),
(9,  'Hugo',      'Girard',     'hugo.girard@entreprise.fr',     '2022-03-14', 35000, 2, 'Assistant marketing'),
(10, 'Léa',       'Bonnet',     'lea.bonnet@entreprise.fr',      '2020-08-17', 42000, 2, 'Community manager'),
(11, 'Nicolas',   'Dubois',     'nicolas.dubois@entreprise.fr',  '2021-01-25', 40000, 2, 'Chargé de communication'),
(12, 'Chloé',     'Leroy',      'chloe.leroy@entreprise.fr',     '2015-06-30', 68000, 3, 'Directrice RH'),
(13, 'Maxime',    'Robin',      'maxime.robin@entreprise.fr',    '2019-10-08', 44000, 3, 'Chargé de recrutement'),
(14, 'Inès',      'Morel',      'ines.morel@entreprise.fr',      '2022-09-01', 36000, 3, 'Assistante RH'),
(15, 'Thomas',    'Simon',      'thomas.simon@entreprise.fr',    '2020-05-18', 41000, 3, 'Gestionnaire paie'),
(16, 'Julie',     'Michel',     'julie.michel@entreprise.fr',    '2017-01-09', 75000, 4, 'Directrice financière'),
(17, 'Alexandre', 'Garcia',     'alexandre.garcia@entreprise.fr','2018-11-22', 52000, 4, 'Contrôleur de gestion'),
(18, 'Manon',     'David',      'manon.david@entreprise.fr',     '2021-04-05', 46000, 4, 'Comptable'),
(19, 'Romain',    'Bertrand',   'romain.bertrand@entreprise.fr', '2019-08-12', 49000, 4, 'Analyste financier'),
(20, 'Clara',     'Richard',    'clara.richard@entreprise.fr',   '2023-01-16', 34000, 4, 'Comptable junior'),
(21, 'Julien',    'Thomas',     'julien.thomas@entreprise.fr',   '2016-10-03', 85000, 5, 'Directeur commercial'),
(22, 'Sarah',     'Robert',     'sarah.robert@entreprise.fr',    '2018-05-14', 52000, 5, 'Responsable grands comptes'),
(23, 'Mathieu',   'Blanc',      'mathieu.blanc@entreprise.fr',   '2020-02-20', 44000, 5, 'Commercial terrain'),
(24, 'Pauline',   'Guérin',     'pauline.guerin@entreprise.fr',  '2021-07-11', 40000, 5, 'Commerciale sédentaire'),
(25, 'Damien',    'Faure',      'damien.faure@entreprise.fr',    '2022-11-28', 36000, 5, 'Commercial junior'),
(26, 'Aurélie',   'Mercier',    NULL,                            '2023-06-01', 32000, 2, 'Stagiaire marketing'),
(27, 'Bastien',   'Lemoine',    'bastien.lemoine@entreprise.fr', '2020-09-15', 47000, 1, 'Administrateur systèmes'),
(28, 'Nathalie',  'Carpentier', 'nathalie.carpentier@entreprise.fr','2014-03-01', 78000, 4, 'Responsable audit'),
(29, 'Éric',      'Perrin',     NULL,                            '2024-01-08', 28000, 3, 'Stagiaire RH'),
(30, 'Céline',    'Chevalier',  'celine.chevalier@entreprise.fr','2019-12-01', NULL,  NULL, 'Consultante externe');

-- projets
CREATE TABLE projets (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    budget REAL,
    date_debut TEXT,
    date_fin TEXT,
    departement_id INTEGER,
    FOREIGN KEY (departement_id) REFERENCES departements(id)
);

INSERT INTO projets (id, nom, budget, date_debut, date_fin, departement_id) VALUES
(1, 'Migration Cloud',          150000, '2024-01-15', '2024-12-31', 1),
(2, 'Refonte Site Web',          85000, '2024-03-01', '2024-09-30', 1),
(3, 'Campagne Été 2024',         60000, '2024-04-01', '2024-08-31', 2),
(4, 'Audit Financier Annuel',    40000, '2024-01-01', '2024-04-30', 4),
(5, 'Expansion Sud-Est',        120000, '2024-02-01', '2025-01-31', 5),
(6, 'Plan de Formation',         30000, '2024-06-01', NULL,         3),
(7, 'Application Mobile',       200000, '2024-05-01', '2025-06-30', 1),
(8, 'Stratégie Réseaux Sociaux', 25000, '2024-03-15', '2024-12-31', 2);

-- affectations
CREATE TABLE affectations (
    employe_id INTEGER,
    projet_id INTEGER,
    role TEXT,
    heures_assignees INTEGER,
    PRIMARY KEY (employe_id, projet_id),
    FOREIGN KEY (employe_id) REFERENCES employes(id),
    FOREIGN KEY (projet_id) REFERENCES projets(id)
);

INSERT INTO affectations (employe_id, projet_id, role, heures_assignees) VALUES
(1,  1, 'Chef de projet',    400),
(2,  1, 'Développeuse lead', 350),
(6,  1, 'Architecte',        300),
(27, 1, 'Administrateur',    250),
(1,  2, 'Superviseur',       100),
(3,  2, 'Développeur',       300),
(5,  2, 'Développeur',       300),
(2,  7, 'Développeuse lead', 500),
(3,  7, 'Développeur',       400),
(5,  7, 'Développeur',       400),
(6,  7, 'Architecte',        200),
(8,  3, 'Responsable',       200),
(7,  3, 'Rédacteur',         150),
(10, 3, 'Community manager', 180),
(9,  8, 'Assistant',         120),
(10, 8, 'Responsable',       200),
(17, 4, 'Auditeur',          250),
(28, 4, 'Responsable audit', 300),
(22, 5, 'Responsable zone',  350),
(23, 5, 'Commercial terrain', 400);
