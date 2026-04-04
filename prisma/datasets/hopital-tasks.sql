-- ============================================================================
-- SQL Clinic Tasks - Hopital Dataset (dataset_id = 5)
-- 50 exercises: 15 beginner, 15 intermediate, 15 advanced, 5 expert
-- expected_result is kept empty — validation uses expected_sql execution
-- ============================================================================

BEGIN;

-- Dataset registration
INSERT INTO sql_clinic_datasets (slug, name, description, db_type, is_active, created_at, updated_at)
VALUES ('hopital', 'Hôpital Saint-Louis', 'Base de données d''un hôpital avec médecins, patients, consultations et prescriptions.', 'sqlite', true, NOW(), NOW())
ON CONFLICT (slug) DO NOTHING;

-- ==================== BEGINNER (1-15) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-tous-services',
  'Liste des services',
  'Affichez tous les services de l''hôpital.',
  'Écrivez une requête qui affiche toutes les colonnes de la table `services`, triées par `id` croissant.',
  'beginner',
  'SELECT * FROM services ORDER BY id;',
  '{"columns":[],"rows":[]}',
  'Utilisez SELECT * pour sélectionner toutes les colonnes et ORDER BY pour trier.',
  10, 1, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-liste-medecins',
  'Annuaire des médecins',
  'Affichez le nom et prénom de tous les médecins.',
  'Sélectionnez le nom, le prénom et la spécialité de tous les médecins, triés par nom puis par prénom.',
  'beginner',
  'SELECT nom, prenom, specialite FROM medecins ORDER BY nom, prenom;',
  '{"columns":[],"rows":[]}',
  'Utilisez SELECT avec les colonnes nom, prenom, specialite et ORDER BY nom, prenom.',
  10, 2, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-patients-paris',
  'Patients parisiens',
  'Trouvez les patients habitant à Paris.',
  'Affichez le nom, le prénom et le téléphone des patients qui habitent à Paris, triés par nom.',
  'beginner',
  'SELECT nom, prenom, telephone FROM patients WHERE ville = ''Paris'' ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Utilisez WHERE ville = ''Paris'' pour filtrer les patients parisiens.',
  10, 3, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecins-salaires',
  'Médecins bien rémunérés',
  'Trouvez les médecins dont le salaire dépasse 8000€.',
  'Affichez le nom, le prénom et le salaire des médecins gagnant plus de 8000€ par mois, triés par salaire décroissant.',
  'beginner',
  'SELECT nom, prenom, salaire FROM medecins WHERE salaire > 8000 ORDER BY salaire DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez WHERE salaire > 8000 et ORDER BY salaire DESC pour le tri décroissant.',
  10, 4, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medicaments-libre',
  'Médicaments sans ordonnance',
  'Trouvez les médicaments disponibles sans ordonnance.',
  'Affichez le nom, la catégorie et le prix des médicaments ne nécessitant pas d''ordonnance (`ordonnance_requise = 0`), triés par nom.',
  'beginner',
  'SELECT nom, categorie, prix FROM medicaments WHERE ordonnance_requise = 0 ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Filtrez avec WHERE ordonnance_requise = 0 pour les médicaments en vente libre.',
  10, 5, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-patients-femmes',
  'Patientes de l''hôpital',
  'Comptez le nombre de patientes (sexe féminin).',
  'Affichez le nombre total de patients de sexe féminin (`sexe = ''F''`).',
  'beginner',
  'SELECT COUNT(*) AS nombre_patientes FROM patients WHERE sexe = ''F'';',
  '{"columns":[],"rows":[]}',
  'Utilisez COUNT(*) avec WHERE sexe = ''F''.',
  10, 6, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-consultations-octobre',
  'Consultations d''octobre',
  'Trouvez les consultations du mois d''octobre 2024.',
  'Affichez l''id, le patient_id, le medecin_id, la date_consultation et le motif des consultations entre le 1er et le 31 octobre 2024, triés par date.',
  'beginner',
  'SELECT id, patient_id, medecin_id, date_consultation, motif FROM consultations WHERE date_consultation BETWEEN ''2024-10-01'' AND ''2024-10-31'' ORDER BY date_consultation;',
  '{"columns":[],"rows":[]}',
  'Utilisez BETWEEN ''2024-10-01'' AND ''2024-10-31'' pour filtrer les dates.',
  10, 7, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-sans-telephone',
  'Patients sans téléphone',
  'Trouvez les patients dont le numéro de téléphone n''est pas renseigné.',
  'Affichez le nom, le prénom et la ville des patients dont le téléphone est NULL, triés par nom.',
  'beginner',
  'SELECT nom, prenom, ville FROM patients WHERE telephone IS NULL ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Utilisez IS NULL pour trouver les valeurs manquantes.',
  10, 8, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-consult-cheres',
  'Consultations coûteuses',
  'Trouvez les consultations dont le prix dépasse 70€.',
  'Affichez l''id, le motif, le diagnostic et le prix des consultations coûtant plus de 70€, triées par prix décroissant.',
  'beginner',
  'SELECT id, motif, diagnostic, prix FROM consultations WHERE prix > 70 ORDER BY prix DESC;',
  '{"columns":[],"rows":[]}',
  'Filtrez avec WHERE prix > 70 et triez par prix décroissant.',
  10, 9, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medoc-stock-bas',
  'Stock faible de médicaments',
  'Identifiez les médicaments avec un stock inférieur à 100.',
  'Affichez le nom, la catégorie et le stock des médicaments dont le stock est inférieur à 100 unités, triés par stock croissant.',
  'beginner',
  'SELECT nom, categorie, stock FROM medicaments WHERE stock < 100 ORDER BY stock;',
  '{"columns":[],"rows":[]}',
  'Utilisez WHERE stock < 100 et ORDER BY stock pour trier du plus petit au plus grand.',
  10, 10, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-patients-groupe-a',
  'Patients du groupe A',
  'Trouvez les patients dont le groupe sanguin commence par A.',
  'Affichez le nom, le prénom et le groupe sanguin des patients dont le groupe sanguin commence par ''A'', triés par nom.',
  'beginner',
  'SELECT nom, prenom, groupe_sanguin FROM patients WHERE groupe_sanguin LIKE ''A%'' ORDER BY nom;',
  '{"columns":[],"rows":[]}',
  'Utilisez LIKE ''A%'' pour trouver les groupes sanguins commençant par A.',
  10, 11, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-consult-sans-diag',
  'Consultations sans diagnostic',
  'Trouvez les consultations où le diagnostic n''a pas été posé.',
  'Affichez l''id, la date_consultation et le motif des consultations dont le diagnostic est NULL, triées par date.',
  'beginner',
  'SELECT id, date_consultation, motif FROM consultations WHERE diagnostic IS NULL ORDER BY date_consultation;',
  '{"columns":[],"rows":[]}',
  'Utilisez WHERE diagnostic IS NULL pour trouver les consultations sans diagnostic.',
  10, 12, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecins-recents',
  'Médecins récemment embauchés',
  'Trouvez les médecins embauchés après 2020.',
  'Affichez le nom, le prénom, la spécialité et la date d''embauche des médecins embauchés à partir de 2021, triés par date d''embauche.',
  'beginner',
  'SELECT nom, prenom, specialite, date_embauche FROM medecins WHERE date_embauche >= ''2021-01-01'' ORDER BY date_embauche;',
  '{"columns":[],"rows":[]}',
  'Filtrez avec WHERE date_embauche >= ''2021-01-01''.',
  10, 13, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-top5-consult-longues',
  'Consultations les plus longues',
  'Trouvez les 5 consultations les plus longues.',
  'Affichez l''id, le motif, le diagnostic et la durée en minutes des 5 consultations les plus longues, triées par durée décroissante.',
  'beginner',
  'SELECT id, motif, diagnostic, duree_minutes FROM consultations ORDER BY duree_minutes DESC LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Utilisez ORDER BY duree_minutes DESC LIMIT 5 pour les 5 plus longues.',
  10, 14, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-sans-mutuelle',
  'Patients sans mutuelle',
  'Trouvez les patients qui n''ont pas de mutuelle.',
  'Affichez le nom, le prénom et la ville des patients dont la mutuelle est NULL, triés par ville puis par nom.',
  'beginner',
  'SELECT nom, prenom, ville FROM patients WHERE mutuelle IS NULL ORDER BY ville, nom;',
  '{"columns":[],"rows":[]}',
  'Utilisez WHERE mutuelle IS NULL pour filtrer les patients sans mutuelle.',
  10, 15, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== INTERMEDIATE (16-30) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecins-par-service',
  'Médecins par service',
  'Comptez le nombre de médecins dans chaque service.',
  'Affichez le nom du service et le nombre de médecins qu''il contient. Triez par nombre de médecins décroissant puis par nom de service.',
  'intermediate',
  'SELECT s.nom AS service, COUNT(*) AS nb_medecins FROM medecins m JOIN services s ON m.service_id = s.id GROUP BY s.nom ORDER BY nb_medecins DESC, s.nom;',
  '{"columns":[],"rows":[]}',
  'Joignez les tables medecins et services, puis utilisez GROUP BY et COUNT.',
  20, 16, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-patients-par-ville',
  'Patients par ville',
  'Comptez le nombre de patients par ville.',
  'Affichez chaque ville et le nombre de patients qui y habitent. Triez par nombre de patients décroissant puis par ville.',
  'intermediate',
  'SELECT ville, COUNT(*) AS nb_patients FROM patients GROUP BY ville ORDER BY nb_patients DESC, ville;',
  '{"columns":[],"rows":[]}',
  'Utilisez GROUP BY ville avec COUNT(*) pour compter par ville.',
  20, 17, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-consult-avec-medecin',
  'Détails des consultations',
  'Affichez les consultations avec le nom du médecin.',
  'Affichez la date de consultation, le motif, le nom et le prénom du médecin pour chaque consultation, triés par date de consultation.',
  'intermediate',
  'SELECT c.date_consultation, c.motif, m.nom, m.prenom FROM consultations c JOIN medecins m ON c.medecin_id = m.id ORDER BY c.date_consultation;',
  '{"columns":[],"rows":[]}',
  'Faites un JOIN entre consultations et medecins sur medecin_id = id.',
  20, 18, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-ca-par-medecin',
  'Chiffre d''affaires par médecin',
  'Calculez le total des consultations par médecin.',
  'Affichez le nom, le prénom du médecin et le total de ses consultations (somme des prix). Triez par total décroissant.',
  'intermediate',
  'SELECT m.nom, m.prenom, SUM(c.prix) AS total_ca FROM consultations c JOIN medecins m ON c.medecin_id = m.id GROUP BY m.id, m.nom, m.prenom ORDER BY total_ca DESC;',
  '{"columns":[],"rows":[]}',
  'Joignez consultations et medecins, puis utilisez SUM(prix) avec GROUP BY.',
  20, 19, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-salaire-moyen-service',
  'Salaire moyen par service',
  'Calculez le salaire moyen des médecins par service.',
  'Affichez le nom du service et le salaire moyen de ses médecins, arrondi à 2 décimales. Triez par salaire moyen décroissant.',
  'intermediate',
  'SELECT s.nom AS service, ROUND(AVG(m.salaire), 2) AS salaire_moyen FROM medecins m JOIN services s ON m.service_id = s.id GROUP BY s.nom ORDER BY salaire_moyen DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez AVG(salaire) avec ROUND(..., 2) et GROUP BY sur le nom du service.',
  20, 20, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-nb-consult-par-patient',
  'Nombre de consultations par patient',
  'Comptez les consultations de chaque patient.',
  'Affichez le nom, le prénom du patient et le nombre de ses consultations. Ne gardez que les patients ayant eu au moins 2 consultations. Triez par nombre de consultations décroissant.',
  'intermediate',
  'SELECT p.nom, p.prenom, COUNT(*) AS nb_consultations FROM consultations c JOIN patients p ON c.patient_id = p.id GROUP BY p.id, p.nom, p.prenom HAVING COUNT(*) >= 2 ORDER BY nb_consultations DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez HAVING COUNT(*) >= 2 après le GROUP BY pour filtrer.',
  20, 21, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medoc-par-categorie',
  'Médicaments par catégorie',
  'Comptez les médicaments par catégorie.',
  'Affichez chaque catégorie de médicament avec le nombre de médicaments et le prix moyen arrondi à 2 décimales. Triez par nombre de médicaments décroissant.',
  'intermediate',
  'SELECT categorie, COUNT(*) AS nb_medicaments, ROUND(AVG(prix), 2) AS prix_moyen FROM medicaments GROUP BY categorie ORDER BY nb_medicaments DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez GROUP BY categorie avec COUNT et AVG.',
  20, 22, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-groupes-sanguins',
  'Répartition des groupes sanguins',
  'Analysez la répartition des groupes sanguins.',
  'Affichez chaque groupe sanguin et le nombre de patients correspondant. Triez par nombre décroissant.',
  'intermediate',
  'SELECT groupe_sanguin, COUNT(*) AS nb_patients FROM patients GROUP BY groupe_sanguin ORDER BY nb_patients DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez GROUP BY groupe_sanguin avec COUNT(*).',
  20, 23, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-prescriptions-medoc',
  'Médicaments les plus prescrits',
  'Trouvez les médicaments les plus prescrits.',
  'Affichez le nom du médicament et le nombre de fois qu''il a été prescrit. Triez par nombre de prescriptions décroissant puis par nom.',
  'intermediate',
  'SELECT med.nom, COUNT(*) AS nb_prescriptions FROM prescriptions p JOIN medicaments med ON p.medicament_id = med.id GROUP BY med.nom ORDER BY nb_prescriptions DESC, med.nom;',
  '{"columns":[],"rows":[]}',
  'Joignez prescriptions et medicaments, puis utilisez GROUP BY et COUNT.',
  20, 24, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-duree-moy-service',
  'Durée moyenne par service',
  'Calculez la durée moyenne des consultations par service.',
  'Affichez le nom du service et la durée moyenne des consultations (en minutes, arrondie à 1 décimale) de ses médecins. Triez par durée moyenne décroissante.',
  'intermediate',
  'SELECT s.nom AS service, ROUND(AVG(c.duree_minutes), 1) AS duree_moyenne FROM consultations c JOIN medecins m ON c.medecin_id = m.id JOIN services s ON m.service_id = s.id GROUP BY s.nom ORDER BY duree_moyenne DESC;',
  '{"columns":[],"rows":[]}',
  'Faites un double JOIN : consultations -> medecins -> services.',
  20, 25, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-mutuelles-populaires',
  'Mutuelles populaires',
  'Trouvez les mutuelles ayant au moins 3 adhérents.',
  'Affichez les mutuelles ayant au moins 3 patients adhérents, avec le nombre de patients. Ignorez les patients sans mutuelle. Triez par nombre décroissant.',
  'intermediate',
  'SELECT mutuelle, COUNT(*) AS nb_patients FROM patients WHERE mutuelle IS NOT NULL GROUP BY mutuelle HAVING COUNT(*) >= 3 ORDER BY nb_patients DESC;',
  '{"columns":[],"rows":[]}',
  'Filtrez d''abord les NULL avec WHERE, puis utilisez HAVING après GROUP BY.',
  20, 26, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-consult-patient-complet',
  'Fiche consultation complète',
  'Affichez les consultations avec les noms du patient et du médecin.',
  'Affichez la date de consultation, le nom et prénom du patient, le nom et prénom du médecin, et le motif. Triez par date.',
  'intermediate',
  'SELECT c.date_consultation, p.nom AS patient_nom, p.prenom AS patient_prenom, m.nom AS medecin_nom, m.prenom AS medecin_prenom, c.motif FROM consultations c JOIN patients p ON c.patient_id = p.id JOIN medecins m ON c.medecin_id = m.id ORDER BY c.date_consultation;',
  '{"columns":[],"rows":[]}',
  'Faites deux JOIN : un vers patients et un vers medecins. Utilisez des alias pour distinguer les noms.',
  20, 27, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecin-max-salaire',
  'Médecin le mieux payé par service',
  'Trouvez le salaire maximum dans chaque service.',
  'Affichez le nom du service et le salaire le plus élevé parmi ses médecins. Triez par salaire décroissant.',
  'intermediate',
  'SELECT s.nom AS service, MAX(m.salaire) AS salaire_max FROM medecins m JOIN services s ON m.service_id = s.id GROUP BY s.nom ORDER BY salaire_max DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez MAX(salaire) avec GROUP BY sur le service.',
  20, 28, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-prix-moyen-consult',
  'Prix moyen des consultations',
  'Calculez le prix moyen des consultations par mois.',
  'Affichez le mois (format YYYY-MM) et le prix moyen des consultations arrondi à 2 décimales, pour chaque mois. Triez par mois.',
  'intermediate',
  'SELECT SUBSTR(date_consultation, 1, 7) AS mois, ROUND(AVG(prix), 2) AS prix_moyen FROM consultations GROUP BY SUBSTR(date_consultation, 1, 7) ORDER BY mois;',
  '{"columns":[],"rows":[]}',
  'Utilisez SUBSTR(date_consultation, 1, 7) pour extraire le mois au format YYYY-MM.',
  20, 29, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecins-urgences',
  'Équipe des urgences et leurs consultations',
  'Listez les médecins des urgences avec leur nombre de consultations.',
  'Affichez le nom, le prénom et le nombre de consultations des médecins du service Urgences (service_id = 3). Triez par nombre de consultations décroissant.',
  'intermediate',
  'SELECT m.nom, m.prenom, COUNT(c.id) AS nb_consultations FROM medecins m LEFT JOIN consultations c ON m.id = c.medecin_id WHERE m.service_id = 3 GROUP BY m.id, m.nom, m.prenom ORDER BY nb_consultations DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez LEFT JOIN pour inclure les médecins même sans consultation, avec WHERE sur le service_id.',
  20, 30, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== ADVANCED (31-45) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-patients-sans-consult',
  'Patients jamais consultés',
  'Trouvez les patients qui n''ont jamais eu de consultation.',
  'Affichez le nom, le prénom et la ville des patients qui n''apparaissent dans aucune consultation. Triez par nom.',
  'advanced',
  'SELECT p.nom, p.prenom, p.ville FROM patients p WHERE p.id NOT IN (SELECT DISTINCT patient_id FROM consultations) ORDER BY p.nom;',
  '{"columns":[],"rows":[]}',
  'Utilisez une sous-requête avec NOT IN pour exclure les patients ayant des consultations.',
  30, 31, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medoc-jamais-prescrit',
  'Médicaments jamais prescrits',
  'Trouvez les médicaments qui n''ont jamais été prescrits.',
  'Affichez le nom, la catégorie et le stock des médicaments qui n''apparaissent dans aucune prescription. Triez par nom.',
  'advanced',
  'SELECT m.nom, m.categorie, m.stock FROM medicaments m WHERE m.id NOT IN (SELECT DISTINCT medicament_id FROM prescriptions) ORDER BY m.nom;',
  '{"columns":[],"rows":[]}',
  'Utilisez NOT IN avec une sous-requête sur la table prescriptions.',
  30, 32, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-cout-total-prescriptions',
  'Coût total des prescriptions par consultation',
  'Calculez le coût médicamenteux de chaque consultation.',
  'Affichez l''id de la consultation, le motif, et le coût total des médicaments prescrits (somme de prix du médicament * durée en jours). Triez par coût décroissant. Limitez aux 10 premiers.',
  'advanced',
  'SELECT c.id, c.motif, SUM(med.prix * pr.duree_jours) AS cout_medicaments FROM consultations c JOIN prescriptions pr ON c.id = pr.consultation_id JOIN medicaments med ON pr.medicament_id = med.id GROUP BY c.id, c.motif ORDER BY cout_medicaments DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'Joignez consultations, prescriptions et medicaments. Multipliez prix par duree_jours.',
  30, 33, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecin-plus-consulte',
  'Médecin le plus consulté',
  'Trouvez le médecin ayant réalisé le plus de consultations.',
  'Affichez le nom, le prénom, la spécialité et le nombre de consultations du médecin ayant effectué le plus grand nombre de consultations.',
  'advanced',
  'SELECT m.nom, m.prenom, m.specialite, COUNT(*) AS nb_consultations FROM consultations c JOIN medecins m ON c.medecin_id = m.id GROUP BY m.id, m.nom, m.prenom, m.specialite ORDER BY nb_consultations DESC LIMIT 1;',
  '{"columns":[],"rows":[]}',
  'Utilisez GROUP BY avec COUNT, ORDER BY DESC et LIMIT 1 pour le maximum.',
  30, 34, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-patients-multi-services',
  'Patients vus par plusieurs services',
  'Trouvez les patients ayant consulté dans au moins 2 services différents.',
  'Affichez le nom, le prénom du patient et le nombre de services différents où il a été vu. Triez par nombre de services décroissant puis par nom.',
  'advanced',
  'SELECT p.nom, p.prenom, COUNT(DISTINCT m.service_id) AS nb_services FROM consultations c JOIN patients p ON c.patient_id = p.id JOIN medecins m ON c.medecin_id = m.id GROUP BY p.id, p.nom, p.prenom HAVING COUNT(DISTINCT m.service_id) >= 2 ORDER BY nb_services DESC, p.nom;',
  '{"columns":[],"rows":[]}',
  'Utilisez COUNT(DISTINCT m.service_id) avec HAVING >= 2 en joignant consultations, patients et medecins.',
  30, 35, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-tranche-age',
  'Répartition par tranche d''âge',
  'Classez les patients par tranche d''âge.',
  'Utilisez CASE WHEN pour classer les patients en tranches d''âge basées sur l''année de naissance : ''Enfant'' (né après 2006), ''Adulte'' (né entre 1976 et 2006), ''Senior'' (né avant 1976). Affichez la tranche et le nombre de patients. Triez par nombre décroissant.',
  'advanced',
  'SELECT CASE WHEN date_naissance > ''2006-12-31'' THEN ''Enfant'' WHEN date_naissance >= ''1976-01-01'' THEN ''Adulte'' ELSE ''Senior'' END AS tranche_age, COUNT(*) AS nb_patients FROM patients GROUP BY tranche_age ORDER BY nb_patients DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez CASE WHEN sur date_naissance pour créer les tranches, puis GROUP BY sur l''alias.',
  30, 36, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecin-au-dessus-moy',
  'Médecins au-dessus de la moyenne',
  'Trouvez les médecins dont le salaire dépasse la moyenne.',
  'Affichez le nom, le prénom, le salaire et la spécialité des médecins dont le salaire est supérieur au salaire moyen de tous les médecins. Triez par salaire décroissant.',
  'advanced',
  'SELECT nom, prenom, salaire, specialite FROM medecins WHERE salaire > (SELECT AVG(salaire) FROM medecins) ORDER BY salaire DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez une sous-requête (SELECT AVG(salaire) FROM medecins) dans la clause WHERE.',
  30, 37, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-ca-par-service',
  'Chiffre d''affaires par service',
  'Calculez le CA total des consultations par service.',
  'Affichez le nom du service, le nombre de consultations et le chiffre d''affaires total (somme des prix). Triez par CA décroissant.',
  'advanced',
  'SELECT s.nom AS service, COUNT(c.id) AS nb_consultations, SUM(c.prix) AS ca_total FROM consultations c JOIN medecins m ON c.medecin_id = m.id JOIN services s ON m.service_id = s.id GROUP BY s.nom ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  'Enchaînez les JOIN : consultations -> medecins -> services, puis GROUP BY et SUM.',
  30, 38, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-prescription-complete',
  'Ordonnance détaillée',
  'Affichez le détail complet d''une prescription.',
  'Pour chaque prescription, affichez le nom du patient, le nom du médecin, la date de consultation, le nom du médicament, la posologie et la durée en jours. Triez par date de consultation puis par nom du patient.',
  'advanced',
  'SELECT p.nom AS patient, m.nom AS medecin, c.date_consultation, med.nom AS medicament, pr.posologie, pr.duree_jours FROM prescriptions pr JOIN consultations c ON pr.consultation_id = c.id JOIN patients p ON c.patient_id = p.id JOIN medecins m ON c.medecin_id = m.id JOIN medicaments med ON pr.medicament_id = med.id ORDER BY c.date_consultation, p.nom;',
  '{"columns":[],"rows":[]}',
  'Enchaînez 4 JOIN : prescriptions -> consultations -> patients, consultations -> medecins, prescriptions -> medicaments.',
  30, 39, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-categorie-prix-consult',
  'Catégorie de prix des consultations',
  'Classez les consultations par gamme de prix.',
  'Utilisez CASE WHEN pour classer les consultations : ''Économique'' (prix <= 40), ''Standard'' (prix entre 41 et 65), ''Premium'' (prix > 65). Affichez la catégorie et le nombre de consultations. Triez par nombre décroissant.',
  'advanced',
  'SELECT CASE WHEN prix <= 40 THEN ''Économique'' WHEN prix <= 65 THEN ''Standard'' ELSE ''Premium'' END AS categorie_prix, COUNT(*) AS nb_consultations FROM consultations GROUP BY categorie_prix ORDER BY nb_consultations DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez CASE WHEN pour créer des catégories sur le prix, puis GROUP BY.',
  30, 40, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecin-anciennete',
  'Ancienneté des médecins',
  'Classez les médecins par ancienneté.',
  'Affichez le nom, le prénom, la date d''embauche et le nombre d''années d''ancienneté (différence entre 2024 et l''année d''embauche) de chaque médecin. Triez par ancienneté décroissante.',
  'advanced',
  'SELECT nom, prenom, date_embauche, (2024 - CAST(SUBSTR(date_embauche, 1, 4) AS INTEGER)) AS anciennete_annees FROM medecins ORDER BY anciennete_annees DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez SUBSTR pour extraire l''année et CAST pour la convertir en entier.',
  30, 41, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-services-ca-eleve',
  'Services à fort chiffre d''affaires',
  'Trouvez les services dont le CA moyen par consultation dépasse 60€.',
  'Affichez le nom du service et le prix moyen par consultation arrondi à 2 décimales, uniquement pour les services dont la moyenne dépasse 60€. Triez par prix moyen décroissant.',
  'advanced',
  'SELECT s.nom AS service, ROUND(AVG(c.prix), 2) AS prix_moyen FROM consultations c JOIN medecins m ON c.medecin_id = m.id JOIN services s ON m.service_id = s.id GROUP BY s.nom HAVING AVG(c.prix) > 60 ORDER BY prix_moyen DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez HAVING AVG(c.prix) > 60 après le GROUP BY pour filtrer les services.',
  30, 42, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-top-depensiers',
  'Patients les plus dépensiers',
  'Trouvez les 5 patients ayant dépensé le plus en consultations.',
  'Affichez le nom, le prénom, le nombre de consultations et le total dépensé par les 5 patients ayant le plus gros montant cumulé. Triez par total décroissant.',
  'advanced',
  'SELECT p.nom, p.prenom, COUNT(*) AS nb_consultations, SUM(c.prix) AS total_depense FROM consultations c JOIN patients p ON c.patient_id = p.id GROUP BY p.id, p.nom, p.prenom ORDER BY total_depense DESC LIMIT 5;',
  '{"columns":[],"rows":[]}',
  'Joignez consultations et patients, utilisez SUM(prix) avec GROUP BY et LIMIT 5.',
  30, 43, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-antibiotiques-prescrits',
  'Prescriptions d''antibiotiques',
  'Analysez les prescriptions d''antibiotiques.',
  'Affichez le nom du patient, le nom du médecin, le nom du médicament et la durée de traitement pour toutes les prescriptions de médicaments de catégorie ''Antibiotique''. Triez par durée décroissante.',
  'advanced',
  'SELECT p.nom AS patient, doc.nom AS medecin, med.nom AS medicament, pr.duree_jours FROM prescriptions pr JOIN consultations c ON pr.consultation_id = c.id JOIN patients p ON c.patient_id = p.id JOIN medecins doc ON c.medecin_id = doc.id JOIN medicaments med ON pr.medicament_id = med.id WHERE med.categorie = ''Antibiotique'' ORDER BY pr.duree_jours DESC;',
  '{"columns":[],"rows":[]}',
  'Filtrez avec WHERE med.categorie = ''Antibiotique'' après avoir joint toutes les tables nécessaires.',
  30, 44, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-medecin-sous-moyenne-service',
  'Médecins sous la moyenne de leur service',
  'Trouvez les médecins gagnant moins que la moyenne de leur service.',
  'Affichez le nom, le prénom, le salaire du médecin et le nom de son service, uniquement pour ceux dont le salaire est inférieur à la moyenne de leur service. Triez par nom de service puis par salaire.',
  'advanced',
  'SELECT m.nom, m.prenom, m.salaire, s.nom AS service FROM medecins m JOIN services s ON m.service_id = s.id WHERE m.salaire < (SELECT AVG(m2.salaire) FROM medecins m2 WHERE m2.service_id = m.service_id) ORDER BY s.nom, m.salaire;',
  '{"columns":[],"rows":[]}',
  'Utilisez une sous-requête corrélée qui calcule la moyenne du service de chaque médecin.',
  30, 45, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ==================== EXPERT (46-50) ====================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-analyse-complete-service',
  'Tableau de bord par service',
  'Créez un tableau de bord complet pour chaque service.',
  'Pour chaque service, affichez : le nom du service, le nombre de médecins, le nombre total de consultations, le CA total (somme des prix des consultations), et le prix moyen par consultation arrondi à 2 décimales. Triez par CA total décroissant.',
  'advanced',
  'SELECT s.nom AS service, COUNT(DISTINCT m.id) AS nb_medecins, COUNT(c.id) AS nb_consultations, SUM(c.prix) AS ca_total, ROUND(AVG(c.prix), 2) AS prix_moyen FROM services s LEFT JOIN medecins m ON s.id = m.service_id LEFT JOIN consultations c ON m.id = c.medecin_id GROUP BY s.id, s.nom ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez LEFT JOIN pour inclure tous les services, COUNT(DISTINCT m.id) pour les médecins uniques.',
  40, 46, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-patient-profil-complet',
  'Profil patient enrichi',
  'Créez un profil enrichi pour chaque patient ayant consulté.',
  'Pour chaque patient ayant eu au moins une consultation, affichez : nom, prénom, ville, nombre de consultations, total dépensé, nombre de prescriptions reçues, et le nombre de médecins différents consultés. Triez par total dépensé décroissant. Limitez aux 10 premiers.',
  'advanced',
  'SELECT p.nom, p.prenom, p.ville, COUNT(DISTINCT c.id) AS nb_consultations, SUM(c.prix) AS total_depense, COUNT(DISTINCT pr.id) AS nb_prescriptions, COUNT(DISTINCT c.medecin_id) AS nb_medecins FROM patients p JOIN consultations c ON p.id = c.patient_id LEFT JOIN prescriptions pr ON c.id = pr.consultation_id GROUP BY p.id, p.nom, p.prenom, p.ville ORDER BY total_depense DESC LIMIT 10;',
  '{"columns":[],"rows":[]}',
  'Utilisez COUNT(DISTINCT ...) pour éviter les doublons causés par les JOIN multiples.',
  40, 47, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-synthese-medecin',
  'Synthèse par médecin',
  'Créez une fiche synthétique pour chaque médecin.',
  'Pour chaque médecin, affichez : nom, prénom, nom du service, nombre de consultations, CA total, nombre de patients distincts, et classez-les en ''Senior'' (embauché avant 2015), ''Confirmé'' (2015-2019) ou ''Junior'' (2020 et après) selon leur date d''embauche. Triez par CA total décroissant.',
  'advanced',
  'SELECT m.nom, m.prenom, s.nom AS service, COUNT(c.id) AS nb_consultations, COALESCE(SUM(c.prix), 0) AS ca_total, COUNT(DISTINCT c.patient_id) AS nb_patients, CASE WHEN m.date_embauche < ''2015-01-01'' THEN ''Senior'' WHEN m.date_embauche < ''2020-01-01'' THEN ''Confirmé'' ELSE ''Junior'' END AS statut FROM medecins m JOIN services s ON m.service_id = s.id LEFT JOIN consultations c ON m.id = c.medecin_id GROUP BY m.id, m.nom, m.prenom, s.nom, m.date_embauche ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  'Combinez CASE WHEN pour le statut, LEFT JOIN pour inclure les médecins sans consultation, et COALESCE pour gérer les NULL.',
  40, 48, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-analyse-prescriptions',
  'Analyse croisée des prescriptions',
  'Analysez les prescriptions par catégorie de médicament et par service.',
  'Affichez le nom du service, la catégorie du médicament, le nombre de prescriptions et la durée moyenne de traitement arrondie à 1 décimale. Ne gardez que les combinaisons ayant au moins 2 prescriptions. Triez par nombre de prescriptions décroissant.',
  'advanced',
  'SELECT s.nom AS service, med.categorie, COUNT(*) AS nb_prescriptions, ROUND(AVG(pr.duree_jours), 1) AS duree_moyenne FROM prescriptions pr JOIN consultations c ON pr.consultation_id = c.id JOIN medecins m ON c.medecin_id = m.id JOIN services s ON m.service_id = s.id JOIN medicaments med ON pr.medicament_id = med.id GROUP BY s.nom, med.categorie HAVING COUNT(*) >= 2 ORDER BY nb_prescriptions DESC;',
  '{"columns":[],"rows":[]}',
  'Joignez les 5 tables (prescriptions -> consultations -> medecins -> services et prescriptions -> medicaments) puis GROUP BY service et catégorie.',
  40, 49, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, hint, points, sort_order, created_at, updated_at)
VALUES (
  5,
  'hop-rapport-global',
  'Rapport d''activité global',
  'Créez un rapport d''activité complet de l''hôpital.',
  'Affichez pour chaque service : le nom du service, l''étage, le nombre de médecins, le nombre de consultations, le CA total, le CA moyen par médecin arrondi à 2 décimales, le nombre total de prescriptions émises, et la part du CA total de l''hôpital en pourcentage arrondi à 1 décimale. Triez par CA total décroissant.',
  'advanced',
  'SELECT s.nom AS service, s.etage, COUNT(DISTINCT m.id) AS nb_medecins, COUNT(DISTINCT c.id) AS nb_consultations, COALESCE(SUM(c.prix), 0) AS ca_total, ROUND(COALESCE(SUM(c.prix), 0) * 1.0 / COUNT(DISTINCT m.id), 2) AS ca_moyen_par_medecin, COUNT(DISTINCT pr.id) AS nb_prescriptions, ROUND(COALESCE(SUM(c.prix), 0) * 100.0 / (SELECT SUM(prix) FROM consultations), 1) AS part_ca_pct FROM services s LEFT JOIN medecins m ON s.id = m.service_id LEFT JOIN consultations c ON m.id = c.medecin_id LEFT JOIN prescriptions pr ON c.id = pr.consultation_id GROUP BY s.id, s.nom, s.etage ORDER BY ca_total DESC;',
  '{"columns":[],"rows":[]}',
  'Utilisez LEFT JOIN en cascade, COUNT(DISTINCT ...) pour éviter les doublons, et une sous-requête scalaire pour le CA total de l''hôpital.',
  40, 50, NOW(), NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

COMMIT;
