-- ============================================================================
-- SQL Clinic Tasks - Dataset Université (dataset_id = 6)
-- 50 exercises: 15 beginner, 15 intermediate, 15 advanced, 5 expert
-- ============================================================================

BEGIN;

-- Dataset insert
INSERT INTO sql_clinic_datasets (slug, name, description, db_type, is_active, created_at, updated_at)
VALUES ('universite', 'Université Paris-Lumière', 'Base de données d''une université avec professeurs, étudiants, cours et notes.', 'sqlite', true, NOW(), NOW())
ON CONFLICT (slug) DO NOTHING;

-- ============================================================================
-- BEGINNER (1-15) — 10 pts each
-- ============================================================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-departements',
  'Liste des départements',
  'Affichez tous les départements de l''université.',
  'Écrivez une requête qui affiche toutes les colonnes de la table `departements`, triées par `id` croissant.',
  'beginner',
  'SELECT * FROM departements ORDER BY id;',
  '{"columns":["id","nom","responsable","batiment"],"rows":[[1,"Informatique","Prof. Lefebvre","Bâtiment A"],[2,"Mathématiques","Prof. Garnier","Bâtiment B"],[3,"Physique","Prof. Morel","Bâtiment C"],[4,"Lettres","Prof. Rousseau","Bâtiment D"],[5,"Économie","Prof. Blanchard","Bâtiment E"]]}',
  'Utilise SELECT * et ORDER BY pour trier par identifiant.',
  10,
  1,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-professeurs-pu',
  'Professeurs titulaires',
  'Trouvez les professeurs ayant le grade PU.',
  'Sélectionnez le prénom, le nom et le département (`departement_id`) des professeurs dont le grade est ''PU'', triés par `nom`.',
  'beginner',
  'SELECT prenom, nom, departement_id FROM professeurs WHERE grade = ''PU'' ORDER BY nom;',
  '{"columns":["prenom","nom","departement_id"],"rows":[["Sophie","Blanchard",5],["Isabelle","Garnier",2],["Antoine","Lefebvre",1],["Catherine","Morel",3],["Claire","Rousseau",4]]}',
  'Filtre avec WHERE grade = ''PU'' et trie par nom.',
  10,
  2,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiants-paris',
  'Étudiants parisiens',
  'Listez les étudiants habitant à Paris.',
  'Sélectionnez le prénom, le nom et l''année d''étude des étudiants habitant à Paris, triés par `nom`.',
  'beginner',
  'SELECT prenom, nom, annee_etude FROM etudiants WHERE ville = ''Paris'' ORDER BY nom;',
  '{"columns":["prenom","nom","annee_etude"],"rows":[["Rose","Dumas",2],["Eva","Masson",5],["Lucas","Martin",1],["Louis","Bertrand",3],["Adam","Roux",1],["Léo","Schmitt",5]]}',
  'Filtre avec WHERE ville = ''Paris'' et trie par nom.',
  10,
  3,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-boursiers',
  'Étudiants boursiers',
  'Identifiez les étudiants qui bénéficient d''une bourse.',
  'Sélectionnez le prénom, le nom et la ville des étudiants boursiers (`boursier = 1`), triés par `nom`.',
  'beginner',
  'SELECT prenom, nom, ville FROM etudiants WHERE boursier = 1 ORDER BY nom;',
  '{"columns":["prenom","nom","ville"],"rows":[["Emma","Bernard","Lyon"],["Paul","Carpentier","Lyon"],["Inès","Lambert","Strasbourg"],["Camille","Leroy","Lille"],["Zoé","Noel","Nice"],["Mia","Perrin","Bordeaux"],["Lina","Picard","Strasbourg"],["Léa","Richard","Nantes"],["Arthur","Robin","Lille"],["Adam","Roux","Paris"],["Liam","Sanchez","Lyon"],["Manon","Simon","Montpellier"],["Chloé","Thomas","Toulouse"],["Louise","Bonnet","Nice"]]}',
  'Utilise WHERE boursier = 1 pour filtrer les boursiers.',
  10,
  4,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-cours-info',
  'Cours d''informatique',
  'Affichez les cours du département Informatique.',
  'Sélectionnez le nom, le code et les crédits des cours du département Informatique (`departement_id = 1`), triés par `code`.',
  'beginner',
  'SELECT nom, code, credits FROM cours WHERE departement_id = 1 ORDER BY code;',
  '{"columns":["nom","code","credits"],"rows":[["Introduction à la programmation","INF101",6],["Bases de données","INF201",6],["Algorithmes et structures","INF202",6],["Réseaux informatiques","INF301",4]]}',
  'Filtre avec WHERE departement_id = 1 et trie par code.',
  10,
  5,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-cours-6-credits',
  'Cours à 6 crédits',
  'Trouvez les cours valant 6 crédits.',
  'Sélectionnez le nom, le code et le semestre des cours ayant exactement 6 crédits, triés par `code`.',
  'beginner',
  'SELECT nom, code, semestre FROM cours WHERE credits = 6 ORDER BY code;',
  '{"columns":["nom","code","semestre"],"rows":[["Microéconomie","ECO101",1],["Macroéconomie","ECO102",1],["Introduction à la programmation","INF101",1],["Bases de données","INF201",2],["Algorithmes et structures","INF202",1],["Littérature française","LET101",1],["Analyse mathématique","MAT101",1],["Algèbre linéaire","MAT102",1],["Mécanique classique","PHY101",1],["Électromagnétisme","PHY201",2]]}',
  'Filtre avec WHERE credits = 6 et trie par code.',
  10,
  6,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiants-l1',
  'Étudiants en première année',
  'Listez les étudiants en L1.',
  'Sélectionnez le prénom, le nom et la ville des étudiants en première année (`annee_etude = 1`), triés par `nom`.',
  'beginner',
  'SELECT prenom, nom, ville FROM etudiants WHERE annee_etude = 1 ORDER BY nom;',
  '{"columns":["prenom","nom","ville"],"rows":[["Noah","Clement","Lille"],["Hugo","Dubois","Marseille"],["Maxime","Fontaine","Montpellier"],["Gabriel","Girard","Toulouse"],["Lucas","Martin","Paris"],["Tom","Mercier","Nantes"],["Théo","Moreau","Strasbourg"],["Adam","Roux","Paris"],["Liam","Sanchez","Lyon"]]}',
  'Filtre avec WHERE annee_etude = 1.',
  10,
  7,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-notes-examens',
  'Notes d''examen élevées',
  'Trouvez les notes d''examen supérieures à 16.',
  'Sélectionnez l''inscription_id, la note et la date_evaluation des notes de type ''examen'' dont la note est supérieure à 16, triées par `note` décroissante.',
  'beginner',
  'SELECT inscription_id, note, date_evaluation FROM notes WHERE type_evaluation = ''examen'' AND note > 16 ORDER BY note DESC;',
  '{"columns":["inscription_id","note","date_evaluation"],"rows":[[50,18.0,"2025-01-17"],[15,18.0,"2025-01-18"],[25,17.5,"2025-01-14"],[13,17.0,"2025-01-14"],[33,17.0,"2025-01-14"],[11,16.5,"2025-01-14"],[29,16.5,"2025-01-15"]]}',
  'Combine deux conditions avec AND : type_evaluation = ''examen'' et note > 16.',
  10,
  8,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-profs-recents',
  'Recrutements récents',
  'Trouvez les professeurs recrutés depuis 2020.',
  'Sélectionnez le prénom, le nom, le grade et la date de recrutement des professeurs recrutés à partir du 1er janvier 2020 (`date_recrutement >= ''2020-01-01''`), triés par `date_recrutement`.',
  'beginner',
  'SELECT prenom, nom, grade, date_recrutement FROM professeurs WHERE date_recrutement >= ''2020-01-01'' ORDER BY date_recrutement;',
  '{"columns":["prenom","nom","grade","date_recrutement"],"rows":[["Thomas","Chevalier","ATER","2023-09-01"],["Karim","Benali","Vacataire","2024-01-15"]]}',
  'Compare date_recrutement >= ''2020-01-01'' et trie par date.',
  10,
  9,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-count-etudiants',
  'Nombre total d''étudiants',
  'Comptez le nombre total d''étudiants inscrits.',
  'Écrivez une requête qui retourne le nombre total d''étudiants dans la table `etudiants` (alias `total`).',
  'beginner',
  'SELECT COUNT(*) AS total FROM etudiants;',
  '{"columns":["total"],"rows":[[35]]}',
  'Utilise COUNT(*) avec un alias AS total.',
  10,
  10,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-notes-between',
  'Notes moyennes',
  'Trouvez les notes entre 10 et 14.',
  'Sélectionnez l''inscription_id, le type_evaluation, la note et le coefficient des notes comprises entre 10 et 14 (inclus), triées par `note` décroissante.',
  'beginner',
  'SELECT inscription_id, type_evaluation, note, coefficient FROM notes WHERE note BETWEEN 10 AND 14 ORDER BY note DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE note BETWEEN 10 AND 14.',
  10,
  11,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiants-order-age',
  'Étudiants par date de naissance',
  'Triez les étudiants du plus âgé au plus jeune.',
  'Sélectionnez le prénom, le nom et la date_naissance de tous les étudiants, triés par `date_naissance` croissante (les plus âgés en premier). Limitez aux 10 premiers résultats.',
  'beginner',
  'SELECT prenom, nom, date_naissance FROM etudiants ORDER BY date_naissance LIMIT 10;',
  '{"columns":["prenom","nom","date_naissance"],"rows":[["Léo","Schmitt","2000-12-01"],["Mia","Perrin","2001-01-19"],["Léa","Richard","2001-05-25"],["Eva","Masson","2001-06-16"],["Ambre","Andre","2001-08-09"],["Zoé","Noel","2001-09-08"],["Camille","Leroy","2001-10-14"],["Alice","Fournier","2001-11-22"],["Inès","Lambert","2001-03-14"],["Chloé","Thomas","2002-01-30"]]}',
  'Utilise ORDER BY date_naissance et LIMIT 10.',
  10,
  12,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-cours-semestre1',
  'Cours du premier semestre',
  'Listez les cours du semestre 1.',
  'Sélectionnez le nom, le code et les crédits des cours du semestre 1, triés par `code`.',
  'beginner',
  'SELECT nom, code, credits FROM cours WHERE semestre = 1 ORDER BY code;',
  '{"columns":["nom","code","credits"],"rows":[["Microéconomie","ECO101",6],["Macroéconomie","ECO102",6],["Introduction à la programmation","INF101",6],["Algorithmes et structures","INF202",6],["Littérature française","LET101",6],["Littérature comparée","LET301",4],["Analyse mathématique","MAT101",6],["Algèbre linéaire","MAT102",6],["Équations différentielles","MAT301",4],["Mécanique classique","PHY101",6],["Physique quantique","PHY301",4]]}',
  'Filtre avec WHERE semestre = 1.',
  10,
  13,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiants-villes',
  'Villes distinctes',
  'Listez les villes d''origine des étudiants sans doublons.',
  'Sélectionnez les villes distinctes des étudiants, triées par ordre alphabétique.',
  'beginner',
  'SELECT DISTINCT ville FROM etudiants ORDER BY ville;',
  '{"columns":["ville"],"rows":[["Bordeaux"],["Lille"],["Lyon"],["Marseille"],["Montpellier"],["Nantes"],["Nice"],["Paris"],["Strasbourg"],["Toulouse"]]}',
  'Utilise SELECT DISTINCT pour éviter les doublons.',
  10,
  14,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-profs-count-grade',
  'Répartition par grade',
  'Comptez le nombre de professeurs par grade.',
  'Affichez le grade et le nombre de professeurs (alias `nombre`) pour chaque grade, triés par `nombre` décroissant.',
  'beginner',
  'SELECT grade, COUNT(*) AS nombre FROM professeurs GROUP BY grade ORDER BY nombre DESC;',
  '{"columns":["grade","nombre"],"rows":[["MCF",5],["PU",5],["ATER",1],["Vacataire",1]]}',
  'Utilise COUNT(*) avec GROUP BY grade.',
  10,
  15,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ============================================================================
-- INTERMEDIATE (16-30) — 20 pts each
-- ============================================================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-profs-departement',
  'Professeurs et leurs départements',
  'Associez chaque professeur à son département.',
  'Sélectionnez le prénom et le nom du professeur, ainsi que le nom du département (alias `departement`). Triez par nom de département puis par nom du professeur.',
  'intermediate',
  'SELECT p.prenom, p.nom, d.nom AS departement FROM professeurs p JOIN departements d ON p.departement_id = d.id ORDER BY d.nom, p.nom;',
  '{"columns":["prenom","nom","departement"],"rows":[["Sophie","Blanchard","Économie"],["Thomas","Chevalier","Économie"],["Philippe","Durand","Informatique"],["Antoine","Lefebvre","Informatique"],["Marie","Nguyen","Informatique"],["Karim","Benali","Informatique"],["Nicolas","Lambert","Lettres"],["Claire","Rousseau","Lettres"],["Isabelle","Garnier","Mathématiques"],["François","Petit","Mathématiques"],["Julien","Faure","Physique"],["Catherine","Morel","Physique"]]}',
  'Fais un JOIN entre professeurs et departements sur departement_id.',
  20,
  16,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiants-par-ville',
  'Étudiants par ville',
  'Comptez le nombre d''étudiants dans chaque ville.',
  'Affichez la ville et le nombre d''étudiants (alias `nombre`) par ville, triés par `nombre` décroissant puis par `ville`.',
  'intermediate',
  'SELECT ville, COUNT(*) AS nombre FROM etudiants GROUP BY ville ORDER BY nombre DESC, ville;',
  '{"columns":["ville","nombre"],"rows":[["Paris",6],["Lyon",3],["Marseille",3],["Bordeaux",2],["Lille",2],["Montpellier",2],["Nantes",2],["Nice",2],["Strasbourg",2],["Toulouse",2]]}',
  'Utilise COUNT(*) avec GROUP BY ville.',
  20,
  17,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-moyenne-notes-type',
  'Moyenne par type d''évaluation',
  'Calculez la note moyenne pour chaque type d''évaluation.',
  'Affichez le type_evaluation et la moyenne des notes (alias `moyenne`, arrondie à 1 décimale) pour chaque type d''évaluation, triés par `moyenne` décroissante.',
  'intermediate',
  'SELECT type_evaluation, ROUND(AVG(note), 1) AS moyenne FROM notes GROUP BY type_evaluation ORDER BY moyenne DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise ROUND(AVG(note), 1) avec GROUP BY type_evaluation.',
  20,
  18,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-cours-avec-prof',
  'Cours et professeurs',
  'Affichez chaque cours avec le nom de son professeur.',
  'Sélectionnez le nom du cours (alias `cours`), le code, et le nom complet du professeur (prénom + '' '' + nom, alias `professeur`). Triez par `code`.',
  'intermediate',
  'SELECT c.nom AS cours, c.code, p.prenom || '' '' || p.nom AS professeur FROM cours c JOIN professeurs p ON c.professeur_id = p.id ORDER BY c.code;',
  '{"columns":[],"rows":[]}',
  'Joins cours et professeurs. Utilise || pour concaténer prénom et nom.',
  20,
  19,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-nb-inscrits-cours',
  'Nombre d''inscrits par cours',
  'Comptez le nombre d''étudiants inscrits à chaque cours.',
  'Sélectionnez le nom du cours (alias `cours`), le code et le nombre d''inscrits (alias `nb_inscrits`). Triez par `nb_inscrits` décroissant puis par `code`.',
  'intermediate',
  'SELECT c.nom AS cours, c.code, COUNT(i.id) AS nb_inscrits FROM cours c JOIN inscriptions i ON c.id = i.cours_id GROUP BY c.id, c.nom, c.code ORDER BY nb_inscrits DESC, c.code;',
  '{"columns":[],"rows":[]}',
  'Joins cours et inscriptions, puis COUNT avec GROUP BY.',
  20,
  20,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-boursiers-par-annee',
  'Boursiers par année d''étude',
  'Comptez le nombre de boursiers par année d''étude.',
  'Affichez l''annee_etude et le nombre de boursiers (alias `nb_boursiers`) pour chaque année d''étude, triés par `annee_etude`.',
  'intermediate',
  'SELECT annee_etude, COUNT(*) AS nb_boursiers FROM etudiants WHERE boursier = 1 GROUP BY annee_etude ORDER BY annee_etude;',
  '{"columns":["annee_etude","nb_boursiers"],"rows":[[1,3],[2,4],[3,3],[4,3],[5,1]]}',
  'Filtre d''abord avec WHERE boursier = 1, puis GROUP BY annee_etude.',
  20,
  21,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-villes-3-plus',
  'Villes avec au moins 3 étudiants',
  'Trouvez les villes ayant 3 étudiants ou plus.',
  'Affichez la ville et le nombre d''étudiants (alias `nombre`) pour les villes ayant au moins 3 étudiants, triées par `nombre` décroissant.',
  'intermediate',
  'SELECT ville, COUNT(*) AS nombre FROM etudiants GROUP BY ville HAVING COUNT(*) >= 3 ORDER BY nombre DESC;',
  '{"columns":["ville","nombre"],"rows":[["Paris",6],["Lyon",3],["Marseille",3]]}',
  'Utilise HAVING COUNT(*) >= 3 après le GROUP BY.',
  20,
  22,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-profs-nb-cours',
  'Charge d''enseignement',
  'Comptez le nombre de cours enseignés par chaque professeur.',
  'Sélectionnez le prénom, le nom du professeur et le nombre de cours (alias `nb_cours`). Triez par `nb_cours` décroissant puis par `nom`.',
  'intermediate',
  'SELECT p.prenom, p.nom, COUNT(c.id) AS nb_cours FROM professeurs p JOIN cours c ON p.id = c.professeur_id GROUP BY p.id, p.prenom, p.nom ORDER BY nb_cours DESC, p.nom;',
  '{"columns":[],"rows":[]}',
  'Joins professeurs et cours, puis COUNT avec GROUP BY.',
  20,
  23,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiants-sans-inscription',
  'Étudiants sans inscription',
  'Trouvez les étudiants qui ne sont inscrits à aucun cours.',
  'Sélectionnez le prénom, le nom et l''année d''étude des étudiants n''ayant aucune inscription, triés par `nom`.',
  'intermediate',
  'SELECT e.prenom, e.nom, e.annee_etude FROM etudiants e WHERE e.id NOT IN (SELECT DISTINCT etudiant_id FROM inscriptions) ORDER BY e.nom;',
  '{"columns":["prenom","nom","annee_etude"],"rows":[["Ambre","Andre",4],["Noah","Clement",1],["Rose","Dumas",2],["Maxime","Fontaine",1],["Léo","Schmitt",5]]}',
  'Utilise NOT IN avec une sous-requête sur inscriptions.',
  20,
  24,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-credits-total-dept',
  'Total crédits par département',
  'Calculez le total des crédits offerts par département.',
  'Sélectionnez le nom du département (alias `departement`) et la somme des crédits (alias `total_credits`). Triez par `total_credits` décroissant.',
  'intermediate',
  'SELECT d.nom AS departement, SUM(c.credits) AS total_credits FROM departements d JOIN cours c ON d.id = c.departement_id GROUP BY d.id, d.nom ORDER BY total_credits DESC;',
  '{"columns":["departement","total_credits"],"rows":[["Informatique",22],["Mathématiques",20],["Physique",20],["Lettres",18],["Économie",20]]}',
  'Joins departements et cours, puis SUM(credits) avec GROUP BY.',
  20,
  25,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-notes-sous-10',
  'Notes en dessous de la moyenne',
  'Comptez les notes inférieures à 10 par type d''évaluation.',
  'Affichez le type_evaluation et le nombre de notes inférieures à 10 (alias `nb_sous_10`). Ne gardez que les types ayant au moins une note sous 10. Triez par `nb_sous_10` décroissant.',
  'intermediate',
  'SELECT type_evaluation, COUNT(*) AS nb_sous_10 FROM notes WHERE note < 10 GROUP BY type_evaluation HAVING COUNT(*) >= 1 ORDER BY nb_sous_10 DESC;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE note < 10, puis GROUP BY et HAVING.',
  20,
  26,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-inscriptions-2024',
  'Inscriptions 2024-2025',
  'Listez les étudiants inscrits pour l''année 2024-2025 avec leurs cours.',
  'Sélectionnez le prénom et le nom de l''étudiant, le nom du cours (alias `cours`) et l''annee_universitaire. Filtrez sur l''année ''2024-2025''. Triez par nom de l''étudiant puis par nom du cours. Limitez aux 15 premiers résultats.',
  'intermediate',
  'SELECT e.prenom, e.nom, c.nom AS cours, i.annee_universitaire FROM inscriptions i JOIN etudiants e ON i.etudiant_id = e.id JOIN cours c ON i.cours_id = c.id WHERE i.annee_universitaire = ''2024-2025'' ORDER BY e.nom, c.nom LIMIT 15;',
  '{"columns":[],"rows":[]}',
  'Triple jointure : inscriptions -> etudiants et inscriptions -> cours.',
  20,
  27,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-nb-etudiants-annee',
  'Répartition par année d''étude',
  'Comptez les étudiants dans chaque année d''étude.',
  'Affichez l''annee_etude et le nombre d''étudiants (alias `nombre`), triés par `annee_etude`.',
  'intermediate',
  'SELECT annee_etude, COUNT(*) AS nombre FROM etudiants GROUP BY annee_etude ORDER BY annee_etude;',
  '{"columns":["annee_etude","nombre"],"rows":[[1,9],[2,8],[3,7],[4,5],[5,6]]}',
  'Utilise COUNT(*) avec GROUP BY annee_etude.',
  20,
  28,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-max-note-cours',
  'Meilleure note par cours',
  'Trouvez la meilleure note obtenue dans chaque cours.',
  'Sélectionnez le nom du cours (alias `cours`) et la note maximale (alias `meilleure_note`) en joignant notes, inscriptions et cours. Triez par `meilleure_note` décroissante. Limitez aux 10 premiers.',
  'intermediate',
  'SELECT c.nom AS cours, MAX(n.note) AS meilleure_note FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN cours c ON i.cours_id = c.id GROUP BY c.id, c.nom ORDER BY meilleure_note DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'Triple jointure notes -> inscriptions -> cours, puis MAX(note) avec GROUP BY.',
  20,
  29,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-nb-etudiants-par-dept',
  'Étudiants inscrits par département',
  'Comptez les étudiants distincts inscrits dans chaque département.',
  'Sélectionnez le nom du département (alias `departement`) et le nombre d''étudiants distincts inscrits (alias `nb_etudiants`). Joignez inscriptions, cours et departements. Triez par `nb_etudiants` décroissant.',
  'intermediate',
  'SELECT d.nom AS departement, COUNT(DISTINCT i.etudiant_id) AS nb_etudiants FROM inscriptions i JOIN cours c ON i.cours_id = c.id JOIN departements d ON c.departement_id = d.id GROUP BY d.id, d.nom ORDER BY nb_etudiants DESC;',
  '{"columns":[],"rows":[]}',
  'Triple jointure inscriptions -> cours -> departements. Utilise COUNT(DISTINCT etudiant_id).',
  20,
  30,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ============================================================================
-- ADVANCED (31-45) — 30 pts each
-- ============================================================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-moyenne-ponderee',
  'Moyenne pondérée par inscription',
  'Calculez la moyenne pondérée des notes pour chaque inscription.',
  'Sélectionnez l''inscription_id et la moyenne pondérée (alias `moyenne_ponderee`, arrondie à 2 décimales) calculée comme SUM(note * coefficient) / SUM(coefficient). Triez par `moyenne_ponderee` décroissante. Limitez aux 10 premiers.',
  'advanced',
  'SELECT inscription_id, ROUND(SUM(note * coefficient) / SUM(coefficient), 2) AS moyenne_ponderee FROM notes GROUP BY inscription_id ORDER BY moyenne_ponderee DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'La moyenne pondérée se calcule : SUM(note * coefficient) / SUM(coefficient).',
  30,
  31,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiant-moyenne-cours',
  'Moyenne par étudiant et par cours',
  'Calculez la moyenne pondérée de chaque étudiant dans chaque cours.',
  'Sélectionnez le prénom et le nom de l''étudiant, le nom du cours (alias `cours`), et la moyenne pondérée (alias `moyenne`, arrondie à 2 décimales). Joignez notes, inscriptions, etudiants et cours. Triez par `moyenne` décroissante. Limitez aux 15 premiers.',
  'advanced',
  'SELECT e.prenom, e.nom, c.nom AS cours, ROUND(SUM(n.note * n.coefficient) / SUM(n.coefficient), 2) AS moyenne FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN etudiants e ON i.etudiant_id = e.id JOIN cours c ON i.cours_id = c.id GROUP BY i.id, e.prenom, e.nom, c.nom ORDER BY moyenne DESC LIMIT 15;',
  '{"columns":[],"rows":[]}',
  'Quadruple jointure. Moyenne pondérée par inscription avec GROUP BY sur l''inscription.',
  30,
  32,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-mention-case',
  'Attribution des mentions',
  'Attribuez une mention selon la note d''examen.',
  'Sélectionnez l''inscription_id, la note (uniquement les examens) et une mention (alias `mention`) selon ces règles : note >= 16 -> ''Très Bien'', note >= 14 -> ''Bien'', note >= 12 -> ''Assez Bien'', note >= 10 -> ''Passable'', sinon ''Ajourné''. Triez par `note` décroissante.',
  'advanced',
  'SELECT inscription_id, note, CASE WHEN note >= 16 THEN ''Très Bien'' WHEN note >= 14 THEN ''Bien'' WHEN note >= 12 THEN ''Assez Bien'' WHEN note >= 10 THEN ''Passable'' ELSE ''Ajourné'' END AS mention FROM notes WHERE type_evaluation = ''examen'' ORDER BY note DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise CASE WHEN pour créer des tranches de mentions. Filtre sur type_evaluation = ''examen''.',
  30,
  33,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-dept-moyenne-generale',
  'Moyenne générale par département',
  'Calculez la moyenne des notes par département.',
  'Sélectionnez le nom du département (alias `departement`) et la moyenne de toutes les notes (alias `moyenne`, arrondie à 2 décimales). Joignez notes, inscriptions, cours et departements. Triez par `moyenne` décroissante.',
  'advanced',
  'SELECT d.nom AS departement, ROUND(AVG(n.note), 2) AS moyenne FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN cours c ON i.cours_id = c.id JOIN departements d ON c.departement_id = d.id GROUP BY d.id, d.nom ORDER BY moyenne DESC;',
  '{"columns":[],"rows":[]}',
  'Quadruple jointure notes -> inscriptions -> cours -> departements, puis AVG(note).',
  30,
  34,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-top-etudiant-par-cours',
  'Meilleur étudiant par cours',
  'Trouvez l''étudiant ayant la meilleure note d''examen dans chaque cours.',
  'Sélectionnez le nom du cours (alias `cours`), le prénom et le nom de l''étudiant, et la note d''examen. Utilisez une sous-requête corrélée pour ne garder que la note maximale d''examen par cours. Triez par `cours`.',
  'advanced',
  'SELECT c.nom AS cours, e.prenom, e.nom, n.note FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN etudiants e ON i.etudiant_id = e.id JOIN cours c ON i.cours_id = c.id WHERE n.type_evaluation = ''examen'' AND n.note = (SELECT MAX(n2.note) FROM notes n2 JOIN inscriptions i2 ON n2.inscription_id = i2.id WHERE i2.cours_id = i.cours_id AND n2.type_evaluation = ''examen'') ORDER BY c.nom;',
  '{"columns":[],"rows":[]}',
  'Sous-requête corrélée : WHERE note = (SELECT MAX(note) ... WHERE cours_id = cours_id_externe AND type = ''examen'').',
  30,
  35,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-boursiers-vs-non',
  'Comparaison boursiers / non-boursiers',
  'Comparez la moyenne des notes entre boursiers et non-boursiers.',
  'Sélectionnez le statut (alias `statut` : ''Boursier'' si boursier = 1, ''Non boursier'' sinon) et la moyenne des notes (alias `moyenne`, arrondie à 2 décimales). Joignez notes, inscriptions et etudiants. Groupez par statut boursier. Triez par `moyenne` décroissante.',
  'advanced',
  'SELECT CASE WHEN e.boursier = 1 THEN ''Boursier'' ELSE ''Non boursier'' END AS statut, ROUND(AVG(n.note), 2) AS moyenne FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN etudiants e ON i.etudiant_id = e.id GROUP BY e.boursier ORDER BY moyenne DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise CASE WHEN e.boursier = 1 pour créer le statut, puis AVG(note) avec GROUP BY.',
  30,
  36,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-cours-taux-reussite',
  'Taux de réussite par cours',
  'Calculez le taux de réussite aux examens pour chaque cours.',
  'Sélectionnez le nom du cours (alias `cours`) et le taux de réussite (alias `taux_reussite`, arrondi à 1 décimale) calculé comme le pourcentage de notes d''examen >= 10. Joignez notes, inscriptions et cours. Ne gardez que les notes d''examen. Triez par `taux_reussite` décroissant.',
  'advanced',
  'SELECT c.nom AS cours, ROUND(100.0 * SUM(CASE WHEN n.note >= 10 THEN 1 ELSE 0 END) / COUNT(*), 1) AS taux_reussite FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN cours c ON i.cours_id = c.id WHERE n.type_evaluation = ''examen'' GROUP BY c.id, c.nom ORDER BY taux_reussite DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(CASE WHEN note >= 10 THEN 1 ELSE 0 END) / COUNT(*) * 100.',
  30,
  37,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-profs-sans-cours',
  'Professeurs sans cours',
  'Identifiez les professeurs qui n''enseignent aucun cours.',
  'Sélectionnez le prénom, le nom et le grade des professeurs qui n''apparaissent pas dans la table cours comme professeur_id. Triez par `nom`.',
  'advanced',
  'SELECT p.prenom, p.nom, p.grade FROM professeurs p WHERE p.id NOT IN (SELECT DISTINCT professeur_id FROM cours) ORDER BY p.nom;',
  '{"columns":["prenom","nom","grade"],"rows":[["Karim","Benali","Vacataire"]]}',
  'Utilise NOT IN avec une sous-requête sur la colonne professeur_id de la table cours.',
  30,
  38,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-etudiants-multi-dept',
  'Étudiants inscrits dans plusieurs départements',
  'Trouvez les étudiants inscrits dans plus d''un département.',
  'Sélectionnez le prénom, le nom de l''étudiant et le nombre de départements distincts (alias `nb_departements`). Joignez inscriptions, cours et etudiants. Gardez uniquement ceux inscrits dans plus d''un département. Triez par `nb_departements` décroissant puis par `nom`.',
  'advanced',
  'SELECT e.prenom, e.nom, COUNT(DISTINCT c.departement_id) AS nb_departements FROM inscriptions i JOIN etudiants e ON i.etudiant_id = e.id JOIN cours c ON i.cours_id = c.id GROUP BY e.id, e.prenom, e.nom HAVING COUNT(DISTINCT c.departement_id) > 1 ORDER BY nb_departements DESC, e.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(DISTINCT c.departement_id) et HAVING > 1.',
  30,
  39,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-nb-evaluations-etudiant',
  'Nombre d''évaluations par étudiant',
  'Comptez le nombre total d''évaluations pour chaque étudiant.',
  'Sélectionnez le prénom, le nom de l''étudiant et le nombre de notes (alias `nb_evaluations`). Joignez notes, inscriptions et etudiants. Triez par `nb_evaluations` décroissante puis par `nom`. Limitez aux 10 premiers.',
  'advanced',
  'SELECT e.prenom, e.nom, COUNT(n.id) AS nb_evaluations FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN etudiants e ON i.etudiant_id = e.id GROUP BY e.id, e.prenom, e.nom ORDER BY nb_evaluations DESC, e.nom LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'Triple jointure notes -> inscriptions -> etudiants, puis COUNT(n.id).',
  30,
  40,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-moyenne-par-semestre',
  'Moyenne par semestre',
  'Calculez la moyenne des notes par semestre.',
  'Sélectionnez le semestre du cours et la moyenne des notes (alias `moyenne`, arrondie à 2 décimales). Joignez notes, inscriptions et cours. Groupez par semestre et triez par `semestre`.',
  'advanced',
  'SELECT c.semestre, ROUND(AVG(n.note), 2) AS moyenne FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN cours c ON i.cours_id = c.id GROUP BY c.semestre ORDER BY c.semestre;',
  '{"columns":[],"rows":[]}',
  'Triple jointure notes -> inscriptions -> cours, puis AVG(note) GROUP BY semestre.',
  30,
  41,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-prof-moyenne-etudiants',
  'Moyenne des étudiants par professeur',
  'Calculez la note moyenne obtenue par les étudiants de chaque professeur.',
  'Sélectionnez le prénom et le nom du professeur, et la moyenne des notes de ses étudiants (alias `moyenne_etudiants`, arrondie à 2 décimales). Joignez notes, inscriptions, cours et professeurs. Triez par `moyenne_etudiants` décroissante.',
  'advanced',
  'SELECT p.prenom, p.nom, ROUND(AVG(n.note), 2) AS moyenne_etudiants FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN cours c ON i.cours_id = c.id JOIN professeurs p ON c.professeur_id = p.id GROUP BY p.id, p.prenom, p.nom ORDER BY moyenne_etudiants DESC;',
  '{"columns":[],"rows":[]}',
  'Quadruple jointure notes -> inscriptions -> cours -> professeurs, puis AVG(note).',
  30,
  42,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-cours-sans-notes',
  'Cours sans notes enregistrées',
  'Identifiez les cours qui n''ont aucune note enregistrée.',
  'Sélectionnez le nom et le code des cours pour lesquels aucune inscription n''a de note associée. Triez par `code`.',
  'advanced',
  'SELECT c.nom, c.code FROM cours c WHERE c.id NOT IN (SELECT DISTINCT i.cours_id FROM inscriptions i JOIN notes n ON n.inscription_id = i.id) ORDER BY c.code;',
  '{"columns":[],"rows":[]}',
  'Utilise NOT IN avec une sous-requête joignant inscriptions et notes.',
  30,
  43,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-classement-ville-notes',
  'Classement des villes par notes',
  'Classez les villes d''origine des étudiants selon leur moyenne de notes.',
  'Sélectionnez la ville et la moyenne des notes (alias `moyenne`, arrondie à 2 décimales). Joignez notes, inscriptions et etudiants. Groupez par ville. Ne gardez que les villes avec au moins 3 notes. Triez par `moyenne` décroissante.',
  'advanced',
  'SELECT e.ville, ROUND(AVG(n.note), 2) AS moyenne FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN etudiants e ON i.etudiant_id = e.id GROUP BY e.ville HAVING COUNT(n.id) >= 3 ORDER BY moyenne DESC;',
  '{"columns":[],"rows":[]}',
  'Triple jointure, GROUP BY ville, HAVING COUNT >= 3.',
  30,
  44,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-ecart-notes-dept',
  'Écart de notes par département',
  'Calculez l''écart entre la note maximale et minimale par département.',
  'Sélectionnez le nom du département (alias `departement`), la note minimale (alias `note_min`), la note maximale (alias `note_max`) et l''écart (alias `ecart`, arrondi à 1 décimale). Joignez notes, inscriptions, cours et departements. Triez par `ecart` décroissant.',
  'advanced',
  'SELECT d.nom AS departement, MIN(n.note) AS note_min, MAX(n.note) AS note_max, ROUND(MAX(n.note) - MIN(n.note), 1) AS ecart FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN cours c ON i.cours_id = c.id JOIN departements d ON c.departement_id = d.id GROUP BY d.id, d.nom ORDER BY ecart DESC;',
  '{"columns":[],"rows":[]}',
  'Quadruple jointure. Utilise MIN, MAX et MAX - MIN pour l''écart.',
  30,
  45,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ============================================================================
-- EXPERT (46-50) — 40 pts each
-- ============================================================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-bulletin-complet',
  'Bulletin complet d''un étudiant',
  'Générez un bulletin avec moyenne pondérée par cours pour Emma Bernard.',
  'Sélectionnez le nom du cours (alias `cours`), le code, le nombre d''évaluations (alias `nb_eval`), la moyenne pondérée (alias `moyenne`, arrondie à 2 décimales) et une mention (alias `mention` : >= 16 ''Très Bien'', >= 14 ''Bien'', >= 12 ''Assez Bien'', >= 10 ''Passable'', sinon ''Ajourné''). Filtrez sur Emma Bernard (etudiant_id = 2). Triez par `code`.',
  'advanced',
  'SELECT c.nom AS cours, c.code, COUNT(n.id) AS nb_eval, ROUND(SUM(n.note * n.coefficient) / SUM(n.coefficient), 2) AS moyenne, CASE WHEN ROUND(SUM(n.note * n.coefficient) / SUM(n.coefficient), 2) >= 16 THEN ''Très Bien'' WHEN ROUND(SUM(n.note * n.coefficient) / SUM(n.coefficient), 2) >= 14 THEN ''Bien'' WHEN ROUND(SUM(n.note * n.coefficient) / SUM(n.coefficient), 2) >= 12 THEN ''Assez Bien'' WHEN ROUND(SUM(n.note * n.coefficient) / SUM(n.coefficient), 2) >= 10 THEN ''Passable'' ELSE ''Ajourné'' END AS mention FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN cours c ON i.cours_id = c.id WHERE i.etudiant_id = 2 GROUP BY c.id, c.nom, c.code ORDER BY c.code;',
  '{"columns":[],"rows":[]}',
  'Filtre etudiant_id = 2, calcule la moyenne pondérée par cours, puis utilise CASE WHEN sur cette moyenne.',
  40,
  46,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-synthese-departement',
  'Synthèse par département',
  'Générez un tableau de synthèse complet pour chaque département.',
  'Sélectionnez le nom du département (alias `departement`), le nombre de cours (alias `nb_cours`), le nombre d''étudiants distincts inscrits (alias `nb_etudiants`), le nombre total de notes (alias `nb_notes`), et la moyenne des notes (alias `moyenne`, arrondie à 2 décimales). Utilisez des LEFT JOIN depuis departements vers cours, inscriptions et notes. Triez par `departement`.',
  'advanced',
  'SELECT d.nom AS departement, COUNT(DISTINCT c.id) AS nb_cours, COUNT(DISTINCT i.etudiant_id) AS nb_etudiants, COUNT(n.id) AS nb_notes, ROUND(AVG(n.note), 2) AS moyenne FROM departements d LEFT JOIN cours c ON d.id = c.departement_id LEFT JOIN inscriptions i ON c.id = i.cours_id LEFT JOIN notes n ON i.id = n.inscription_id GROUP BY d.id, d.nom ORDER BY d.nom;',
  '{"columns":[],"rows":[]}',
  'Chaîne de LEFT JOIN depuis departements. Utilise COUNT(DISTINCT ...) pour éviter les doublons.',
  40,
  47,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-classement-etudiants',
  'Classement général des étudiants',
  'Établissez un classement des étudiants par moyenne générale pondérée.',
  'Sélectionnez le prénom, le nom, la ville, l''année d''étude, le nombre de cours (alias `nb_cours`), et la moyenne générale pondérée (alias `moyenne_generale`, arrondie à 2 décimales). Joignez notes, inscriptions et etudiants. Triez par `moyenne_generale` décroissante. Limitez aux 10 premiers.',
  'advanced',
  'SELECT e.prenom, e.nom, e.ville, e.annee_etude, COUNT(DISTINCT i.cours_id) AS nb_cours, ROUND(SUM(n.note * n.coefficient) / SUM(n.coefficient), 2) AS moyenne_generale FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN etudiants e ON i.etudiant_id = e.id GROUP BY e.id, e.prenom, e.nom, e.ville, e.annee_etude ORDER BY moyenne_generale DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'Triple jointure. Moyenne pondérée globale par étudiant avec GROUP BY etudiant.',
  40,
  48,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-analyse-reussite-profil',
  'Analyse de réussite par profil',
  'Analysez le taux de réussite aux examens selon le profil étudiant (boursier, année, ville).',
  'Sélectionnez le statut boursier (alias `statut` : ''Boursier'' ou ''Non boursier''), l''annee_etude, le nombre d''examens (alias `nb_examens`), le nombre de réussites >= 10 (alias `nb_reussites`), et le taux de réussite en pourcentage (alias `taux_reussite`, arrondi à 1 décimale). Joignez notes, inscriptions et etudiants. Filtrez sur type_evaluation = ''examen''. Groupez par statut et année. Triez par `statut` puis `annee_etude`.',
  'advanced',
  'SELECT CASE WHEN e.boursier = 1 THEN ''Boursier'' ELSE ''Non boursier'' END AS statut, e.annee_etude, COUNT(*) AS nb_examens, SUM(CASE WHEN n.note >= 10 THEN 1 ELSE 0 END) AS nb_reussites, ROUND(100.0 * SUM(CASE WHEN n.note >= 10 THEN 1 ELSE 0 END) / COUNT(*), 1) AS taux_reussite FROM notes n JOIN inscriptions i ON n.inscription_id = i.id JOIN etudiants e ON i.etudiant_id = e.id WHERE n.type_evaluation = ''examen'' GROUP BY e.boursier, e.annee_etude ORDER BY statut, e.annee_etude;',
  '{"columns":[],"rows":[]}',
  'Combine CASE WHEN pour le statut et SUM(CASE WHEN note >= 10 ...) pour le taux. GROUP BY boursier, annee_etude.',
  40,
  49,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  6,
  'uni-rapport-professeur',
  'Rapport complet par professeur',
  'Générez un rapport détaillé pour chaque professeur.',
  'Sélectionnez le prénom et le nom du professeur, le grade, le nom du département (alias `departement`), le nombre de cours enseignés (alias `nb_cours`), le nombre d''étudiants distincts (alias `nb_etudiants`), le nombre de notes (alias `nb_notes`), la moyenne des notes (alias `moyenne`, arrondie à 2 décimales), et la meilleure note (alias `meilleure_note`). Utilisez des LEFT JOIN depuis professeurs vers departements, cours, inscriptions et notes. Triez par `moyenne` décroissante en gérant les NULL (NULLS LAST ou COALESCE).',
  'advanced',
  'SELECT p.prenom, p.nom, p.grade, d.nom AS departement, COUNT(DISTINCT c.id) AS nb_cours, COUNT(DISTINCT i.etudiant_id) AS nb_etudiants, COUNT(n.id) AS nb_notes, ROUND(AVG(n.note), 2) AS moyenne, MAX(n.note) AS meilleure_note FROM professeurs p JOIN departements d ON p.departement_id = d.id LEFT JOIN cours c ON p.id = c.professeur_id LEFT JOIN inscriptions i ON c.id = i.cours_id LEFT JOIN notes n ON i.id = n.inscription_id GROUP BY p.id, p.prenom, p.nom, p.grade, d.nom ORDER BY COALESCE(AVG(n.note), 0) DESC;',
  '{"columns":[],"rows":[]}',
  'Chaîne de LEFT JOIN depuis professeurs. COALESCE(AVG(note), 0) pour gérer les profs sans notes.',
  40,
  50,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

COMMIT;
