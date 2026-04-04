-- ============================================================================
-- SQL Clinic Tasks - Restaurant Dataset (dataset_id = 4)
-- 50 exercises: 15 beginner, 15 intermediate, 15 advanced, 5 expert
-- expected_result is kept empty — validation uses expected_sql execution
-- ============================================================================

BEGIN;

-- Dataset insert
INSERT INTO sql_clinic_datasets (slug, name, description, db_type, is_active, created_at, updated_at)
VALUES ('restaurant', 'Restaurant Le Gourmet', 'Base de donnees d''un restaurant avec serveurs, plats, commandes et reservations.', 'sqlite', true, NOW(), NOW())
ON CONFLICT (slug) DO NOTHING;

-- ============================================================================
-- BEGINNER (1-15) — 10 pts each
-- ============================================================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-liste-serveurs',
  'Liste des serveurs',
  'Affichez tous les serveurs du restaurant.',
  'Ecrivez une requete qui affiche toutes les colonnes de la table `serveurs`, triees par `id` croissant.',
  'beginner',
  'SELECT * FROM serveurs ORDER BY id;',
  '{"columns":[],"rows":[]}',
  'Utilise SELECT * et ORDER BY id.',
  10,
  1,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-categories',
  'Les categories de plats',
  'Affichez toutes les categories de plats disponibles.',
  'Ecrivez une requete qui affiche toutes les colonnes de la table `categories_plats`, triees par `id`.',
  'beginner',
  'SELECT * FROM categories_plats ORDER BY id;',
  '{"columns":[],"rows":[]}',
  'Utilise SELECT * sur categories_plats avec ORDER BY id.',
  10,
  2,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-plats-chers',
  'Plats les plus chers',
  'Trouvez les plats dont le prix depasse 20 euros.',
  'Selectionnez le nom et le prix des plats dont le prix est superieur a 20, tries par prix decroissant.',
  'beginner',
  'SELECT nom, prix FROM plats WHERE prix > 20 ORDER BY prix DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE prix > 20 et ORDER BY prix DESC.',
  10,
  3,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-plats-vegetariens',
  'Plats vegetariens',
  'Listez les plats vegetariens disponibles.',
  'Selectionnez le nom et le prix des plats qui sont vegetariens (`est_vegetarien = 1`) ET disponibles (`est_disponible = 1`), tries par nom.',
  'beginner',
  'SELECT nom, prix FROM plats WHERE est_vegetarien = 1 AND est_disponible = 1 ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Combine deux conditions avec AND : est_vegetarien = 1 et est_disponible = 1.',
  10,
  4,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-tables-terrasse',
  'Tables en terrasse',
  'Affichez les tables situees en terrasse.',
  'Selectionnez le numero et la capacite des tables dont l''emplacement est ''terrasse'', tries par numero.',
  'beginner',
  'SELECT numero, capacite FROM tables_resto WHERE emplacement = ''terrasse'' ORDER BY numero;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE emplacement = ''terrasse''.',
  10,
  5,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-serveurs-experimentes',
  'Serveurs experimentes',
  'Trouvez les serveurs ayant plus de 5 ans d''experience.',
  'Selectionnez le prenom, le nom et l''experience (en annees) des serveurs ayant plus de 5 ans d''experience, tries par experience decroissante.',
  'beginner',
  'SELECT prenom, nom, experience_annees FROM serveurs WHERE experience_annees > 5 ORDER BY experience_annees DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE experience_annees > 5 et ORDER BY experience_annees DESC.',
  10,
  6,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-reservations-confirmees',
  'Reservations confirmees',
  'Listez les reservations ayant le statut confirme.',
  'Selectionnez le nom_client, la date_reservation, l''heure et le nb_personnes des reservations confirmees (`statut = ''confirmee''`), triees par date_reservation puis heure.',
  'beginner',
  'SELECT nom_client, date_reservation, heure, nb_personnes FROM reservations WHERE statut = ''confirmee'' ORDER BY date_reservation, heure;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE statut = ''confirmee'' et trie par date puis heure.',
  10,
  7,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-commandes-payees',
  'Commandes payees',
  'Comptez le nombre de commandes payees.',
  'Ecrivez une requete qui retourne le nombre total de commandes dont le statut est ''payee''. Nommez la colonne `nb_payees`.',
  'beginner',
  'SELECT COUNT(*) AS nb_payees FROM commandes WHERE statut = ''payee'';',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(*) avec WHERE statut = ''payee'' et un alias AS nb_payees.',
  10,
  8,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-plats-indisponibles',
  'Plats indisponibles',
  'Trouvez les plats qui ne sont pas disponibles actuellement.',
  'Selectionnez le nom et le prix des plats dont `est_disponible = 0`, tries par nom.',
  'beginner',
  'SELECT nom, prix FROM plats WHERE est_disponible = 0 ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE est_disponible = 0.',
  10,
  9,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-grosses-tables',
  'Grandes tables',
  'Trouvez les tables pouvant accueillir 6 personnes ou plus.',
  'Selectionnez le numero, la capacite et l''emplacement des tables dont la capacite est superieure ou egale a 6, tries par capacite decroissante puis par numero.',
  'beginner',
  'SELECT numero, capacite, emplacement FROM tables_resto WHERE capacite >= 6 ORDER BY capacite DESC, numero;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE capacite >= 6 et ORDER BY capacite DESC, numero.',
  10,
  10,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-reservations-annulees',
  'Reservations annulees',
  'Listez les reservations annulees avec le nom du client.',
  'Selectionnez le nom_client, la date_reservation et l''heure des reservations annulees (`statut = ''annulee''`), triees par date_reservation.',
  'beginner',
  'SELECT nom_client, date_reservation, heure FROM reservations WHERE statut = ''annulee'' ORDER BY date_reservation;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE statut = ''annulee'' et trie par date_reservation.',
  10,
  11,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-entrees',
  'La carte des entrees',
  'Affichez uniquement les entrees du menu.',
  'Selectionnez le nom et le prix des plats de la categorie ''Entree'' (`categorie_id = 1`), tries par prix croissant.',
  'beginner',
  'SELECT nom, prix FROM plats WHERE categorie_id = 1 ORDER BY prix;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE categorie_id = 1 et trie par prix croissant.',
  10,
  12,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-top5-chers',
  'Top 5 des plats les plus chers',
  'Affichez les 5 plats les plus onereux.',
  'Selectionnez le nom et le prix des 5 plats les plus chers, tries par prix decroissant. Utilisez `LIMIT 5`.',
  'beginner',
  'SELECT nom, prix FROM plats ORDER BY prix DESC LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Utilise ORDER BY prix DESC et LIMIT 5.',
  10,
  13,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-reservations-noel',
  'Reservations du 24 decembre',
  'Listez les reservations du 24 decembre 2024.',
  'Selectionnez le nom_client, l''heure, le nb_personnes et le statut des reservations du ''2024-12-24'', tries par heure.',
  'beginner',
  'SELECT nom_client, heure, nb_personnes, statut FROM reservations WHERE date_reservation = ''2024-12-24'' ORDER BY heure;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE date_reservation = ''2024-12-24'' et trie par heure.',
  10,
  14,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-salaire-moyen-serveurs',
  'Salaire moyen des serveurs',
  'Calculez le salaire moyen des serveurs.',
  'Ecrivez une requete qui retourne le salaire moyen des serveurs, arrondi a 2 decimales. Nommez la colonne `salaire_moyen`.',
  'beginner',
  'SELECT ROUND(AVG(salaire), 2) AS salaire_moyen FROM serveurs;',
  '{"columns":[],"rows":[]}',
  'Utilise ROUND(AVG(salaire), 2) avec un alias AS salaire_moyen.',
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
  4,
  'rest-plats-avec-categorie',
  'Plats et leurs categories',
  'Associez chaque plat a sa categorie.',
  'Selectionnez le nom du plat, son prix et le nom de la categorie (alias `categorie`) en joignant les tables `plats` et `categories_plats`. Triez par categorie puis par nom du plat.',
  'intermediate',
  'SELECT p.nom, p.prix, c.nom AS categorie FROM plats p JOIN categories_plats c ON p.categorie_id = c.id ORDER BY c.nom, p.nom;',
  '{"columns":[],"rows":[]}',
  'Fais un JOIN entre plats et categories_plats sur categorie_id.',
  20,
  16,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-nb-plats-par-categorie',
  'Nombre de plats par categorie',
  'Comptez combien de plats il y a dans chaque categorie.',
  'Selectionnez le nom de la categorie et le nombre de plats (alias `nb_plats`) pour chaque categorie, tries par nb_plats decroissant.',
  'intermediate',
  'SELECT c.nom AS categorie, COUNT(*) AS nb_plats FROM plats p JOIN categories_plats c ON p.categorie_id = c.id GROUP BY c.nom ORDER BY nb_plats DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(*) avec GROUP BY et un JOIN sur categories_plats.',
  20,
  17,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-commandes-par-serveur',
  'Commandes par serveur',
  'Comptez le nombre de commandes gerees par chaque serveur.',
  'Selectionnez le prenom, le nom du serveur et le nombre de commandes (alias `nb_commandes`) pour chaque serveur, tries par nb_commandes decroissant.',
  'intermediate',
  'SELECT s.prenom, s.nom, COUNT(*) AS nb_commandes FROM commandes co JOIN serveurs s ON co.serveur_id = s.id GROUP BY s.id, s.prenom, s.nom ORDER BY nb_commandes DESC;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et serveurs, puis COUNT(*) avec GROUP BY.',
  20,
  18,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-ca-par-jour',
  'Chiffre d''affaires par jour',
  'Calculez le chiffre d''affaires journalier pour les commandes payees.',
  'Selectionnez la date_commande et la somme des montant_total (alias `ca_jour`) pour les commandes payees, groupees par date et triees par date.',
  'intermediate',
  'SELECT date_commande, SUM(montant_total) AS ca_jour FROM commandes WHERE statut = ''payee'' GROUP BY date_commande ORDER BY date_commande;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(montant_total) avec WHERE statut = ''payee'' et GROUP BY date_commande.',
  20,
  19,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-reservations-avec-table',
  'Reservations et tables',
  'Affichez les reservations avec les details de la table reservee.',
  'Selectionnez le nom_client, la date_reservation, l''heure, le numero de table (alias `table_numero`) et la capacite de la table pour les reservations confirmees. Triez par date_reservation puis heure.',
  'intermediate',
  'SELECT r.nom_client, r.date_reservation, r.heure, t.numero AS table_numero, t.capacite FROM reservations r JOIN tables_resto t ON r.table_id = t.id WHERE r.statut = ''confirmee'' ORDER BY r.date_reservation, r.heure;',
  '{"columns":[],"rows":[]}',
  'Joins reservations et tables_resto sur table_id, avec WHERE statut = ''confirmee''.',
  20,
  20,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-prix-moyen-categorie',
  'Prix moyen par categorie',
  'Calculez le prix moyen des plats dans chaque categorie.',
  'Selectionnez le nom de la categorie et le prix moyen arrondi a 2 decimales (alias `prix_moyen`) pour chaque categorie, trie par prix_moyen decroissant.',
  'intermediate',
  'SELECT c.nom AS categorie, ROUND(AVG(p.prix), 2) AS prix_moyen FROM plats p JOIN categories_plats c ON p.categorie_id = c.id GROUP BY c.nom ORDER BY prix_moyen DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise ROUND(AVG(p.prix), 2) avec un JOIN et GROUP BY.',
  20,
  21,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-commandes-par-emplacement',
  'Commandes par emplacement',
  'Analysez le nombre de commandes selon l''emplacement des tables.',
  'Selectionnez l''emplacement de la table et le nombre de commandes (alias `nb_commandes`) groupes par emplacement, tries par nb_commandes decroissant.',
  'intermediate',
  'SELECT t.emplacement, COUNT(*) AS nb_commandes FROM commandes co JOIN tables_resto t ON co.table_id = t.id GROUP BY t.emplacement ORDER BY nb_commandes DESC;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et tables_resto, puis COUNT(*) avec GROUP BY emplacement.',
  20,
  22,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-serveurs-gros-ca',
  'Serveurs avec gros chiffre d''affaires',
  'Trouvez les serveurs dont le CA total depasse 200 euros.',
  'Selectionnez le prenom, le nom du serveur et la somme des montant_total (alias `ca_total`) pour les serveurs dont le CA total est superieur a 200. Triez par ca_total decroissant.',
  'intermediate',
  'SELECT s.prenom, s.nom, SUM(co.montant_total) AS ca_total FROM commandes co JOIN serveurs s ON co.serveur_id = s.id GROUP BY s.id, s.prenom, s.nom HAVING SUM(co.montant_total) > 200 ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM avec GROUP BY et HAVING SUM(montant_total) > 200.',
  20,
  23,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-nb-reservations-par-jour',
  'Reservations par jour',
  'Comptez le nombre de reservations par date.',
  'Selectionnez la date_reservation et le nombre de reservations (alias `nb_reservations`) pour chaque date, triees par date.',
  'intermediate',
  'SELECT date_reservation, COUNT(*) AS nb_reservations FROM reservations GROUP BY date_reservation ORDER BY date_reservation;',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(*) avec GROUP BY date_reservation.',
  20,
  24,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-plats-jamais-commandes',
  'Plats jamais commandes',
  'Identifiez les plats qui n''ont jamais ete commandes.',
  'Selectionnez le nom et le prix des plats qui n''apparaissent dans aucune ligne de commande. Triez par nom.',
  'intermediate',
  'SELECT p.nom, p.prix FROM plats p WHERE p.id NOT IN (SELECT DISTINCT plat_id FROM lignes_commande) ORDER BY p.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise NOT IN avec une sous-requete SELECT DISTINCT plat_id FROM lignes_commande.',
  20,
  25,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-montant-moyen-commande',
  'Montant moyen par commande',
  'Calculez le montant moyen des commandes par statut.',
  'Selectionnez le statut et le montant moyen arrondi a 2 decimales (alias `montant_moyen`) pour chaque statut de commande, trie par montant_moyen decroissant.',
  'intermediate',
  'SELECT statut, ROUND(AVG(montant_total), 2) AS montant_moyen FROM commandes GROUP BY statut ORDER BY montant_moyen DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise ROUND(AVG(montant_total), 2) avec GROUP BY statut.',
  20,
  26,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-tables-plus-utilisees',
  'Tables les plus utilisees',
  'Trouvez les tables ayant recu le plus de commandes.',
  'Selectionnez le numero de la table, son emplacement et le nombre de commandes (alias `nb_commandes`) pour chaque table, tries par nb_commandes decroissant. Limitez aux 5 premieres.',
  'intermediate',
  'SELECT t.numero, t.emplacement, COUNT(*) AS nb_commandes FROM commandes co JOIN tables_resto t ON co.table_id = t.id GROUP BY t.id, t.numero, t.emplacement ORDER BY nb_commandes DESC LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et tables_resto, GROUP BY, ORDER BY DESC et LIMIT 5.',
  20,
  27,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-desserts-commandes',
  'Desserts commandes',
  'Listez les desserts qui ont ete commandes au moins une fois.',
  'Selectionnez le nom du plat et le nombre total de fois qu''il a ete commande (alias `nb_fois`) pour les plats de la categorie ''Dessert'' (`categorie_id = 3`). Triez par nb_fois decroissant.',
  'intermediate',
  'SELECT p.nom, SUM(lc.quantite) AS nb_fois FROM lignes_commande lc JOIN plats p ON lc.plat_id = p.id WHERE p.categorie_id = 3 GROUP BY p.nom ORDER BY nb_fois DESC;',
  '{"columns":[],"rows":[]}',
  'Joins lignes_commande et plats, filtre categorie_id = 3, SUM(quantite) avec GROUP BY.',
  20,
  28,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-jours-plus-3-reservations',
  'Jours charges',
  'Trouvez les jours ayant plus de 3 reservations.',
  'Selectionnez la date_reservation et le nombre de reservations (alias `nb_reservations`) pour les dates ayant strictement plus de 3 reservations. Triez par nb_reservations decroissant.',
  'intermediate',
  'SELECT date_reservation, COUNT(*) AS nb_reservations FROM reservations GROUP BY date_reservation HAVING COUNT(*) > 3 ORDER BY nb_reservations DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise GROUP BY avec HAVING COUNT(*) > 3.',
  20,
  29,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-ca-total-serveur',
  'CA total par serveur',
  'Calculez le chiffre d''affaires total de chaque serveur.',
  'Selectionnez le prenom, le nom et la somme des montant_total (alias `ca_total`) de chaque serveur pour les commandes payees. Triez par ca_total decroissant.',
  'intermediate',
  'SELECT s.prenom, s.nom, SUM(co.montant_total) AS ca_total FROM commandes co JOIN serveurs s ON co.serveur_id = s.id WHERE co.statut = ''payee'' GROUP BY s.id, s.prenom, s.nom ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et serveurs, filtre payee, SUM avec GROUP BY.',
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
  4,
  'rest-top5-plats-vendus',
  'Top 5 des plats les plus vendus',
  'Identifiez les 5 plats les plus commandes en quantite.',
  'Selectionnez le nom du plat, le nom de la categorie (alias `categorie`) et la quantite totale vendue (alias `total_vendu`) pour les 5 plats les plus vendus. Triez par total_vendu decroissant.',
  'advanced',
  'SELECT p.nom, c.nom AS categorie, SUM(lc.quantite) AS total_vendu FROM lignes_commande lc JOIN plats p ON lc.plat_id = p.id JOIN categories_plats c ON p.categorie_id = c.id GROUP BY p.id, p.nom, c.nom ORDER BY total_vendu DESC LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Triple jointure : lignes_commande -> plats -> categories_plats, SUM(quantite), GROUP BY et LIMIT 5.',
  30,
  31,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-ca-par-categorie',
  'Chiffre d''affaires par categorie',
  'Calculez le CA genere par chaque categorie de plats.',
  'Selectionnez le nom de la categorie et la somme de (quantite * prix_unitaire) arrondie a 2 decimales (alias `ca_categorie`). Triez par ca_categorie decroissant.',
  'advanced',
  'SELECT c.nom AS categorie, ROUND(SUM(lc.quantite * lc.prix_unitaire), 2) AS ca_categorie FROM lignes_commande lc JOIN plats p ON lc.plat_id = p.id JOIN categories_plats c ON p.categorie_id = c.id GROUP BY c.nom ORDER BY ca_categorie DESC;',
  '{"columns":[],"rows":[]}',
  'Triple jointure, SUM(quantite * prix_unitaire) avec GROUP BY categorie.',
  30,
  32,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-serveur-commande-detail',
  'Detail des commandes par serveur et date',
  'Affichez le resume des commandes par serveur et par date.',
  'Selectionnez le prenom du serveur, la date_commande, le nombre de commandes (alias `nb_commandes`) et la somme des montants (alias `total`) par serveur et par date. Triez par date puis par prenom.',
  'advanced',
  'SELECT s.prenom, co.date_commande, COUNT(*) AS nb_commandes, SUM(co.montant_total) AS total FROM commandes co JOIN serveurs s ON co.serveur_id = s.id GROUP BY s.prenom, co.date_commande ORDER BY co.date_commande, s.prenom;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et serveurs, GROUP BY prenom et date_commande.',
  30,
  33,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-commande-la-plus-chere',
  'La commande la plus chere',
  'Trouvez la commande avec le montant le plus eleve et ses details.',
  'Selectionnez l''id de la commande, le numero de la table, le prenom du serveur et le montant_total de la commande ayant le montant_total le plus eleve.',
  'advanced',
  'SELECT co.id, t.numero, s.prenom, co.montant_total FROM commandes co JOIN tables_resto t ON co.table_id = t.id JOIN serveurs s ON co.serveur_id = s.id ORDER BY co.montant_total DESC LIMIT 1;',
  '{"columns":[],"rows":[]}',
  'Joins commandes, tables_resto et serveurs, ORDER BY montant_total DESC LIMIT 1.',
  30,
  34,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-panier-moyen-emplacement',
  'Panier moyen par emplacement',
  'Comparez le montant moyen des commandes selon l''emplacement des tables.',
  'Selectionnez l''emplacement et le montant moyen des commandes arrondi a 2 decimales (alias `panier_moyen`) pour chaque emplacement. Triez par panier_moyen decroissant.',
  'advanced',
  'SELECT t.emplacement, ROUND(AVG(co.montant_total), 2) AS panier_moyen FROM commandes co JOIN tables_resto t ON co.table_id = t.id GROUP BY t.emplacement ORDER BY panier_moyen DESC;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et tables_resto, ROUND(AVG(montant_total), 2) avec GROUP BY emplacement.',
  30,
  35,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-nb-items-par-commande',
  'Nombre d''items par commande',
  'Calculez le nombre total d''items dans chaque commande.',
  'Selectionnez l''id de la commande (alias `commande_id`), le prenom du serveur et le nombre total d''items (SUM de quantite, alias `nb_items`) pour chaque commande. Triez par nb_items decroissant. Limitez aux 10 premieres.',
  'advanced',
  'SELECT co.id AS commande_id, s.prenom, SUM(lc.quantite) AS nb_items FROM commandes co JOIN serveurs s ON co.serveur_id = s.id JOIN lignes_commande lc ON lc.commande_id = co.id GROUP BY co.id, s.prenom ORDER BY nb_items DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'Triple jointure : commandes -> serveurs + lignes_commande, SUM(quantite) GROUP BY commande.',
  30,
  36,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-plats-vegetariens-ca',
  'CA des plats vegetariens vs non-vegetariens',
  'Comparez le chiffre d''affaires entre plats vegetariens et non-vegetariens.',
  'Selectionnez un libelle indiquant si le plat est vegetarien (utilisez CASE WHEN p.est_vegetarien = 1 THEN ''Vegetarien'' ELSE ''Non vegetarien'' END, alias `type_plat`) et la somme de (quantite * prix_unitaire) arrondie a 2 decimales (alias `ca`). Groupez par type_plat et triez par ca decroissant.',
  'advanced',
  'SELECT CASE WHEN p.est_vegetarien = 1 THEN ''Vegetarien'' ELSE ''Non vegetarien'' END AS type_plat, ROUND(SUM(lc.quantite * lc.prix_unitaire), 2) AS ca FROM lignes_commande lc JOIN plats p ON lc.plat_id = p.id GROUP BY type_plat ORDER BY ca DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise CASE WHEN pour creer le libelle, puis SUM et GROUP BY.',
  30,
  37,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-taux-annulation',
  'Taux d''annulation des reservations',
  'Calculez le pourcentage de reservations annulees.',
  'Ecrivez une requete qui retourne le nombre total de reservations (alias `total`), le nombre de reservations annulees (alias `annulees`) et le taux d''annulation en pourcentage arrondi a 1 decimale (alias `taux_annulation`). Utilisez SUM(CASE ...) pour compter les annulees.',
  'advanced',
  'SELECT COUNT(*) AS total, SUM(CASE WHEN statut = ''annulee'' THEN 1 ELSE 0 END) AS annulees, ROUND(100.0 * SUM(CASE WHEN statut = ''annulee'' THEN 1 ELSE 0 END) / COUNT(*), 1) AS taux_annulation FROM reservations;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(CASE WHEN statut = ''annulee'' THEN 1 ELSE 0 END) et divise par COUNT(*).',
  30,
  38,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-serveurs-sans-commande-encours',
  'Serveurs sans commande en cours',
  'Identifiez les serveurs qui n''ont aucune commande en cours.',
  'Selectionnez le prenom et le nom des serveurs qui n''ont pas de commande avec le statut ''en_cours''. Triez par nom.',
  'advanced',
  'SELECT prenom, nom FROM serveurs WHERE id NOT IN (SELECT DISTINCT serveur_id FROM commandes WHERE statut = ''en_cours'') ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Utilise NOT IN avec une sous-requete sur commandes WHERE statut = ''en_cours''.',
  30,
  39,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-reservation-grande-table',
  'Reservations dans les salons prives',
  'Affichez les reservations pour les salons prives.',
  'Selectionnez le nom_client, la date_reservation, l''heure, le numero de table et la capacite pour les reservations dont la table est en salon prive (`emplacement = ''salon_prive''`). Triez par date puis heure.',
  'advanced',
  'SELECT r.nom_client, r.date_reservation, r.heure, t.numero, t.capacite FROM reservations r JOIN tables_resto t ON r.table_id = t.id WHERE t.emplacement = ''salon_prive'' ORDER BY r.date_reservation, r.heure;',
  '{"columns":[],"rows":[]}',
  'Joins reservations et tables_resto, filtre emplacement = ''salon_prive''.',
  30,
  40,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-ca-par-jour-emplacement',
  'CA par jour et emplacement',
  'Analysez le CA par jour et par emplacement de table.',
  'Selectionnez la date_commande, l''emplacement et la somme des montant_total (alias `ca`) pour les commandes payees. Groupez par date et emplacement, triez par date puis emplacement.',
  'advanced',
  'SELECT co.date_commande, t.emplacement, SUM(co.montant_total) AS ca FROM commandes co JOIN tables_resto t ON co.table_id = t.id WHERE co.statut = ''payee'' GROUP BY co.date_commande, t.emplacement ORDER BY co.date_commande, t.emplacement;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et tables_resto, filtre payee, GROUP BY date et emplacement.',
  30,
  41,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-detail-commande-complete',
  'Detail complet d''une commande',
  'Reconstituez le detail de la commande n 6 (la plus fournie du 21).',
  'Pour la commande id = 6, selectionnez le nom du plat, le nom de la categorie (alias `categorie`), la quantite, le prix_unitaire et le sous-total (quantite * prix_unitaire, alias `sous_total`). Triez par categorie puis par nom du plat.',
  'advanced',
  'SELECT p.nom, c.nom AS categorie, lc.quantite, lc.prix_unitaire, lc.quantite * lc.prix_unitaire AS sous_total FROM lignes_commande lc JOIN plats p ON lc.plat_id = p.id JOIN categories_plats c ON p.categorie_id = c.id WHERE lc.commande_id = 6 ORDER BY c.nom, p.nom;',
  '{"columns":[],"rows":[]}',
  'Triple jointure avec WHERE commande_id = 6, calcul quantite * prix_unitaire.',
  30,
  42,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-plats-populaires-terrasse',
  'Plats populaires en terrasse',
  'Quels plats sont les plus commandes aux tables en terrasse ?',
  'Selectionnez le nom du plat et la quantite totale vendue (alias `total_vendu`) pour les commandes passees a des tables en terrasse. Triez par total_vendu decroissant, limitez aux 5 premiers.',
  'advanced',
  'SELECT p.nom, SUM(lc.quantite) AS total_vendu FROM lignes_commande lc JOIN commandes co ON lc.commande_id = co.id JOIN tables_resto t ON co.table_id = t.id JOIN plats p ON lc.plat_id = p.id WHERE t.emplacement = ''terrasse'' GROUP BY p.nom ORDER BY total_vendu DESC LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Quadruple jointure : lignes_commande -> commandes -> tables_resto + plats, filtre terrasse.',
  30,
  43,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-serveur-meilleur-jour',
  'Meilleur jour de chaque serveur',
  'Trouvez le jour ou chaque serveur a genere le plus de CA.',
  'Pour chaque serveur, selectionnez le prenom, la date_commande et le CA du jour (alias `ca_jour`) pour le jour ou il a genere le plus de CA (parmi les commandes payees). Utilisez une sous-requete ou un tri. Triez par prenom.',
  'advanced',
  'SELECT s.prenom, co.date_commande, SUM(co.montant_total) AS ca_jour FROM commandes co JOIN serveurs s ON co.serveur_id = s.id WHERE co.statut = ''payee'' GROUP BY s.prenom, co.date_commande HAVING SUM(co.montant_total) = (SELECT MAX(sub.ca) FROM (SELECT co2.serveur_id, co2.date_commande, SUM(co2.montant_total) AS ca FROM commandes co2 WHERE co2.statut = ''payee'' GROUP BY co2.serveur_id, co2.date_commande) sub WHERE sub.serveur_id = s.id) ORDER BY s.prenom;',
  '{"columns":[],"rows":[]}',
  'Sous-requete correlee : compare le SUM du jour au MAX des SUM de ce serveur.',
  30,
  44,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-categories-toutes-commandees',
  'Categories toutes representees',
  'Verifiez que chaque categorie a au moins un plat commande.',
  'Selectionnez le nom de la categorie et le nombre de plats distincts commandes (alias `nb_plats_commandes`) pour chaque categorie. Incluez aussi les categories sans aucun plat commande (utilisez LEFT JOIN). Triez par nb_plats_commandes croissant.',
  'advanced',
  'SELECT c.nom AS categorie, COUNT(DISTINCT lc.plat_id) AS nb_plats_commandes FROM categories_plats c LEFT JOIN plats p ON p.categorie_id = c.id LEFT JOIN lignes_commande lc ON lc.plat_id = p.id GROUP BY c.nom ORDER BY nb_plats_commandes;',
  '{"columns":[],"rows":[]}',
  'Utilise LEFT JOIN pour inclure les categories sans commandes, COUNT(DISTINCT lc.plat_id).',
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
  4,
  'rest-synthese-serveur-complete',
  'Synthese complete par serveur',
  'Etablissez un tableau de bord complet pour chaque serveur.',
  'Selectionnez le prenom du serveur, le nombre total de commandes (alias `nb_commandes`), le CA total des commandes payees (alias `ca_total`), le montant moyen des commandes payees arrondi a 2 decimales (alias `montant_moyen`) et le nombre de jours distincts travailles (alias `nb_jours`). Triez par ca_total decroissant.',
  'advanced',
  'SELECT s.prenom, COUNT(*) AS nb_commandes, SUM(CASE WHEN co.statut = ''payee'' THEN co.montant_total ELSE 0 END) AS ca_total, ROUND(AVG(CASE WHEN co.statut = ''payee'' THEN co.montant_total END), 2) AS montant_moyen, COUNT(DISTINCT co.date_commande) AS nb_jours FROM commandes co JOIN serveurs s ON co.serveur_id = s.id GROUP BY s.id, s.prenom ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  'Combine COUNT, SUM(CASE WHEN), AVG(CASE WHEN) et COUNT(DISTINCT) dans une seule requete.',
  40,
  46,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-analyse-croisee-plats',
  'Analyse croisee plats et emplacements',
  'Analysez quelles categories de plats sont les plus vendues selon l''emplacement.',
  'Selectionnez l''emplacement, le nom de la categorie (alias `categorie`), la quantite totale vendue (alias `total_vendu`) et le CA associe arrondi a 2 decimales (alias `ca`). Groupez par emplacement et categorie, triez par emplacement puis ca decroissant.',
  'advanced',
  'SELECT t.emplacement, c.nom AS categorie, SUM(lc.quantite) AS total_vendu, ROUND(SUM(lc.quantite * lc.prix_unitaire), 2) AS ca FROM lignes_commande lc JOIN commandes co ON lc.commande_id = co.id JOIN tables_resto t ON co.table_id = t.id JOIN plats p ON lc.plat_id = p.id JOIN categories_plats c ON p.categorie_id = c.id GROUP BY t.emplacement, c.nom ORDER BY t.emplacement, ca DESC;',
  '{"columns":[],"rows":[]}',
  'Jointure 5 tables : lignes_commande -> commandes -> tables_resto + plats -> categories_plats.',
  40,
  47,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-coherence-montants',
  'Verification de coherence des montants',
  'Verifiez si les montants totaux des commandes correspondent a la somme des lignes.',
  'Pour chaque commande, selectionnez l''id de la commande (alias `commande_id`), le montant_total enregistre (alias `montant_enregistre`), la somme recalculee des lignes (quantite * prix_unitaire, alias `montant_recalcule`) et la difference entre les deux (alias `ecart`). Affichez uniquement les commandes ou l''ecart est different de 0. Triez par commande_id.',
  'advanced',
  'SELECT co.id AS commande_id, co.montant_total AS montant_enregistre, SUM(lc.quantite * lc.prix_unitaire) AS montant_recalcule, co.montant_total - SUM(lc.quantite * lc.prix_unitaire) AS ecart FROM commandes co JOIN lignes_commande lc ON lc.commande_id = co.id GROUP BY co.id, co.montant_total HAVING co.montant_total - SUM(lc.quantite * lc.prix_unitaire) != 0 ORDER BY co.id;',
  '{"columns":[],"rows":[]}',
  'Joins commandes et lignes_commande, SUM(quantite * prix_unitaire), HAVING pour filtrer les ecarts != 0.',
  40,
  48,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-evolution-ca-quotidien',
  'Evolution du CA quotidien',
  'Calculez le CA quotidien et le cumul progressif.',
  'Selectionnez la date_commande, le CA du jour (alias `ca_jour`) et le CA cumule depuis le debut (alias `ca_cumule`) en utilisant une sous-requete pour le cumul. Ne considerez que les commandes payees. Triez par date.',
  'advanced',
  'SELECT date_commande, SUM(montant_total) AS ca_jour, (SELECT SUM(co2.montant_total) FROM commandes co2 WHERE co2.statut = ''payee'' AND co2.date_commande <= co.date_commande) AS ca_cumule FROM commandes co WHERE statut = ''payee'' GROUP BY date_commande ORDER BY date_commande;',
  '{"columns":[],"rows":[]}',
  'Sous-requete correlee : SELECT SUM(...) FROM commandes WHERE date <= date courante.',
  40,
  49,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  4,
  'rest-rapport-complet-jour',
  'Rapport complet du 21 decembre',
  'Generez un rapport detaille de la journee du 21 decembre 2024.',
  'Pour la date ''2024-12-21'', selectionnez le prenom du serveur, le numero de table, l''emplacement, le montant_total de la commande, le nombre de lignes dans la commande (alias `nb_lignes`) et le statut. Triez par prenom puis par montant_total decroissant.',
  'advanced',
  'SELECT s.prenom, t.numero, t.emplacement, co.montant_total, COUNT(lc.id) AS nb_lignes, co.statut FROM commandes co JOIN serveurs s ON co.serveur_id = s.id JOIN tables_resto t ON co.table_id = t.id JOIN lignes_commande lc ON lc.commande_id = co.id WHERE co.date_commande = ''2024-12-21'' GROUP BY co.id, s.prenom, t.numero, t.emplacement, co.montant_total, co.statut ORDER BY s.prenom, co.montant_total DESC;',
  '{"columns":[],"rows":[]}',
  'Jointure 4 tables avec WHERE date = ''2024-12-21'', COUNT(lc.id) pour les lignes.',
  40,
  50,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

COMMIT;
