-- ============================================================================
-- SQL Clinic Tasks - Sport / Ligue de Football (dataset_id = 7)
-- 50 exercises: 15 beginner, 15 intermediate, 15 advanced, 5 expert
-- ============================================================================

BEGIN;

-- Dataset insert
INSERT INTO sql_clinic_datasets (slug, name, description, db_type, is_active, created_at, updated_at)
VALUES ('sport', 'Ligue de Football', 'Base de données d''une ligue de football avec équipes, joueurs, matchs, buts et cartons.', 'sqlite', true, NOW(), NOW())
ON CONFLICT (slug) DO NOTHING;

-- ==================== BEGINNER (1-15) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-liste-equipes',
  'Liste des équipes',
  'Affichez toutes les équipes de la ligue.',
  'Écrivez une requête qui affiche toutes les colonnes de la table `equipes`, triées par `id` croissant.',
  'beginner',
  'SELECT * FROM equipes ORDER BY id;',
  '{"columns":[],"rows":[]}',
  'Utilise SELECT * et ORDER BY pour trier par id.',
  10, 1, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-equipes-anciennes',
  'Équipes centenaires',
  'Trouvez les équipes créées avant 1910.',
  'Affichez le nom, la ville et l''année de création des équipes fondées avant 1910, triées par année de création croissante.',
  'beginner',
  'SELECT nom, ville, annee_creation FROM equipes WHERE annee_creation < 1910 ORDER BY annee_creation;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE annee_creation < 1910 pour filtrer.',
  10, 2, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-attaquants',
  'Les attaquants',
  'Listez tous les attaquants de la ligue.',
  'Affichez le nom, le prénom et l''équipe_id des joueurs dont le poste est ''Attaquant'', triés par nom.',
  'beginner',
  'SELECT nom, prenom, equipe_id FROM joueurs WHERE poste = ''Attaquant'' ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE poste = ''Attaquant''.',
  10, 3, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-gros-salaires',
  'Gros salaires',
  'Trouvez les joueurs gagnant plus de 50000.',
  'Affichez le nom, le prénom, le poste et le salaire des joueurs dont le salaire est supérieur à 50000, triés par salaire décroissant.',
  'beginner',
  'SELECT nom, prenom, poste, salaire FROM joueurs WHERE salaire > 50000 ORDER BY salaire DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE salaire > 50000 et ORDER BY salaire DESC.',
  10, 4, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-joueurs-francais',
  'Joueurs français',
  'Listez les joueurs de nationalité française.',
  'Affichez le nom, le prénom et le poste des joueurs français (nationalite = ''Francais''), triés par nom puis prénom.',
  'beginner',
  'SELECT nom, prenom, poste FROM joueurs WHERE nationalite = ''Francais'' ORDER BY nom, prenom;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE nationalite = ''Francais'' et trie par nom, prenom.',
  10, 5, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-nb-joueurs',
  'Nombre de joueurs',
  'Comptez le nombre total de joueurs.',
  'Écrivez une requête qui affiche le nombre total de joueurs dans la table `joueurs`. Nommez la colonne `total_joueurs`.',
  'beginner',
  'SELECT COUNT(*) AS total_joueurs FROM joueurs;',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(*) avec un alias AS total_joueurs.',
  10, 6, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-entraineurs',
  'Liste des entraîneurs',
  'Affichez tous les entraîneurs.',
  'Affichez le nom, le prénom et la nationalité de tous les entraîneurs, triés par nom.',
  'beginner',
  'SELECT nom, prenom, nationalite FROM entraineurs ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Simple SELECT avec ORDER BY sur la table entraineurs.',
  10, 7, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-matchs-journee1',
  'Matchs de la journée 1',
  'Affichez les matchs de la première journée.',
  'Affichez l''id, equipe_domicile_id, equipe_exterieur_id, score_domicile et score_exterieur des matchs de la journée 1, triés par id.',
  'beginner',
  'SELECT id, equipe_domicile_id, equipe_exterieur_id, score_domicile, score_exterieur FROM matchs WHERE journee = 1 ORDER BY id;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE journee = 1.',
  10, 8, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-penaltys',
  'Buts sur penalty',
  'Trouvez tous les buts marqués sur penalty.',
  'Affichez l''id, le match_id, le joueur_id et la minute des buts de type ''penalty'', triés par match_id puis minute.',
  'beginner',
  'SELECT id, match_id, joueur_id, minute FROM buts WHERE type_but = ''penalty'' ORDER BY match_id, minute;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE type_but = ''penalty''.',
  10, 9, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-cartons-rouges',
  'Cartons rouges',
  'Listez tous les cartons rouges distribués.',
  'Affichez le match_id, le joueur_id et la minute de tous les cartons rouges, triés par match_id.',
  'beginner',
  'SELECT match_id, joueur_id, minute FROM cartons WHERE type_carton = ''rouge'' ORDER BY match_id;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE type_carton = ''rouge''.',
  10, 10, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-budget-max',
  'Plus gros budget',
  'Trouvez l''équipe avec le plus gros budget.',
  'Affichez le nom et le budget de l''équipe ayant le budget le plus élevé.',
  'beginner',
  'SELECT nom, budget FROM equipes ORDER BY budget DESC LIMIT 1;',
  '{"columns":[],"rows":[]}',
  'Trie par budget décroissant et utilise LIMIT 1.',
  10, 11, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-joueurs-paris',
  'Joueurs de Paris',
  'Listez les joueurs de l''équipe parisienne.',
  'Affichez le nom, le prénom, le poste et le numéro de maillot des joueurs de l''equipe_id = 1, triés par numero_maillot.',
  'beginner',
  'SELECT nom, prenom, poste, numero_maillot FROM joueurs WHERE equipe_id = 1 ORDER BY numero_maillot;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE equipe_id = 1 et trie par numero_maillot.',
  10, 12, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-nationalites-distinctes',
  'Nationalités représentées',
  'Listez les différentes nationalités des joueurs.',
  'Affichez la liste des nationalités distinctes des joueurs, triées par ordre alphabétique.',
  'beginner',
  'SELECT DISTINCT nationalite FROM joueurs ORDER BY nationalite;',
  '{"columns":[],"rows":[]}',
  'Utilise SELECT DISTINCT pour éliminer les doublons.',
  10, 13, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buts-premiere-mi-temps',
  'Buts en première mi-temps',
  'Trouvez les buts marqués avant la 46e minute.',
  'Affichez l''id, le match_id, le joueur_id, la minute et le type_but des buts marqués avant la 46e minute (minute < 46), triés par match_id puis minute.',
  'beginner',
  'SELECT id, match_id, joueur_id, minute, type_but FROM buts WHERE minute < 46 ORDER BY match_id, minute;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE minute < 46.',
  10, 14, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-salaire-moyen-global',
  'Salaire moyen',
  'Calculez le salaire moyen de tous les joueurs.',
  'Affichez le salaire moyen de tous les joueurs, arrondi a l''entier. Nommez la colonne `salaire_moyen`.',
  'beginner',
  'SELECT ROUND(AVG(salaire), 0) AS salaire_moyen FROM joueurs;',
  '{"columns":[],"rows":[]}',
  'Utilise ROUND(AVG(salaire), 0) avec un alias.',
  10, 15, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== INTERMEDIATE (16-30) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-joueurs-equipe',
  'Joueurs avec leur équipe',
  'Affichez les joueurs avec le nom de leur équipe.',
  'Affichez le nom et le prénom du joueur ainsi que le nom de son équipe (alias `equipe`). Joignez les tables `joueurs` et `equipes`. Triez par nom d''équipe puis nom du joueur.',
  'intermediate',
  'SELECT j.nom, j.prenom, e.nom AS equipe FROM joueurs j JOIN equipes e ON j.equipe_id = e.id ORDER BY e.nom, j.nom;',
  '{"columns":[],"rows":[]}',
  'Fais un JOIN entre joueurs et equipes sur equipe_id = e.id.',
  20, 16, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-nb-joueurs-equipe',
  'Effectif par équipe',
  'Comptez le nombre de joueurs par équipe.',
  'Affichez le nom de chaque équipe et le nombre de joueurs (alias `nb_joueurs`). Triez par nombre de joueurs décroissant puis par nom d''équipe.',
  'intermediate',
  'SELECT e.nom, COUNT(*) AS nb_joueurs FROM joueurs j JOIN equipes e ON j.equipe_id = e.id GROUP BY e.nom ORDER BY nb_joueurs DESC, e.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise JOIN, GROUP BY et COUNT(*) pour compter par équipe.',
  20, 17, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-salaire-moyen-equipe',
  'Salaire moyen par équipe',
  'Calculez le salaire moyen par équipe.',
  'Affichez le nom de chaque équipe et le salaire moyen de ses joueurs arrondi a l''entier (alias `salaire_moyen`). Triez par salaire moyen décroissant.',
  'intermediate',
  'SELECT e.nom, ROUND(AVG(j.salaire), 0) AS salaire_moyen FROM joueurs j JOIN equipes e ON j.equipe_id = e.id GROUP BY e.nom ORDER BY salaire_moyen DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise JOIN, GROUP BY et ROUND(AVG(salaire), 0).',
  20, 18, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buts-par-type',
  'Buts par type',
  'Comptez les buts par type.',
  'Affichez le type_but et le nombre de buts (alias `nb_buts`) pour chaque type, triés par nombre de buts décroissant.',
  'intermediate',
  'SELECT type_but, COUNT(*) AS nb_buts FROM buts GROUP BY type_but ORDER BY nb_buts DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise GROUP BY type_but avec COUNT(*).',
  20, 19, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-entraineur-equipe',
  'Entraîneurs et leurs équipes',
  'Affichez chaque entraîneur avec son équipe.',
  'Affichez le nom et le prénom de l''entraîneur, le nom de son équipe (alias `equipe`) et sa date de prise de poste. Triez par nom d''équipe.',
  'intermediate',
  'SELECT en.nom, en.prenom, e.nom AS equipe, en.date_prise_poste FROM entraineurs en JOIN equipes e ON en.equipe_id = e.id ORDER BY e.nom;',
  '{"columns":[],"rows":[]}',
  'Fais un JOIN entre entraineurs et equipes.',
  20, 20, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buteurs-noms',
  'Noms des buteurs',
  'Affichez les noms des joueurs ayant marqué.',
  'Affichez le nom, le prénom du joueur et le nombre de buts marqués (alias `nb_buts`). Ne gardez que les joueurs ayant marqué au moins un but. Triez par nombre de buts décroissant puis par nom.',
  'intermediate',
  'SELECT j.nom, j.prenom, COUNT(*) AS nb_buts FROM buts b JOIN joueurs j ON b.joueur_id = j.id GROUP BY j.id, j.nom, j.prenom ORDER BY nb_buts DESC, j.nom;',
  '{"columns":[],"rows":[]}',
  'Fais un JOIN entre buts et joueurs, puis GROUP BY le joueur.',
  20, 21, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-nb-cartons-equipe',
  'Cartons par équipe',
  'Comptez les cartons reçus par chaque équipe.',
  'Affichez le nom de l''équipe et le nombre total de cartons reçus (alias `nb_cartons`). Joignez les tables cartons, joueurs et equipes. Triez par nombre de cartons décroissant.',
  'intermediate',
  'SELECT e.nom, COUNT(*) AS nb_cartons FROM cartons c JOIN joueurs j ON c.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id GROUP BY e.nom ORDER BY nb_cartons DESC;',
  '{"columns":[],"rows":[]}',
  'Fais un double JOIN: cartons -> joueurs -> equipes, puis GROUP BY.',
  20, 22, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-matchs-nuls',
  'Matchs nuls',
  'Trouvez tous les matchs nuls.',
  'Affichez la journée, la date du match, le nom de l''équipe à domicile (alias `domicile`), le nom de l''équipe à l''extérieur (alias `exterieur`) et le score (score_domicile) pour les matchs nuls (score_domicile = score_exterieur). Triez par journée.',
  'intermediate',
  'SELECT m.journee, m.date_match, ed.nom AS domicile, ee.nom AS exterieur, m.score_domicile FROM matchs m JOIN equipes ed ON m.equipe_domicile_id = ed.id JOIN equipes ee ON m.equipe_exterieur_id = ee.id WHERE m.score_domicile = m.score_exterieur ORDER BY m.journee;',
  '{"columns":[],"rows":[]}',
  'Fais deux JOIN sur equipes (domicile et exterieur) et filtre avec WHERE score_domicile = score_exterieur.',
  20, 23, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-nb-joueurs-poste',
  'Joueurs par poste',
  'Comptez les joueurs par poste.',
  'Affichez le poste et le nombre de joueurs (alias `nb_joueurs`) pour chaque poste, triés par nombre de joueurs décroissant.',
  'intermediate',
  'SELECT poste, COUNT(*) AS nb_joueurs FROM joueurs GROUP BY poste ORDER BY nb_joueurs DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise GROUP BY poste avec COUNT(*).',
  20, 24, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buts-par-match',
  'Buts par match',
  'Comptez le nombre de buts enregistrés par match.',
  'Affichez le match_id et le nombre de buts enregistrés (alias `nb_buts`) pour chaque match qui a au moins un but. Triez par nombre de buts décroissant puis par match_id.',
  'intermediate',
  'SELECT match_id, COUNT(*) AS nb_buts FROM buts GROUP BY match_id ORDER BY nb_buts DESC, match_id;',
  '{"columns":[],"rows":[]}',
  'Utilise GROUP BY match_id avec COUNT(*). Les matchs sans but n''apparaîtront pas.',
  20, 25, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-equipes-gros-budget',
  'Équipes à gros budget et masse salariale',
  'Comparez budget et masse salariale.',
  'Affichez le nom de l''équipe, son budget et la somme des salaires de ses joueurs (alias `masse_salariale`). Ne gardez que les équipes dont le budget est supérieur à 150. Triez par budget décroissant.',
  'intermediate',
  'SELECT e.nom, e.budget, SUM(j.salaire) AS masse_salariale FROM equipes e JOIN joueurs j ON e.id = j.equipe_id WHERE e.budget > 150 GROUP BY e.id, e.nom, e.budget ORDER BY e.budget DESC;',
  '{"columns":[],"rows":[]}',
  'JOIN equipes et joueurs, filtre avec WHERE budget > 150, puis GROUP BY avec SUM(salaire).',
  20, 26, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-nb-nationalites-equipe',
  'Diversité par équipe',
  'Comptez le nombre de nationalités distinctes par équipe.',
  'Affichez le nom de l''équipe et le nombre de nationalités distinctes parmi ses joueurs (alias `nb_nationalites`). Triez par nb_nationalites décroissant puis par nom.',
  'intermediate',
  'SELECT e.nom, COUNT(DISTINCT j.nationalite) AS nb_nationalites FROM joueurs j JOIN equipes e ON j.equipe_id = e.id GROUP BY e.nom ORDER BY nb_nationalites DESC, e.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(DISTINCT nationalite) avec un JOIN et GROUP BY.',
  20, 27, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buts-journee',
  'Buts par journée',
  'Comptez les buts marqués à chaque journée.',
  'Affichez la journée et le nombre total de buts (alias `nb_buts`) pour chaque journée. Joignez buts et matchs. Triez par journée.',
  'intermediate',
  'SELECT m.journee, COUNT(*) AS nb_buts FROM buts b JOIN matchs m ON b.match_id = m.id GROUP BY m.journee ORDER BY m.journee;',
  '{"columns":[],"rows":[]}',
  'Fais un JOIN entre buts et matchs, puis GROUP BY journee.',
  20, 28, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-equipes-plus-3-buts',
  'Équipes prolifiques',
  'Trouvez les équipes dont les joueurs ont marqué plus de 5 buts au total.',
  'Affichez le nom de l''équipe et le nombre total de buts marqués par ses joueurs (alias `total_buts`). Ne gardez que les équipes ayant plus de 5 buts. Triez par total_buts décroissant.',
  'intermediate',
  'SELECT e.nom, COUNT(*) AS total_buts FROM buts b JOIN joueurs j ON b.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id GROUP BY e.nom HAVING COUNT(*) > 5 ORDER BY total_buts DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise un double JOIN (buts -> joueurs -> equipes), GROUP BY et HAVING COUNT(*) > 5.',
  20, 29, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-score-total-matchs',
  'Score total des matchs',
  'Calculez le nombre total de buts par match à partir des scores.',
  'Affichez l''id du match, la date, le score_domicile, le score_exterieur et le total de buts (score_domicile + score_exterieur, alias `total_buts`). Triez par total_buts décroissant puis par id.',
  'intermediate',
  'SELECT id, date_match, score_domicile, score_exterieur, (score_domicile + score_exterieur) AS total_buts FROM matchs ORDER BY total_buts DESC, id;',
  '{"columns":[],"rows":[]}',
  'Additionne score_domicile + score_exterieur et utilise un alias.',
  20, 30, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== ADVANCED (31-45) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-meilleur-buteur',
  'Meilleur buteur',
  'Trouvez le meilleur buteur de la ligue.',
  'Affichez le nom, le prénom, le nom de l''équipe (alias `equipe`) et le nombre de buts (alias `nb_buts`) du joueur ayant marqué le plus de buts. Utilisez LIMIT 1.',
  'advanced',
  'SELECT j.nom, j.prenom, e.nom AS equipe, COUNT(*) AS nb_buts FROM buts b JOIN joueurs j ON b.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id GROUP BY j.id, j.nom, j.prenom, e.nom ORDER BY nb_buts DESC LIMIT 1;',
  '{"columns":[],"rows":[]}',
  'Triple JOIN (buts -> joueurs -> equipes), GROUP BY joueur, ORDER BY nb_buts DESC LIMIT 1.',
  30, 31, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-resultat-matchs',
  'Résultats détaillés des matchs',
  'Affichez les résultats avec les noms des équipes.',
  'Affichez la journée, la date, le nom de l''équipe à domicile (alias `domicile`), le score_domicile, le score_exterieur, et le nom de l''équipe à l''extérieur (alias `exterieur`). Triez par journée puis date_match.',
  'advanced',
  'SELECT m.journee, m.date_match, ed.nom AS domicile, m.score_domicile, m.score_exterieur, ee.nom AS exterieur FROM matchs m JOIN equipes ed ON m.equipe_domicile_id = ed.id JOIN equipes ee ON m.equipe_exterieur_id = ee.id ORDER BY m.journee, m.date_match;',
  '{"columns":[],"rows":[]}',
  'Fais deux JOIN sur equipes: un pour domicile (ed), un pour exterieur (ee).',
  30, 32, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buteurs-penalty',
  'Spécialistes des penaltys',
  'Trouvez les joueurs ayant marqué au moins un penalty.',
  'Affichez le nom, le prénom du joueur, le nom de son équipe (alias `equipe`) et le nombre de penaltys marqués (alias `nb_penaltys`). Ne gardez que ceux ayant au moins 1 penalty. Triez par nb_penaltys décroissant puis nom.',
  'advanced',
  'SELECT j.nom, j.prenom, e.nom AS equipe, COUNT(*) AS nb_penaltys FROM buts b JOIN joueurs j ON b.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id WHERE b.type_but = ''penalty'' GROUP BY j.id, j.nom, j.prenom, e.nom ORDER BY nb_penaltys DESC, j.nom;',
  '{"columns":[],"rows":[]}',
  'Filtre WHERE type_but = ''penalty'' avant le GROUP BY.',
  30, 33, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-joueurs-buts-cartons',
  'Joueurs avec buts et cartons',
  'Trouvez les joueurs ayant à la fois marqué et reçu un carton.',
  'Affichez le nom et le prénom des joueurs qui apparaissent dans la table `buts` ET dans la table `cartons`. Utilisez des sous-requêtes. Triez par nom.',
  'advanced',
  'SELECT nom, prenom FROM joueurs WHERE id IN (SELECT joueur_id FROM buts) AND id IN (SELECT joueur_id FROM cartons) ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Utilise deux sous-requêtes avec IN pour trouver les joueurs présents dans buts ET cartons.',
  30, 34, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buts-par-poste',
  'Buts par poste',
  'Analysez la répartition des buts par poste.',
  'Affichez le poste du joueur et le nombre de buts marqués (alias `nb_buts`) par les joueurs de chaque poste. Triez par nb_buts décroissant.',
  'advanced',
  'SELECT j.poste, COUNT(*) AS nb_buts FROM buts b JOIN joueurs j ON b.joueur_id = j.id GROUP BY j.poste ORDER BY nb_buts DESC;',
  '{"columns":[],"rows":[]}',
  'JOIN buts et joueurs, GROUP BY poste.',
  30, 35, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-matchs-plus-4-buts',
  'Matchs riches en buts',
  'Trouvez les matchs avec 4 buts ou plus.',
  'Affichez la journée, le nom de l''équipe domicile (alias `domicile`), le nom de l''équipe extérieur (alias `exterieur`), le score_domicile et le score_exterieur pour les matchs dont le total de buts (score_domicile + score_exterieur) est supérieur ou égal à 4. Triez par total décroissant puis journée.',
  'advanced',
  'SELECT m.journee, ed.nom AS domicile, ee.nom AS exterieur, m.score_domicile, m.score_exterieur FROM matchs m JOIN equipes ed ON m.equipe_domicile_id = ed.id JOIN equipes ee ON m.equipe_exterieur_id = ee.id WHERE (m.score_domicile + m.score_exterieur) >= 4 ORDER BY (m.score_domicile + m.score_exterieur) DESC, m.journee;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE (score_domicile + score_exterieur) >= 4 après les deux JOIN.',
  30, 36, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-detail-buts-match',
  'Détail des buts d''un match',
  'Affichez les détails des buts du match 5.',
  'Pour le match_id = 5, affichez la minute, le nom et le prénom du buteur, le nom de son équipe (alias `equipe`) et le type_but. Triez par minute.',
  'advanced',
  'SELECT b.minute, j.nom, j.prenom, e.nom AS equipe, b.type_but FROM buts b JOIN joueurs j ON b.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id WHERE b.match_id = 5 ORDER BY b.minute;',
  '{"columns":[],"rows":[]}',
  'Triple JOIN (buts -> joueurs -> equipes) avec WHERE match_id = 5.',
  30, 37, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-salaire-max-poste',
  'Salaire max par poste',
  'Trouvez le salaire le plus élevé dans chaque poste.',
  'Affichez le poste, le salaire maximum (alias `salaire_max`) et le nom du joueur le mieux payé de chaque poste. Utilisez une sous-requête. Triez par salaire_max décroissant.',
  'advanced',
  'SELECT j.poste, j.salaire AS salaire_max, j.nom FROM joueurs j WHERE j.salaire = (SELECT MAX(j2.salaire) FROM joueurs j2 WHERE j2.poste = j.poste) ORDER BY salaire_max DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise une sous-requête corrélée: WHERE salaire = (SELECT MAX(salaire) FROM joueurs WHERE poste = j.poste).',
  30, 38, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-equipe-type-carton',
  'Cartons jaunes et rouges par équipe',
  'Détaillez les cartons par type et par équipe.',
  'Affichez le nom de l''équipe, le nombre de cartons jaunes (alias `jaunes`) et le nombre de cartons rouges (alias `rouges`). Utilisez CASE WHEN ou SUM avec condition. Triez par nom d''équipe.',
  'advanced',
  'SELECT e.nom, SUM(CASE WHEN c.type_carton = ''jaune'' THEN 1 ELSE 0 END) AS jaunes, SUM(CASE WHEN c.type_carton = ''rouge'' THEN 1 ELSE 0 END) AS rouges FROM cartons c JOIN joueurs j ON c.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id GROUP BY e.nom ORDER BY e.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(CASE WHEN type_carton = ''jaune'' THEN 1 ELSE 0 END) pour compter chaque type.',
  30, 39, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-victoires-domicile',
  'Victoires à domicile',
  'Comptez les victoires à domicile par équipe.',
  'Affichez le nom de l''équipe et le nombre de victoires à domicile (alias `victoires_dom`) pour chaque équipe ayant gagné au moins un match à domicile (score_domicile > score_exterieur). Triez par victoires_dom décroissant.',
  'advanced',
  'SELECT e.nom, COUNT(*) AS victoires_dom FROM matchs m JOIN equipes e ON m.equipe_domicile_id = e.id WHERE m.score_domicile > m.score_exterieur GROUP BY e.nom ORDER BY victoires_dom DESC;',
  '{"columns":[],"rows":[]}',
  'JOIN matchs et equipes sur equipe_domicile_id, filtre WHERE score_domicile > score_exterieur.',
  30, 40, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-joueurs-sans-but',
  'Joueurs sans but',
  'Trouvez les attaquants n''ayant marqué aucun but.',
  'Affichez le nom, le prénom et le nom de l''équipe (alias `equipe`) des joueurs au poste ''Attaquant'' qui n''apparaissent pas dans la table buts. Triez par nom.',
  'advanced',
  'SELECT j.nom, j.prenom, e.nom AS equipe FROM joueurs j JOIN equipes e ON j.equipe_id = e.id WHERE j.poste = ''Attaquant'' AND j.id NOT IN (SELECT joueur_id FROM buts) ORDER BY j.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise NOT IN (SELECT joueur_id FROM buts) pour exclure les buteurs.',
  30, 41, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-moyenne-buts-journee',
  'Moyenne de buts par journée',
  'Calculez la moyenne de buts par match pour chaque journée.',
  'Affichez la journée et la moyenne de buts par match (alias `moy_buts_par_match`), arrondie a 1 décimale. Calculez le total de buts (score_domicile + score_exterieur) divisé par le nombre de matchs. Triez par journée.',
  'advanced',
  'SELECT journee, ROUND(AVG(score_domicile + score_exterieur), 1) AS moy_buts_par_match FROM matchs GROUP BY journee ORDER BY journee;',
  '{"columns":[],"rows":[]}',
  'Utilise AVG(score_domicile + score_exterieur) avec GROUP BY journee.',
  30, 42, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buteurs-multi-types',
  'Buteurs polyvalents',
  'Trouvez les joueurs ayant marqué avec différents types de buts.',
  'Affichez le nom, le prénom du joueur et le nombre de types de buts différents utilisés (alias `nb_types`). Ne gardez que ceux ayant au moins 2 types différents. Triez par nb_types décroissant puis nom.',
  'advanced',
  'SELECT j.nom, j.prenom, COUNT(DISTINCT b.type_but) AS nb_types FROM buts b JOIN joueurs j ON b.joueur_id = j.id GROUP BY j.id, j.nom, j.prenom HAVING COUNT(DISTINCT b.type_but) >= 2 ORDER BY nb_types DESC, j.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(DISTINCT type_but) avec HAVING >= 2.',
  30, 43, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-equipes-sans-carton-rouge',
  'Équipes fair-play',
  'Trouvez les équipes n''ayant reçu aucun carton rouge.',
  'Affichez le nom des équipes dont aucun joueur n''a reçu de carton rouge. Triez par nom.',
  'advanced',
  'SELECT e.nom FROM equipes e WHERE e.id NOT IN (SELECT j.equipe_id FROM cartons c JOIN joueurs j ON c.joueur_id = j.id WHERE c.type_carton = ''rouge'') ORDER BY e.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise NOT IN avec une sous-requête qui joint cartons et joueurs pour trouver les equipe_id ayant un carton rouge.',
  30, 44, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-buts-minute-tranche',
  'Buts par tranche de temps',
  'Analysez la répartition des buts par tranche de 15 minutes.',
  'Affichez une tranche horaire (alias `tranche`) et le nombre de buts (alias `nb_buts`). Les tranches sont: ''0-15'', ''16-30'', ''31-45'', ''46-60'', ''61-75'', ''76-90''. Utilisez CASE WHEN. Triez par tranche.',
  'advanced',
  'SELECT CASE WHEN minute <= 15 THEN ''0-15'' WHEN minute <= 30 THEN ''16-30'' WHEN minute <= 45 THEN ''31-45'' WHEN minute <= 60 THEN ''46-60'' WHEN minute <= 75 THEN ''61-75'' ELSE ''76-90'' END AS tranche, COUNT(*) AS nb_buts FROM buts GROUP BY tranche ORDER BY tranche;',
  '{"columns":[],"rows":[]}',
  'Utilise CASE WHEN pour créer les tranches, puis GROUP BY sur l''alias.',
  30, 45, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== EXPERT (46-50) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-classement',
  'Classement de la ligue',
  'Calculez le classement complet de la ligue.',
  'Calculez le classement avec: nom de l''équipe (alias `equipe`), nombre de matchs joués (alias `mj`), victoires (alias `v`), nuls (alias `n`), défaites (alias `d`), buts marqués (alias `bp`), buts encaissés (alias `bc`), différence de buts (alias `diff`), points (alias `pts`, 3 pour victoire, 1 pour nul). Combinez les matchs à domicile et à l''extérieur avec UNION ALL. Triez par pts décroissant puis diff décroissant.',
  'advanced',
  'SELECT equipe, COUNT(*) AS mj, SUM(CASE WHEN bm > be THEN 1 ELSE 0 END) AS v, SUM(CASE WHEN bm = be THEN 1 ELSE 0 END) AS n, SUM(CASE WHEN bm < be THEN 1 ELSE 0 END) AS d, SUM(bm) AS bp, SUM(be) AS bc, SUM(bm) - SUM(be) AS diff, SUM(CASE WHEN bm > be THEN 3 WHEN bm = be THEN 1 ELSE 0 END) AS pts FROM (SELECT e.nom AS equipe, m.score_domicile AS bm, m.score_exterieur AS be FROM matchs m JOIN equipes e ON m.equipe_domicile_id = e.id UNION ALL SELECT e.nom AS equipe, m.score_exterieur AS bm, m.score_domicile AS be FROM matchs m JOIN equipes e ON m.equipe_exterieur_id = e.id) GROUP BY equipe ORDER BY pts DESC, diff DESC;',
  '{"columns":[],"rows":[]}',
  'Combine domicile et extérieur avec UNION ALL dans une sous-requête, puis agrège avec SUM et CASE WHEN pour calculer V/N/D et les points.',
  40, 46, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-top-buteurs-complet',
  'Top 5 buteurs détaillé',
  'Classement des 5 meilleurs buteurs avec détails.',
  'Affichez le nom et prénom du joueur, le nom de son équipe (alias `equipe`), le poste, le nombre total de buts (alias `nb_buts`), le nombre de penaltys (alias `penaltys`) et le nombre de buts hors penalty (alias `hors_penalty`) pour les 5 meilleurs buteurs. Triez par nb_buts décroissant puis nom. Limitez à 5.',
  'advanced',
  'SELECT j.nom, j.prenom, e.nom AS equipe, j.poste, COUNT(*) AS nb_buts, SUM(CASE WHEN b.type_but = ''penalty'' THEN 1 ELSE 0 END) AS penaltys, SUM(CASE WHEN b.type_but != ''penalty'' THEN 1 ELSE 0 END) AS hors_penalty FROM buts b JOIN joueurs j ON b.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id GROUP BY j.id, j.nom, j.prenom, e.nom, j.poste ORDER BY nb_buts DESC, j.nom LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(CASE WHEN type_but = ''penalty'' ...) pour séparer les penaltys du reste.',
  40, 47, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-forme-domicile-exterieur',
  'Performance domicile vs extérieur',
  'Comparez les performances à domicile et à l''extérieur.',
  'Pour chaque équipe, affichez le nom (alias `equipe`), le nombre de points à domicile (alias `pts_dom`) et le nombre de points à l''extérieur (alias `pts_ext`). 3 points pour une victoire, 1 pour un nul. Triez par le total de points (pts_dom + pts_ext) décroissant puis par nom.',
  'advanced',
  'SELECT e.nom AS equipe, COALESCE(dom.pts, 0) AS pts_dom, COALESCE(ext.pts, 0) AS pts_ext FROM equipes e LEFT JOIN (SELECT equipe_domicile_id AS eid, SUM(CASE WHEN score_domicile > score_exterieur THEN 3 WHEN score_domicile = score_exterieur THEN 1 ELSE 0 END) AS pts FROM matchs GROUP BY equipe_domicile_id) dom ON e.id = dom.eid LEFT JOIN (SELECT equipe_exterieur_id AS eid, SUM(CASE WHEN score_exterieur > score_domicile THEN 3 WHEN score_exterieur = score_domicile THEN 1 ELSE 0 END) AS pts FROM matchs GROUP BY equipe_exterieur_id) ext ON e.id = ext.eid ORDER BY (COALESCE(dom.pts, 0) + COALESCE(ext.pts, 0)) DESC, e.nom;',
  '{"columns":[],"rows":[]}',
  'Crée deux sous-requêtes (domicile et extérieur) avec SUM(CASE WHEN ...) et fais un LEFT JOIN sur equipes.',
  40, 48, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-indice-discipline',
  'Indice de discipline',
  'Calculez un indice de discipline par équipe.',
  'Calculez un indice de discipline pour chaque équipe: un carton jaune vaut 1 point, un carton rouge vaut 3 points. Affichez le nom de l''équipe (alias `equipe`), le nombre de cartons jaunes (alias `jaunes`), le nombre de cartons rouges (alias `rouges`) et l''indice total (alias `indice_discipline`). Triez par indice_discipline décroissant.',
  'advanced',
  'SELECT e.nom AS equipe, SUM(CASE WHEN c.type_carton = ''jaune'' THEN 1 ELSE 0 END) AS jaunes, SUM(CASE WHEN c.type_carton = ''rouge'' THEN 1 ELSE 0 END) AS rouges, SUM(CASE WHEN c.type_carton = ''jaune'' THEN 1 WHEN c.type_carton = ''rouge'' THEN 3 ELSE 0 END) AS indice_discipline FROM cartons c JOIN joueurs j ON c.joueur_id = j.id JOIN equipes e ON j.equipe_id = e.id GROUP BY e.nom ORDER BY indice_discipline DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(CASE WHEN) avec des poids différents: 1 pour jaune, 3 pour rouge.',
  40, 49, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  7,
  'spo-efficacite-attaque',
  'Efficacité offensive complète',
  'Analysez l''efficacité offensive de chaque équipe.',
  'Pour chaque équipe, affichez le nom (alias `equipe`), le nombre total de buts marqués par ses joueurs dans la table buts (alias `buts_marques`), le nombre de matchs joués (alias `matchs_joues`), et la moyenne de buts par match arrondie à 2 décimales (alias `moy_buts_match`). Combinez les données de buts (via joueurs) et de matchs (domicile + extérieur). Triez par moy_buts_match décroissant.',
  'advanced',
  'SELECT e.nom AS equipe, COALESCE(bg.total_buts, 0) AS buts_marques, mg.matchs_joues, ROUND(CAST(COALESCE(bg.total_buts, 0) AS REAL) / mg.matchs_joues, 2) AS moy_buts_match FROM equipes e LEFT JOIN (SELECT j.equipe_id, COUNT(*) AS total_buts FROM buts b JOIN joueurs j ON b.joueur_id = j.id GROUP BY j.equipe_id) bg ON e.id = bg.equipe_id JOIN (SELECT equipe_id, COUNT(*) AS matchs_joues FROM (SELECT equipe_domicile_id AS equipe_id FROM matchs UNION ALL SELECT equipe_exterieur_id AS equipe_id FROM matchs) GROUP BY equipe_id) mg ON e.id = mg.equipe_id ORDER BY moy_buts_match DESC;',
  '{"columns":[],"rows":[]}',
  'Crée deux sous-requêtes: une pour les buts (via joueurs), une pour les matchs joués (UNION ALL domicile + extérieur). Fais un LEFT JOIN pour combiner.',
  40, 50, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

COMMIT;
