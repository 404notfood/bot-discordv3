-- ============================================================================
-- SQL Clinic - Dataset Bibliotheque
-- Table cible: sql_clinic_datasets + sql_clinic_tasks (PostgreSQL)
-- dataset_id = 3
-- 50 exercices: 15 beginner, 15 intermediate, 15 advanced, 5 expert
-- expected_result is kept empty — validation uses expected_sql execution
-- ============================================================================

BEGIN;

-- ============================================================================
-- DATASET REGISTRATION
-- ============================================================================

INSERT INTO sql_clinic_datasets (slug, name, description, is_active, created_at, updated_at)
VALUES ('bibliotheque', 'Bibliothèque Municipale', 'Base de données d''une bibliothèque avec auteurs, livres, adhérents et emprunts.', true, NOW(), NOW())
ON CONFLICT (slug) DO NOTHING;

-- ============================================================================
-- BEGINNER (1-15) — 10 pts each
-- ============================================================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-tous-les-auteurs',
  'Liste des auteurs',
  'Affichez tous les auteurs de la bibliothèque.',
  'Écrivez une requête qui affiche toutes les colonnes de la table `auteurs`, triées par `id` croissant.',
  'beginner',
  'SELECT * FROM auteurs ORDER BY id;',
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
  3,
  'bib-tous-les-genres',
  'Les genres littéraires',
  'Affichez tous les genres disponibles.',
  'Affichez le `nom` et la `description` de tous les genres, triés par `nom` croissant.',
  'beginner',
  'SELECT nom, description FROM genres ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Sélectionne seulement les colonnes nom et description, puis trie par nom.',
  10,
  2,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-auteurs-francais',
  'Auteurs français',
  'Filtrez les auteurs de nationalité française.',
  'Affichez le `prenom` et le `nom` des auteurs de nationalité ''Francaise'', triés par `nom`.',
  'beginner',
  'SELECT prenom, nom FROM auteurs WHERE nationalite = ''Francaise'' ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE nationalite = ''Francaise'' et trie par nom.',
  10,
  3,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-longs',
  'Livres volumineux',
  'Trouvez les livres de plus de 500 pages.',
  'Affichez le `titre` et le nombre de `pages` des livres ayant plus de 500 pages, triés par `pages` décroissant.',
  'beginner',
  'SELECT titre, pages FROM livres WHERE pages > 500 ORDER BY pages DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE pages > 500 et ORDER BY pages DESC.',
  10,
  4,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-adherents-premium',
  'Adhérents premium',
  'Listez les adhérents ayant un abonnement premium.',
  'Affichez le `prenom`, le `nom` et la `ville` des adhérents ayant un abonnement ''premium'', triés par `nom`.',
  'beginner',
  'SELECT prenom, nom, ville FROM adherents WHERE abonnement = ''premium'' ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE abonnement = ''premium'' et trie par nom.',
  10,
  5,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-recents',
  'Livres du XXe siècle et après',
  'Trouvez les livres publiés à partir de 1950.',
  'Affichez le `titre` et l''`annee_publication` des livres publiés en 1950 ou après, triés par `annee_publication` décroissant puis par `titre`.',
  'beginner',
  'SELECT titre, annee_publication FROM livres WHERE annee_publication >= 1950 ORDER BY annee_publication DESC, titre;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE annee_publication >= 1950 et ORDER BY annee_publication DESC, titre.',
  10,
  6,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-emprunts-en-cours',
  'Emprunts non rendus',
  'Trouvez les emprunts qui n''ont pas encore été retournés.',
  'Affichez l''`id`, l''`adherent_id`, le `livre_id` et la `date_emprunt` des emprunts dont la `date_retour_effective` est NULL, triés par `date_emprunt`.',
  'beginner',
  'SELECT id, adherent_id, livre_id, date_emprunt FROM emprunts WHERE date_retour_effective IS NULL ORDER BY date_emprunt;',
  '{"columns":[],"rows":[]}',
  'Cherche les valeurs NULL avec IS NULL sur date_retour_effective.',
  10,
  7,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-stock-faible',
  'Stock faible',
  'Trouvez les livres avec un stock de 1 ou 2 exemplaires.',
  'Affichez le `titre` et le `stock` des livres ayant un stock compris entre 1 et 2 (inclus), triés par `stock` puis par `titre`.',
  'beginner',
  'SELECT titre, stock FROM livres WHERE stock BETWEEN 1 AND 2 ORDER BY stock, titre;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE stock BETWEEN 1 AND 2.',
  10,
  8,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-adherents-paris',
  'Adhérents parisiens',
  'Trouvez les adhérents habitant à Paris.',
  'Affichez le `prenom`, le `nom` et l''`email` des adhérents qui habitent à Paris, triés par `nom` puis par `prenom`.',
  'beginner',
  'SELECT prenom, nom, email FROM adherents WHERE ville = ''Paris'' ORDER BY nom, prenom;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE ville = ''Paris'' et trie par nom, prenom.',
  10,
  9,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-titres-like',
  'Recherche par titre',
  'Cherchez les livres dont le titre contient le mot "de".',
  'Affichez le `titre` des livres dont le titre contient le mot ''de'' (insensible à la casse), triés par `titre`.',
  'beginner',
  'SELECT titre FROM livres WHERE titre LIKE ''%de%'' ORDER BY titre;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE titre LIKE ''%de%'' pour chercher un motif dans le titre.',
  10,
  10,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-nb-livres',
  'Nombre total de livres',
  'Comptez le nombre total de livres dans la bibliothèque.',
  'Affichez le nombre total de livres sous l''alias `total_livres`.',
  'beginner',
  'SELECT COUNT(*) AS total_livres FROM livres;',
  '{"columns":[],"rows":[]}',
  'Utilise COUNT(*) avec un alias AS total_livres.',
  10,
  11,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-xixe',
  'Livres du XIXe siècle',
  'Trouvez les livres publiés entre 1800 et 1899.',
  'Affichez le `titre` et l''`annee_publication` des livres publiés entre 1800 et 1899 inclus, triés par `annee_publication`.',
  'beginner',
  'SELECT titre, annee_publication FROM livres WHERE annee_publication BETWEEN 1800 AND 1899 ORDER BY annee_publication;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE annee_publication BETWEEN 1800 AND 1899.',
  10,
  12,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-top5-pages',
  'Les 5 plus gros livres',
  'Affichez les 5 livres ayant le plus de pages.',
  'Affichez le `titre` et le nombre de `pages` des 5 livres ayant le plus de pages, triés par `pages` décroissant.',
  'beginner',
  'SELECT titre, pages FROM livres ORDER BY pages DESC LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Utilise ORDER BY pages DESC et LIMIT 5.',
  10,
  13,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-adherents-2023',
  'Inscriptions 2023',
  'Trouvez les adhérents inscrits en 2023.',
  'Affichez le `prenom`, le `nom` et la `date_inscription` des adhérents inscrits en 2023 (date_inscription entre ''2023-01-01'' et ''2023-12-31''), triés par `date_inscription`.',
  'beginner',
  'SELECT prenom, nom, date_inscription FROM adherents WHERE date_inscription BETWEEN ''2023-01-01'' AND ''2023-12-31'' ORDER BY date_inscription;',
  '{"columns":[],"rows":[]}',
  'Utilise WHERE date_inscription BETWEEN ''2023-01-01'' AND ''2023-12-31''.',
  10,
  14,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-stock-total',
  'Stock total par livre',
  'Calculez le stock total de tous les livres.',
  'Affichez la somme totale du stock de tous les livres sous l''alias `stock_total` et la moyenne du stock arrondie à 1 décimale sous l''alias `stock_moyen`.',
  'beginner',
  'SELECT SUM(stock) AS stock_total, ROUND(AVG(stock), 1) AS stock_moyen FROM livres;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(stock) et ROUND(AVG(stock), 1) avec des alias.',
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
  3,
  'bib-livres-auteurs',
  'Livres avec leurs auteurs',
  'Affichez chaque livre avec le nom de son auteur.',
  'Affichez le `titre` du livre, le `prenom` et le `nom` de l''auteur pour chaque livre, triés par le `nom` de l''auteur puis par `titre`.',
  'intermediate',
  'SELECT l.titre, a.prenom, a.nom FROM livres l JOIN auteurs a ON l.auteur_id = a.id ORDER BY a.nom, l.titre;',
  '{"columns":[],"rows":[]}',
  'Fais un JOIN entre livres et auteurs sur auteur_id = a.id.',
  20,
  16,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-par-genre',
  'Nombre de livres par genre',
  'Comptez le nombre de livres dans chaque genre.',
  'Affichez le `nom` du genre et le nombre de livres sous l''alias `nb_livres`, triés par `nb_livres` décroissant puis par `nom`.',
  'intermediate',
  'SELECT g.nom, COUNT(*) AS nb_livres FROM livres l JOIN genres g ON l.genre_id = g.id GROUP BY g.nom ORDER BY nb_livres DESC, g.nom;',
  '{"columns":[],"rows":[]}',
  'Joins livres et genres, puis utilise COUNT(*) avec GROUP BY g.nom.',
  20,
  17,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-par-auteur',
  'Nombre de livres par auteur',
  'Comptez combien de livres chaque auteur a dans la bibliothèque.',
  'Affichez le `prenom`, le `nom` de l''auteur et le nombre de livres sous l''alias `nb_livres`, triés par `nb_livres` décroissant puis par `nom`.',
  'intermediate',
  'SELECT a.prenom, a.nom, COUNT(*) AS nb_livres FROM livres l JOIN auteurs a ON l.auteur_id = a.id GROUP BY a.id, a.prenom, a.nom ORDER BY nb_livres DESC, a.nom;',
  '{"columns":[],"rows":[]}',
  'Joins livres et auteurs, puis GROUP BY sur l''auteur avec COUNT(*).',
  20,
  18,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-emprunts-details',
  'Détails des emprunts',
  'Affichez les emprunts avec les noms des adhérents et des livres.',
  'Affichez le `prenom` et le `nom` de l''adhérent, le `titre` du livre et la `date_emprunt`, triés par `date_emprunt` décroissant. Limitez aux 10 emprunts les plus récents.',
  'intermediate',
  'SELECT ad.prenom, ad.nom, l.titre, e.date_emprunt FROM emprunts e JOIN adherents ad ON e.adherent_id = ad.id JOIN livres l ON e.livre_id = l.id ORDER BY e.date_emprunt DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'Double JOIN : emprunts -> adherents et emprunts -> livres. Trie par date_emprunt DESC et LIMIT 10.',
  20,
  19,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-adherents-par-ville',
  'Adhérents par ville',
  'Comptez le nombre d''adhérents par ville.',
  'Affichez la `ville` et le nombre d''adhérents sous l''alias `nb_adherents`, triés par `nb_adherents` décroissant puis par `ville`.',
  'intermediate',
  'SELECT ville, COUNT(*) AS nb_adherents FROM adherents GROUP BY ville ORDER BY nb_adherents DESC, ville;',
  '{"columns":[],"rows":[]}',
  'Utilise GROUP BY ville avec COUNT(*) et un alias.',
  20,
  20,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-adherents-par-abonnement',
  'Répartition des abonnements',
  'Comptez le nombre d''adhérents par type d''abonnement.',
  'Affichez le type d''`abonnement` et le nombre d''adhérents sous l''alias `nb_adherents`, triés par `nb_adherents` décroissant.',
  'intermediate',
  'SELECT abonnement, COUNT(*) AS nb_adherents FROM adherents GROUP BY abonnement ORDER BY nb_adherents DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise GROUP BY abonnement avec COUNT(*).',
  20,
  21,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-emprunts-par-adherent',
  'Nombre d''emprunts par adhérent',
  'Comptez le nombre d''emprunts de chaque adhérent.',
  'Affichez le `prenom`, le `nom` de l''adhérent et le nombre d''emprunts sous l''alias `nb_emprunts`, triés par `nb_emprunts` décroissant puis par `nom`.',
  'intermediate',
  'SELECT ad.prenom, ad.nom, COUNT(*) AS nb_emprunts FROM emprunts e JOIN adherents ad ON e.adherent_id = ad.id GROUP BY ad.id, ad.prenom, ad.nom ORDER BY nb_emprunts DESC, ad.nom;',
  '{"columns":[],"rows":[]}',
  'Joins emprunts et adherents, puis GROUP BY sur l''adhérent avec COUNT(*).',
  20,
  22,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-villes-actives',
  'Villes avec beaucoup d''adhérents',
  'Trouvez les villes ayant au moins 3 adhérents.',
  'Affichez la `ville` et le nombre d''adhérents sous l''alias `nb_adherents` pour les villes ayant au moins 3 adhérents, triés par `nb_adherents` décroissant.',
  'intermediate',
  'SELECT ville, COUNT(*) AS nb_adherents FROM adherents GROUP BY ville HAVING COUNT(*) >= 3 ORDER BY nb_adherents DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise GROUP BY ville avec HAVING COUNT(*) >= 3.',
  20,
  23,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-pages-moy-auteur',
  'Pages moyennes par auteur',
  'Calculez le nombre moyen de pages des livres de chaque auteur.',
  'Affichez le `nom` de l''auteur et le nombre moyen de pages arrondi à l''entier sous l''alias `pages_moyenne`, triés par `pages_moyenne` décroissant.',
  'intermediate',
  'SELECT a.nom, ROUND(AVG(l.pages)) AS pages_moyenne FROM livres l JOIN auteurs a ON l.auteur_id = a.id GROUP BY a.nom ORDER BY pages_moyenne DESC;',
  '{"columns":[],"rows":[]}',
  'Joins livres et auteurs, puis ROUND(AVG(l.pages)) avec GROUP BY a.nom.',
  20,
  24,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-policiers',
  'Tous les policiers',
  'Affichez les livres du genre Policier avec leur auteur.',
  'Affichez le `titre`, le `prenom` et le `nom` de l''auteur des livres du genre ''Policier'' (genre_id = 3), triés par `titre`.',
  'intermediate',
  'SELECT l.titre, a.prenom, a.nom FROM livres l JOIN auteurs a ON l.auteur_id = a.id WHERE l.genre_id = 3 ORDER BY l.titre;',
  '{"columns":[],"rows":[]}',
  'Joins livres et auteurs, filtre avec WHERE genre_id = 3.',
  20,
  25,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-emprunts-rendus-retard',
  'Emprunts rendus en retard',
  'Trouvez les emprunts qui ont été rendus après la date prévue.',
  'Affichez l''`id` de l''emprunt, la `date_retour_prevue` et la `date_retour_effective` des emprunts rendus en retard (date_retour_effective > date_retour_prevue), triés par `id`.',
  'intermediate',
  'SELECT id, date_retour_prevue, date_retour_effective FROM emprunts WHERE date_retour_effective IS NOT NULL AND date_retour_effective > date_retour_prevue ORDER BY id;',
  '{"columns":[],"rows":[]}',
  'Filtre avec WHERE date_retour_effective IS NOT NULL AND date_retour_effective > date_retour_prevue.',
  20,
  26,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-empruntes',
  'Livres les plus empruntés',
  'Trouvez les livres qui ont été empruntés le plus souvent.',
  'Affichez le `titre` du livre et le nombre d''emprunts sous l''alias `nb_emprunts`, triés par `nb_emprunts` décroissant puis par `titre`. Limitez aux 5 premiers.',
  'intermediate',
  'SELECT l.titre, COUNT(*) AS nb_emprunts FROM emprunts e JOIN livres l ON e.livre_id = l.id GROUP BY l.titre ORDER BY nb_emprunts DESC, l.titre LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Joins emprunts et livres, GROUP BY l.titre, COUNT(*) et LIMIT 5.',
  20,
  27,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-auteurs-genre',
  'Auteurs et leurs genres',
  'Listez chaque auteur avec les genres de ses livres.',
  'Affichez le `nom` de l''auteur et le `nom` du genre (alias `genre`) sans doublons, triés par `nom` d''auteur puis par `genre`.',
  'intermediate',
  'SELECT DISTINCT a.nom, g.nom AS genre FROM livres l JOIN auteurs a ON l.auteur_id = a.id JOIN genres g ON l.genre_id = g.id ORDER BY a.nom, genre;',
  '{"columns":[],"rows":[]}',
  'Triple JOIN livres -> auteurs et livres -> genres, avec DISTINCT pour éviter les doublons.',
  20,
  28,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-stock-par-genre',
  'Stock total par genre',
  'Calculez le stock total de livres pour chaque genre.',
  'Affichez le `nom` du genre et la somme du `stock` sous l''alias `stock_total`, triés par `stock_total` décroissant.',
  'intermediate',
  'SELECT g.nom, SUM(l.stock) AS stock_total FROM livres l JOIN genres g ON l.genre_id = g.id GROUP BY g.nom ORDER BY stock_total DESC;',
  '{"columns":[],"rows":[]}',
  'Joins livres et genres, puis SUM(stock) avec GROUP BY g.nom.',
  20,
  29,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-non-empruntes',
  'Livres jamais empruntés',
  'Trouvez les livres qui n''ont jamais été empruntés.',
  'Affichez le `titre` et le `stock` des livres qui n''apparaissent dans aucun emprunt, triés par `titre`.',
  'intermediate',
  'SELECT l.titre, l.stock FROM livres l WHERE l.id NOT IN (SELECT DISTINCT livre_id FROM emprunts) ORDER BY l.titre;',
  '{"columns":[],"rows":[]}',
  'Utilise NOT IN avec une sous-requête SELECT DISTINCT livre_id FROM emprunts.',
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
  3,
  'bib-adherent-plus-emprunts',
  'Adhérent le plus actif',
  'Trouvez l''adhérent ayant effectué le plus d''emprunts.',
  'Affichez le `prenom`, le `nom` et le nombre d''emprunts (`nb_emprunts`) de l''adhérent ayant le plus d''emprunts.',
  'advanced',
  'SELECT ad.prenom, ad.nom, COUNT(*) AS nb_emprunts FROM emprunts e JOIN adherents ad ON e.adherent_id = ad.id GROUP BY ad.id, ad.prenom, ad.nom ORDER BY nb_emprunts DESC LIMIT 1;',
  '{"columns":[],"rows":[]}',
  'Joins emprunts et adherents, GROUP BY, ORDER BY COUNT(*) DESC LIMIT 1.',
  30,
  31,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-auteurs-emprunts',
  'Auteurs les plus empruntés',
  'Classez les auteurs par nombre total d''emprunts de leurs livres.',
  'Affichez le `prenom`, le `nom` de l''auteur et le nombre total d''emprunts de ses livres sous l''alias `total_emprunts`, triés par `total_emprunts` décroissant.',
  'advanced',
  'SELECT a.prenom, a.nom, COUNT(e.id) AS total_emprunts FROM auteurs a JOIN livres l ON a.id = l.auteur_id JOIN emprunts e ON l.id = e.livre_id GROUP BY a.id, a.prenom, a.nom ORDER BY total_emprunts DESC;',
  '{"columns":[],"rows":[]}',
  'Triple JOIN : auteurs -> livres -> emprunts, puis GROUP BY auteur et COUNT(e.id).',
  30,
  32,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-genre-emprunts',
  'Emprunts par genre',
  'Comptez le nombre d''emprunts pour chaque genre littéraire.',
  'Affichez le `nom` du genre et le nombre d''emprunts sous l''alias `nb_emprunts`, triés par `nb_emprunts` décroissant.',
  'advanced',
  'SELECT g.nom, COUNT(e.id) AS nb_emprunts FROM genres g JOIN livres l ON g.id = l.genre_id JOIN emprunts e ON l.id = e.livre_id GROUP BY g.nom ORDER BY nb_emprunts DESC;',
  '{"columns":[],"rows":[]}',
  'Triple JOIN : genres -> livres -> emprunts, GROUP BY g.nom.',
  30,
  33,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-retard-details',
  'Détails des retards',
  'Affichez les emprunts non rendus qui sont en retard.',
  'Affichez le `prenom` et le `nom` de l''adhérent, le `titre` du livre, la `date_retour_prevue` des emprunts non rendus (date_retour_effective IS NULL) dont la date_retour_prevue est antérieure à ''2026-04-04'', triés par `date_retour_prevue`.',
  'advanced',
  'SELECT ad.prenom, ad.nom, l.titre, e.date_retour_prevue FROM emprunts e JOIN adherents ad ON e.adherent_id = ad.id JOIN livres l ON e.livre_id = l.id WHERE e.date_retour_effective IS NULL AND e.date_retour_prevue < ''2026-04-04'' ORDER BY e.date_retour_prevue;',
  '{"columns":[],"rows":[]}',
  'Double JOIN avec WHERE date_retour_effective IS NULL AND date_retour_prevue < ''2026-04-04''.',
  30,
  34,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-adherents-sans-emprunt',
  'Adhérents sans emprunt',
  'Trouvez les adhérents qui n''ont jamais emprunté de livre.',
  'Affichez le `prenom`, le `nom` et la `ville` des adhérents qui n''ont aucun emprunt, triés par `nom`.',
  'advanced',
  'SELECT ad.prenom, ad.nom, ad.ville FROM adherents ad WHERE ad.id NOT IN (SELECT DISTINCT adherent_id FROM emprunts) ORDER BY ad.nom;',
  '{"columns":[],"rows":[]}',
  'Utilise NOT IN avec une sous-requête sur emprunts pour trouver les adhérents sans emprunt.',
  30,
  35,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-classification-stock',
  'Classification du stock',
  'Classifiez les livres selon leur niveau de stock.',
  'Affichez le `titre` et une colonne `niveau_stock` valant ''Critique'' si stock <= 1, ''Faible'' si stock <= 3, ''Suffisant'' si stock <= 5, et ''Abondant'' sinon, triés par `stock` puis par `titre`.',
  'advanced',
  'SELECT titre, CASE WHEN stock <= 1 THEN ''Critique'' WHEN stock <= 3 THEN ''Faible'' WHEN stock <= 5 THEN ''Suffisant'' ELSE ''Abondant'' END AS niveau_stock FROM livres ORDER BY stock, titre;',
  '{"columns":[],"rows":[]}',
  'Utilise CASE WHEN pour créer des catégories basées sur la valeur du stock.',
  30,
  36,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-emprunts-par-mois',
  'Emprunts par mois',
  'Comptez le nombre d''emprunts par mois en 2026.',
  'Affichez le mois (extraire avec `substr(date_emprunt, 6, 2)`) sous l''alias `mois` et le nombre d''emprunts sous l''alias `nb_emprunts`, pour les emprunts de 2026, triés par `mois`.',
  'advanced',
  'SELECT substr(e.date_emprunt, 6, 2) AS mois, COUNT(*) AS nb_emprunts FROM emprunts e WHERE e.date_emprunt >= ''2026-01-01'' GROUP BY mois ORDER BY mois;',
  '{"columns":[],"rows":[]}',
  'Utilise substr(date_emprunt, 6, 2) pour extraire le mois et filtre sur l''année 2026.',
  30,
  37,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-livres-multiples-emprunts',
  'Livres empruntés plusieurs fois',
  'Trouvez les livres empruntés au moins 2 fois.',
  'Affichez le `titre` du livre, le `nom` de l''auteur et le nombre d''emprunts sous l''alias `nb_emprunts`, pour les livres empruntés au moins 2 fois, triés par `nb_emprunts` décroissant puis par `titre`.',
  'advanced',
  'SELECT l.titre, a.nom, COUNT(e.id) AS nb_emprunts FROM emprunts e JOIN livres l ON e.livre_id = l.id JOIN auteurs a ON l.auteur_id = a.id GROUP BY l.id, l.titre, a.nom HAVING COUNT(e.id) >= 2 ORDER BY nb_emprunts DESC, l.titre;',
  '{"columns":[],"rows":[]}',
  'Triple JOIN avec GROUP BY et HAVING COUNT(e.id) >= 2.',
  30,
  38,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-duree-emprunt-moy',
  'Durée moyenne d''emprunt',
  'Calculez la durée moyenne d''emprunt (en jours) pour les emprunts rendus.',
  'Affichez la durée moyenne en jours (alias `duree_moyenne`) arrondie à 1 décimale, calculée avec `julianday(date_retour_effective) - julianday(date_emprunt)` pour les emprunts rendus.',
  'advanced',
  'SELECT ROUND(AVG(julianday(date_retour_effective) - julianday(date_emprunt)), 1) AS duree_moyenne FROM emprunts WHERE date_retour_effective IS NOT NULL;',
  '{"columns":[],"rows":[]}',
  'Utilise julianday() pour calculer la différence de dates et AVG() pour la moyenne.',
  30,
  39,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-nationalite-emprunts',
  'Emprunts par nationalité d''auteur',
  'Comptez les emprunts en fonction de la nationalité des auteurs.',
  'Affichez la `nationalite` de l''auteur et le nombre d''emprunts sous l''alias `nb_emprunts`, triés par `nb_emprunts` décroissant.',
  'advanced',
  'SELECT a.nationalite, COUNT(e.id) AS nb_emprunts FROM emprunts e JOIN livres l ON e.livre_id = l.id JOIN auteurs a ON l.auteur_id = a.id GROUP BY a.nationalite ORDER BY nb_emprunts DESC;',
  '{"columns":[],"rows":[]}',
  'Triple JOIN emprunts -> livres -> auteurs, GROUP BY nationalite.',
  30,
  40,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-ville-genre-prefere',
  'Genre préféré par ville',
  'Trouvez le genre le plus emprunté dans chaque ville.',
  'Affichez la `ville`, le `nom` du genre et le nombre d''emprunts (`nb_emprunts`) pour la combinaison ville/genre ayant le plus d''emprunts par ville. Triez par `ville`.',
  'advanced',
  'SELECT ad.ville, g.nom, COUNT(*) AS nb_emprunts FROM emprunts e JOIN adherents ad ON e.adherent_id = ad.id JOIN livres l ON e.livre_id = l.id JOIN genres g ON l.genre_id = g.id GROUP BY ad.ville, g.nom HAVING COUNT(*) = (SELECT MAX(cnt) FROM (SELECT ad2.ville, COUNT(*) AS cnt FROM emprunts e2 JOIN adherents ad2 ON e2.adherent_id = ad2.id JOIN livres l2 ON e2.livre_id = l2.id WHERE ad2.ville = ad.ville GROUP BY ad2.ville, l2.genre_id)) ORDER BY ad.ville;',
  '{"columns":[],"rows":[]}',
  'Sous-requête corrélée : pour chaque ville, trouve le COUNT max parmi les genres.',
  30,
  41,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-classement-abonnement',
  'Emprunts par type d''abonnement',
  'Analysez l''activité d''emprunt selon le type d''abonnement.',
  'Affichez le type d''`abonnement`, le nombre d''adhérents (`nb_adherents`), le nombre total d''emprunts (`total_emprunts`) et la moyenne d''emprunts par adhérent arrondie à 1 décimale (`moy_emprunts`), triés par `total_emprunts` décroissant.',
  'advanced',
  'SELECT ad.abonnement, COUNT(DISTINCT ad.id) AS nb_adherents, COUNT(e.id) AS total_emprunts, ROUND(1.0 * COUNT(e.id) / COUNT(DISTINCT ad.id), 1) AS moy_emprunts FROM adherents ad LEFT JOIN emprunts e ON ad.id = e.adherent_id GROUP BY ad.abonnement ORDER BY total_emprunts DESC;',
  '{"columns":[],"rows":[]}',
  'LEFT JOIN adherents et emprunts, COUNT(DISTINCT ad.id) pour les adhérents, COUNT(e.id) pour les emprunts.',
  30,
  42,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-siecle-livres',
  'Livres par siècle',
  'Regroupez les livres par siècle de publication.',
  'Affichez le siècle sous la forme ''XIXe'' pour 1800-1899, ''XXe'' pour 1900-1999, ''XXIe'' pour 2000+ (alias `siecle`), le nombre de livres (`nb_livres`) et la moyenne de pages arrondie à l''entier (`pages_moyenne`), triés par `siecle`.',
  'advanced',
  'SELECT CASE WHEN annee_publication < 1900 THEN ''XIXe'' WHEN annee_publication < 2000 THEN ''XXe'' ELSE ''XXIe'' END AS siecle, COUNT(*) AS nb_livres, ROUND(AVG(pages)) AS pages_moyenne FROM livres GROUP BY siecle ORDER BY siecle;',
  '{"columns":[],"rows":[]}',
  'Utilise CASE WHEN sur annee_publication pour créer les catégories de siècle, puis GROUP BY.',
  30,
  43,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-auteur-plus-ancien',
  'Livre le plus ancien par auteur',
  'Trouvez le livre le plus ancien de chaque auteur.',
  'Affichez le `nom` de l''auteur, le `titre` et l''`annee_publication` du livre le plus ancien de chaque auteur, triés par `annee_publication`.',
  'advanced',
  'SELECT a.nom, l.titre, l.annee_publication FROM livres l JOIN auteurs a ON l.auteur_id = a.id WHERE l.annee_publication = (SELECT MIN(l2.annee_publication) FROM livres l2 WHERE l2.auteur_id = l.auteur_id) ORDER BY l.annee_publication;',
  '{"columns":[],"rows":[]}',
  'Sous-requête corrélée : WHERE annee_publication = (SELECT MIN(annee_publication) FROM livres WHERE auteur_id = ...).',
  30,
  44,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-adherent-diversite',
  'Diversité de lecture',
  'Trouvez les adhérents ayant emprunté des livres de genres différents.',
  'Affichez le `prenom`, le `nom` de l''adhérent et le nombre de genres différents empruntés sous l''alias `nb_genres`, pour les adhérents ayant emprunté au moins 2 genres différents, triés par `nb_genres` décroissant puis par `nom`.',
  'advanced',
  'SELECT ad.prenom, ad.nom, COUNT(DISTINCT l.genre_id) AS nb_genres FROM emprunts e JOIN adherents ad ON e.adherent_id = ad.id JOIN livres l ON e.livre_id = l.id GROUP BY ad.id, ad.prenom, ad.nom HAVING COUNT(DISTINCT l.genre_id) >= 2 ORDER BY nb_genres DESC, ad.nom;',
  '{"columns":[],"rows":[]}',
  'COUNT(DISTINCT l.genre_id) après des JOINs emprunts -> adherents et emprunts -> livres, avec HAVING >= 2.',
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
  3,
  'bib-rang-emprunteurs',
  'Classement des emprunteurs',
  'Classez les adhérents par nombre d''emprunts avec leur rang.',
  'Affichez le `prenom`, le `nom`, le nombre d''emprunts (`nb_emprunts`) et le rang de chaque adhérent emprunteur (alias `rang`, basé sur l''ordre décroissant de nb_emprunts en utilisant une sous-requête comptant les adhérents ayant plus d''emprunts + 1). Triez par `rang` puis par `nom`.',
  'advanced',
  'SELECT ad.prenom, ad.nom, COUNT(e.id) AS nb_emprunts, (SELECT COUNT(DISTINCT e3.adherent_id) FROM emprunts e3 GROUP BY e3.adherent_id HAVING COUNT(e3.id) > COUNT(e.id)) + 1 AS rang FROM emprunts e JOIN adherents ad ON e.adherent_id = ad.id GROUP BY ad.id, ad.prenom, ad.nom ORDER BY nb_emprunts DESC, ad.nom;',
  '{"columns":[],"rows":[]}',
  'Simule un rang avec une sous-requête corrélée qui compte les adhérents ayant strictement plus d''emprunts.',
  40,
  46,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-analyse-complete-auteur',
  'Analyse complète par auteur',
  'Créez un rapport complet pour chaque auteur.',
  'Affichez le `nom` de l''auteur, le nombre de livres (`nb_livres`), le total de pages (`total_pages`), le stock total (`stock_total`), le nombre d''emprunts de ses livres (`nb_emprunts`), triés par `nb_emprunts` décroissant puis par `nom`.',
  'advanced',
  'SELECT a.nom, COUNT(DISTINCT l.id) AS nb_livres, SUM(DISTINCT l.pages) AS total_pages, SUM(DISTINCT l.stock) AS stock_total, COUNT(e.id) AS nb_emprunts FROM auteurs a JOIN livres l ON a.id = l.auteur_id LEFT JOIN emprunts e ON l.id = e.livre_id GROUP BY a.id, a.nom ORDER BY nb_emprunts DESC, a.nom;',
  '{"columns":[],"rows":[]}',
  'JOIN auteurs -> livres, LEFT JOIN emprunts. Utilise COUNT(DISTINCT l.id) pour les livres et COUNT(e.id) pour les emprunts.',
  40,
  47,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-taux-retour-genre',
  'Taux de retour par genre',
  'Calculez le taux de retour et le taux de retard pour chaque genre.',
  'Affichez le `nom` du genre, le total d''emprunts (`total_emprunts`), le nombre d''emprunts rendus (`rendus`), le nombre de retards parmi les rendus (`retards`, où date_retour_effective > date_retour_prevue), et le pourcentage de retour arrondi à 1 décimale (`pct_retour` = rendus * 100.0 / total). Triez par `total_emprunts` décroissant.',
  'advanced',
  'SELECT g.nom, COUNT(e.id) AS total_emprunts, SUM(CASE WHEN e.date_retour_effective IS NOT NULL THEN 1 ELSE 0 END) AS rendus, SUM(CASE WHEN e.date_retour_effective IS NOT NULL AND e.date_retour_effective > e.date_retour_prevue THEN 1 ELSE 0 END) AS retards, ROUND(SUM(CASE WHEN e.date_retour_effective IS NOT NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(e.id), 1) AS pct_retour FROM genres g JOIN livres l ON g.id = l.genre_id JOIN emprunts e ON l.id = e.livre_id GROUP BY g.nom ORDER BY total_emprunts DESC;',
  '{"columns":[],"rows":[]}',
  'Utilise SUM(CASE WHEN ... THEN 1 ELSE 0 END) pour compter conditionnellement les rendus et les retards.',
  40,
  48,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-profil-ville',
  'Profil de lecture par ville',
  'Analysez les habitudes de lecture par ville.',
  'Affichez la `ville`, le nombre d''adhérents (`nb_adherents`), le nombre total d''emprunts (`total_emprunts`), le nombre de genres différents empruntés (`nb_genres_differents`) et le nombre de livres actuellement non rendus (`en_cours`), triés par `total_emprunts` décroissant.',
  'advanced',
  'SELECT ad.ville, COUNT(DISTINCT ad.id) AS nb_adherents, COUNT(e.id) AS total_emprunts, COUNT(DISTINCT l.genre_id) AS nb_genres_differents, SUM(CASE WHEN e.date_retour_effective IS NULL THEN 1 ELSE 0 END) AS en_cours FROM adherents ad LEFT JOIN emprunts e ON ad.id = e.adherent_id LEFT JOIN livres l ON e.livre_id = l.id GROUP BY ad.ville ORDER BY total_emprunts DESC;',
  '{"columns":[],"rows":[]}',
  'LEFT JOIN adherents -> emprunts -> livres, puis agrégations multiples avec COUNT(DISTINCT) et SUM(CASE WHEN).',
  40,
  49,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  3,
  'bib-recommandation',
  'Recommandation de livres',
  'Trouvez les livres populaires non encore empruntés par un adhérent donné.',
  'Pour l''adhérent id=1 (Marie Dupont), affichez le `titre` des livres qu''elle n''a jamais empruntés mais qui ont été empruntés au moins 2 fois par d''autres adhérents. Triez par nombre d''emprunts décroissant puis par `titre`. Affichez le `titre` et le `nb_emprunts`.',
  'advanced',
  'SELECT l.titre, COUNT(e.id) AS nb_emprunts FROM livres l JOIN emprunts e ON l.id = e.livre_id WHERE l.id NOT IN (SELECT livre_id FROM emprunts WHERE adherent_id = 1) GROUP BY l.id, l.titre HAVING COUNT(e.id) >= 2 ORDER BY nb_emprunts DESC, l.titre;',
  '{"columns":[],"rows":[]}',
  'Sous-requête NOT IN pour exclure les livres déjà empruntés par l''adhérent 1, puis HAVING COUNT >= 2 pour les livres populaires.',
  40,
  50,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

COMMIT;
