-- ============================================================================
-- SQL Clinic Tasks - E-commerce Dataset (dataset_id = 2)
-- 15 exercises: 5 beginner, 5 intermediate, 5 advanced
-- expected_result is kept empty — validation uses expected_sql execution
-- ============================================================================

BEGIN;

-- ==================== BEGINNER ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-categories',
  'Toutes les catégories',
  'Affichez toutes les catégories de la boutique.',
  'Écrivez une requête qui affiche toutes les colonnes de la table `categories`, triées par `id` croissant.',
  'beginner',
  'SELECT * FROM categories ORDER BY id;',
  '{"columns":[],"rows":[]}',
  10, 1, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-electronique',
  'Produits électroniques',
  'Filtrez les produits de la catégorie Électronique.',
  'Affichez le nom, le prix et le stock des produits de la catégorie Électronique (`categorie_id = 1`), triés par prix décroissant.',
  'beginner',
  'SELECT nom, prix, stock FROM produits WHERE categorie_id = 1 ORDER BY prix DESC;',
  '{"columns":[],"rows":[]}',
  10, 2, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-livrees',
  'Commandes livrées',
  'Filtrez les commandes ayant le statut livré.',
  'Affichez l''id, le client_id, la date_commande et le montant_total des commandes livrées (`statut = ''livree''`), triées par date de commande.',
  'beginner',
  'SELECT id, client_id, date_commande, montant_total FROM commandes WHERE statut = ''livree'' ORDER BY date_commande;',
  '{"columns":[],"rows":[]}',
  10, 3, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-parisiens',
  'Clients parisiens',
  'Trouvez les clients habitant à Paris.',
  'Affichez le prénom, le nom et l''email des clients qui habitent à Paris, triés par nom.',
  'beginner',
  'SELECT prenom, nom, email FROM clients WHERE ville = ''Paris'' ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  10, 4, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-chers',
  'Produits premium',
  'Trouvez les produits dont le prix dépasse 100€.',
  'Affichez le nom et le prix des produits dont le prix est supérieur à 100€, triés du plus cher au moins cher.',
  'beginner',
  'SELECT nom, prix FROM produits WHERE prix > 100 ORDER BY prix DESC;',
  '{"columns":[],"rows":[]}',
  10, 5, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== INTERMEDIATE ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-produits-cat',
  'Produits par catégorie',
  'Comptez le nombre de produits dans chaque catégorie.',
  'Affichez le nom de chaque catégorie et le nombre de produits qu''elle contient, triés par nombre de produits décroissant puis par nom de catégorie.',
  'intermediate',
  'SELECT c.nom AS categorie, COUNT(*) AS nb_produits FROM produits p JOIN categories c ON p.categorie_id = c.id GROUP BY c.nom ORDER BY nb_produits DESC, c.nom;',
  '{"columns":[],"rows":[]}',
  20, 6, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-commandes-client',
  'Commandes par client',
  'Comptez les commandes de chaque client.',
  'Affichez le prénom, le nom et le nombre de commandes de chaque client. Triez par nombre de commandes décroissant puis par nom.',
  'intermediate',
  'SELECT cl.prenom, cl.nom, COUNT(co.id) AS nb_commandes FROM clients cl JOIN commandes co ON cl.id = co.client_id GROUP BY cl.id, cl.prenom, cl.nom ORDER BY nb_commandes DESC, cl.nom;',
  '{"columns":[],"rows":[]}',
  20, 7, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-ca-categorie',
  'CA par catégorie',
  'Calculez le chiffre d''affaires par catégorie.',
  'Calculez le chiffre d''affaires total (somme de `quantite * prix_unitaire`) pour chaque catégorie. Affichez le nom de la catégorie et le CA, triés par CA décroissant.',
  'intermediate',
  'SELECT c.nom AS categorie, SUM(lc.quantite * lc.prix_unitaire) AS ca_total FROM lignes_commande lc JOIN produits p ON lc.produit_id = p.id JOIN categories c ON p.categorie_id = c.id GROUP BY c.nom ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  20, 8, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-notes-produits',
  'Notes moyennes',
  'Calculez la note moyenne des avis par produit.',
  'Affichez le nom de chaque produit ayant reçu des avis avec sa note moyenne arrondie à 1 décimale et le nombre d''avis. Triez par note décroissante puis par nom.',
  'intermediate',
  'SELECT p.nom, ROUND(AVG(a.note), 1) AS note_moyenne, COUNT(*) AS nb_avis FROM avis a JOIN produits p ON a.produit_id = p.id GROUP BY p.nom ORDER BY note_moyenne DESC, p.nom;',
  '{"columns":[],"rows":[]}',
  20, 9, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-villes-actives',
  'Villes actives',
  'Trouvez les villes avec au moins 2 clients.',
  'Affichez les villes ayant au moins 2 clients inscrits avec le nombre de clients. Triez par nombre de clients décroissant puis par ville.',
  'intermediate',
  'SELECT ville, COUNT(*) AS nb_clients FROM clients GROUP BY ville HAVING COUNT(*) >= 2 ORDER BY nb_clients DESC, ville;',
  '{"columns":[],"rows":[]}',
  20, 10, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== ADVANCED ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-top-vendus',
  'Top 5 produits vendus',
  'Trouvez les produits les plus vendus en quantité.',
  'Affichez les 5 produits les plus vendus (nombre total d''unités). Montrez le nom et la quantité totale. Triez par quantité décroissante puis par nom.',
  'advanced',
  'SELECT p.nom, SUM(lc.quantite) AS total_vendu FROM lignes_commande lc JOIN produits p ON lc.produit_id = p.id GROUP BY p.nom ORDER BY total_vendu DESC, p.nom LIMIT 5;',
  '{"columns":[],"rows":[]}',
  30, 11, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-sans-avis',
  'Clients sans avis',
  'Trouvez les clients qui n''ont jamais laissé d''avis.',
  'Affichez le prénom, le nom et la ville des clients qui n''ont laissé aucun avis. Triez par nom.',
  'advanced',
  'SELECT cl.prenom, cl.nom, cl.ville FROM clients cl WHERE cl.id NOT IN (SELECT DISTINCT client_id FROM avis) ORDER BY cl.nom;',
  '{"columns":[],"rows":[]}',
  30, 12, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-panier-moyen',
  'Panier moyen par ville',
  'Calculez le panier moyen par ville.',
  'Calculez le montant moyen des commandes pour chaque ville. Affichez la ville et le panier moyen arrondi à 2 décimales. Triez par panier moyen décroissant.',
  'advanced',
  'SELECT cl.ville, ROUND(AVG(co.montant_total), 2) AS panier_moyen FROM clients cl JOIN commandes co ON cl.id = co.client_id GROUP BY cl.ville ORDER BY panier_moyen DESC;',
  '{"columns":[],"rows":[]}',
  30, 13, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-jamais-commandes',
  'Produits jamais commandés',
  'Trouvez les produits qui n''ont jamais été commandés.',
  'Affichez le nom et le prix des produits qui n''apparaissent dans aucune ligne de commande. Triez par nom.',
  'advanced',
  'SELECT p.nom, p.prix FROM produits p WHERE p.id NOT IN (SELECT DISTINCT produit_id FROM lignes_commande) ORDER BY p.nom;',
  '{"columns":[],"rows":[]}',
  30, 14, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  2,
  'eco-synthese-clients',
  'Synthèse clients',
  'Analyse complète des dépenses par client.',
  'Affichez le prénom, le nom, le nombre de commandes et le total dépensé pour les 10 clients les plus dépensiers. Triez par total dépensé décroissant.',
  'advanced',
  'SELECT cl.prenom, cl.nom, COUNT(co.id) AS nb_commandes, SUM(co.montant_total) AS total_depense FROM clients cl JOIN commandes co ON cl.id = co.client_id GROUP BY cl.id, cl.prenom, cl.nom ORDER BY total_depense DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  30, 15, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

COMMIT;
