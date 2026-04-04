-- ============================================
-- Dataset: Hopital Saint-Louis (SQL Clinic)
-- Base de donnees SQLite - Donnees francophones
-- ============================================

-- Suppression des tables existantes
DROP TABLE IF EXISTS prescriptions;
DROP TABLE IF EXISTS medicaments;
DROP TABLE IF EXISTS consultations;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS medecins;
DROP TABLE IF EXISTS services;

-- ============================================
-- CREATION DES TABLES
-- ============================================

CREATE TABLE services (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    etage INTEGER NOT NULL,
    chef_service_id INTEGER
);

CREATE TABLE medecins (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    specialite TEXT NOT NULL,
    service_id INTEGER NOT NULL,
    date_embauche TEXT NOT NULL,
    salaire REAL NOT NULL,
    FOREIGN KEY (service_id) REFERENCES services(id)
);

CREATE TABLE patients (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    date_naissance TEXT NOT NULL,
    sexe TEXT NOT NULL,
    ville TEXT NOT NULL,
    telephone TEXT,
    groupe_sanguin TEXT,
    mutuelle TEXT
);

CREATE TABLE consultations (
    id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL,
    medecin_id INTEGER NOT NULL,
    date_consultation TEXT NOT NULL,
    motif TEXT NOT NULL,
    diagnostic TEXT,
    duree_minutes INTEGER NOT NULL,
    prix REAL NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (medecin_id) REFERENCES medecins(id)
);

CREATE TABLE medicaments (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL,
    categorie TEXT NOT NULL,
    prix REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    ordonnance_requise INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE prescriptions (
    id INTEGER PRIMARY KEY,
    consultation_id INTEGER NOT NULL,
    medicament_id INTEGER NOT NULL,
    posologie TEXT NOT NULL,
    duree_jours INTEGER NOT NULL,
    FOREIGN KEY (consultation_id) REFERENCES consultations(id),
    FOREIGN KEY (medicament_id) REFERENCES medicaments(id)
);

-- ============================================
-- INSERTION DES DONNEES
-- ============================================

-- Services (6)
INSERT INTO services (id, nom, etage, chef_service_id) VALUES
(1, 'Cardiologie', 3, 1),
(2, 'Pediatrie', 1, 4),
(3, 'Urgences', 0, 6),
(4, 'Neurologie', 4, 8),
(5, 'Orthopedie', 2, 10),
(6, 'Dermatologie', 2, 13);

-- Medecins (15)
INSERT INTO medecins (id, nom, prenom, specialite, service_id, date_embauche, salaire) VALUES
(1, 'Moreau', 'Jean-Pierre', 'Cardiologie interventionnelle', 1, '2010-03-15', 8500.00),
(2, 'Dubois', 'Claire', 'Cardiologie generale', 1, '2015-09-01', 7200.00),
(3, 'Lambert', 'Philippe', 'Rythmologie', 1, '2018-01-10', 6800.00),
(4, 'Martin', 'Sophie', 'Pediatrie generale', 2, '2012-06-20', 7500.00),
(5, 'Petit', 'Antoine', 'Neonatologie', 2, '2019-11-05', 6500.00),
(6, 'Durand', 'Marc', 'Medecine d''urgence', 3, '2008-02-28', 8800.00),
(7, 'Lefevre', 'Nathalie', 'Traumatologie', 3, '2016-04-12', 7000.00),
(8, 'Garcia', 'Roberto', 'Neurologie generale', 4, '2011-08-30', 8200.00),
(9, 'Roux', 'Isabelle', 'Neurochirurgie', 4, '2014-05-18', 9200.00),
(10, 'Bernard', 'Francois', 'Chirurgie orthopedique', 5, '2009-07-22', 8700.00),
(11, 'Thomas', 'Julie', 'Rhumatologie', 5, '2017-03-08', 6900.00),
(12, 'Richard', 'David', 'Traumatologie du sport', 5, '2020-09-14', 6200.00),
(13, 'Leroy', 'Catherine', 'Dermatologie generale', 6, '2013-11-25', 7100.00),
(14, 'Simon', 'Alexandre', 'Dermatologie esthetique', 6, '2021-02-01', 6000.00),
(15, 'Mercier', 'Emilie', 'Pediatrie', 2, '2022-06-15', 5800.00);

-- Patients (30)
INSERT INTO patients (id, nom, prenom, date_naissance, sexe, ville, telephone, groupe_sanguin, mutuelle) VALUES
(1, 'Dupont', 'Marie', '1985-04-12', 'F', 'Paris', '0612345678', 'A+', 'MGEN'),
(2, 'Lefebvre', 'Pierre', '1972-08-23', 'M', 'Lyon', '0623456789', 'O+', 'Harmonie Mutuelle'),
(3, 'Girard', 'Camille', '1990-01-05', 'F', 'Marseille', '0634567890', 'B+', NULL),
(4, 'Bonnet', 'Lucas', '2015-11-30', 'M', 'Paris', '0645678901', 'A-', 'MAAF'),
(5, 'Fournier', 'Emma', '1968-06-17', 'F', 'Toulouse', '0656789012', 'O-', 'MGEN'),
(6, 'Morel', 'Hugo', '1995-09-08', 'M', 'Bordeaux', '0667890123', 'AB+', 'Harmonie Mutuelle'),
(7, 'Rousseau', 'Lea', '2018-03-22', 'F', 'Nantes', '0678901234', 'A+', 'Groupama'),
(8, 'Blanc', 'Thomas', '1980-12-01', 'M', 'Strasbourg', '0689012345', 'O+', NULL),
(9, 'Guerin', 'Chloe', '1999-07-14', 'F', 'Paris', '0690123456', 'B-', 'MGEN'),
(10, 'Faure', 'Antoine', '1955-02-28', 'M', 'Lyon', NULL, 'A+', 'Malakoff Humanis'),
(11, 'Andre', 'Sarah', '1988-10-19', 'F', 'Marseille', '0612340001', 'O+', 'Harmonie Mutuelle'),
(12, 'Clement', 'Nicolas', '2005-05-06', 'M', 'Lille', '0612340002', 'AB-', NULL),
(13, 'Gauthier', 'Julie', '1975-08-11', 'F', 'Toulouse', '0612340003', 'A+', 'MAAF'),
(14, 'Perrin', 'Maxime', '1962-01-25', 'M', 'Bordeaux', '0612340004', 'O+', 'Groupama'),
(15, 'Robin', 'Clara', '2010-12-03', 'F', 'Nantes', '0612340005', 'B+', 'MGEN'),
(16, 'David', 'Julien', '1983-04-30', 'M', 'Paris', '0612340006', 'A-', 'Harmonie Mutuelle'),
(17, 'Bertrand', 'Manon', '1997-06-22', 'F', 'Lyon', '0612340007', 'O-', NULL),
(18, 'Michel', 'Gabriel', '1970-09-15', 'M', 'Strasbourg', '0612340008', 'AB+', 'Malakoff Humanis'),
(19, 'Leclerc', 'Ines', '2008-02-14', 'F', 'Lille', '0612340009', 'A+', 'Groupama'),
(20, 'Renard', 'Paul', '1958-11-07', 'M', 'Marseille', '0612340010', 'O+', 'MGEN'),
(21, 'Picard', 'Louise', '1992-03-18', 'F', 'Toulouse', '0612340011', 'B+', 'MAAF'),
(22, 'Arnaud', 'Romain', '1987-07-09', 'M', 'Bordeaux', NULL, 'A+', NULL),
(23, 'Vincent', 'Amandine', '2001-10-26', 'F', 'Nantes', '0612340013', 'O-', 'Harmonie Mutuelle'),
(24, 'Masson', 'Victor', '1965-05-20', 'M', 'Paris', '0612340014', 'AB+', 'MGEN'),
(25, 'Chevalier', 'Eva', '2012-08-31', 'F', 'Lyon', '0612340015', 'A-', 'Groupama'),
(26, 'Marchand', 'Theo', '1978-01-12', 'M', 'Strasbourg', '0612340016', 'O+', 'Malakoff Humanis'),
(27, 'Duval', 'Alice', '1993-04-05', 'F', 'Lille', '0612340017', 'B-', NULL),
(28, 'Henry', 'Mathis', '2003-09-17', 'M', 'Marseille', '0612340018', 'A+', 'MAAF'),
(29, 'Schmitt', 'Charlotte', '1960-06-28', 'F', 'Strasbourg', '0612340019', 'O+', 'Harmonie Mutuelle'),
(30, 'Barbier', 'Louis', '1982-11-14', 'M', 'Toulouse', '0612340020', 'AB-', 'MGEN');

-- Medicaments (20)
INSERT INTO medicaments (id, nom, categorie, prix, stock, ordonnance_requise) VALUES
(1, 'Doliprane 1000mg', 'Antalgique', 2.50, 500, 0),
(2, 'Amoxicilline 500mg', 'Antibiotique', 4.80, 200, 1),
(3, 'Ibuprofene 400mg', 'Anti-inflammatoire', 3.20, 350, 0),
(4, 'Omeprazole 20mg', 'Anti-acide', 5.60, 180, 1),
(5, 'Metformine 850mg', 'Antidiabetique', 3.90, 150, 1),
(6, 'Amlodipine 5mg', 'Antihypertenseur', 4.50, 120, 1),
(7, 'Levothyrox 75ug', 'Hormone thyroidienne', 3.10, 200, 1),
(8, 'Ventoline spray', 'Bronchodilatateur', 6.80, 90, 1),
(9, 'Xanax 0.25mg', 'Anxiolytique', 4.20, 60, 1),
(10, 'Kardegic 75mg', 'Antithrombotique', 2.80, 300, 1),
(11, 'Spasfon 80mg', 'Antispasmodique', 3.50, 250, 0),
(12, 'Smecta', 'Anti-diarrheique', 4.10, 180, 0),
(13, 'Augmentin 1g', 'Antibiotique', 7.20, 100, 1),
(14, 'Cortisone 20mg', 'Corticoide', 5.30, 80, 1),
(15, 'Tramadol 50mg', 'Antalgique', 3.70, 70, 1),
(16, 'Lovenox 4000UI', 'Anticoagulant', 12.50, 40, 1),
(17, 'Voltarene gel', 'Anti-inflammatoire', 8.90, 160, 0),
(18, 'Aerius 5mg', 'Antihistaminique', 5.10, 140, 1),
(19, 'Gaviscon', 'Anti-acide', 6.30, 110, 0),
(20, 'Dafalgan codeine', 'Antalgique', 3.40, 95, 1);

-- Consultations (50)
INSERT INTO consultations (id, patient_id, medecin_id, date_consultation, motif, diagnostic, duree_minutes, prix) VALUES
(1, 1, 1, '2024-09-02', 'Douleur thoracique', 'Angine de poitrine stable', 45, 75.00),
(2, 2, 6, '2024-09-03', 'Chute a domicile', 'Entorse cheville gauche', 30, 50.00),
(3, 3, 13, '2024-09-05', 'Eruption cutanee', 'Eczema de contact', 20, 45.00),
(4, 4, 4, '2024-09-06', 'Fievre persistante', 'Angine virale', 25, 40.00),
(5, 5, 8, '2024-09-09', 'Cephalees recurrentes', 'Migraine avec aura', 40, 70.00),
(6, 6, 10, '2024-09-10', 'Douleur genou', 'Rupture meniscale', 35, 60.00),
(7, 7, 5, '2024-09-11', 'Controle croissance', NULL, 20, 35.00),
(8, 8, 2, '2024-09-12', 'Essoufflement', 'Insuffisance cardiaque legere', 50, 80.00),
(9, 9, 7, '2024-09-15', 'Accident velo', 'Fracture radius droit', 40, 55.00),
(10, 10, 1, '2024-09-16', 'Suivi post-infarctus', 'Evolution favorable', 30, 75.00),
(11, 11, 6, '2024-09-17', 'Douleur abdominale', 'Appendicite aigue', 25, 50.00),
(12, 12, 4, '2024-09-18', 'Vaccination rappel', NULL, 15, 30.00),
(13, 13, 9, '2024-09-19', 'Perte de memoire', 'Debut maladie Alzheimer', 60, 90.00),
(14, 14, 10, '2024-09-20', 'Douleur hanche', 'Arthrose coxo-femorale', 35, 60.00),
(15, 15, 5, '2024-09-23', 'Otite', 'Otite moyenne aigue', 20, 35.00),
(16, 16, 3, '2024-09-24', 'Palpitations', 'Fibrillation auriculaire', 45, 75.00),
(17, 17, 13, '2024-09-25', 'Acne severe', 'Acne nodulo-kystique', 25, 45.00),
(18, 18, 8, '2024-09-26', 'Tremblements mains', 'Maladie de Parkinson', 50, 85.00),
(19, 19, 11, '2024-09-27', 'Douleur dos', 'Scoliose', 30, 55.00),
(20, 20, 6, '2024-09-30', 'Malaise general', 'Deshydratation', 20, 50.00),
(21, 21, 14, '2024-10-01', 'Grain de beaute suspect', 'Naevus atypique', 30, 50.00),
(22, 22, 2, '2024-10-02', 'Hypertension', 'HTA grade 2', 35, 65.00),
(23, 23, 7, '2024-10-03', 'Entorse poignet', 'Entorse benigne', 25, 45.00),
(24, 24, 1, '2024-10-04', 'Bilan cardiaque', 'Souffle cardiaque benin', 40, 75.00),
(25, 25, 4, '2024-10-07', 'Bronchiolite', 'Bronchiolite virale', 30, 40.00),
(26, 26, 9, '2024-10-08', 'Vertiges', 'Nevrite vestibulaire', 35, 70.00),
(27, 27, 6, '2024-10-09', 'Brulure main', 'Brulure second degre', 20, 50.00),
(28, 28, 11, '2024-10-10', 'Douleur epaule', 'Tendinite sus-epineux', 30, 55.00),
(29, 29, 3, '2024-10-11', 'Douleur poitrine', 'Angor instable', 50, 80.00),
(30, 30, 14, '2024-10-14', 'Psoriasis', 'Psoriasis en plaques', 25, 50.00),
(31, 1, 2, '2024-10-15', 'Suivi cardiologique', 'Stable sous traitement', 30, 65.00),
(32, 5, 9, '2024-10-16', 'Maux de tete violents', 'AIT suspect', 55, 90.00),
(33, 8, 10, '2024-10-17', 'Douleur genou droit', 'Gonarthrose', 30, 60.00),
(34, 11, 13, '2024-10-18', 'Allergie cutanee', 'Urticaire chronique', 25, 45.00),
(35, 16, 1, '2024-10-21', 'Controle tension', 'HTA bien controlee', 20, 60.00),
(36, 20, 8, '2024-10-22', 'Confusion mentale', NULL, 40, 70.00),
(37, 3, 6, '2024-10-23', 'Torsion cheville', 'Entorse grade 2', 25, 50.00),
(38, 9, 14, '2024-10-24', 'Taches cutanees', 'Vitiligo debutant', 20, 45.00),
(39, 14, 11, '2024-10-25', 'Suivi rhumatologie', 'Polyarthrite rhumatoide', 40, 65.00),
(40, 22, 6, '2024-10-28', 'Coupure profonde', 'Plaie necessite suture', 30, 55.00),
(41, 4, 15, '2024-10-29', 'Controle pediatrique', NULL, 20, 35.00),
(42, 7, 4, '2024-10-30', 'Gastro-enterite', 'Gastro-enterite virale', 25, 40.00),
(43, 12, 7, '2024-10-31', 'Fracture orteil', 'Fracture 5e orteil', 20, 45.00),
(44, 18, 9, '2024-11-04', 'Suivi neurologique', 'Parkinson stade 2', 45, 85.00),
(45, 24, 3, '2024-11-05', 'Arythmie', 'Tachycardie supraventriculaire', 40, 75.00),
(46, 26, 8, '2024-11-06', 'Nevralgie faciale', 'Nevralgie du trijumeau', 35, 70.00),
(47, 28, 10, '2024-11-07', 'Fracture poignet', 'Fracture Pouteau-Colles', 45, 65.00),
(48, 30, 13, '2024-11-08', 'Suivi psoriasis', 'Amelioration clinique', 20, 45.00),
(49, 2, 2, '2024-11-12', 'Bilan cardiovasculaire', 'Atherosclerose debutante', 50, 80.00),
(50, 6, 12, '2024-11-13', 'Douleur cheville sport', 'Tendinite achilleenne', 30, 55.00);

-- Prescriptions (40)
INSERT INTO prescriptions (id, consultation_id, medicament_id, posologie, duree_jours) VALUES
(1, 1, 10, '1 sachet le matin', 365),
(2, 1, 6, '1 comprime le soir', 90),
(3, 2, 3, '1 comprime 3 fois par jour', 7),
(4, 2, 1, '1 comprime si douleur, max 4 par jour', 5),
(5, 3, 14, '1 application matin et soir', 14),
(6, 4, 1, '1 comprime 3 fois par jour', 5),
(7, 5, 15, '1 comprime en cas de crise', 10),
(8, 6, 3, '1 comprime 2 fois par jour', 14),
(9, 6, 17, '1 application 3 fois par jour', 14),
(10, 8, 6, '1 comprime le matin', 180),
(11, 8, 16, '1 injection par jour', 10),
(12, 9, 1, '1 comprime 4 fois par jour', 7),
(13, 9, 15, '1 comprime matin et soir', 5),
(14, 10, 10, '1 sachet le matin', 365),
(15, 11, 4, '1 comprime avant repas', 14),
(16, 13, 9, '1 comprime le soir', 30),
(17, 14, 3, '1 comprime 3 fois par jour', 21),
(18, 14, 17, '1 application 2 fois par jour', 21),
(19, 15, 2, '1 comprime 2 fois par jour', 7),
(20, 16, 10, '1 sachet le matin', 365),
(21, 17, 14, '1 comprime par jour', 30),
(22, 18, 9, '1 comprime matin et soir', 60),
(23, 19, 3, '1 comprime 2 fois par jour', 10),
(24, 20, 12, '1 sachet 3 fois par jour', 3),
(25, 22, 6, '1 comprime le matin', 90),
(26, 23, 1, '1 comprime si douleur', 5),
(27, 25, 8, '2 bouffees si besoin', 7),
(28, 26, 9, '1 comprime le soir', 14),
(29, 28, 17, '1 application 2 fois par jour', 21),
(30, 29, 10, '1 sachet le matin', 365),
(31, 29, 16, '1 injection par jour', 14),
(32, 30, 14, '1 application le soir', 30),
(33, 32, 15, '1 comprime en urgence', 3),
(34, 33, 3, '1 comprime 3 fois par jour', 14),
(35, 34, 18, '1 comprime le matin', 30),
(36, 39, 5, '1 comprime matin et soir', 90),
(37, 42, 12, '1 sachet 3 fois par jour', 5),
(38, 44, 9, '1 comprime matin et soir', 60),
(39, 46, 15, '1 comprime 2 fois par jour', 14),
(40, 47, 1, '1 comprime 4 fois par jour', 10);
