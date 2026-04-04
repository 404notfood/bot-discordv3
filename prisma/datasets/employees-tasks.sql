-- ============================================
-- Exercices SQL Clinic - Dataset Employes
-- Table cible: sql_clinic_tasks (PostgreSQL)
-- dataset_id = 1
-- ============================================

BEGIN;

-- ============================================
-- BEGINNER (1-5)
-- ============================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-departements',
  'Liste des départements',
  'Affichez toutes les colonnes de la table departements, triées par identifiant.',
  'Écrivez une requête qui affiche toutes les colonnes de la table `departements`, triées par `id` croissant.',
  'beginner',
  'SELECT * FROM departements ORDER BY id;',
  '{"columns":["id","nom","localisation"],"rows":[[1,"Informatique","Paris - La Défense"],[2,"Marketing","Paris - Opéra"],[3,"Ressources Humaines","Lyon"],[4,"Finance","Paris - La Défense"],[5,"Commercial","Marseille"]]}',
  10,
  1,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-informatique',
  'Equipe Informatique',
  'Listez les membres du département Informatique avec leur poste.',
  'Sélectionnez le prénom, le nom et le poste des employés du département Informatique (`departement_id = 1`), triés par `nom`.',
  'beginner',
  'SELECT prenom, nom, poste FROM employes WHERE departement_id = 1 ORDER BY nom;',
  '{"columns":["prenom","nom","poste"],"rows":[["Sophie","Bernard","Analyste données"],["Jean","Dupont","Chef de projet"],["Marie","Laurent","Développeuse senior"],["Bastien","Lemoine","Administrateur systèmes"],["Pierre","Martin","Développeur junior"],["Lucas","Moreau","Développeur junior"],["Camille","Petit","Architecte logiciel"]]}',
  10,
  2,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-salaires-eleves',
  'Hauts salaires',
  'Trouvez les employés dont le salaire dépasse 50 000 €.',
  'Sélectionnez le prénom, le nom et le salaire des employés dont le salaire est supérieur à 50000, triés par `salaire` décroissant.',
  'beginner',
  'SELECT prenom, nom, salaire FROM employes WHERE salaire > 50000 ORDER BY salaire DESC;',
  '{"columns":["prenom","nom","salaire"],"rows":[["Julien","Thomas",85000],["Nathalie","Carpentier",78000],["Julie","Michel",75000],["Camille","Petit",72000],["Chloé","Leroy",68000],["Jean","Dupont",62000],["Émilie","Fournier",58000],["Marie","Laurent",55000],["Alexandre","Garcia",52000],["Sarah","Robert",52000]]}',
  10,
  3,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-sans-email',
  'Employés sans email',
  'Identifiez les employés qui n''ont pas d''adresse email renseignée.',
  'Sélectionnez le prénom, le nom et le poste des employés dont l''email est NULL.',
  'beginner',
  'SELECT prenom, nom, poste FROM employes WHERE email IS NULL;',
  '{"columns":["prenom","nom","poste"],"rows":[["Aurélie","Mercier","Stagiaire marketing"],["Éric","Perrin","Stagiaire RH"]]}',
  10,
  4,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-recents',
  'Recrues récentes',
  'Listez les employés embauchés depuis début 2022.',
  'Sélectionnez le prénom, le nom et la date d''embauche des employés embauchés à partir du 1er janvier 2022 (`date_embauche >= ''2022-01-01''`), triés par `date_embauche` croissante.',
  'beginner',
  'SELECT prenom, nom, date_embauche FROM employes WHERE date_embauche >= ''2022-01-01'' ORDER BY date_embauche;',
  '{"columns":["prenom","nom","date_embauche"],"rows":[["Hugo","Girard","2022-03-14"],["Inès","Morel","2022-09-01"],["Damien","Faure","2022-11-28"],["Clara","Richard","2023-01-16"],["Aurélie","Mercier","2023-06-01"],["Éric","Perrin","2024-01-08"]]}',
  10,
  5,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ============================================
-- INTERMEDIATE (6-10)
-- ============================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-avec-dept',
  'Employés et départements',
  'Associez chaque employé à son département grâce à une jointure.',
  'Sélectionnez le prénom et le nom de l''employé ainsi que le nom du département (alias `departement`) pour chaque employé ayant un département. Triez par nom de département puis par nom de l''employé.',
  'intermediate',
  'SELECT e.prenom, e.nom, d.nom as departement FROM employes e JOIN departements d ON e.departement_id = d.id ORDER BY d.nom, e.nom;',
  '{"columns":["prenom","nom","departement"],"rows":[["Mathieu","Blanc","Commercial"],["Damien","Faure","Commercial"],["Pauline","Guérin","Commercial"],["Sarah","Robert","Commercial"],["Julien","Thomas","Commercial"],["Romain","Bertrand","Finance"],["Nathalie","Carpentier","Finance"],["Manon","David","Finance"],["Alexandre","Garcia","Finance"],["Julie","Michel","Finance"],["Clara","Richard","Finance"],["Sophie","Bernard","Informatique"],["Jean","Dupont","Informatique"],["Marie","Laurent","Informatique"],["Bastien","Lemoine","Informatique"],["Pierre","Martin","Informatique"],["Lucas","Moreau","Informatique"],["Camille","Petit","Informatique"],["Léa","Bonnet","Marketing"],["Nicolas","Dubois","Marketing"],["Émilie","Fournier","Marketing"],["Hugo","Girard","Marketing"],["Aurélie","Mercier","Marketing"],["Antoine","Roux","Marketing"],["Chloé","Leroy","Ressources Humaines"],["Inès","Morel","Ressources Humaines"],["Éric","Perrin","Ressources Humaines"],["Maxime","Robin","Ressources Humaines"],["Thomas","Simon","Ressources Humaines"]]}',
  20,
  6,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-count-dept',
  'Effectifs par département',
  'Comptez le nombre d''employés dans chaque département.',
  'Affichez le nom du département (alias `nom`) et le nombre d''employés (alias `effectif`) pour chaque département. Triez par effectif décroissant.',
  'intermediate',
  'SELECT d.nom, COUNT(*) as effectif FROM employes e JOIN departements d ON e.departement_id = d.id GROUP BY d.nom ORDER BY effectif DESC;',
  '{"columns":["nom","effectif"],"rows":[["Informatique",7],["Finance",6],["Marketing",6],["Commercial",5],["Ressources Humaines",5]]}',
  20,
  7,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-salaire-moyen',
  'Salaire moyen par département',
  'Calculez le salaire moyen arrondi pour chaque département.',
  'Affichez le nom du département (alias `nom`) et le salaire moyen arrondi à l''entier (alias `salaire_moyen`) en utilisant `ROUND(AVG(e.salaire), 0)`. Triez par salaire moyen décroissant.',
  'intermediate',
  'SELECT d.nom, ROUND(AVG(e.salaire), 0) as salaire_moyen FROM employes e JOIN departements d ON e.departement_id = d.id GROUP BY d.nom ORDER BY salaire_moyen DESC;',
  '{"columns":["nom","salaire_moyen"],"rows":[["Finance",55667.0],["Informatique",52000.0],["Commercial",51400.0],["Ressources Humaines",43400.0],["Marketing",42000.0]]}',
  20,
  8,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-projets-dept',
  'Projets par département',
  'Listez les projets avec leur département et leur budget.',
  'Sélectionnez le nom du projet (alias `projet`), le nom du département (alias `departement`) et le budget du projet. Triez par budget décroissant.',
  'intermediate',
  'SELECT p.nom as projet, d.nom as departement, p.budget FROM projets p JOIN departements d ON p.departement_id = d.id ORDER BY p.budget DESC;',
  '{"columns":["projet","departement","budget"],"rows":[["Application Mobile","Informatique",200000],["Migration Cloud","Informatique",150000],["Expansion Sud-Est","Commercial",120000],["Refonte Site Web","Informatique",85000],["Campagne Été 2024","Marketing",60000],["Audit Financier Annuel","Finance",40000],["Plan de Formation","Ressources Humaines",30000],["Stratégie Réseaux Sociaux","Marketing",25000]]}',
  20,
  9,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-dept-gros',
  'Grands départements',
  'Identifiez les départements comptant au moins 6 employés.',
  'Affichez le nom du département (alias `nom`) et le nombre d''employés (alias `effectif`) pour les départements ayant 6 employés ou plus (`HAVING COUNT(*) >= 6`). Triez par effectif décroissant.',
  'intermediate',
  'SELECT d.nom, COUNT(*) as effectif FROM employes e JOIN departements d ON e.departement_id = d.id GROUP BY d.nom HAVING COUNT(*) >= 6 ORDER BY effectif DESC;',
  '{"columns":["nom","effectif"],"rows":[["Informatique",7],["Finance",6],["Marketing",6]]}',
  20,
  10,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

-- ============================================
-- ADVANCED (11-15)
-- ============================================

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-affectes-projets',
  'Employés sur projets',
  'Listez toutes les affectations d''employés sur des projets avec leur rôle.',
  'Sélectionnez le prénom et le nom de l''employé, le nom du projet (alias `projet`) et le rôle depuis la table `affectations`. Joignez les tables `employes`, `affectations` et `projets`. Triez par nom de l''employé puis par nom du projet.',
  'advanced',
  'SELECT e.prenom, e.nom, p.nom as projet, a.role FROM employes e JOIN affectations a ON a.employe_id = e.id JOIN projets p ON p.id = a.projet_id ORDER BY e.nom, p.nom;',
  '{"columns":["prenom","nom","projet","role"],"rows":[["Mathieu","Blanc","Expansion Sud-Est","Commercial terrain"],["Léa","Bonnet","Campagne Été 2024","Community manager"],["Léa","Bonnet","Stratégie Réseaux Sociaux","Responsable"],["Nathalie","Carpentier","Audit Financier Annuel","Responsable audit"],["Jean","Dupont","Migration Cloud","Chef de projet"],["Jean","Dupont","Refonte Site Web","Superviseur"],["Émilie","Fournier","Campagne Été 2024","Responsable"],["Alexandre","Garcia","Audit Financier Annuel","Auditeur"],["Hugo","Girard","Stratégie Réseaux Sociaux","Assistant"],["Marie","Laurent","Application Mobile","Développeuse lead"],["Marie","Laurent","Migration Cloud","Développeuse lead"],["Bastien","Lemoine","Migration Cloud","Administrateur"],["Pierre","Martin","Application Mobile","Développeur"],["Pierre","Martin","Refonte Site Web","Développeur"],["Lucas","Moreau","Application Mobile","Développeur"],["Lucas","Moreau","Refonte Site Web","Développeur"],["Camille","Petit","Application Mobile","Architecte"],["Camille","Petit","Migration Cloud","Architecte"],["Sarah","Robert","Expansion Sud-Est","Responsable zone"],["Antoine","Roux","Campagne Été 2024","Rédacteur"]]}',
  30,
  11,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-budget-dept',
  'Budget total par département',
  'Calculez le budget total des projets pour chaque département.',
  'Affichez le nom du département (alias `nom`) et la somme des budgets de ses projets (alias `budget_total`). Joignez `projets` et `departements`. Triez par budget total décroissant.',
  'advanced',
  'SELECT d.nom, SUM(p.budget) as budget_total FROM projets p JOIN departements d ON p.departement_id = d.id GROUP BY d.nom ORDER BY budget_total DESC;',
  '{"columns":["nom","budget_total"],"rows":[["Informatique",435000],["Commercial",120000],["Marketing",85000],["Finance",40000],["Ressources Humaines",30000]]}',
  30,
  12,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-top-salaire-dept',
  'Meilleur salaire par département',
  'Trouvez l''employé le mieux payé dans chaque département.',
  'Pour chaque département, affichez le nom du département (alias `departement`), le prénom, le nom et le salaire de l''employé ayant le salaire le plus élevé. Utilisez une sous-requête corrélée pour trouver le MAX du salaire par département. Triez par salaire décroissant.',
  'advanced',
  'SELECT d.nom as departement, e.prenom, e.nom, e.salaire FROM employes e JOIN departements d ON e.departement_id = d.id WHERE e.salaire = (SELECT MAX(e2.salaire) FROM employes e2 WHERE e2.departement_id = e.departement_id) ORDER BY e.salaire DESC;',
  '{"columns":["departement","prenom","nom","salaire"],"rows":[["Commercial","Julien","Thomas",85000],["Finance","Nathalie","Carpentier",78000],["Informatique","Camille","Petit",72000],["Ressources Humaines","Chloé","Leroy",68000],["Marketing","Émilie","Fournier",58000]]}',
  30,
  13,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-heures-projet',
  'Heures par projet',
  'Calculez le total des heures assignées et le nombre de membres pour chaque projet.',
  'Affichez le nom du projet (alias `projet`), la somme des heures assignées (alias `total_heures`) et le nombre de membres (alias `nb_membres`). Joignez `affectations` et `projets`. Regroupez par nom de projet et triez par total d''heures décroissant.',
  'advanced',
  'SELECT p.nom as projet, SUM(a.heures_assignees) as total_heures, COUNT(*) as nb_membres FROM affectations a JOIN projets p ON p.id = a.projet_id GROUP BY p.nom ORDER BY total_heures DESC;',
  '{"columns":["projet","total_heures","nb_membres"],"rows":[["Application Mobile",1500,4],["Migration Cloud",1300,4],["Expansion Sud-Est",750,2],["Refonte Site Web",700,3],["Audit Financier Annuel",550,2],["Campagne Été 2024",530,3],["Stratégie Réseaux Sociaux",320,2]]}',
  30,
  14,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

INSERT INTO sql_clinic_tasks (dataset_id, slug, title, description, statement, difficulty, expected_sql, expected_result, points, sort_order, created_at, updated_at)
VALUES (
  1,
  'emp-sans-projet',
  'Employés sans projet',
  'Identifiez les employés qui ne sont affectés à aucun projet.',
  'Sélectionnez le prénom, le nom et le poste des employés dont l''identifiant n''apparaît pas dans la table `affectations` (`NOT IN`). Triez par nom de famille.',
  'advanced',
  'SELECT e.prenom, e.nom, e.poste FROM employes e WHERE e.id NOT IN (SELECT employe_id FROM affectations) ORDER BY e.nom;',
  '{"columns":["prenom","nom","poste"],"rows":[["Sophie","Bernard","Analyste données"],["Romain","Bertrand","Analyste financier"],["Céline","Chevalier","Consultante externe"],["Manon","David","Comptable"],["Nicolas","Dubois","Chargé de communication"],["Damien","Faure","Commercial junior"],["Pauline","Guérin","Commerciale sédentaire"],["Chloé","Leroy","Directrice RH"],["Aurélie","Mercier","Stagiaire marketing"],["Julie","Michel","Directrice financière"],["Inès","Morel","Assistante RH"],["Éric","Perrin","Stagiaire RH"],["Clara","Richard","Comptable junior"],["Maxime","Robin","Chargé de recrutement"],["Thomas","Simon","Gestionnaire paie"],["Julien","Thomas","Directeur commercial"]]}',
  30,
  15,
  NOW(),
  NOW()
)
ON CONFLICT (dataset_id, slug) DO NOTHING;

COMMIT;
