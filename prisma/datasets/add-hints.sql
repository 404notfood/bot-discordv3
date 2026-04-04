-- ============================================
-- Add hints to SQL Clinic tasks
-- Run AFTER the task inserts
-- ============================================

-- Employees dataset hints
UPDATE sql_clinic_tasks SET hint = 'Utilise SELECT * et ORDER BY pour trier.' WHERE slug = 'emp-departements';
UPDATE sql_clinic_tasks SET hint = 'Filtre avec WHERE departement_id = 1 et trie par nom.' WHERE slug = 'emp-informatique';
UPDATE sql_clinic_tasks SET hint = 'Utilise WHERE salaire > 50000 et ORDER BY salaire DESC.' WHERE slug = 'emp-salaires-eleves';
UPDATE sql_clinic_tasks SET hint = 'Cherche les valeurs NULL avec IS NULL.' WHERE slug = 'emp-sans-email';
UPDATE sql_clinic_tasks SET hint = 'Compare date_embauche >= ''2022-01-01'' et trie par date.' WHERE slug = 'emp-recents';
UPDATE sql_clinic_tasks SET hint = 'Fais un JOIN entre employes et departements sur departement_id.' WHERE slug = 'emp-avec-dept';
UPDATE sql_clinic_tasks SET hint = 'Utilise COUNT(*) avec GROUP BY et un JOIN sur departements.' WHERE slug = 'emp-count-dept';
UPDATE sql_clinic_tasks SET hint = 'Utilise ROUND(AVG(salaire), 0) avec GROUP BY sur le departement.' WHERE slug = 'emp-salaire-moyen';
UPDATE sql_clinic_tasks SET hint = 'Joins projets et departements, puis trie par budget DESC.' WHERE slug = 'emp-projets-dept';
UPDATE sql_clinic_tasks SET hint = 'Utilise HAVING COUNT(*) >= 6 apres le GROUP BY.' WHERE slug = 'emp-dept-gros';
UPDATE sql_clinic_tasks SET hint = 'Triple jointure: employes -> affectations -> projets.' WHERE slug = 'emp-affectes-projets';
UPDATE sql_clinic_tasks SET hint = 'Joins projets et departements, puis SUM(budget) avec GROUP BY.' WHERE slug = 'emp-budget-dept';
UPDATE sql_clinic_tasks SET hint = 'Sous-requete correlee: WHERE salaire = (SELECT MAX(salaire) FROM employes e2 WHERE e2.departement_id = e.departement_id).' WHERE slug = 'emp-top-salaire-dept';
UPDATE sql_clinic_tasks SET hint = 'Joins affectations et projets, puis SUM(heures_assignees) et COUNT(*) avec GROUP BY.' WHERE slug = 'emp-heures-projet';
UPDATE sql_clinic_tasks SET hint = 'Utilise NOT IN avec une sous-requete sur la table affectations.' WHERE slug = 'emp-sans-projet';

-- E-commerce dataset hints
UPDATE sql_clinic_tasks SET hint = 'Utilise SELECT * et ORDER BY id.' WHERE slug = 'eco-categories';
UPDATE sql_clinic_tasks SET hint = 'Filtre avec WHERE categorie_id = 1 et trie par prix DESC.' WHERE slug = 'eco-electronique';
UPDATE sql_clinic_tasks SET hint = 'Filtre avec WHERE statut = ''livree'' et trie par date_commande.' WHERE slug = 'eco-livrees';
UPDATE sql_clinic_tasks SET hint = 'Filtre avec WHERE ville = ''Paris'' et trie par nom.' WHERE slug = 'eco-parisiens';
UPDATE sql_clinic_tasks SET hint = 'Filtre avec WHERE prix > 100 et trie par prix DESC.' WHERE slug = 'eco-chers';
UPDATE sql_clinic_tasks SET hint = 'Joins produits et categories, puis COUNT(*) avec GROUP BY.' WHERE slug = 'eco-produits-cat';
UPDATE sql_clinic_tasks SET hint = 'Joins clients et commandes, puis COUNT(co.id) avec GROUP BY.' WHERE slug = 'eco-commandes-client';
UPDATE sql_clinic_tasks SET hint = 'Triple jointure: lignes_commande -> produits -> categories, puis SUM(quantite * prix_unitaire).' WHERE slug = 'eco-ca-categorie';
UPDATE sql_clinic_tasks SET hint = 'Joins avis et produits, puis ROUND(AVG(note), 1) avec GROUP BY.' WHERE slug = 'eco-notes-produits';
UPDATE sql_clinic_tasks SET hint = 'Utilise GROUP BY ville HAVING COUNT(*) >= 2.' WHERE slug = 'eco-villes-actives';
UPDATE sql_clinic_tasks SET hint = 'Joins lignes_commande et produits, SUM(quantite) avec GROUP BY et LIMIT 5.' WHERE slug = 'eco-top-vendus';
UPDATE sql_clinic_tasks SET hint = 'Utilise NOT IN avec une sous-requete SELECT DISTINCT client_id FROM avis.' WHERE slug = 'eco-sans-avis';
UPDATE sql_clinic_tasks SET hint = 'Joins clients et commandes, puis ROUND(AVG(montant_total), 2) avec GROUP BY ville.' WHERE slug = 'eco-panier-moyen';
UPDATE sql_clinic_tasks SET hint = 'Utilise NOT IN avec une sous-requete sur lignes_commande.' WHERE slug = 'eco-jamais-commandes';
UPDATE sql_clinic_tasks SET hint = 'Joins clients et commandes, COUNT et SUM avec GROUP BY, LIMIT 10.' WHERE slug = 'eco-synthese-clients';
