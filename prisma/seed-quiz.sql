-- ============================================================================
-- SEED QUIZ - Questions Dev pour Taureau Celtique v3
-- 500 questions (50 par theme) x 4 reponses = 2000 reponses
-- ============================================================================

-- ==================== THEMES ====================

INSERT INTO quiz_themes (name, slug, description, color, is_active, created_at, updated_at) VALUES
('JavaScript', 'javascript', 'Questions sur JavaScript, ES6+, Node.js', '#F7DF1E', true, NOW(), NOW()),
('Python', 'python', 'Questions sur Python 3', '#3776AB', true, NOW(), NOW()),
('SQL', 'sql', 'Questions sur SQL, bases de donnees relationnelles', '#CC6600', true, NOW(), NOW()),
('HTML / CSS', 'html-css', 'Questions sur HTML5, CSS3, responsive design', '#E34F26', true, NOW(), NOW()),
('Git', 'git', 'Questions sur Git et le versioning', '#F05032', true, NOW(), NOW()),
('DevOps', 'devops', 'Questions sur Docker, CI/CD, Linux, deploiement', '#2496ED', true, NOW(), NOW()),
('TypeScript', 'typescript', 'Questions sur TypeScript', '#3178C6', true, NOW(), NOW()),
('React', 'react', 'Questions sur React et son ecosysteme', '#61DAFB', true, NOW(), NOW()),
('Culture Dev', 'culture-dev', 'Questions de culture generale en developpement', '#9B59B6', true, NOW(), NOW()),
('Securite', 'securite', 'Questions sur la securite web et les bonnes pratiques', '#E74C3C', true, NOW(), NOW());

-- ==================== JAVASCRIPT (50 questions) ====================

-- JS Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quel mot-cle permet de declarer une variable qui ne peut pas etre reassignee ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'var', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de declarer une variable qui ne peut pas etre reassignee ?' UNION ALL
SELECT id, 'B', 'let', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de declarer une variable qui ne peut pas etre reassignee ?' UNION ALL
SELECT id, 'C', 'const', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de declarer une variable qui ne peut pas etre reassignee ?' UNION ALL
SELECT id, 'D', 'static', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de declarer une variable qui ne peut pas etre reassignee ?';

-- JS Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que retourne typeof null en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'null', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof null en JavaScript ?' UNION ALL
SELECT id, 'B', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof null en JavaScript ?' UNION ALL
SELECT id, 'C', 'object', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof null en JavaScript ?' UNION ALL
SELECT id, 'D', 'number', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof null en JavaScript ?';

-- JS Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle methode transforme un tableau en chaine de caracteres avec un separateur ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'concat()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode transforme un tableau en chaine de caracteres avec un separateur ?' UNION ALL
SELECT id, 'B', 'join()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode transforme un tableau en chaine de caracteres avec un separateur ?' UNION ALL
SELECT id, 'C', 'split()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode transforme un tableau en chaine de caracteres avec un separateur ?' UNION ALL
SELECT id, 'D', 'toString()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode transforme un tableau en chaine de caracteres avec un separateur ?';

-- JS Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait l''operateur === en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Compare les valeurs uniquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur === en JavaScript ?' UNION ALL
SELECT id, 'B', 'Compare les valeurs et les types', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur === en JavaScript ?' UNION ALL
SELECT id, 'C', 'Assigne une valeur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur === en JavaScript ?' UNION ALL
SELECT id, 'D', 'Compare les references memoire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur === en JavaScript ?';

-- JS Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle est la sortie de console.log(0.1 + 0.2 === 0.3) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'true', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la sortie de console.log(0.1 + 0.2 === 0.3) ?' UNION ALL
SELECT id, 'B', 'false', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la sortie de console.log(0.1 + 0.2 === 0.3) ?' UNION ALL
SELECT id, 'C', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la sortie de console.log(0.1 + 0.2 === 0.3) ?' UNION ALL
SELECT id, 'D', 'NaN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la sortie de console.log(0.1 + 0.2 === 0.3) ?';

-- JS Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que retourne typeof NaN en JavaScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'NaN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof NaN en JavaScript ?' UNION ALL
SELECT id, 'B', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof NaN en JavaScript ?' UNION ALL
SELECT id, 'C', 'number', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof NaN en JavaScript ?' UNION ALL
SELECT id, 'D', 'string', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne typeof NaN en JavaScript ?';

-- JS Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle est la difference principale entre map() et forEach() ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'map() retourne un nouveau tableau, forEach() ne retourne rien', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference principale entre map() et forEach() ?' UNION ALL
SELECT id, 'B', 'forEach() est plus rapide que map()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference principale entre map() et forEach() ?' UNION ALL
SELECT id, 'C', 'map() modifie le tableau original', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference principale entre map() et forEach() ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune difference', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference principale entre map() et forEach() ?';

-- JS Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait le mot-cle async devant une fonction ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Rend la fonction synchrone', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle async devant une fonction ?' UNION ALL
SELECT id, 'B', 'La fonction retourne automatiquement une Promise', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle async devant une fonction ?' UNION ALL
SELECT id, 'C', 'La fonction s''execute dans un Web Worker', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle async devant une fonction ?' UNION ALL
SELECT id, 'D', 'La fonction est executee en parallele', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle async devant une fonction ?';

-- JS Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Qu''est-ce que le hoisting en JavaScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le deplacement des declarations en haut de leur portee', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le hoisting en JavaScript ?' UNION ALL
SELECT id, 'B', 'L''optimisation automatique du code', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le hoisting en JavaScript ?' UNION ALL
SELECT id, 'C', 'La compilation du code avant execution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le hoisting en JavaScript ?' UNION ALL
SELECT id, 'D', 'Le chargement asynchrone des modules', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le hoisting en JavaScript ?';

-- JS Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Qu''est-ce qu''une closure en JavaScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une fonction qui a acces aux variables de sa portee parente meme apres que celle-ci a fini de s''executer', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une closure en JavaScript ?' UNION ALL
SELECT id, 'B', 'Une methode pour fermer une connexion reseau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une closure en JavaScript ?' UNION ALL
SELECT id, 'C', 'Un design pattern pour encapsuler des classes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une closure en JavaScript ?' UNION ALL
SELECT id, 'D', 'Une syntaxe pour creer des objets immutables', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une closure en JavaScript ?';

-- JS Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle methode de tableau cree un nouveau tableau avec les elements qui passent un test ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'find()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode de tableau cree un nouveau tableau avec les elements qui passent un test ?' UNION ALL
SELECT id, 'B', 'filter()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode de tableau cree un nouveau tableau avec les elements qui passent un test ?' UNION ALL
SELECT id, 'C', 'some()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode de tableau cree un nouveau tableau avec les elements qui passent un test ?' UNION ALL
SELECT id, 'D', 'every()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode de tableau cree un nouveau tableau avec les elements qui passent un test ?';

-- JS Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que retourne console.log([] == false) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'true', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log([] == false) ?' UNION ALL
SELECT id, 'B', 'false', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log([] == false) ?' UNION ALL
SELECT id, 'C', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log([] == false) ?' UNION ALL
SELECT id, 'D', 'TypeError', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log([] == false) ?';

-- JS Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle structure permet de gerer les erreurs avec async/await ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'if/else', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure permet de gerer les erreurs avec async/await ?' UNION ALL
SELECT id, 'B', 'try/catch', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure permet de gerer les erreurs avec async/await ?' UNION ALL
SELECT id, 'C', 'switch/case', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure permet de gerer les erreurs avec async/await ?' UNION ALL
SELECT id, 'D', 'for/in', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure permet de gerer les erreurs avec async/await ?';

-- JS Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que retourne [..."hello"] en JavaScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '["hello"]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne [..."hello"] en JavaScript ?' UNION ALL
SELECT id, 'B', '["h", "e", "l", "l", "o"]', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne [..."hello"] en JavaScript ?' UNION ALL
SELECT id, 'C', 'Une erreur de syntaxe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne [..."hello"] en JavaScript ?' UNION ALL
SELECT id, 'D', '["h-e-l-l-o"]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne [..."hello"] en JavaScript ?';

-- JS Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quel est le resultat de console.log(1 + "2" + 3) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '6', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(1 + "2" + 3) ?' UNION ALL
SELECT id, 'B', '123', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(1 + "2" + 3) ?' UNION ALL
SELECT id, 'C', '33', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(1 + "2" + 3) ?' UNION ALL
SELECT id, 'D', 'NaN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(1 + "2" + 3) ?';

-- JS Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle methode permet de copier superficiellement un objet ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Object.assign({}, obj)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet de copier superficiellement un objet ?' UNION ALL
SELECT id, 'B', 'Object.clone(obj)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet de copier superficiellement un objet ?' UNION ALL
SELECT id, 'C', 'Object.copy(obj)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet de copier superficiellement un objet ?' UNION ALL
SELECT id, 'D', 'Object.duplicate(obj)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet de copier superficiellement un objet ?';

-- JS Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Qu''est-ce que l''event loop en JavaScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une boucle for qui parcourt les evenements du DOM', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''event loop en JavaScript ?' UNION ALL
SELECT id, 'B', 'Le mecanisme qui gere l''execution asynchrone en verifiant la pile d''appels et la file de messages', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''event loop en JavaScript ?' UNION ALL
SELECT id, 'C', 'Un pattern de conception pour les evenements', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''event loop en JavaScript ?' UNION ALL
SELECT id, 'D', 'Une fonctionnalite specifique a Node.js', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''event loop en JavaScript ?';

-- JS Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle est la portee d''une variable declaree avec let ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Portee globale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la portee d''une variable declaree avec let ?' UNION ALL
SELECT id, 'B', 'Portee de fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la portee d''une variable declaree avec let ?' UNION ALL
SELECT id, 'C', 'Portee de bloc', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la portee d''une variable declaree avec let ?' UNION ALL
SELECT id, 'D', 'Portee de module', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la portee d''une variable declaree avec let ?';

-- JS Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode Promise.all() ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Execute les promises une par une', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Promise.all() ?' UNION ALL
SELECT id, 'B', 'Attend que toutes les promises soient resolues ou qu''une soit rejetee', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Promise.all() ?' UNION ALL
SELECT id, 'C', 'Retourne la premiere promise resolue', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Promise.all() ?' UNION ALL
SELECT id, 'D', 'Annule toutes les promises en cours', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Promise.all() ?';

-- JS Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quel symbole est utilise pour le template literal en ES6 ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Guillemets simples ''', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel symbole est utilise pour le template literal en ES6 ?' UNION ALL
SELECT id, 'B', 'Guillemets doubles "', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel symbole est utilise pour le template literal en ES6 ?' UNION ALL
SELECT id, 'C', 'Backticks `', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel symbole est utilise pour le template literal en ES6 ?' UNION ALL
SELECT id, 'D', 'Barres obliques /', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel symbole est utilise pour le template literal en ES6 ?';

-- JS Q21 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles methodes de tableau sont immutables (ne modifient pas le tableau original) ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'map()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes de tableau sont immutables (ne modifient pas le tableau original) ?' UNION ALL
SELECT id, 'B', 'splice()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes de tableau sont immutables (ne modifient pas le tableau original) ?' UNION ALL
SELECT id, 'C', 'filter()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes de tableau sont immutables (ne modifient pas le tableau original) ?' UNION ALL
SELECT id, 'D', 'push()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes de tableau sont immutables (ne modifient pas le tableau original) ?';

-- JS Q22 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quels types sont consideres comme primitifs en JavaScript ?', NULL, 'easy', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'string', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types sont consideres comme primitifs en JavaScript ?' UNION ALL
SELECT id, 'B', 'object', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types sont consideres comme primitifs en JavaScript ?' UNION ALL
SELECT id, 'C', 'number', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types sont consideres comme primitifs en JavaScript ?' UNION ALL
SELECT id, 'D', 'array', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types sont consideres comme primitifs en JavaScript ?';

-- JS Q23 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles valeurs sont falsy en JavaScript ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '0', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles valeurs sont falsy en JavaScript ?' UNION ALL
SELECT id, 'B', '"false"', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles valeurs sont falsy en JavaScript ?' UNION ALL
SELECT id, 'C', '""', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles valeurs sont falsy en JavaScript ?' UNION ALL
SELECT id, 'D', '[]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles valeurs sont falsy en JavaScript ?';

-- JS Q24 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles fonctionnalites ont ete introduites avec ES6 ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les arrow functions', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles fonctionnalites ont ete introduites avec ES6 ?' UNION ALL
SELECT id, 'B', 'JSON.parse()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles fonctionnalites ont ete introduites avec ES6 ?' UNION ALL
SELECT id, 'C', 'Les classes', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles fonctionnalites ont ete introduites avec ES6 ?' UNION ALL
SELECT id, 'D', 'document.getElementById()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles fonctionnalites ont ete introduites avec ES6 ?';

-- JS Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait Object.freeze() sur un objet ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Supprime toutes les proprietes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait Object.freeze() sur un objet ?' UNION ALL
SELECT id, 'B', 'Empeche l''ajout, la suppression et la modification des proprietes', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait Object.freeze() sur un objet ?' UNION ALL
SELECT id, 'C', 'Rend l''objet null', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait Object.freeze() sur un objet ?' UNION ALL
SELECT id, 'D', 'Convertit l''objet en JSON', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait Object.freeze() sur un objet ?';

-- JS Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode reduce() sur un tableau ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Reduit la taille du tableau en supprimant des elements', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode reduce() sur un tableau ?' UNION ALL
SELECT id, 'B', 'Accumule les elements du tableau en une seule valeur via une fonction callback', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode reduce() sur un tableau ?' UNION ALL
SELECT id, 'C', 'Filtre les doublons du tableau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode reduce() sur un tableau ?' UNION ALL
SELECT id, 'D', 'Trie le tableau par ordre decroissant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode reduce() sur un tableau ?';

-- JS Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle est la difference entre null et undefined ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune difference', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre null et undefined ?' UNION ALL
SELECT id, 'B', 'null est une valeur assignee intentionnellement, undefined signifie non initialise', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre null et undefined ?' UNION ALL
SELECT id, 'C', 'undefined est un objet, null est un type primitif', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre null et undefined ?' UNION ALL
SELECT id, 'D', 'null est utilise cote serveur, undefined cote client', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre null et undefined ?';

-- JS Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Qu''est-ce que le destructuring en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Supprimer des elements d''un objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le destructuring en JavaScript ?' UNION ALL
SELECT id, 'B', 'Extraire des valeurs d''un objet ou tableau dans des variables distinctes', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le destructuring en JavaScript ?' UNION ALL
SELECT id, 'C', 'Detruire un objet en memoire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le destructuring en JavaScript ?' UNION ALL
SELECT id, 'D', 'Convertir un objet en tableau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le destructuring en JavaScript ?';

-- JS Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait l''operateur spread (...) sur un objet ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Supprime les proprietes de l''objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur spread (...) sur un objet ?' UNION ALL
SELECT id, 'B', 'Copie superficiellement les proprietes de l''objet', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur spread (...) sur un objet ?' UNION ALL
SELECT id, 'C', 'Fusionne l''objet avec null', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur spread (...) sur un objet ?' UNION ALL
SELECT id, 'D', 'Convertit l''objet en tableau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur spread (...) sur un objet ?';

-- JS Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Comment acceder a la longueur d''un tableau en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'array.size()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder a la longueur d''un tableau en JavaScript ?' UNION ALL
SELECT id, 'B', 'array.length', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder a la longueur d''un tableau en JavaScript ?' UNION ALL
SELECT id, 'C', 'array.count()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder a la longueur d''un tableau en JavaScript ?' UNION ALL
SELECT id, 'D', 'len(array)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder a la longueur d''un tableau en JavaScript ?';

-- JS Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que retourne console.log(typeof []) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'array', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log(typeof []) ?' UNION ALL
SELECT id, 'B', 'object', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log(typeof []) ?' UNION ALL
SELECT id, 'C', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log(typeof []) ?' UNION ALL
SELECT id, 'D', 'list', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne console.log(typeof []) ?';

-- JS Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Qu''est-ce que le prototype chain en JavaScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une chaine de caracteres speciale pour les prototypes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype chain en JavaScript ?' UNION ALL
SELECT id, 'B', 'Le mecanisme d''heritage ou un objet herite des proprietes de son prototype', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype chain en JavaScript ?' UNION ALL
SELECT id, 'C', 'Une liste chainee implementee en JavaScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype chain en JavaScript ?' UNION ALL
SELECT id, 'D', 'Un pattern pour creer des singletons', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype chain en JavaScript ?';

-- JS Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode Array.from() ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Cree un nouveau tableau a partir d''un objet iterable ou array-like', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Array.from() ?' UNION ALL
SELECT id, 'B', 'Importe un tableau depuis un fichier', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Array.from() ?' UNION ALL
SELECT id, 'C', 'Copie un tableau existant en profondeur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Array.from() ?' UNION ALL
SELECT id, 'D', 'Extrait une partie d''un tableau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Array.from() ?';

-- JS Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quel est le resultat de console.log(+"") ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'NaN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(+"") ?' UNION ALL
SELECT id, 'B', '0', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(+"") ?' UNION ALL
SELECT id, 'C', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(+"") ?' UNION ALL
SELECT id, 'D', 'Une erreur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log(+"") ?';

-- JS Q35 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles methodes retournent une Promise ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'fetch()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes retournent une Promise ?' UNION ALL
SELECT id, 'B', 'JSON.parse()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes retournent une Promise ?' UNION ALL
SELECT id, 'C', 'Response.json()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes retournent une Promise ?' UNION ALL
SELECT id, 'D', 'console.log()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles methodes retournent une Promise ?';

-- JS Q36 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles declarations sont block-scoped en JavaScript ?', NULL, 'easy', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'var', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles declarations sont block-scoped en JavaScript ?' UNION ALL
SELECT id, 'B', 'let', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles declarations sont block-scoped en JavaScript ?' UNION ALL
SELECT id, 'C', 'const', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles declarations sont block-scoped en JavaScript ?' UNION ALL
SELECT id, 'D', 'function', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles declarations sont block-scoped en JavaScript ?';

-- JS Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode bind() sur une fonction ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Execute la fonction immediatement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode bind() sur une fonction ?' UNION ALL
SELECT id, 'B', 'Cree une nouvelle fonction avec un this fixe', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode bind() sur une fonction ?' UNION ALL
SELECT id, 'C', 'Lie deux fonctions ensemble', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode bind() sur une fonction ?' UNION ALL
SELECT id, 'D', 'Supprime la reference this', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode bind() sur une fonction ?';

-- JS Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle est la valeur de this dans une arrow function ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'L''objet global window', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur de this dans une arrow function ?' UNION ALL
SELECT id, 'B', 'L''objet qui appelle la fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur de this dans une arrow function ?' UNION ALL
SELECT id, 'C', 'Le this du contexte englobant (lexical)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur de this dans une arrow function ?' UNION ALL
SELECT id, 'D', 'undefined dans tous les cas', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur de this dans une arrow function ?';

-- JS Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode flat() sur un tableau ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Trie le tableau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode flat() sur un tableau ?' UNION ALL
SELECT id, 'B', 'Aplatit les sous-tableaux imbriques', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode flat() sur un tableau ?' UNION ALL
SELECT id, 'C', 'Supprime les doublons', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode flat() sur un tableau ?' UNION ALL
SELECT id, 'D', 'Inverse le tableau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode flat() sur un tableau ?';

-- JS Q40 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles structures permettent d''iterer sur les proprietes d''un objet ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'for...in', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures permettent d''iterer sur les proprietes d''un objet ?' UNION ALL
SELECT id, 'B', 'for...of', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures permettent d''iterer sur les proprietes d''un objet ?' UNION ALL
SELECT id, 'C', 'Object.keys() avec forEach', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures permettent d''iterer sur les proprietes d''un objet ?' UNION ALL
SELECT id, 'D', 'while...do', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures permettent d''iterer sur les proprietes d''un objet ?';

-- JS Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait le mot-cle yield dans une generator function ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Termine definitivement la fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield dans une generator function ?' UNION ALL
SELECT id, 'B', 'Met en pause la fonction et retourne une valeur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield dans une generator function ?' UNION ALL
SELECT id, 'C', 'Lance une erreur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield dans une generator function ?' UNION ALL
SELECT id, 'D', 'Cree une nouvelle instance de la fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield dans une generator function ?';

-- JS Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode Object.keys() ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Retourne un tableau des valeurs de l''objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Object.keys() ?' UNION ALL
SELECT id, 'B', 'Retourne un tableau des noms de proprietes de l''objet', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Object.keys() ?' UNION ALL
SELECT id, 'C', 'Verrouille les cles de l''objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Object.keys() ?' UNION ALL
SELECT id, 'D', 'Retourne le nombre de proprietes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Object.keys() ?';

-- JS Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quel est le resultat de console.log([] + []) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '[]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log([] + []) ?' UNION ALL
SELECT id, 'B', '""  (chaine vide)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log([] + []) ?' UNION ALL
SELECT id, 'C', '0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log([] + []) ?' UNION ALL
SELECT id, 'D', 'NaN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de console.log([] + []) ?';

-- JS Q44 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles sont des facons valides de creer une Promise ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'new Promise((resolve, reject) => {})', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des facons valides de creer une Promise ?' UNION ALL
SELECT id, 'B', 'Promise.create()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des facons valides de creer une Promise ?' UNION ALL
SELECT id, 'C', 'Promise.resolve(valeur)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des facons valides de creer une Promise ?' UNION ALL
SELECT id, 'D', 'new Promise(valeur)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des facons valides de creer une Promise ?';

-- JS Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode Set en JavaScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Cree un tableau ordonne', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Set en JavaScript ?' UNION ALL
SELECT id, 'B', 'Cree une collection de valeurs uniques', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Set en JavaScript ?' UNION ALL
SELECT id, 'C', 'Definit une variable globale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Set en JavaScript ?' UNION ALL
SELECT id, 'D', 'Configure un objet de parametres', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode Set en JavaScript ?';

-- JS Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelle est la difference entre == et === ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '== compare avec coercion de type, === compare sans coercion', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et === ?' UNION ALL
SELECT id, 'B', '=== est plus lent que ==', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et === ?' UNION ALL
SELECT id, 'C', '== compare les references, === compare les valeurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et === ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune difference pratique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et === ?';

-- JS Q47 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quels operateurs permettent une evaluation court-circuit ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '&&', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels operateurs permettent une evaluation court-circuit ?' UNION ALL
SELECT id, 'B', '===', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels operateurs permettent une evaluation court-circuit ?' UNION ALL
SELECT id, 'C', '||', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels operateurs permettent une evaluation court-circuit ?' UNION ALL
SELECT id, 'D', '!=', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels operateurs permettent une evaluation court-circuit ?';

-- JS Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait l''operateur nullish coalescing (??) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Retourne la valeur de droite si la gauche est null ou undefined', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur nullish coalescing (??) ?' UNION ALL
SELECT id, 'B', 'Retourne la valeur de droite si la gauche est falsy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur nullish coalescing (??) ?' UNION ALL
SELECT id, 'C', 'Leve une exception si la valeur est null', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur nullish coalescing (??) ?' UNION ALL
SELECT id, 'D', 'Compare deux valeurs nulles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''operateur nullish coalescing (??) ?';

-- JS Q49 (allow_multiple)
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Quelles structures de donnees sont iterables en JavaScript ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Array', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures de donnees sont iterables en JavaScript ?' UNION ALL
SELECT id, 'B', 'Object', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures de donnees sont iterables en JavaScript ?' UNION ALL
SELECT id, 'C', 'Map', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures de donnees sont iterables en JavaScript ?' UNION ALL
SELECT id, 'D', 'WeakRef', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles structures de donnees sont iterables en JavaScript ?';

-- JS Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'javascript'), 'Que fait la methode optional chaining (?.) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Lance une erreur si la propriete n''existe pas', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode optional chaining (?.) ?' UNION ALL
SELECT id, 'B', 'Retourne undefined si la reference est null ou undefined au lieu de lancer une erreur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode optional chaining (?.) ?' UNION ALL
SELECT id, 'C', 'Cree la propriete si elle n''existe pas', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode optional chaining (?.) ?' UNION ALL
SELECT id, 'D', 'Verifie le type de la propriete', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode optional chaining (?.) ?';


-- ==================== PYTHON (50 questions) ====================

-- PY Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de type(3.14) en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'int', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de type(3.14) en Python ?' UNION ALL
SELECT id, 'B', 'float', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de type(3.14) en Python ?' UNION ALL
SELECT id, 'C', 'double', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de type(3.14) en Python ?' UNION ALL
SELECT id, 'D', 'decimal', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de type(3.14) en Python ?';

-- PY Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel mot-cle permet de definir une fonction en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'function', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de definir une fonction en Python ?' UNION ALL
SELECT id, 'B', 'func', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de definir une fonction en Python ?' UNION ALL
SELECT id, 'C', 'def', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de definir une fonction en Python ?' UNION ALL
SELECT id, 'D', 'define', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de definir une fonction en Python ?';

-- PY Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle structure de donnees Python est immuable ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'list', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure de donnees Python est immuable ?' UNION ALL
SELECT id, 'B', 'dict', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure de donnees Python est immuable ?' UNION ALL
SELECT id, 'C', 'set', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure de donnees Python est immuable ?' UNION ALL
SELECT id, 'D', 'tuple', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle structure de donnees Python est immuable ?';

-- PY Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de len("Bonjour") en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '6', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de len("Bonjour") en Python ?' UNION ALL
SELECT id, 'B', '7', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de len("Bonjour") en Python ?' UNION ALL
SELECT id, 'C', '8', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de len("Bonjour") en Python ?' UNION ALL
SELECT id, 'D', 'Une erreur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de len("Bonjour") en Python ?';

-- PY Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Comment ecrire un commentaire sur une seule ligne en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '// commentaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment ecrire un commentaire sur une seule ligne en Python ?' UNION ALL
SELECT id, 'B', '# commentaire', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment ecrire un commentaire sur une seule ligne en Python ?' UNION ALL
SELECT id, 'C', '/* commentaire */', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment ecrire un commentaire sur une seule ligne en Python ?' UNION ALL
SELECT id, 'D', '-- commentaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment ecrire un commentaire sur une seule ligne en Python ?';

-- PY Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel operateur est utilise pour la division entiere en Python 3 ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '/', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel operateur est utilise pour la division entiere en Python 3 ?' UNION ALL
SELECT id, 'B', '//', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel operateur est utilise pour la division entiere en Python 3 ?' UNION ALL
SELECT id, 'C', '%', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel operateur est utilise pour la division entiere en Python 3 ?' UNION ALL
SELECT id, 'D', '\\', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel operateur est utilise pour la division entiere en Python 3 ?';

-- PY Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle fonction permet de convertir une chaine en entier ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'str()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction permet de convertir une chaine en entier ?' UNION ALL
SELECT id, 'B', 'float()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction permet de convertir une chaine en entier ?' UNION ALL
SELECT id, 'C', 'int()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction permet de convertir une chaine en entier ?' UNION ALL
SELECT id, 'D', 'bool()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction permet de convertir une chaine en entier ?';

-- PY Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de bool("") en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'True', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de bool("") en Python ?' UNION ALL
SELECT id, 'B', 'False', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de bool("") en Python ?' UNION ALL
SELECT id, 'C', 'None', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de bool("") en Python ?' UNION ALL
SELECT id, 'D', 'Une erreur TypeError', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de bool("") en Python ?';

-- PY Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle methode permet d''ajouter un element a la fin d''une liste ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'add()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet d''ajouter un element a la fin d''une liste ?' UNION ALL
SELECT id, 'B', 'append()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet d''ajouter un element a la fin d''une liste ?' UNION ALL
SELECT id, 'C', 'push()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet d''ajouter un element a la fin d''une liste ?' UNION ALL
SELECT id, 'D', 'insert()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle methode permet d''ajouter un element a la fin d''une liste ?';

-- PY Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Comment acceder au dernier element d''une liste en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'liste[last]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder au dernier element d''une liste en Python ?' UNION ALL
SELECT id, 'B', 'liste[-1]', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder au dernier element d''une liste en Python ?' UNION ALL
SELECT id, 'C', 'liste[len(liste)]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder au dernier element d''une liste en Python ?' UNION ALL
SELECT id, 'D', 'liste.last()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment acceder au dernier element d''une liste en Python ?';

-- PY Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de [1, 2, 3] + [4, 5] en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '[1, 2, 3, 4, 5]', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [1, 2, 3] + [4, 5] en Python ?' UNION ALL
SELECT id, 'B', '[5, 7]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [1, 2, 3] + [4, 5] en Python ?' UNION ALL
SELECT id, 'C', 'Une erreur TypeError', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [1, 2, 3] + [4, 5] en Python ?' UNION ALL
SELECT id, 'D', '[[1, 2, 3], [4, 5]]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [1, 2, 3] + [4, 5] en Python ?';

-- PY Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel mot-cle permet de verifier l''appartenance d''un element a une collection ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'has', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de verifier l''appartenance d''un element a une collection ?' UNION ALL
SELECT id, 'B', 'contains', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de verifier l''appartenance d''un element a une collection ?' UNION ALL
SELECT id, 'C', 'in', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de verifier l''appartenance d''un element a une collection ?' UNION ALL
SELECT id, 'D', 'exists', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle permet de verifier l''appartenance d''un element a une collection ?';

-- PY Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de "hello".upper() en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Hello', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de "hello".upper() en Python ?' UNION ALL
SELECT id, 'B', 'HELLO', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de "hello".upper() en Python ?' UNION ALL
SELECT id, 'C', 'hello', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de "hello".upper() en Python ?' UNION ALL
SELECT id, 'D', 'hELLO', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de "hello".upper() en Python ?';

-- PY Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle est la valeur par defaut d''un parametre non initialise en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par defaut d''un parametre non initialise en Python ?' UNION ALL
SELECT id, 'B', 'null', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par defaut d''un parametre non initialise en Python ?' UNION ALL
SELECT id, 'C', 'None', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par defaut d''un parametre non initialise en Python ?' UNION ALL
SELECT id, 'D', '0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par defaut d''un parametre non initialise en Python ?';

-- PY Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel mot-cle est utilise pour gerer les exceptions en Python ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'catch', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle est utilise pour gerer les exceptions en Python ?' UNION ALL
SELECT id, 'B', 'except', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle est utilise pour gerer les exceptions en Python ?' UNION ALL
SELECT id, 'C', 'rescue', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle est utilise pour gerer les exceptions en Python ?' UNION ALL
SELECT id, 'D', 'handle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-cle est utilise pour gerer les exceptions en Python ?';

-- PY Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de [x**2 for x in range(4)] ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '[1, 4, 9, 16]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [x**2 for x in range(4)] ?' UNION ALL
SELECT id, 'B', '[0, 1, 4, 9]', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [x**2 for x in range(4)] ?' UNION ALL
SELECT id, 'C', '[0, 2, 4, 6]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [x**2 for x in range(4)] ?' UNION ALL
SELECT id, 'D', '[0, 1, 4, 9, 16]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de [x**2 for x in range(4)] ?';

-- PY Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait le decorateur @staticmethod en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il rend la methode privee', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @staticmethod en Python ?' UNION ALL
SELECT id, 'B', 'Il definit une methode qui ne recoit ni self ni cls', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @staticmethod en Python ?' UNION ALL
SELECT id, 'C', 'Il empeche la methode d''etre surchargee', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @staticmethod en Python ?' UNION ALL
SELECT id, 'D', 'Il rend la methode asynchrone', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @staticmethod en Python ?';

-- PY Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle est la difference entre == et is en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune difference', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et is en Python ?' UNION ALL
SELECT id, 'B', '== compare les valeurs, is compare les identites (references)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et is en Python ?' UNION ALL
SELECT id, 'C', '== compare les types, is compare les valeurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et is en Python ?' UNION ALL
SELECT id, 'D', 'is est plus rapide que == mais fait la meme chose', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre == et is en Python ?';

-- PY Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de {"a": 1, "b": 2}.get("c", 0) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'None', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {"a": 1, "b": 2}.get("c", 0) ?' UNION ALL
SELECT id, 'B', 'KeyError', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {"a": 1, "b": 2}.get("c", 0) ?' UNION ALL
SELECT id, 'C', '0', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {"a": 1, "b": 2}.get("c", 0) ?' UNION ALL
SELECT id, 'D', 'False', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {"a": 1, "b": 2}.get("c", 0) ?';

-- PY Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que retourne la fonction enumerate() en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une liste de valeurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne la fonction enumerate() en Python ?' UNION ALL
SELECT id, 'B', 'Un iterateur de tuples (index, valeur)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne la fonction enumerate() en Python ?' UNION ALL
SELECT id, 'C', 'Un dictionnaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne la fonction enumerate() en Python ?' UNION ALL
SELECT id, 'D', 'La taille de la collection', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne la fonction enumerate() en Python ?';

-- PY Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle est la syntaxe correcte d''une f-string en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'f"Bonjour {nom}"', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une f-string en Python ?' UNION ALL
SELECT id, 'B', '"Bonjour ${nom}"', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une f-string en Python ?' UNION ALL
SELECT id, 'C', '"Bonjour #{nom}"', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une f-string en Python ?' UNION ALL
SELECT id, 'D', 'format("Bonjour {}", nom)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une f-string en Python ?';

-- PY Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait le mot-cle yield en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il arrete definitivement la fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield en Python ?' UNION ALL
SELECT id, 'B', 'Il transforme la fonction en generateur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield en Python ?' UNION ALL
SELECT id, 'C', 'Il importe un module', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield en Python ?' UNION ALL
SELECT id, 'D', 'Il declare une variable globale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-cle yield en Python ?';

-- PY Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait l''instruction with open("f.txt") as f en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle ouvre le fichier et le ferme automatiquement a la fin du bloc', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction with open("f.txt") as f en Python ?' UNION ALL
SELECT id, 'B', 'Elle ouvre le fichier en mode ecriture uniquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction with open("f.txt") as f en Python ?' UNION ALL
SELECT id, 'C', 'Elle cree un nouveau fichier meme s''il existe deja', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction with open("f.txt") as f en Python ?' UNION ALL
SELECT id, 'D', 'Elle verrouille le fichier pour les autres processus', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction with open("f.txt") as f en Python ?';

-- PY Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Lesquels sont des types de donnees immuables en Python ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'str', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des types de donnees immuables en Python ?' UNION ALL
SELECT id, 'B', 'list', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des types de donnees immuables en Python ?' UNION ALL
SELECT id, 'C', 'tuple', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des types de donnees immuables en Python ?' UNION ALL
SELECT id, 'D', 'frozenset', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des types de donnees immuables en Python ?';

-- PY Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de sorted([3, 1, 2], reverse=True) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '[1, 2, 3]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de sorted([3, 1, 2], reverse=True) ?' UNION ALL
SELECT id, 'B', '[3, 2, 1]', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de sorted([3, 1, 2], reverse=True) ?' UNION ALL
SELECT id, 'C', '[3, 1, 2]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de sorted([3, 1, 2], reverse=True) ?' UNION ALL
SELECT id, 'D', 'None (modifie la liste en place)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de sorted([3, 1, 2], reverse=True) ?';

-- PY Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait la methode __init__ dans une classe Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle detruit l''objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode __init__ dans une classe Python ?' UNION ALL
SELECT id, 'B', 'Elle initialise les attributs de l''instance', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode __init__ dans une classe Python ?' UNION ALL
SELECT id, 'C', 'Elle cree la classe elle-meme', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode __init__ dans une classe Python ?' UNION ALL
SELECT id, 'D', 'Elle rend la classe abstraite', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la methode __init__ dans une classe Python ?';

-- PY Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle est la difference entre une liste et un generateur en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un generateur stocke toutes les valeurs en memoire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre une liste et un generateur en Python ?' UNION ALL
SELECT id, 'B', 'Un generateur produit les valeurs a la demande (lazy evaluation)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre une liste et un generateur en Python ?' UNION ALL
SELECT id, 'C', 'Un generateur est plus rapide pour l''acces par index', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre une liste et un generateur en Python ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune difference fonctionnelle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre une liste et un generateur en Python ?';

-- PY Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Lesquelles sont des manieres valides de creer un dictionnaire en Python ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '{"cle": "valeur"}', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des manieres valides de creer un dictionnaire en Python ?' UNION ALL
SELECT id, 'B', 'dict(cle="valeur")', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des manieres valides de creer un dictionnaire en Python ?' UNION ALL
SELECT id, 'C', 'dict([(''cle'', ''valeur'')])', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des manieres valides de creer un dictionnaire en Python ?' UNION ALL
SELECT id, 'D', '[cle: valeur]', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des manieres valides de creer un dictionnaire en Python ?';

-- PY Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait la fonction map() en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle cree un dictionnaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction map() en Python ?' UNION ALL
SELECT id, 'B', 'Elle applique une fonction a chaque element d''un iterable', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction map() en Python ?' UNION ALL
SELECT id, 'C', 'Elle filtre les elements d''une liste', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction map() en Python ?' UNION ALL
SELECT id, 'D', 'Elle trie une liste', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction map() en Python ?';

-- PY Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de {1, 2, 3} & {2, 3, 4} en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '{1, 2, 3, 4}', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {1, 2, 3} & {2, 3, 4} en Python ?' UNION ALL
SELECT id, 'B', '{2, 3}', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {1, 2, 3} & {2, 3, 4} en Python ?' UNION ALL
SELECT id, 'C', '{1, 4}', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {1, 2, 3} & {2, 3, 4} en Python ?' UNION ALL
SELECT id, 'D', 'Une erreur TypeError', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de {1, 2, 3} & {2, 3, 4} en Python ?';

-- PY Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait le decorateur @property en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il rend l''attribut prive', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @property en Python ?' UNION ALL
SELECT id, 'B', 'Il permet d''acceder a une methode comme un attribut', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @property en Python ?' UNION ALL
SELECT id, 'C', 'Il rend l''attribut constant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @property en Python ?' UNION ALL
SELECT id, 'D', 'Il cree une variable de classe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @property en Python ?';

-- PY Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Lesquels sont des modules de la bibliotheque standard Python ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'os', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des modules de la bibliotheque standard Python ?' UNION ALL
SELECT id, 'B', 'numpy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des modules de la bibliotheque standard Python ?' UNION ALL
SELECT id, 'C', 'json', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des modules de la bibliotheque standard Python ?' UNION ALL
SELECT id, 'D', 'collections', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des modules de la bibliotheque standard Python ?';

-- PY Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le resultat de " hello ".strip() en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '" hello"', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de " hello ".strip() en Python ?' UNION ALL
SELECT id, 'B', '"hello "', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de " hello ".strip() en Python ?' UNION ALL
SELECT id, 'C', '"hello"', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de " hello ".strip() en Python ?' UNION ALL
SELECT id, 'D', '" hello "', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le resultat de " hello ".strip() en Python ?';

-- PY Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que permet l''unpacking en Python avec *args ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Passer un nombre variable d''arguments positionnels a une fonction', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet l''unpacking en Python avec *args ?' UNION ALL
SELECT id, 'B', 'Passer un nombre variable d''arguments nommes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet l''unpacking en Python avec *args ?' UNION ALL
SELECT id, 'C', 'Definir des arguments obligatoires', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet l''unpacking en Python avec *args ?' UNION ALL
SELECT id, 'D', 'Creer un tuple immuable', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet l''unpacking en Python avec *args ?';

-- PY Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait la fonction zip() en Python ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle compresse un fichier', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction zip() en Python ?' UNION ALL
SELECT id, 'B', 'Elle combine plusieurs iterables en tuples', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction zip() en Python ?' UNION ALL
SELECT id, 'C', 'Elle fusionne deux dictionnaires', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction zip() en Python ?' UNION ALL
SELECT id, 'D', 'Elle concatene deux listes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction zip() en Python ?';

-- PY Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que represente l''operateur walrus := en Python 3.8+ ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une comparaison stricte', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que represente l''operateur walrus := en Python 3.8+ ?' UNION ALL
SELECT id, 'B', 'Une affectation dans une expression (assignment expression)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que represente l''operateur walrus := en Python 3.8+ ?' UNION ALL
SELECT id, 'C', 'Une declaration de type', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que represente l''operateur walrus := en Python 3.8+ ?' UNION ALL
SELECT id, 'D', 'Un alias d''import', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que represente l''operateur walrus := en Python 3.8+ ?';

-- PY Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est le role de la methode __str__ vs __repr__ dans une classe Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '__str__ est pour l''utilisateur, __repr__ est pour le developpeur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le role de la methode __str__ vs __repr__ dans une classe Python ?' UNION ALL
SELECT id, 'B', '__repr__ est pour l''utilisateur, __str__ est pour le developpeur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le role de la methode __str__ vs __repr__ dans une classe Python ?' UNION ALL
SELECT id, 'C', 'Les deux font exactement la meme chose', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le role de la methode __str__ vs __repr__ dans une classe Python ?' UNION ALL
SELECT id, 'D', '__str__ est appele par print(), __repr__ n''est jamais appele automatiquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le role de la methode __str__ vs __repr__ dans une classe Python ?';

-- PY Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait le decorateur @dataclass en Python 3.7+ ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il cree automatiquement __init__, __repr__ et __eq__', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @dataclass en Python 3.7+ ?' UNION ALL
SELECT id, 'B', 'Il rend la classe immuable', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @dataclass en Python 3.7+ ?' UNION ALL
SELECT id, 'C', 'Il transforme la classe en dictionnaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @dataclass en Python 3.7+ ?' UNION ALL
SELECT id, 'D', 'Il cree une base de donnees SQLite', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le decorateur @dataclass en Python 3.7+ ?';

-- PY Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Comment definir une fonction asynchrone en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'def async ma_fonction():', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment definir une fonction asynchrone en Python ?' UNION ALL
SELECT id, 'B', 'async def ma_fonction():', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment definir une fonction asynchrone en Python ?' UNION ALL
SELECT id, 'C', '@async def ma_fonction():', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment definir une fonction asynchrone en Python ?' UNION ALL
SELECT id, 'D', 'def ma_fonction() async:', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment definir une fonction asynchrone en Python ?';

-- PY Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait l''instruction nonlocal en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle declare une variable globale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction nonlocal en Python ?' UNION ALL
SELECT id, 'B', 'Elle permet de modifier une variable de la portee englobante (closure)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction nonlocal en Python ?' UNION ALL
SELECT id, 'C', 'Elle supprime une variable locale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction nonlocal en Python ?' UNION ALL
SELECT id, 'D', 'Elle importe un module externe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''instruction nonlocal en Python ?';

-- PY Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que sont les metaclasses en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Des classes abstraites', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les metaclasses en Python ?' UNION ALL
SELECT id, 'B', 'Des classes qui creent d''autres classes', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les metaclasses en Python ?' UNION ALL
SELECT id, 'C', 'Des classes qui ne peuvent pas etre instanciees', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les metaclasses en Python ?' UNION ALL
SELECT id, 'D', 'Des classes qui heritent de plusieurs parents', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les metaclasses en Python ?';

-- PY Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quel est l''ordre de resolution des methodes (MRO) en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Depth-First Search (DFS)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''ordre de resolution des methodes (MRO) en Python ?' UNION ALL
SELECT id, 'B', 'Breadth-First Search (BFS)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''ordre de resolution des methodes (MRO) en Python ?' UNION ALL
SELECT id, 'C', 'Algorithme C3 de linearisation', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''ordre de resolution des methodes (MRO) en Python ?' UNION ALL
SELECT id, 'D', 'Ordre alphabetique des classes parentes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''ordre de resolution des methodes (MRO) en Python ?';

-- PY Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Lesquels sont des usages valides des type hints en Python ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'def f(x: int) -> str:', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des usages valides des type hints en Python ?' UNION ALL
SELECT id, 'B', 'x: list[int] = []', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des usages valides des type hints en Python ?' UNION ALL
SELECT id, 'C', 'from typing import Optional; x: Optional[str]', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des usages valides des type hints en Python ?' UNION ALL
SELECT id, 'D', 'def f(x: int) => str:', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquels sont des usages valides des type hints en Python ?';

-- PY Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Qu''est-ce que le GIL (Global Interpreter Lock) en CPython ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un mecanisme de gestion de la memoire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le GIL (Global Interpreter Lock) en CPython ?' UNION ALL
SELECT id, 'B', 'Un verrou qui empeche l''execution simultanee de threads Python', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le GIL (Global Interpreter Lock) en CPython ?' UNION ALL
SELECT id, 'C', 'Un outil de debogage integre', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le GIL (Global Interpreter Lock) en CPython ?' UNION ALL
SELECT id, 'D', 'Un systeme de gestion des packages', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le GIL (Global Interpreter Lock) en CPython ?';

-- PY Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait le protocole de descripteur (__get__, __set__, __delete__) en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il gere la serialisation des objets', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le protocole de descripteur (__get__, __set__, __delete__) en Python ?' UNION ALL
SELECT id, 'B', 'Il personnalise l''acces aux attributs d''une classe', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le protocole de descripteur (__get__, __set__, __delete__) en Python ?' UNION ALL
SELECT id, 'C', 'Il definit les operateurs de comparaison', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le protocole de descripteur (__get__, __set__, __delete__) en Python ?' UNION ALL
SELECT id, 'D', 'Il gere les entrees/sorties fichier', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le protocole de descripteur (__get__, __set__, __delete__) en Python ?';

-- PY Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Lesquelles sont des bonnes pratiques pour la gestion des exceptions en Python ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Attraper des exceptions specifiques plutot que Exception', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des bonnes pratiques pour la gestion des exceptions en Python ?' UNION ALL
SELECT id, 'B', 'Utiliser except: sans specifier l''exception', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des bonnes pratiques pour la gestion des exceptions en Python ?' UNION ALL
SELECT id, 'C', 'Utiliser finally pour le nettoyage des ressources', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des bonnes pratiques pour la gestion des exceptions en Python ?' UNION ALL
SELECT id, 'D', 'Creer des exceptions personnalisees heritant de Exception', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des bonnes pratiques pour la gestion des exceptions en Python ?';

-- PY Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Quelle est la difference entre deepcopy et copy en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'copy cree une copie superficielle, deepcopy copie recursivement tous les objets imbriques', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre deepcopy et copy en Python ?' UNION ALL
SELECT id, 'B', 'deepcopy est plus rapide que copy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre deepcopy et copy en Python ?' UNION ALL
SELECT id, 'C', 'copy ne fonctionne qu''avec les listes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre deepcopy et copy en Python ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune difference', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la difference entre deepcopy et copy en Python ?';

-- PY Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Qu''est-ce qu''un context manager personnalise en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un objet qui implemente __enter__ et __exit__', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un context manager personnalise en Python ?' UNION ALL
SELECT id, 'B', 'Un objet qui implemente __init__ et __del__', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un context manager personnalise en Python ?' UNION ALL
SELECT id, 'C', 'Un decorateur qui gere les erreurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un context manager personnalise en Python ?' UNION ALL
SELECT id, 'D', 'Une classe qui herite de ContextManager', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un context manager personnalise en Python ?';

-- PY Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Lesquelles sont des caracteristiques de asyncio en Python ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il utilise une boucle evenementielle (event loop)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des caracteristiques de asyncio en Python ?' UNION ALL
SELECT id, 'B', 'Il permet le parallelisme multi-coeur natif', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des caracteristiques de asyncio en Python ?' UNION ALL
SELECT id, 'C', 'Il supporte les coroutines avec async/await', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des caracteristiques de asyncio en Python ?' UNION ALL
SELECT id, 'D', 'Il permet la concurrence cooperative (non preemptive)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Lesquelles sont des caracteristiques de asyncio en Python ?';

-- PY Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'python'), 'Que fait functools.lru_cache en Python ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il limite le nombre d''appels a une fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait functools.lru_cache en Python ?' UNION ALL
SELECT id, 'B', 'Il met en cache les resultats d''une fonction selon ses arguments (memoisation)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait functools.lru_cache en Python ?' UNION ALL
SELECT id, 'C', 'Il compresse les donnees retournees par une fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait functools.lru_cache en Python ?' UNION ALL
SELECT id, 'D', 'Il enregistre les appels de fonction dans un fichier log', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait functools.lru_cache en Python ?';


-- ==================== SQL (50 questions) ====================

-- SQL Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle commande SQL permet de récupérer des données dans une table ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'SELECT', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de récupérer des données dans une table ?' UNION ALL
SELECT id, 'B', 'FETCH', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de récupérer des données dans une table ?' UNION ALL
SELECT id, 'C', 'GET', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de récupérer des données dans une table ?' UNION ALL
SELECT id, 'D', 'RETRIEVE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de récupérer des données dans une table ?';

-- SQL Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel mot-clé permet de filtrer les résultats d''une requête SELECT ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'FILTER', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de filtrer les résultats d''une requête SELECT ?' UNION ALL
SELECT id, 'B', 'WHERE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de filtrer les résultats d''une requête SELECT ?' UNION ALL
SELECT id, 'C', 'HAVING', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de filtrer les résultats d''une requête SELECT ?' UNION ALL
SELECT id, 'D', 'CONDITION', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de filtrer les résultats d''une requête SELECT ?';

-- SQL Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle clause permet de trier les résultats d''une requête ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'SORT BY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de trier les résultats d''une requête ?' UNION ALL
SELECT id, 'B', 'GROUP BY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de trier les résultats d''une requête ?' UNION ALL
SELECT id, 'C', 'ORDER BY', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de trier les résultats d''une requête ?' UNION ALL
SELECT id, 'D', 'ARRANGE BY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de trier les résultats d''une requête ?';

-- SQL Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle commande SQL permet de supprimer des lignes d''une table ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'REMOVE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de supprimer des lignes d''une table ?' UNION ALL
SELECT id, 'B', 'DROP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de supprimer des lignes d''une table ?' UNION ALL
SELECT id, 'C', 'DELETE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de supprimer des lignes d''une table ?' UNION ALL
SELECT id, 'D', 'ERASE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de supprimer des lignes d''une table ?';

-- SQL Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel mot-clé permet d''éliminer les doublons dans un résultat SELECT ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'UNIQUE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet d''éliminer les doublons dans un résultat SELECT ?' UNION ALL
SELECT id, 'B', 'DISTINCT', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet d''éliminer les doublons dans un résultat SELECT ?' UNION ALL
SELECT id, 'C', 'NO_DUPLICATE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet d''éliminer les doublons dans un résultat SELECT ?' UNION ALL
SELECT id, 'D', 'SINGLE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet d''éliminer les doublons dans un résultat SELECT ?';

-- SQL Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle fonction d''agrégation permet de compter le nombre de lignes ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'SUM()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction d''agrégation permet de compter le nombre de lignes ?' UNION ALL
SELECT id, 'B', 'COUNT()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction d''agrégation permet de compter le nombre de lignes ?' UNION ALL
SELECT id, 'C', 'TOTAL()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction d''agrégation permet de compter le nombre de lignes ?' UNION ALL
SELECT id, 'D', 'NUMBER()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction d''agrégation permet de compter le nombre de lignes ?';

-- SQL Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle contrainte garantit qu''une colonne ne peut pas contenir de valeurs NULL ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'REQUIRED', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte garantit qu''une colonne ne peut pas contenir de valeurs NULL ?' UNION ALL
SELECT id, 'B', 'MANDATORY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte garantit qu''une colonne ne peut pas contenir de valeurs NULL ?' UNION ALL
SELECT id, 'C', 'NOT NULL', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte garantit qu''une colonne ne peut pas contenir de valeurs NULL ?' UNION ALL
SELECT id, 'D', 'NO_EMPTY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte garantit qu''une colonne ne peut pas contenir de valeurs NULL ?';

-- SQL Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel opérateur SQL permet de rechercher un motif dans une chaîne de caractères ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'MATCH', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur SQL permet de rechercher un motif dans une chaîne de caractères ?' UNION ALL
SELECT id, 'B', 'LIKE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur SQL permet de rechercher un motif dans une chaîne de caractères ?' UNION ALL
SELECT id, 'C', 'SEARCH', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur SQL permet de rechercher un motif dans une chaîne de caractères ?' UNION ALL
SELECT id, 'D', 'FIND', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur SQL permet de rechercher un motif dans une chaîne de caractères ?';

-- SQL Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle commande permet de modifier des données existantes dans une table ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'MODIFY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier des données existantes dans une table ?' UNION ALL
SELECT id, 'B', 'CHANGE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier des données existantes dans une table ?' UNION ALL
SELECT id, 'C', 'UPDATE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier des données existantes dans une table ?' UNION ALL
SELECT id, 'D', 'ALTER', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier des données existantes dans une table ?';

-- SQL Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel caractère joker représente zéro ou plusieurs caractères avec l''opérateur LIKE ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '*', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel caractère joker représente zéro ou plusieurs caractères avec l''opérateur LIKE ?' UNION ALL
SELECT id, 'B', '?', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel caractère joker représente zéro ou plusieurs caractères avec l''opérateur LIKE ?' UNION ALL
SELECT id, 'C', '%', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel caractère joker représente zéro ou plusieurs caractères avec l''opérateur LIKE ?' UNION ALL
SELECT id, 'D', '#', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel caractère joker représente zéro ou plusieurs caractères avec l''opérateur LIKE ?';

-- SQL Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle clause permet de limiter le nombre de résultats retournés en PostgreSQL ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'TOP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de limiter le nombre de résultats retournés en PostgreSQL ?' UNION ALL
SELECT id, 'B', 'LIMIT', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de limiter le nombre de résultats retournés en PostgreSQL ?' UNION ALL
SELECT id, 'C', 'ROWNUM', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de limiter le nombre de résultats retournés en PostgreSQL ?' UNION ALL
SELECT id, 'D', 'FIRST', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause permet de limiter le nombre de résultats retournés en PostgreSQL ?';

-- SQL Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel opérateur permet de vérifier si une valeur est comprise dans un intervalle ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'IN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de vérifier si une valeur est comprise dans un intervalle ?' UNION ALL
SELECT id, 'B', 'RANGE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de vérifier si une valeur est comprise dans un intervalle ?' UNION ALL
SELECT id, 'C', 'BETWEEN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de vérifier si une valeur est comprise dans un intervalle ?' UNION ALL
SELECT id, 'D', 'WITHIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de vérifier si une valeur est comprise dans un intervalle ?';

-- SQL Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle commande permet d''insérer de nouvelles données dans une table ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'ADD INTO', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''insérer de nouvelles données dans une table ?' UNION ALL
SELECT id, 'B', 'INSERT INTO', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''insérer de nouvelles données dans une table ?' UNION ALL
SELECT id, 'C', 'PUT INTO', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''insérer de nouvelles données dans une table ?' UNION ALL
SELECT id, 'D', 'CREATE INTO', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''insérer de nouvelles données dans une table ?';

-- SQL Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle est la différence principale entre WHERE et HAVING ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre WHERE et HAVING ?' UNION ALL
SELECT id, 'B', 'WHERE filtre avant le GROUP BY, HAVING filtre après', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre WHERE et HAVING ?' UNION ALL
SELECT id, 'C', 'HAVING est plus rapide que WHERE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre WHERE et HAVING ?' UNION ALL
SELECT id, 'D', 'WHERE ne fonctionne qu''avec des nombres', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre WHERE et HAVING ?';

-- SQL Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel type de JOIN retourne uniquement les lignes ayant une correspondance dans les deux tables ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'LEFT JOIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne uniquement les lignes ayant une correspondance dans les deux tables ?' UNION ALL
SELECT id, 'B', 'RIGHT JOIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne uniquement les lignes ayant une correspondance dans les deux tables ?' UNION ALL
SELECT id, 'C', 'INNER JOIN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne uniquement les lignes ayant une correspondance dans les deux tables ?' UNION ALL
SELECT id, 'D', 'FULL JOIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne uniquement les lignes ayant une correspondance dans les deux tables ?';

-- SQL Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Que signifie l''acronyme ACID dans le contexte des transactions ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Atomicité, Cohérence, Isolation, Durabilité', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme ACID dans le contexte des transactions ?' UNION ALL
SELECT id, 'B', 'Addition, Calcul, Indexation, Données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme ACID dans le contexte des transactions ?' UNION ALL
SELECT id, 'C', 'Accès, Contrôle, Intégrité, Distribution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme ACID dans le contexte des transactions ?' UNION ALL
SELECT id, 'D', 'Authentification, Chiffrement, Identification, Déchiffrement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme ACID dans le contexte des transactions ?';

-- SQL Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle est la forme normale qui élimine les dépendances transitives ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Première forme normale (1NF)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la forme normale qui élimine les dépendances transitives ?' UNION ALL
SELECT id, 'B', 'Deuxième forme normale (2NF)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la forme normale qui élimine les dépendances transitives ?' UNION ALL
SELECT id, 'C', 'Troisième forme normale (3NF)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la forme normale qui élimine les dépendances transitives ?' UNION ALL
SELECT id, 'D', 'Forme normale de Boyce-Codd (BCNF)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la forme normale qui élimine les dépendances transitives ?';

-- SQL Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel type d''index est créé automatiquement sur une clé primaire ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Index composite', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index est créé automatiquement sur une clé primaire ?' UNION ALL
SELECT id, 'B', 'Index unique', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index est créé automatiquement sur une clé primaire ?' UNION ALL
SELECT id, 'C', 'Index partiel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index est créé automatiquement sur une clé primaire ?' UNION ALL
SELECT id, 'D', 'Index fonctionnel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index est créé automatiquement sur une clé primaire ?';

-- SQL Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle commande permet d''annuler une transaction en cours ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'CANCEL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''annuler une transaction en cours ?' UNION ALL
SELECT id, 'B', 'UNDO', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''annuler une transaction en cours ?' UNION ALL
SELECT id, 'C', 'ROLLBACK', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''annuler une transaction en cours ?' UNION ALL
SELECT id, 'D', 'REVERT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''annuler une transaction en cours ?';

-- SQL Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Qu''est-ce qu''une sous-requête corrélée ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une requête qui ne retourne qu''une seule ligne', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une sous-requête corrélée ?' UNION ALL
SELECT id, 'B', 'Une sous-requête qui fait référence à une colonne de la requête externe', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une sous-requête corrélée ?' UNION ALL
SELECT id, 'C', 'Une requête qui utilise deux tables', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une sous-requête corrélée ?' UNION ALL
SELECT id, 'D', 'Une requête imbriquée dans un INSERT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une sous-requête corrélée ?';

-- SQL Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle clause SQL définit une CTE (Common Table Expression) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'WITH', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause SQL définit une CTE (Common Table Expression) ?' UNION ALL
SELECT id, 'B', 'DEFINE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause SQL définit une CTE (Common Table Expression) ?' UNION ALL
SELECT id, 'C', 'DECLARE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause SQL définit une CTE (Common Table Expression) ?' UNION ALL
SELECT id, 'D', 'AS TABLE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause SQL définit une CTE (Common Table Expression) ?';

-- SQL Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelles sont des fonctions d''agrégation valides en SQL ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'SUM()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des fonctions d''agrégation valides en SQL ?' UNION ALL
SELECT id, 'B', 'AVG()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des fonctions d''agrégation valides en SQL ?' UNION ALL
SELECT id, 'C', 'CONCAT()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des fonctions d''agrégation valides en SQL ?' UNION ALL
SELECT id, 'D', 'MAX()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des fonctions d''agrégation valides en SQL ?';

-- SQL Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel type de JOIN retourne toutes les lignes de la table de gauche même sans correspondance ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'INNER JOIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne toutes les lignes de la table de gauche même sans correspondance ?' UNION ALL
SELECT id, 'B', 'LEFT JOIN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne toutes les lignes de la table de gauche même sans correspondance ?' UNION ALL
SELECT id, 'C', 'RIGHT JOIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne toutes les lignes de la table de gauche même sans correspondance ?' UNION ALL
SELECT id, 'D', 'CROSS JOIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de JOIN retourne toutes les lignes de la table de gauche même sans correspondance ?';

-- SQL Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle est la différence entre DELETE et TRUNCATE ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre DELETE et TRUNCATE ?' UNION ALL
SELECT id, 'B', 'DELETE peut avoir un WHERE, TRUNCATE supprime toutes les lignes', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre DELETE et TRUNCATE ?' UNION ALL
SELECT id, 'C', 'TRUNCATE est plus lent que DELETE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre DELETE et TRUNCATE ?' UNION ALL
SELECT id, 'D', 'DELETE supprime la table, TRUNCATE supprime les données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre DELETE et TRUNCATE ?';

-- SQL Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Qu''est-ce qu''une vue (VIEW) en SQL ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une copie physique d''une table', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une vue (VIEW) en SQL ?' UNION ALL
SELECT id, 'B', 'Un type de données spécial', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une vue (VIEW) en SQL ?' UNION ALL
SELECT id, 'C', 'Une requête SELECT sauvegardée qui agit comme une table virtuelle', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une vue (VIEW) en SQL ?' UNION ALL
SELECT id, 'D', 'Un index sur plusieurs colonnes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une vue (VIEW) en SQL ?';

-- SQL Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quels sont des types de contraintes valides en SQL ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'PRIMARY KEY', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types de contraintes valides en SQL ?' UNION ALL
SELECT id, 'B', 'FOREIGN KEY', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types de contraintes valides en SQL ?' UNION ALL
SELECT id, 'C', 'SECONDARY KEY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types de contraintes valides en SQL ?' UNION ALL
SELECT id, 'D', 'CHECK', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types de contraintes valides en SQL ?';

-- SQL Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel opérateur permet de combiner les résultats de deux requêtes SELECT en éliminant les doublons ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'UNION', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de combiner les résultats de deux requêtes SELECT en éliminant les doublons ?' UNION ALL
SELECT id, 'B', 'UNION ALL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de combiner les résultats de deux requêtes SELECT en éliminant les doublons ?' UNION ALL
SELECT id, 'C', 'MERGE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de combiner les résultats de deux requêtes SELECT en éliminant les doublons ?' UNION ALL
SELECT id, 'D', 'CONCAT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel opérateur permet de combiner les résultats de deux requêtes SELECT en éliminant les doublons ?';

-- SQL Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel mot-clé permet de renommer une colonne ou une table dans une requête ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'RENAME', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de renommer une colonne ou une table dans une requête ?' UNION ALL
SELECT id, 'B', 'AS', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de renommer une colonne ou une table dans une requête ?' UNION ALL
SELECT id, 'C', 'ALIAS', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de renommer une colonne ou une table dans une requête ?' UNION ALL
SELECT id, 'D', 'NAME', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de renommer une colonne ou une table dans une requête ?';

-- SQL Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle fonction de fenêtre (window function) attribue un numéro séquentiel à chaque ligne ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'RANK()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre (window function) attribue un numéro séquentiel à chaque ligne ?' UNION ALL
SELECT id, 'B', 'DENSE_RANK()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre (window function) attribue un numéro séquentiel à chaque ligne ?' UNION ALL
SELECT id, 'C', 'ROW_NUMBER()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre (window function) attribue un numéro séquentiel à chaque ligne ?' UNION ALL
SELECT id, 'D', 'NTILE()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre (window function) attribue un numéro séquentiel à chaque ligne ?';

-- SQL Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelles affirmations sont vraies concernant les index en SQL ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ils accélèrent les requêtes SELECT', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les index en SQL ?' UNION ALL
SELECT id, 'B', 'Ils ralentissent les opérations INSERT et UPDATE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les index en SQL ?' UNION ALL
SELECT id, 'C', 'Ils ne consomment pas d''espace disque supplémentaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les index en SQL ?' UNION ALL
SELECT id, 'D', 'Ils occupent de l''espace disque supplémentaire', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les index en SQL ?';

-- SQL Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle est la différence entre RANK() et DENSE_RANK() ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'RANK() laisse des trous dans la numérotation en cas d''égalité, DENSE_RANK() non', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre RANK() et DENSE_RANK() ?' UNION ALL
SELECT id, 'B', 'DENSE_RANK() est plus rapide que RANK()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre RANK() et DENSE_RANK() ?' UNION ALL
SELECT id, 'C', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre RANK() et DENSE_RANK() ?' UNION ALL
SELECT id, 'D', 'RANK() commence à 0, DENSE_RANK() commence à 1', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre RANK() et DENSE_RANK() ?';

-- SQL Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Qu''est-ce qu''un deadlock dans le contexte des bases de données ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une erreur de syntaxe dans une requête', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un deadlock dans le contexte des bases de données ?' UNION ALL
SELECT id, 'B', 'Un verrouillage circulaire où deux transactions s''attendent mutuellement', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un deadlock dans le contexte des bases de données ?' UNION ALL
SELECT id, 'C', 'Une table qui ne peut plus être modifiée', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un deadlock dans le contexte des bases de données ?' UNION ALL
SELECT id, 'D', 'Une connexion qui a expiré', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un deadlock dans le contexte des bases de données ?';

-- SQL Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel niveau d''isolation des transactions permet les lectures fantômes (phantom reads) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'SERIALIZABLE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel niveau d''isolation des transactions permet les lectures fantômes (phantom reads) ?' UNION ALL
SELECT id, 'B', 'REPEATABLE READ', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel niveau d''isolation des transactions permet les lectures fantômes (phantom reads) ?' UNION ALL
SELECT id, 'C', 'READ UNCOMMITTED', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel niveau d''isolation des transactions permet les lectures fantômes (phantom reads) ?' UNION ALL
SELECT id, 'D', 'READ COMMITTED', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel niveau d''isolation des transactions permet les lectures fantômes (phantom reads) ?';

-- SQL Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Qu''est-ce qu''une CTE récursive permet de faire ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Créer des boucles infinies', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une CTE récursive permet de faire ?' UNION ALL
SELECT id, 'B', 'Parcourir des structures hiérarchiques comme des arbres', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une CTE récursive permet de faire ?' UNION ALL
SELECT id, 'C', 'Optimiser automatiquement les requêtes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une CTE récursive permet de faire ?' UNION ALL
SELECT id, 'D', 'Remplacer les procédures stockées', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une CTE récursive permet de faire ?';

-- SQL Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'En PostgreSQL, quel type de données permet de stocker du JSON avec validation et indexation ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'JSON', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel type de données permet de stocker du JSON avec validation et indexation ?' UNION ALL
SELECT id, 'B', 'JSONB', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel type de données permet de stocker du JSON avec validation et indexation ?' UNION ALL
SELECT id, 'C', 'TEXT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel type de données permet de stocker du JSON avec validation et indexation ?' UNION ALL
SELECT id, 'D', 'HSTORE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel type de données permet de stocker du JSON avec validation et indexation ?';

-- SQL Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelles affirmations sont vraies concernant les triggers (déclencheurs) ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ils s''exécutent automatiquement en réponse à un événement', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les triggers (déclencheurs) ?' UNION ALL
SELECT id, 'B', 'Ils peuvent être déclenchés par INSERT, UPDATE ou DELETE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les triggers (déclencheurs) ?' UNION ALL
SELECT id, 'C', 'Ils ne peuvent pas modifier d''autres tables', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les triggers (déclencheurs) ?' UNION ALL
SELECT id, 'D', 'Ils peuvent s''exécuter BEFORE ou AFTER l''événement', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les triggers (déclencheurs) ?';

-- SQL Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Qu''est-ce que le plan d''exécution (EXPLAIN) d''une requête permet d''analyser ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'La syntaxe de la requête', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le plan d''exécution (EXPLAIN) d''une requête permet d''analyser ?' UNION ALL
SELECT id, 'B', 'La stratégie choisie par l''optimiseur pour exécuter la requête', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le plan d''exécution (EXPLAIN) d''une requête permet d''analyser ?' UNION ALL
SELECT id, 'C', 'Les permissions de l''utilisateur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le plan d''exécution (EXPLAIN) d''une requête permet d''analyser ?' UNION ALL
SELECT id, 'D', 'La structure de la table', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le plan d''exécution (EXPLAIN) d''une requête permet d''analyser ?';

-- SQL Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle clause de fenêtre permet de définir un cadre de lignes pour une fonction analytique ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'PARTITION BY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause de fenêtre permet de définir un cadre de lignes pour une fonction analytique ?' UNION ALL
SELECT id, 'B', 'ORDER BY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause de fenêtre permet de définir un cadre de lignes pour une fonction analytique ?' UNION ALL
SELECT id, 'C', 'ROWS BETWEEN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause de fenêtre permet de définir un cadre de lignes pour une fonction analytique ?' UNION ALL
SELECT id, 'D', 'GROUP BY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle clause de fenêtre permet de définir un cadre de lignes pour une fonction analytique ?';

-- SQL Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel est l''avantage principal d''un index couvrant (covering index) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il empêche les mises à jour sur la table', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un index couvrant (covering index) ?' UNION ALL
SELECT id, 'B', 'Il permet de répondre à la requête sans accéder à la table', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un index couvrant (covering index) ?' UNION ALL
SELECT id, 'C', 'Il réduit la taille de la table', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un index couvrant (covering index) ?' UNION ALL
SELECT id, 'D', 'Il supprime automatiquement les doublons', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un index couvrant (covering index) ?';

-- SQL Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quels types de JOIN existent en SQL standard ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'INNER JOIN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de JOIN existent en SQL standard ?' UNION ALL
SELECT id, 'B', 'LEFT OUTER JOIN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de JOIN existent en SQL standard ?' UNION ALL
SELECT id, 'C', 'DIAGONAL JOIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de JOIN existent en SQL standard ?' UNION ALL
SELECT id, 'D', 'CROSS JOIN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de JOIN existent en SQL standard ?';

-- SQL Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'En PostgreSQL, quel opérateur permet d''accéder à une valeur dans un champ JSONB ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '->', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel opérateur permet d''accéder à une valeur dans un champ JSONB ?' UNION ALL
SELECT id, 'B', '.', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel opérateur permet d''accéder à une valeur dans un champ JSONB ?' UNION ALL
SELECT id, 'C', '=>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel opérateur permet d''accéder à une valeur dans un champ JSONB ?' UNION ALL
SELECT id, 'D', '::', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quel opérateur permet d''accéder à une valeur dans un champ JSONB ?';

-- SQL Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Qu''est-ce que la dénormalisation d''une base de données ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Supprimer toutes les contraintes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que la dénormalisation d''une base de données ?' UNION ALL
SELECT id, 'B', 'Ajouter intentionnellement de la redondance pour améliorer les performances de lecture', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que la dénormalisation d''une base de données ?' UNION ALL
SELECT id, 'C', 'Convertir une base relationnelle en NoSQL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que la dénormalisation d''une base de données ?' UNION ALL
SELECT id, 'D', 'Supprimer les index inutiles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que la dénormalisation d''une base de données ?';

-- SQL Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Qu''est-ce qu''une procédure stockée ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une requête mise en cache automatiquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une procédure stockée ?' UNION ALL
SELECT id, 'B', 'Un programme SQL précompilé stocké dans la base de données', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une procédure stockée ?' UNION ALL
SELECT id, 'C', 'Un fichier SQL sauvegardé sur le serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une procédure stockée ?' UNION ALL
SELECT id, 'D', 'Un type de sauvegarde de la base', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une procédure stockée ?';

-- SQL Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle fonction de fenêtre permet d''accéder à la valeur d''une ligne précédente ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'LEAD()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre permet d''accéder à la valeur d''une ligne précédente ?' UNION ALL
SELECT id, 'B', 'LAG()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre permet d''accéder à la valeur d''une ligne précédente ?' UNION ALL
SELECT id, 'C', 'PREVIOUS()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre permet d''accéder à la valeur d''une ligne précédente ?' UNION ALL
SELECT id, 'D', 'BEFORE()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction de fenêtre permet d''accéder à la valeur d''une ligne précédente ?';

-- SQL Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel est le rôle du mot-clé EXISTS dans une sous-requête ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Vérifier si une table existe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du mot-clé EXISTS dans une sous-requête ?' UNION ALL
SELECT id, 'B', 'Vérifier si la sous-requête retourne au moins une ligne', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du mot-clé EXISTS dans une sous-requête ?' UNION ALL
SELECT id, 'C', 'Créer une table si elle n''existe pas', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du mot-clé EXISTS dans une sous-requête ?' UNION ALL
SELECT id, 'D', 'Vérifier si une colonne contient des données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du mot-clé EXISTS dans une sous-requête ?';

-- SQL Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelles sont les propriétés de l''atomicité dans ACID ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Toutes les opérations d''une transaction sont exécutées ou aucune', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les propriétés de l''atomicité dans ACID ?' UNION ALL
SELECT id, 'B', 'Une transaction ne peut pas être divisée en sous-transactions', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les propriétés de l''atomicité dans ACID ?' UNION ALL
SELECT id, 'C', 'En cas d''échec, la base revient à son état initial', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les propriétés de l''atomicité dans ACID ?' UNION ALL
SELECT id, 'D', 'Les données sont stockées de manière atomique sur le disque', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les propriétés de l''atomicité dans ACID ?';

-- SQL Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'En PostgreSQL, quelle commande permet de voir le plan d''exécution réel avec les temps ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'EXPLAIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quelle commande permet de voir le plan d''exécution réel avec les temps ?' UNION ALL
SELECT id, 'B', 'EXPLAIN ANALYZE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quelle commande permet de voir le plan d''exécution réel avec les temps ?' UNION ALL
SELECT id, 'C', 'SHOW PLAN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quelle commande permet de voir le plan d''exécution réel avec les temps ?' UNION ALL
SELECT id, 'D', 'DESCRIBE QUERY', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En PostgreSQL, quelle commande permet de voir le plan d''exécution réel avec les temps ?';

-- SQL Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle est la première forme normale (1NF) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Chaque colonne contient des valeurs atomiques et chaque ligne est unique', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la première forme normale (1NF) ?' UNION ALL
SELECT id, 'B', 'Toutes les colonnes dépendent entièrement de la clé primaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la première forme normale (1NF) ?' UNION ALL
SELECT id, 'C', 'Il n''y a pas de dépendances transitives', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la première forme normale (1NF) ?' UNION ALL
SELECT id, 'D', 'Toutes les tables ont une clé étrangère', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la première forme normale (1NF) ?';

-- SQL Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quel type d''index en PostgreSQL est le plus adapté pour les recherches plein texte ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'B-tree', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index en PostgreSQL est le plus adapté pour les recherches plein texte ?' UNION ALL
SELECT id, 'B', 'Hash', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index en PostgreSQL est le plus adapté pour les recherches plein texte ?' UNION ALL
SELECT id, 'C', 'GIN', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index en PostgreSQL est le plus adapté pour les recherches plein texte ?' UNION ALL
SELECT id, 'D', 'BRIN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''index en PostgreSQL est le plus adapté pour les recherches plein texte ?';

-- SQL Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'sql'), 'Quelle commande SQL permet de créer un point de sauvegarde dans une transaction ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'CHECKPOINT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de créer un point de sauvegarde dans une transaction ?' UNION ALL
SELECT id, 'B', 'SAVEPOINT', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de créer un point de sauvegarde dans une transaction ?' UNION ALL
SELECT id, 'C', 'BOOKMARK', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de créer un point de sauvegarde dans une transaction ?' UNION ALL
SELECT id, 'D', 'SNAPSHOT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande SQL permet de créer un point de sauvegarde dans une transaction ?';


-- ==================== HTML / CSS (50 questions) ====================

-- HC Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle balise HTML5 est utilisée pour définir une navigation principale ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<nav>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour définir une navigation principale ?' UNION ALL
SELECT id, 'B', '<navigation>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour définir une navigation principale ?' UNION ALL
SELECT id, 'C', '<menu>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour définir une navigation principale ?' UNION ALL
SELECT id, 'D', '<div class="nav">', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour définir une navigation principale ?';

-- HC Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS permet de créer un conteneur flexbox ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'display: block', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de créer un conteneur flexbox ?' UNION ALL
SELECT id, 'B', 'display: flex', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de créer un conteneur flexbox ?' UNION ALL
SELECT id, 'C', 'display: grid', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de créer un conteneur flexbox ?' UNION ALL
SELECT id, 'D', 'display: inline', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de créer un conteneur flexbox ?';

-- HC Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel attribut HTML rend un champ de formulaire obligatoire ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'mandatory', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML rend un champ de formulaire obligatoire ?' UNION ALL
SELECT id, 'B', 'required', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML rend un champ de formulaire obligatoire ?' UNION ALL
SELECT id, 'C', 'necessary', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML rend un champ de formulaire obligatoire ?' UNION ALL
SELECT id, 'D', 'validate', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML rend un champ de formulaire obligatoire ?';

-- HC Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle unité CSS est relative à la taille de la police de l''élément parent ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'rem', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle unité CSS est relative à la taille de la police de l''élément parent ?' UNION ALL
SELECT id, 'B', 'px', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle unité CSS est relative à la taille de la police de l''élément parent ?' UNION ALL
SELECT id, 'C', 'em', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle unité CSS est relative à la taille de la police de l''élément parent ?' UNION ALL
SELECT id, 'D', 'vw', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle unité CSS est relative à la taille de la police de l''élément parent ?';

-- HC Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle balise HTML5 représente un contenu autonome comme un article de blog ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<section>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 représente un contenu autonome comme un article de blog ?' UNION ALL
SELECT id, 'B', '<div>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 représente un contenu autonome comme un article de blog ?' UNION ALL
SELECT id, 'C', '<article>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 représente un contenu autonome comme un article de blog ?' UNION ALL
SELECT id, 'D', '<main>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 représente un contenu autonome comme un article de blog ?';

-- HC Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS contrôle l''espacement entre les lettres ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'word-spacing', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''espacement entre les lettres ?' UNION ALL
SELECT id, 'B', 'text-indent', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''espacement entre les lettres ?' UNION ALL
SELECT id, 'C', 'letter-spacing', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''espacement entre les lettres ?' UNION ALL
SELECT id, 'D', 'font-stretch', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''espacement entre les lettres ?';

-- HC Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel est le rôle de l''attribut alt sur une balise <img> ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Définir la taille de l''image', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut alt sur une balise <img> ?' UNION ALL
SELECT id, 'B', 'Fournir un texte alternatif pour l''accessibilité', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut alt sur une balise <img> ?' UNION ALL
SELECT id, 'C', 'Ajouter un lien sur l''image', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut alt sur une balise <img> ?' UNION ALL
SELECT id, 'D', 'Définir le format de l''image', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut alt sur une balise <img> ?';

-- HC Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle valeur de position CSS retire un élément du flux normal ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'relative', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle valeur de position CSS retire un élément du flux normal ?' UNION ALL
SELECT id, 'B', 'static', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle valeur de position CSS retire un élément du flux normal ?' UNION ALL
SELECT id, 'C', 'absolute', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle valeur de position CSS retire un élément du flux normal ?' UNION ALL
SELECT id, 'D', 'inherit', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle valeur de position CSS retire un élément du flux normal ?';

-- HC Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle balise HTML est utilisée pour un champ de saisie de texte sur une seule ligne ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<textarea>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML est utilisée pour un champ de saisie de texte sur une seule ligne ?' UNION ALL
SELECT id, 'B', '<input type="text">', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML est utilisée pour un champ de saisie de texte sur une seule ligne ?' UNION ALL
SELECT id, 'C', '<field>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML est utilisée pour un champ de saisie de texte sur une seule ligne ?' UNION ALL
SELECT id, 'D', '<text>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML est utilisée pour un champ de saisie de texte sur une seule ligne ?';

-- HC Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS permet d''arrondir les coins d''un élément ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'border-radius', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet d''arrondir les coins d''un élément ?' UNION ALL
SELECT id, 'B', 'corner-radius', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet d''arrondir les coins d''un élément ?' UNION ALL
SELECT id, 'C', 'border-curve', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet d''arrondir les coins d''un élément ?' UNION ALL
SELECT id, 'D', 'round-corner', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet d''arrondir les coins d''un élément ?';

-- HC Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS définit le nombre de colonnes dans un conteneur CSS Grid ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'grid-template-rows', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS définit le nombre de colonnes dans un conteneur CSS Grid ?' UNION ALL
SELECT id, 'B', 'grid-columns', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS définit le nombre de colonnes dans un conteneur CSS Grid ?' UNION ALL
SELECT id, 'C', 'grid-template-columns', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS définit le nombre de colonnes dans un conteneur CSS Grid ?' UNION ALL
SELECT id, 'D', 'columns', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS définit le nombre de colonnes dans un conteneur CSS Grid ?';

-- HC Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle balise HTML5 est utilisée pour regrouper des éléments de pied de page ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<bottom>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour regrouper des éléments de pied de page ?' UNION ALL
SELECT id, 'B', '<footer>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour regrouper des éléments de pied de page ?' UNION ALL
SELECT id, 'C', '<foot>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour regrouper des éléments de pied de page ?' UNION ALL
SELECT id, 'D', '<end>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour regrouper des éléments de pied de page ?';

-- HC Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel sélecteur CSS cible le premier enfant d''un élément ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', ':first-child', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible le premier enfant d''un élément ?' UNION ALL
SELECT id, 'B', ':first-element', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible le premier enfant d''un élément ?' UNION ALL
SELECT id, 'C', ':first', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible le premier enfant d''un élément ?' UNION ALL
SELECT id, 'D', '::first-child', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible le premier enfant d''un élément ?';

-- HC Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle meta balise est essentielle pour le responsive design ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<meta charset="UTF-8">', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle meta balise est essentielle pour le responsive design ?' UNION ALL
SELECT id, 'B', '<meta name="viewport" content="width=device-width, initial-scale=1">', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle meta balise est essentielle pour le responsive design ?' UNION ALL
SELECT id, 'C', '<meta name="responsive" content="true">', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle meta balise est essentielle pour le responsive design ?' UNION ALL
SELECT id, 'D', '<meta http-equiv="mobile">', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle meta balise est essentielle pour le responsive design ?';

-- HC Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS permet de masquer un élément tout en conservant son espace ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'display: none', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de masquer un élément tout en conservant son espace ?' UNION ALL
SELECT id, 'B', 'visibility: hidden', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de masquer un élément tout en conservant son espace ?' UNION ALL
SELECT id, 'C', 'opacity: 0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de masquer un élément tout en conservant son espace ?' UNION ALL
SELECT id, 'D', 'hidden: true', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de masquer un élément tout en conservant son espace ?';

-- HC Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelles propriétés CSS sont des propriétés de l''élément enfant en flexbox ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'flex-grow', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS sont des propriétés de l''élément enfant en flexbox ?' UNION ALL
SELECT id, 'B', 'justify-content', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS sont des propriétés de l''élément enfant en flexbox ?' UNION ALL
SELECT id, 'C', 'align-self', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS sont des propriétés de l''élément enfant en flexbox ?' UNION ALL
SELECT id, 'D', 'order', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS sont des propriétés de l''élément enfant en flexbox ?';

-- HC Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la spécificité d''un sélecteur ID en CSS ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '0, 0, 1, 0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la spécificité d''un sélecteur ID en CSS ?' UNION ALL
SELECT id, 'B', '0, 1, 0, 0', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la spécificité d''un sélecteur ID en CSS ?' UNION ALL
SELECT id, 'C', '1, 0, 0, 0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la spécificité d''un sélecteur ID en CSS ?' UNION ALL
SELECT id, 'D', '0, 0, 0, 1', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la spécificité d''un sélecteur ID en CSS ?';

-- HC Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la différence entre les pseudo-éléments ::before et ::after ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '::before insère du contenu avant le contenu de l''élément, ::after après', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les pseudo-éléments ::before et ::after ?' UNION ALL
SELECT id, 'B', '::before s''applique aux éléments parents, ::after aux enfants', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les pseudo-éléments ::before et ::after ?' UNION ALL
SELECT id, 'C', '::before est pour le texte, ::after pour les images', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les pseudo-éléments ::before et ::after ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune différence fonctionnelle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les pseudo-éléments ::before et ::after ?';

-- HC Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS permet de définir des variables personnalisées ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '$variable-name', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de définir des variables personnalisées ?' UNION ALL
SELECT id, 'B', '@variable-name', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de définir des variables personnalisées ?' UNION ALL
SELECT id, 'C', '--variable-name', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de définir des variables personnalisées ?' UNION ALL
SELECT id, 'D', 'var(variable-name)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS permet de définir des variables personnalisées ?';

-- HC Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel attribut HTML permet d''associer un label à un champ de formulaire ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'name', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML permet d''associer un label à un champ de formulaire ?' UNION ALL
SELECT id, 'B', 'for', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML permet d''associer un label à un champ de formulaire ?' UNION ALL
SELECT id, 'C', 'id', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML permet d''associer un label à un champ de formulaire ?' UNION ALL
SELECT id, 'D', 'link', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut HTML permet d''associer un label à un champ de formulaire ?';

-- HC Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Que fait la propriété CSS flex-wrap: wrap ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle empêche les éléments de passer à la ligne', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS flex-wrap: wrap ?' UNION ALL
SELECT id, 'B', 'Elle permet aux éléments flex de passer à la ligne suivante si nécessaire', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS flex-wrap: wrap ?' UNION ALL
SELECT id, 'C', 'Elle inverse l''ordre des éléments', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS flex-wrap: wrap ?' UNION ALL
SELECT id, 'D', 'Elle centre les éléments verticalement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS flex-wrap: wrap ?';

-- HC Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle fonction CSS est utilisée pour récupérer la valeur d''une variable CSS ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'calc()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction CSS est utilisée pour récupérer la valeur d''une variable CSS ?' UNION ALL
SELECT id, 'B', 'get()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction CSS est utilisée pour récupérer la valeur d''une variable CSS ?' UNION ALL
SELECT id, 'C', 'var()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction CSS est utilisée pour récupérer la valeur d''une variable CSS ?' UNION ALL
SELECT id, 'D', 'env()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle fonction CSS est utilisée pour récupérer la valeur d''une variable CSS ?';

-- HC Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quels sont des types valides pour l''attribut type d''un input HTML ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'email', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types valides pour l''attribut type d''un input HTML ?' UNION ALL
SELECT id, 'B', 'date', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types valides pour l''attribut type d''un input HTML ?' UNION ALL
SELECT id, 'C', 'integer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types valides pour l''attribut type d''un input HTML ?' UNION ALL
SELECT id, 'D', 'range', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des types valides pour l''attribut type d''un input HTML ?';

-- HC Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS Grid permet de placer un élément sur plusieurs colonnes ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'grid-column: span 2', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS Grid permet de placer un élément sur plusieurs colonnes ?' UNION ALL
SELECT id, 'B', 'grid-merge: 2', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS Grid permet de placer un élément sur plusieurs colonnes ?' UNION ALL
SELECT id, 'C', 'column-span: 2', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS Grid permet de placer un élément sur plusieurs colonnes ?' UNION ALL
SELECT id, 'D', 'grid-width: 2', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS Grid permet de placer un élément sur plusieurs colonnes ?';

-- HC Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel est le modèle de boîte par défaut en CSS ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'border-box', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le modèle de boîte par défaut en CSS ?' UNION ALL
SELECT id, 'B', 'content-box', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le modèle de boîte par défaut en CSS ?' UNION ALL
SELECT id, 'C', 'padding-box', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le modèle de boîte par défaut en CSS ?' UNION ALL
SELECT id, 'D', 'margin-box', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le modèle de boîte par défaut en CSS ?';

-- HC Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS crée une animation de transition fluide ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'animation', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS crée une animation de transition fluide ?' UNION ALL
SELECT id, 'B', 'transition', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS crée une animation de transition fluide ?' UNION ALL
SELECT id, 'C', 'transform', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS crée une animation de transition fluide ?' UNION ALL
SELECT id, 'D', 'smooth', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS crée une animation de transition fluide ?';

-- HC Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quels éléments HTML sont des éléments de type inline par défaut ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<span>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments HTML sont des éléments de type inline par défaut ?' UNION ALL
SELECT id, 'B', '<div>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments HTML sont des éléments de type inline par défaut ?' UNION ALL
SELECT id, 'C', '<a>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments HTML sont des éléments de type inline par défaut ?' UNION ALL
SELECT id, 'D', '<strong>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments HTML sont des éléments de type inline par défaut ?';

-- HC Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Que signifie le B dans la méthodologie BEM ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Base', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le B dans la méthodologie BEM ?' UNION ALL
SELECT id, 'B', 'Block', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le B dans la méthodologie BEM ?' UNION ALL
SELECT id, 'C', 'Border', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le B dans la méthodologie BEM ?' UNION ALL
SELECT id, 'D', 'Box', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le B dans la méthodologie BEM ?';

-- HC Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la syntaxe correcte d''une media query pour les écrans de moins de 768px ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '@media screen and (max-width: 768px)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une media query pour les écrans de moins de 768px ?' UNION ALL
SELECT id, 'B', '@media (screen-width < 768px)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une media query pour les écrans de moins de 768px ?' UNION ALL
SELECT id, 'C', '@screen (max: 768px)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une media query pour les écrans de moins de 768px ?' UNION ALL
SELECT id, 'D', '@responsive (width: 768px)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''une media query pour les écrans de moins de 768px ?';

-- HC Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle propriété CSS contrôle l''ordre d''empilement des éléments positionnés ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'stack-order', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''ordre d''empilement des éléments positionnés ?' UNION ALL
SELECT id, 'B', 'layer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''ordre d''empilement des éléments positionnés ?' UNION ALL
SELECT id, 'C', 'z-index', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''ordre d''empilement des éléments positionnés ?' UNION ALL
SELECT id, 'D', 'depth', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété CSS contrôle l''ordre d''empilement des éléments positionnés ?';

-- HC Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle balise HTML5 est utilisée pour intégrer une vidéo ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<media>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour intégrer une vidéo ?' UNION ALL
SELECT id, 'B', '<video>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour intégrer une vidéo ?' UNION ALL
SELECT id, 'C', '<embed>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour intégrer une vidéo ?' UNION ALL
SELECT id, 'D', '<movie>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle balise HTML5 est utilisée pour intégrer une vidéo ?';

-- HC Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelles propriétés font partie du shorthand CSS animation ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'animation-name', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés font partie du shorthand CSS animation ?' UNION ALL
SELECT id, 'B', 'animation-duration', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés font partie du shorthand CSS animation ?' UNION ALL
SELECT id, 'C', 'animation-source', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés font partie du shorthand CSS animation ?' UNION ALL
SELECT id, 'D', 'animation-timing-function', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés font partie du shorthand CSS animation ?';

-- HC Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel sélecteur CSS cible tous les éléments <p> directement enfants d''un <div> ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'div p', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible tous les éléments <p> directement enfants d''un <div> ?' UNION ALL
SELECT id, 'B', 'div > p', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible tous les éléments <p> directement enfants d''un <div> ?' UNION ALL
SELECT id, 'C', 'div + p', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible tous les éléments <p> directement enfants d''un <div> ?' UNION ALL
SELECT id, 'D', 'div ~ p', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel sélecteur CSS cible tous les éléments <p> directement enfants d''un <div> ?';

-- HC Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la valeur par défaut de la propriété flex-direction ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'column', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par défaut de la propriété flex-direction ?' UNION ALL
SELECT id, 'B', 'row', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par défaut de la propriété flex-direction ?' UNION ALL
SELECT id, 'C', 'row-reverse', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par défaut de la propriété flex-direction ?' UNION ALL
SELECT id, 'D', 'initial', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la valeur par défaut de la propriété flex-direction ?';

-- HC Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel attribut ARIA est utilisé pour indiquer qu''un élément est requis ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'aria-required', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut ARIA est utilisé pour indiquer qu''un élément est requis ?' UNION ALL
SELECT id, 'B', 'aria-mandatory', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut ARIA est utilisé pour indiquer qu''un élément est requis ?' UNION ALL
SELECT id, 'C', 'aria-needed', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut ARIA est utilisé pour indiquer qu''un élément est requis ?' UNION ALL
SELECT id, 'D', 'aria-validate', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut ARIA est utilisé pour indiquer qu''un élément est requis ?';

-- HC Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la différence entre les unités vh et % pour la hauteur ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'vh est relatif au viewport, % est relatif à l''élément parent', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les unités vh et % pour la hauteur ?' UNION ALL
SELECT id, 'B', 'Ce sont des synonymes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les unités vh et % pour la hauteur ?' UNION ALL
SELECT id, 'C', 'vh est une unité fixe, % est relative', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les unités vh et % pour la hauteur ?' UNION ALL
SELECT id, 'D', '% est relatif au viewport, vh est relatif au parent', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les unités vh et % pour la hauteur ?';

-- HC Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Comment fonctionne la propriété CSS grid-auto-flow: dense ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle réduit l''espacement entre les éléments de la grille', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la propriété CSS grid-auto-flow: dense ?' UNION ALL
SELECT id, 'B', 'Elle remplit les trous dans la grille en réorganisant les éléments', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la propriété CSS grid-auto-flow: dense ?' UNION ALL
SELECT id, 'C', 'Elle compresse les éléments pour qu''ils tiennent dans moins d''espace', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la propriété CSS grid-auto-flow: dense ?' UNION ALL
SELECT id, 'D', 'Elle augmente la densité de pixels des éléments', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la propriété CSS grid-auto-flow: dense ?';

-- HC Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel est le comportement de la propriété CSS contain: layout ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle empêche l''élément d''affecter la mise en page des éléments extérieurs', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le comportement de la propriété CSS contain: layout ?' UNION ALL
SELECT id, 'B', 'Elle fixe la taille de l''élément', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le comportement de la propriété CSS contain: layout ?' UNION ALL
SELECT id, 'C', 'Elle centre l''élément dans son parent', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le comportement de la propriété CSS contain: layout ?' UNION ALL
SELECT id, 'D', 'Elle désactive le positionnement de l''élément', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le comportement de la propriété CSS contain: layout ?';

-- HC Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelles propriétés CSS déclenchent un nouveau contexte d''empilement (stacking context) ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'position: relative avec z-index', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS déclenchent un nouveau contexte d''empilement (stacking context) ?' UNION ALL
SELECT id, 'B', 'opacity inférieure à 1', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS déclenchent un nouveau contexte d''empilement (stacking context) ?' UNION ALL
SELECT id, 'C', 'margin: auto', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS déclenchent un nouveau contexte d''empilement (stacking context) ?' UNION ALL
SELECT id, 'D', 'transform autre que none', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles propriétés CSS déclenchent un nouveau contexte d''empilement (stacking context) ?';

-- HC Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la différence entre l''attribut srcset et l''élément <picture> en HTML ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'srcset gère les résolutions, <picture> gère les formats et les conditions artistiques', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre l''attribut srcset et l''élément <picture> en HTML ?' UNION ALL
SELECT id, 'B', 'Ce sont des synonymes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre l''attribut srcset et l''élément <picture> en HTML ?' UNION ALL
SELECT id, 'C', '<picture> est obsolète au profit de srcset', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre l''attribut srcset et l''élément <picture> en HTML ?' UNION ALL
SELECT id, 'D', 'srcset ne fonctionne qu''avec les SVG', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre l''attribut srcset et l''élément <picture> en HTML ?';

-- HC Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Que fait la propriété CSS will-change ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle détecte les changements dans le DOM', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS will-change ?' UNION ALL
SELECT id, 'B', 'Elle informe le navigateur des propriétés qui vont changer pour optimiser le rendu', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS will-change ?' UNION ALL
SELECT id, 'C', 'Elle empêche les modifications de style', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS will-change ?' UNION ALL
SELECT id, 'D', 'Elle déclenche une animation automatique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la propriété CSS will-change ?';

-- HC Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel est le rôle de l''attribut inert en HTML ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il rend l''élément et ses descendants non interactifs et invisibles aux technologies d''assistance', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut inert en HTML ?' UNION ALL
SELECT id, 'B', 'Il désactive les animations CSS de l''élément', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut inert en HTML ?' UNION ALL
SELECT id, 'C', 'Il empêche le chargement des ressources', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut inert en HTML ?' UNION ALL
SELECT id, 'D', 'Il masque l''élément visuellement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''attribut inert en HTML ?';

-- HC Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la différence entre min-content et max-content en CSS Grid ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'min-content utilise la largeur minimale sans débordement, max-content la largeur maximale sans retour à la ligne', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre min-content et max-content en CSS Grid ?' UNION ALL
SELECT id, 'B', 'min-content fixe une taille minimale, max-content une taille maximale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre min-content et max-content en CSS Grid ?' UNION ALL
SELECT id, 'C', 'Ce sont des alias pour min-width et max-width', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre min-content et max-content en CSS Grid ?' UNION ALL
SELECT id, 'D', 'min-content s''applique aux lignes, max-content aux colonnes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre min-content et max-content en CSS Grid ?';

-- HC Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelles sont des propriétés CSS logiques (logical properties) valides ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'margin-inline-start', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des propriétés CSS logiques (logical properties) valides ?' UNION ALL
SELECT id, 'B', 'padding-block-end', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des propriétés CSS logiques (logical properties) valides ?' UNION ALL
SELECT id, 'C', 'border-logical-left', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des propriétés CSS logiques (logical properties) valides ?' UNION ALL
SELECT id, 'D', 'inset-inline', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont des propriétés CSS logiques (logical properties) valides ?';

-- HC Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Comment fonctionne la fonction CSS clamp() ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle fixe une valeur entre un minimum et un maximum avec une valeur préférée', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la fonction CSS clamp() ?' UNION ALL
SELECT id, 'B', 'Elle calcule la moyenne de trois valeurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la fonction CSS clamp() ?' UNION ALL
SELECT id, 'C', 'Elle limite le nombre de lignes de texte', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la fonction CSS clamp() ?' UNION ALL
SELECT id, 'D', 'Elle restreint la zone cliquable d''un élément', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment fonctionne la fonction CSS clamp() ?';

-- HC Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Que fait la règle CSS @layer ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle crée un calque visuel superposé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la règle CSS @layer ?' UNION ALL
SELECT id, 'B', 'Elle permet de contrôler l''ordre de priorité des styles en cascade', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la règle CSS @layer ?' UNION ALL
SELECT id, 'C', 'Elle définit un z-index global', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la règle CSS @layer ?' UNION ALL
SELECT id, 'D', 'Elle isole les styles dans un shadow DOM', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la règle CSS @layer ?';

-- HC Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la différence entre :nth-child() et :nth-of-type() ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', ':nth-child() compte tous les enfants, :nth-of-type() ne compte que les enfants du même type', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre :nth-child() et :nth-of-type() ?' UNION ALL
SELECT id, 'B', 'Ce sont des synonymes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre :nth-child() et :nth-of-type() ?' UNION ALL
SELECT id, 'C', ':nth-of-type() est obsolète', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre :nth-child() et :nth-of-type() ?' UNION ALL
SELECT id, 'D', ':nth-child() ne fonctionne qu''avec les listes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre :nth-child() et :nth-of-type() ?';

-- HC Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quel est l''impact de la propriété CSS isolation: isolate ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle crée un nouveau contexte d''empilement sans affecter les autres propriétés', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''impact de la propriété CSS isolation: isolate ?' UNION ALL
SELECT id, 'B', 'Elle empêche l''héritage CSS', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''impact de la propriété CSS isolation: isolate ?' UNION ALL
SELECT id, 'C', 'Elle isole l''élément du flux du document', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''impact de la propriété CSS isolation: isolate ?' UNION ALL
SELECT id, 'D', 'Elle désactive les effets de mélange (blend modes)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''impact de la propriété CSS isolation: isolate ?';

-- HC Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Que permet la pseudo-classe CSS :has() ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Sélectionner un élément parent en fonction de ses enfants', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet la pseudo-classe CSS :has() ?' UNION ALL
SELECT id, 'B', 'Vérifier si un élément possède un attribut', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet la pseudo-classe CSS :has() ?' UNION ALL
SELECT id, 'C', 'Tester si un élément a du contenu textuel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet la pseudo-classe CSS :has() ?' UNION ALL
SELECT id, 'D', 'Sélectionner un élément qui contient une classe spécifique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que permet la pseudo-classe CSS :has() ?';

-- HC Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'html-css'), 'Quelle est la différence entre les container queries (@container) et les media queries (@media) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les container queries réagissent à la taille du conteneur parent, les media queries à la taille du viewport', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les container queries (@container) et les media queries (@media) ?' UNION ALL
SELECT id, 'B', 'Ce sont des synonymes avec une syntaxe différente', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les container queries (@container) et les media queries (@media) ?' UNION ALL
SELECT id, 'C', 'Les container queries sont plus performantes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les container queries (@container) et les media queries (@media) ?' UNION ALL
SELECT id, 'D', 'Les media queries sont obsolètes au profit des container queries', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre les container queries (@container) et les media queries (@media) ?';


-- ==================== GIT (50 questions) ====================

-- GIT Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet d''initialiser un nouveau dépôt Git ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git start', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''initialiser un nouveau dépôt Git ?' UNION ALL
SELECT id, 'B', 'git init', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''initialiser un nouveau dépôt Git ?' UNION ALL
SELECT id, 'C', 'git create', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''initialiser un nouveau dépôt Git ?' UNION ALL
SELECT id, 'D', 'git new', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''initialiser un nouveau dépôt Git ?';

-- GIT Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande ajoute tous les fichiers modifiés à la zone de staging ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git commit -a', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande ajoute tous les fichiers modifiés à la zone de staging ?' UNION ALL
SELECT id, 'B', 'git push .', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande ajoute tous les fichiers modifiés à la zone de staging ?' UNION ALL
SELECT id, 'C', 'git add .', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande ajoute tous les fichiers modifiés à la zone de staging ?' UNION ALL
SELECT id, 'D', 'git stage --all', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande ajoute tous les fichiers modifiés à la zone de staging ?';

-- GIT Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait la commande git status ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle affiche l''historique des commits', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git status ?' UNION ALL
SELECT id, 'B', 'Elle affiche l''état actuel du répertoire de travail et de la zone de staging', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git status ?' UNION ALL
SELECT id, 'C', 'Elle envoie les modifications au dépôt distant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git status ?' UNION ALL
SELECT id, 'D', 'Elle fusionne deux branches', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git status ?';

-- GIT Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de créer une nouvelle branche ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git branch ma-branche', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer une nouvelle branche ?' UNION ALL
SELECT id, 'B', 'git new-branch ma-branche', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer une nouvelle branche ?' UNION ALL
SELECT id, 'C', 'git create ma-branche', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer une nouvelle branche ?' UNION ALL
SELECT id, 'D', 'git fork ma-branche', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer une nouvelle branche ?';

-- GIT Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de voir l''historique des commits ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git history', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir l''historique des commits ?' UNION ALL
SELECT id, 'B', 'git show', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir l''historique des commits ?' UNION ALL
SELECT id, 'C', 'git log', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir l''historique des commits ?' UNION ALL
SELECT id, 'D', 'git commits', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir l''historique des commits ?';

-- GIT Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que signifie l''option -m dans git commit -m "message" ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'merge', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''option -m dans git commit -m "message" ?' UNION ALL
SELECT id, 'B', 'message', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''option -m dans git commit -m "message" ?' UNION ALL
SELECT id, 'C', 'main', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''option -m dans git commit -m "message" ?' UNION ALL
SELECT id, 'D', 'modify', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''option -m dans git commit -m "message" ?';

-- GIT Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de cloner un dépôt distant ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git copy <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de cloner un dépôt distant ?' UNION ALL
SELECT id, 'B', 'git download <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de cloner un dépôt distant ?' UNION ALL
SELECT id, 'C', 'git clone <url>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de cloner un dépôt distant ?' UNION ALL
SELECT id, 'D', 'git fetch <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de cloner un dépôt distant ?';

-- GIT Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quel fichier permet d''ignorer des fichiers dans Git ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '.gitconfig', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier permet d''ignorer des fichiers dans Git ?' UNION ALL
SELECT id, 'B', '.gitignore', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier permet d''ignorer des fichiers dans Git ?' UNION ALL
SELECT id, 'C', '.gitexclude', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier permet d''ignorer des fichiers dans Git ?' UNION ALL
SELECT id, 'D', '.gitskip', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier permet d''ignorer des fichiers dans Git ?';

-- GIT Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande envoie les commits locaux vers le dépôt distant ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git send', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande envoie les commits locaux vers le dépôt distant ?' UNION ALL
SELECT id, 'B', 'git upload', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande envoie les commits locaux vers le dépôt distant ?' UNION ALL
SELECT id, 'C', 'git push', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande envoie les commits locaux vers le dépôt distant ?' UNION ALL
SELECT id, 'D', 'git deploy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande envoie les commits locaux vers le dépôt distant ?';

-- GIT Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande récupère et fusionne les modifications du dépôt distant ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git pull', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande récupère et fusionne les modifications du dépôt distant ?' UNION ALL
SELECT id, 'B', 'git fetch', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande récupère et fusionne les modifications du dépôt distant ?' UNION ALL
SELECT id, 'C', 'git sync', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande récupère et fusionne les modifications du dépôt distant ?' UNION ALL
SELECT id, 'D', 'git download', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande récupère et fusionne les modifications du dépôt distant ?';

-- GIT Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de basculer sur une branche existante ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git switch ma-branche', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de basculer sur une branche existante ?' UNION ALL
SELECT id, 'B', 'git move ma-branche', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de basculer sur une branche existante ?' UNION ALL
SELECT id, 'C', 'git go ma-branche', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de basculer sur une branche existante ?' UNION ALL
SELECT id, 'D', 'git change ma-branche', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de basculer sur une branche existante ?';

-- GIT Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que contient le dossier .git à la racine d''un projet ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les fichiers source du projet uniquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le dossier .git à la racine d''un projet ?' UNION ALL
SELECT id, 'B', 'Toute la base de données et la configuration du dépôt Git', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le dossier .git à la racine d''un projet ?' UNION ALL
SELECT id, 'C', 'Les fichiers ignorés par .gitignore', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le dossier .git à la racine d''un projet ?' UNION ALL
SELECT id, 'D', 'Les fichiers temporaires de compilation', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le dossier .git à la racine d''un projet ?';

-- GIT Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande affiche les différences entre le répertoire de travail et la zone de staging ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git compare', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande affiche les différences entre le répertoire de travail et la zone de staging ?' UNION ALL
SELECT id, 'B', 'git changes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande affiche les différences entre le répertoire de travail et la zone de staging ?' UNION ALL
SELECT id, 'C', 'git diff', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande affiche les différences entre le répertoire de travail et la zone de staging ?' UNION ALL
SELECT id, 'D', 'git delta', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande affiche les différences entre le répertoire de travail et la zone de staging ?';

-- GIT Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle est la différence entre git fetch et git pull ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git fetch et git pull ?' UNION ALL
SELECT id, 'B', 'git fetch télécharge les modifications sans les fusionner, git pull télécharge et fusionne', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git fetch et git pull ?' UNION ALL
SELECT id, 'C', 'git pull est plus rapide que git fetch', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git fetch et git pull ?' UNION ALL
SELECT id, 'D', 'git fetch fonctionne uniquement avec GitHub', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git fetch et git pull ?';

-- GIT Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait git stash ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il supprime définitivement les modifications non commitées', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git stash ?' UNION ALL
SELECT id, 'B', 'Il met de côté temporairement les modifications en cours', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git stash ?' UNION ALL
SELECT id, 'C', 'Il crée une nouvelle branche', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git stash ?' UNION ALL
SELECT id, 'D', 'Il annule le dernier commit', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git stash ?';

-- GIT Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de fusionner une branche dans la branche courante ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git combine <branche>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de fusionner une branche dans la branche courante ?' UNION ALL
SELECT id, 'B', 'git merge <branche>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de fusionner une branche dans la branche courante ?' UNION ALL
SELECT id, 'C', 'git join <branche>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de fusionner une branche dans la branche courante ?' UNION ALL
SELECT id, 'D', 'git unite <branche>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de fusionner une branche dans la branche courante ?';

-- GIT Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle est la différence entre git reset --soft et git reset --hard ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '--soft conserve les modifications dans le staging, --hard supprime toutes les modifications', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset --soft et git reset --hard ?' UNION ALL
SELECT id, 'B', '--soft est plus lent que --hard', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset --soft et git reset --hard ?' UNION ALL
SELECT id, 'C', '--hard ne fonctionne que sur la branche main', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset --soft et git reset --hard ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset --soft et git reset --hard ?';

-- GIT Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait la commande git revert ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle supprime un commit de l''historique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git revert ?' UNION ALL
SELECT id, 'B', 'Elle crée un nouveau commit qui annule les modifications d''un commit précédent', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git revert ?' UNION ALL
SELECT id, 'C', 'Elle restaure un fichier supprimé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git revert ?' UNION ALL
SELECT id, 'D', 'Elle revient à la version initiale du dépôt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git revert ?';

-- GIT Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait git cherry-pick ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il sélectionne les meilleurs commits automatiquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git cherry-pick ?' UNION ALL
SELECT id, 'B', 'Il applique un commit spécifique d''une autre branche sur la branche courante', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git cherry-pick ?' UNION ALL
SELECT id, 'C', 'Il supprime les commits inutiles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git cherry-pick ?' UNION ALL
SELECT id, 'D', 'Il fusionne toutes les branches', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git cherry-pick ?';

-- GIT Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de créer un tag annoté ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git tag v1.0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un tag annoté ?' UNION ALL
SELECT id, 'B', 'git tag -a v1.0 -m "Version 1.0"', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un tag annoté ?' UNION ALL
SELECT id, 'C', 'git label v1.0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un tag annoté ?' UNION ALL
SELECT id, 'D', 'git mark v1.0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un tag annoté ?';

-- GIT Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que se passe-t-il lors d''un conflit de fusion (merge conflict) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Git choisit automatiquement la meilleure version', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que se passe-t-il lors d''un conflit de fusion (merge conflict) ?' UNION ALL
SELECT id, 'B', 'Git annule la fusion automatiquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que se passe-t-il lors d''un conflit de fusion (merge conflict) ?' UNION ALL
SELECT id, 'C', 'Git marque les zones de conflit dans les fichiers et attend une résolution manuelle', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que se passe-t-il lors d''un conflit de fusion (merge conflict) ?' UNION ALL
SELECT id, 'D', 'Git supprime les deux versions en conflit', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que se passe-t-il lors d''un conflit de fusion (merge conflict) ?';

-- GIT Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de voir les branches distantes ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git branch -r', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir les branches distantes ?' UNION ALL
SELECT id, 'B', 'git branch --remote-list', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir les branches distantes ?' UNION ALL
SELECT id, 'C', 'git remote branches', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir les branches distantes ?' UNION ALL
SELECT id, 'D', 'git show-branches', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de voir les branches distantes ?';

-- GIT Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait la commande git rebase ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle réécrit l''historique en déplaçant les commits sur une nouvelle base', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git rebase ?' UNION ALL
SELECT id, 'B', 'Elle crée une copie de sauvegarde du dépôt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git rebase ?' UNION ALL
SELECT id, 'C', 'Elle renomme la branche courante', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git rebase ?' UNION ALL
SELECT id, 'D', 'Elle supprime les branches obsolètes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git rebase ?';

-- GIT Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande supprime une branche locale ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git remove <branche>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande supprime une branche locale ?' UNION ALL
SELECT id, 'B', 'git branch -d <branche>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande supprime une branche locale ?' UNION ALL
SELECT id, 'C', 'git delete <branche>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande supprime une branche locale ?' UNION ALL
SELECT id, 'D', 'git branch --remove <branche>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande supprime une branche locale ?';

-- GIT Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de récupérer les modifications mises de côté avec stash ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git stash apply', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de récupérer les modifications mises de côté avec stash ?' UNION ALL
SELECT id, 'B', 'git stash get', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de récupérer les modifications mises de côté avec stash ?' UNION ALL
SELECT id, 'C', 'git stash restore', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de récupérer les modifications mises de côté avec stash ?' UNION ALL
SELECT id, 'D', 'git stash pull', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de récupérer les modifications mises de côté avec stash ?';

-- GIT Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que représente HEAD dans Git ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le premier commit du dépôt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente HEAD dans Git ?' UNION ALL
SELECT id, 'B', 'Le pointeur vers le commit courant de la branche active', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente HEAD dans Git ?' UNION ALL
SELECT id, 'C', 'La branche principale du dépôt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente HEAD dans Git ?' UNION ALL
SELECT id, 'D', 'Le dernier commit poussé sur le dépôt distant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente HEAD dans Git ?';

-- GIT Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet d''ajouter un dépôt distant ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git remote add origin <url>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un dépôt distant ?' UNION ALL
SELECT id, 'B', 'git add remote <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un dépôt distant ?' UNION ALL
SELECT id, 'C', 'git connect <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un dépôt distant ?' UNION ALL
SELECT id, 'D', 'git origin set <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un dépôt distant ?';

-- GIT Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelles affirmations sont vraies concernant git merge ? (plusieurs réponses)', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il peut créer un commit de fusion (merge commit)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant git merge ? (plusieurs réponses)' UNION ALL
SELECT id, 'B', 'Il réécrit toujours l''historique des commits', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant git merge ? (plusieurs réponses)' UNION ALL
SELECT id, 'C', 'Il peut être de type fast-forward', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant git merge ? (plusieurs réponses)' UNION ALL
SELECT id, 'D', 'Il peut provoquer des conflits', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant git merge ? (plusieurs réponses)';

-- GIT Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de modifier le message du dernier commit ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git commit --edit', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier le message du dernier commit ?' UNION ALL
SELECT id, 'B', 'git commit --amend', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier le message du dernier commit ?' UNION ALL
SELECT id, 'C', 'git modify --last', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier le message du dernier commit ?' UNION ALL
SELECT id, 'D', 'git rewrite commit', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de modifier le message du dernier commit ?';

-- GIT Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quels types de hooks Git existent ? (plusieurs réponses)', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'pre-commit', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de hooks Git existent ? (plusieurs réponses)' UNION ALL
SELECT id, 'B', 'post-merge', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de hooks Git existent ? (plusieurs réponses)' UNION ALL
SELECT id, 'C', 'pre-deploy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de hooks Git existent ? (plusieurs réponses)' UNION ALL
SELECT id, 'D', 'pre-push', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types de hooks Git existent ? (plusieurs réponses)';

-- GIT Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait git log --oneline ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il affiche uniquement le dernier commit', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git log --oneline ?' UNION ALL
SELECT id, 'B', 'Il affiche chaque commit sur une seule ligne avec le hash abrégé et le message', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git log --oneline ?' UNION ALL
SELECT id, 'C', 'Il affiche les commits en une seule colonne', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git log --oneline ?' UNION ALL
SELECT id, 'D', 'Il affiche uniquement les commits de la branche courante sans les merges', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git log --oneline ?';

-- GIT Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande annule les modifications d''un fichier non encore stagé ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git undo <fichier>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande annule les modifications d''un fichier non encore stagé ?' UNION ALL
SELECT id, 'B', 'git reset <fichier>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande annule les modifications d''un fichier non encore stagé ?' UNION ALL
SELECT id, 'C', 'git checkout -- <fichier>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande annule les modifications d''un fichier non encore stagé ?' UNION ALL
SELECT id, 'D', 'git clean <fichier>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande annule les modifications d''un fichier non encore stagé ?';

-- GIT Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelles commandes permettent de retirer un fichier de la zone de staging ? (plusieurs réponses)', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git reset HEAD <fichier>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles commandes permettent de retirer un fichier de la zone de staging ? (plusieurs réponses)' UNION ALL
SELECT id, 'B', 'git rm --cached <fichier>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles commandes permettent de retirer un fichier de la zone de staging ? (plusieurs réponses)' UNION ALL
SELECT id, 'C', 'git unstage <fichier>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles commandes permettent de retirer un fichier de la zone de staging ? (plusieurs réponses)' UNION ALL
SELECT id, 'D', 'git restore --staged <fichier>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles commandes permettent de retirer un fichier de la zone de staging ? (plusieurs réponses)';

-- GIT Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Dans le modèle Gitflow, quelle branche contient le code de production ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'develop', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le modèle Gitflow, quelle branche contient le code de production ?' UNION ALL
SELECT id, 'B', 'main (ou master)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le modèle Gitflow, quelle branche contient le code de production ?' UNION ALL
SELECT id, 'C', 'release', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le modèle Gitflow, quelle branche contient le code de production ?' UNION ALL
SELECT id, 'D', 'hotfix', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le modèle Gitflow, quelle branche contient le code de production ?';

-- GIT Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait la commande git bisect ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle divise une branche en deux', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git bisect ?' UNION ALL
SELECT id, 'B', 'Elle effectue une recherche dichotomique dans l''historique pour trouver le commit ayant introduit un bug', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git bisect ?' UNION ALL
SELECT id, 'C', 'Elle fusionne deux commits en un seul', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git bisect ?' UNION ALL
SELECT id, 'D', 'Elle compare deux branches côte à côte', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git bisect ?';

-- GIT Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que contient le reflog de Git ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Uniquement les commits supprimés', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le reflog de Git ?' UNION ALL
SELECT id, 'B', 'L''historique de tous les mouvements de HEAD et des références locales', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le reflog de Git ?' UNION ALL
SELECT id, 'C', 'Les logs du serveur distant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le reflog de Git ?' UNION ALL
SELECT id, 'D', 'Les erreurs rencontrées par Git', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que contient le reflog de Git ?';

-- GIT Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet d''ajouter un sous-module Git ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'git module add <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un sous-module Git ?' UNION ALL
SELECT id, 'B', 'git submodule add <url>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un sous-module Git ?' UNION ALL
SELECT id, 'C', 'git add --submodule <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un sous-module Git ?' UNION ALL
SELECT id, 'D', 'git include <url>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet d''ajouter un sous-module Git ?';

-- GIT Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait git rebase --interactive (ou -i) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il permet de réorganiser, modifier, fusionner ou supprimer des commits de manière interactive', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git rebase --interactive (ou -i) ?' UNION ALL
SELECT id, 'B', 'Il lance une interface graphique pour visualiser les branches', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git rebase --interactive (ou -i) ?' UNION ALL
SELECT id, 'C', 'Il demande confirmation avant chaque opération de rebase', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git rebase --interactive (ou -i) ?' UNION ALL
SELECT id, 'D', 'Il affiche les conflits de manière interactive', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git rebase --interactive (ou -i) ?';

-- GIT Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que signifie un état "detached HEAD" ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'La branche principale a été supprimée', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie un état "detached HEAD" ?' UNION ALL
SELECT id, 'B', 'HEAD pointe directement sur un commit plutôt que sur une branche', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie un état "detached HEAD" ?' UNION ALL
SELECT id, 'C', 'Le dépôt est corrompu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie un état "detached HEAD" ?' UNION ALL
SELECT id, 'D', 'Le dépôt distant est inaccessible', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie un état "detached HEAD" ?';

-- GIT Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelles sont les stratégies de fusion disponibles dans Git ? (plusieurs réponses)', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'recursive', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les stratégies de fusion disponibles dans Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'B', 'octopus', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les stratégies de fusion disponibles dans Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'C', 'parallel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les stratégies de fusion disponibles dans Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'D', 'ours', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les stratégies de fusion disponibles dans Git ? (plusieurs réponses)';

-- GIT Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait la commande git filter-branch ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle filtre les branches par date de création', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git filter-branch ?' UNION ALL
SELECT id, 'B', 'Elle réécrit l''historique complet du dépôt en appliquant des filtres sur chaque commit', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git filter-branch ?' UNION ALL
SELECT id, 'C', 'Elle supprime les branches qui ne correspondent pas au filtre', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git filter-branch ?' UNION ALL
SELECT id, 'D', 'Elle affiche les branches triées par activité', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git filter-branch ?';

-- GIT Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle est la différence entre un tag léger et un tag annoté ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un tag léger et un tag annoté ?' UNION ALL
SELECT id, 'B', 'Un tag annoté contient un message, un auteur et une date, contrairement au tag léger qui est un simple pointeur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un tag léger et un tag annoté ?' UNION ALL
SELECT id, 'C', 'Un tag léger peut être modifié, un tag annoté est immuable', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un tag léger et un tag annoté ?' UNION ALL
SELECT id, 'D', 'Un tag annoté ne peut pas être poussé sur le dépôt distant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un tag léger et un tag annoté ?';

-- GIT Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait git worktree ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il affiche l''arborescence des fichiers du projet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git worktree ?' UNION ALL
SELECT id, 'B', 'Il permet de gérer plusieurs répertoires de travail liés au même dépôt', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git worktree ?' UNION ALL
SELECT id, 'C', 'Il crée un espace de travail collaboratif', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git worktree ?' UNION ALL
SELECT id, 'D', 'Il optimise la structure du dépôt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git worktree ?';

-- GIT Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quels sont les trois types d''objets internes de Git ? (plusieurs réponses)', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'blob', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''objets internes de Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'B', 'tree', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''objets internes de Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'C', 'commit', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''objets internes de Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'D', 'branch', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''objets internes de Git ? (plusieurs réponses)';

-- GIT Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait la commande git gc ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle génère un changelog', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git gc ?' UNION ALL
SELECT id, 'B', 'Elle lance le ramasse-miettes pour nettoyer et optimiser le dépôt', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git gc ?' UNION ALL
SELECT id, 'C', 'Elle crée une copie globale du dépôt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git gc ?' UNION ALL
SELECT id, 'D', 'Elle vérifie la cohérence du dépôt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git gc ?';

-- GIT Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle commande permet de compresser plusieurs commits en un seul lors d''un rebase interactif ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'merge', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de compresser plusieurs commits en un seul lors d''un rebase interactif ?' UNION ALL
SELECT id, 'B', 'squash', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de compresser plusieurs commits en un seul lors d''un rebase interactif ?' UNION ALL
SELECT id, 'C', 'compress', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de compresser plusieurs commits en un seul lors d''un rebase interactif ?' UNION ALL
SELECT id, 'D', 'flatten', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de compresser plusieurs commits en un seul lors d''un rebase interactif ?';

-- GIT Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait git reset --mixed (comportement par défaut) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il annule le commit et conserve les modifications dans le répertoire de travail mais pas dans le staging', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git reset --mixed (comportement par défaut) ?' UNION ALL
SELECT id, 'B', 'Il supprime toutes les modifications y compris dans le répertoire de travail', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git reset --mixed (comportement par défaut) ?' UNION ALL
SELECT id, 'C', 'Il conserve les modifications dans le staging', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git reset --mixed (comportement par défaut) ?' UNION ALL
SELECT id, 'D', 'Il crée un nouveau commit qui annule les changements', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait git reset --mixed (comportement par défaut) ?';

-- GIT Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelles affirmations sont vraies sur les hooks Git ? (plusieurs réponses)', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ils se trouvent dans le dossier .git/hooks', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les hooks Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'B', 'Ils sont automatiquement partagés lors d''un git clone', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les hooks Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'C', 'Ils peuvent empêcher un commit si le script échoue', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les hooks Git ? (plusieurs réponses)' UNION ALL
SELECT id, 'D', 'Ils peuvent être écrits dans n''importe quel langage de script', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les hooks Git ? (plusieurs réponses)';

-- GIT Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Que fait la commande git blame ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle affiche les erreurs dans le code source', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git blame ?' UNION ALL
SELECT id, 'B', 'Elle affiche pour chaque ligne d''un fichier le commit et l''auteur de la dernière modification', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git blame ?' UNION ALL
SELECT id, 'C', 'Elle signale les fichiers non trackés', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git blame ?' UNION ALL
SELECT id, 'D', 'Elle identifie les conflits non résolus', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la commande git blame ?';

-- GIT Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'git'), 'Quelle est la différence entre git reset et git revert pour annuler des modifications ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset et git revert pour annuler des modifications ?' UNION ALL
SELECT id, 'B', 'git reset modifie l''historique tandis que git revert crée un nouveau commit sans modifier l''historique', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset et git revert pour annuler des modifications ?' UNION ALL
SELECT id, 'C', 'git revert est plus rapide que git reset', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset et git revert pour annuler des modifications ?' UNION ALL
SELECT id, 'D', 'git reset fonctionne uniquement sur les fichiers non commitées', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre git reset et git revert pour annuler des modifications ?';


-- ==================== DEVOPS (50 questions) ====================

-- DO Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande permet de lister tous les conteneurs Docker en cours d''exécution ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'docker ps', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de lister tous les conteneurs Docker en cours d''exécution ?' UNION ALL
SELECT id, 'B', 'docker list', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de lister tous les conteneurs Docker en cours d''exécution ?' UNION ALL
SELECT id, 'C', 'docker show', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de lister tous les conteneurs Docker en cours d''exécution ?' UNION ALL
SELECT id, 'D', 'docker containers', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de lister tous les conteneurs Docker en cours d''exécution ?';

-- DO Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel fichier est utilisé par défaut par docker-compose pour définir les services ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Dockerfile', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier est utilisé par défaut par docker-compose pour définir les services ?' UNION ALL
SELECT id, 'B', 'docker-compose.yml', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier est utilisé par défaut par docker-compose pour définir les services ?' UNION ALL
SELECT id, 'C', 'compose.json', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier est utilisé par défaut par docker-compose pour définir les services ?' UNION ALL
SELECT id, 'D', 'services.yaml', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fichier est utilisé par défaut par docker-compose pour définir les services ?';

-- DO Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle instruction Dockerfile permet de copier des fichiers depuis l''hôte vers l''image ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'MOVE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de copier des fichiers depuis l''hôte vers l''image ?' UNION ALL
SELECT id, 'B', 'ADD', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de copier des fichiers depuis l''hôte vers l''image ?' UNION ALL
SELECT id, 'C', 'COPY', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de copier des fichiers depuis l''hôte vers l''image ?' UNION ALL
SELECT id, 'D', 'IMPORT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de copier des fichiers depuis l''hôte vers l''image ?';

-- DO Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande Linux permet d''afficher l''utilisation du disque d''un répertoire ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'ls -la', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet d''afficher l''utilisation du disque d''un répertoire ?' UNION ALL
SELECT id, 'B', 'df -h', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet d''afficher l''utilisation du disque d''un répertoire ?' UNION ALL
SELECT id, 'C', 'du -sh', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet d''afficher l''utilisation du disque d''un répertoire ?' UNION ALL
SELECT id, 'D', 'disk usage', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet d''afficher l''utilisation du disque d''un répertoire ?';

-- DO Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel est le port par défaut du protocole HTTPS ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '80', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le port par défaut du protocole HTTPS ?' UNION ALL
SELECT id, 'B', '8080', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le port par défaut du protocole HTTPS ?' UNION ALL
SELECT id, 'C', '443', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le port par défaut du protocole HTTPS ?' UNION ALL
SELECT id, 'D', '8443', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le port par défaut du protocole HTTPS ?';

-- DO Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Que signifie l''acronyme CI/CD ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Code Integration / Code Deployment', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme CI/CD ?' UNION ALL
SELECT id, 'B', 'Continuous Integration / Continuous Delivery', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme CI/CD ?' UNION ALL
SELECT id, 'C', 'Container Integration / Container Deployment', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme CI/CD ?' UNION ALL
SELECT id, 'D', 'Cloud Infrastructure / Cloud Distribution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme CI/CD ?';

-- DO Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande permet de se connecter en SSH à un serveur distant ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'ssh user@host', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de se connecter en SSH à un serveur distant ?' UNION ALL
SELECT id, 'B', 'connect user@host', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de se connecter en SSH à un serveur distant ?' UNION ALL
SELECT id, 'C', 'remote user@host', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de se connecter en SSH à un serveur distant ?' UNION ALL
SELECT id, 'D', 'telnet user@host', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de se connecter en SSH à un serveur distant ?';

-- DO Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel outil est utilisé pour obtenir des certificats SSL gratuits via Let''s Encrypt ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'OpenSSL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil est utilisé pour obtenir des certificats SSL gratuits via Let''s Encrypt ?' UNION ALL
SELECT id, 'B', 'Certbot', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil est utilisé pour obtenir des certificats SSL gratuits via Let''s Encrypt ?' UNION ALL
SELECT id, 'C', 'SSLManager', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil est utilisé pour obtenir des certificats SSL gratuits via Let''s Encrypt ?' UNION ALL
SELECT id, 'D', 'KeyTool', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil est utilisé pour obtenir des certificats SSL gratuits via Let''s Encrypt ?';

-- DO Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel enregistrement DNS permet de faire pointer un nom de domaine vers une adresse IP ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'CNAME', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel enregistrement DNS permet de faire pointer un nom de domaine vers une adresse IP ?' UNION ALL
SELECT id, 'B', 'MX', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel enregistrement DNS permet de faire pointer un nom de domaine vers une adresse IP ?' UNION ALL
SELECT id, 'C', 'A', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel enregistrement DNS permet de faire pointer un nom de domaine vers une adresse IP ?' UNION ALL
SELECT id, 'D', 'TXT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel enregistrement DNS permet de faire pointer un nom de domaine vers une adresse IP ?';

-- DO Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande Docker permet de construire une image à partir d''un Dockerfile ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'docker create', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Docker permet de construire une image à partir d''un Dockerfile ?' UNION ALL
SELECT id, 'B', 'docker build', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Docker permet de construire une image à partir d''un Dockerfile ?' UNION ALL
SELECT id, 'C', 'docker make', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Docker permet de construire une image à partir d''un Dockerfile ?' UNION ALL
SELECT id, 'D', 'docker compile', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Docker permet de construire une image à partir d''un Dockerfile ?';

-- DO Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande Linux permet de voir les processus en cours d''exécution ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'top', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de voir les processus en cours d''exécution ?' UNION ALL
SELECT id, 'B', 'proc', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de voir les processus en cours d''exécution ?' UNION ALL
SELECT id, 'C', 'tasks', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de voir les processus en cours d''exécution ?' UNION ALL
SELECT id, 'D', 'running', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de voir les processus en cours d''exécution ?';

-- DO Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Dans un fichier GitHub Actions, quel mot-clé déclenche un workflow sur un push ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'trigger: push', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans un fichier GitHub Actions, quel mot-clé déclenche un workflow sur un push ?' UNION ALL
SELECT id, 'B', 'on: push', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans un fichier GitHub Actions, quel mot-clé déclenche un workflow sur un push ?' UNION ALL
SELECT id, 'C', 'event: push', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans un fichier GitHub Actions, quel mot-clé déclenche un workflow sur un push ?' UNION ALL
SELECT id, 'D', 'when: push', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans un fichier GitHub Actions, quel mot-clé déclenche un workflow sur un push ?';

-- DO Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel est le rôle principal d''un reverse proxy comme Nginx ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Compiler du code source', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un reverse proxy comme Nginx ?' UNION ALL
SELECT id, 'B', 'Gérer les bases de données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un reverse proxy comme Nginx ?' UNION ALL
SELECT id, 'C', 'Rediriger les requêtes clients vers les serveurs backend', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un reverse proxy comme Nginx ?' UNION ALL
SELECT id, 'D', 'Stocker les fichiers statiques uniquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un reverse proxy comme Nginx ?';

-- DO Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande permet de supprimer toutes les images Docker non utilisées ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'docker rmi --all', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de supprimer toutes les images Docker non utilisées ?' UNION ALL
SELECT id, 'B', 'docker image prune -a', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de supprimer toutes les images Docker non utilisées ?' UNION ALL
SELECT id, 'C', 'docker clean images', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de supprimer toutes les images Docker non utilisées ?' UNION ALL
SELECT id, 'D', 'docker delete images', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de supprimer toutes les images Docker non utilisées ?';

-- DO Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel est le fichier de configuration principal de Nginx sous Linux ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '/etc/nginx/nginx.conf', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le fichier de configuration principal de Nginx sous Linux ?' UNION ALL
SELECT id, 'B', '/var/nginx/config.yml', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le fichier de configuration principal de Nginx sous Linux ?' UNION ALL
SELECT id, 'C', '/usr/nginx/settings.conf', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le fichier de configuration principal de Nginx sous Linux ?' UNION ALL
SELECT id, 'D', '/opt/nginx/main.conf', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le fichier de configuration principal de Nginx sous Linux ?';

-- DO Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Dans Kubernetes, quel objet est la plus petite unité déployable ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Container', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel objet est la plus petite unité déployable ?' UNION ALL
SELECT id, 'B', 'Pod', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel objet est la plus petite unité déployable ?' UNION ALL
SELECT id, 'C', 'Node', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel objet est la plus petite unité déployable ?' UNION ALL
SELECT id, 'D', 'Deployment', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel objet est la plus petite unité déployable ?';

-- DO Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle directive docker-compose permet de définir une dépendance entre services ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'links', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive docker-compose permet de définir une dépendance entre services ?' UNION ALL
SELECT id, 'B', 'depends_on', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive docker-compose permet de définir une dépendance entre services ?' UNION ALL
SELECT id, 'C', 'requires', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive docker-compose permet de définir une dépendance entre services ?' UNION ALL
SELECT id, 'D', 'needs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive docker-compose permet de définir une dépendance entre services ?';

-- DO Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel outil de monitoring open source est souvent associé à Grafana pour la collecte de métriques ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Nagios', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil de monitoring open source est souvent associé à Grafana pour la collecte de métriques ?' UNION ALL
SELECT id, 'B', 'Prometheus', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil de monitoring open source est souvent associé à Grafana pour la collecte de métriques ?' UNION ALL
SELECT id, 'C', 'Zabbix', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil de monitoring open source est souvent associé à Grafana pour la collecte de métriques ?' UNION ALL
SELECT id, 'D', 'Datadog', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil de monitoring open source est souvent associé à Grafana pour la collecte de métriques ?';

-- DO Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel langage utilise Terraform pour définir l''infrastructure as code ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'YAML', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage utilise Terraform pour définir l''infrastructure as code ?' UNION ALL
SELECT id, 'B', 'JSON', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage utilise Terraform pour définir l''infrastructure as code ?' UNION ALL
SELECT id, 'C', 'HCL (HashiCorp Configuration Language)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage utilise Terraform pour définir l''infrastructure as code ?' UNION ALL
SELECT id, 'D', 'XML', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage utilise Terraform pour définir l''infrastructure as code ?';

-- DO Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande Kubernetes permet de voir les pods en cours d''exécution ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'kubectl list pods', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Kubernetes permet de voir les pods en cours d''exécution ?' UNION ALL
SELECT id, 'B', 'kubectl get pods', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Kubernetes permet de voir les pods en cours d''exécution ?' UNION ALL
SELECT id, 'C', 'kubectl show pods', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Kubernetes permet de voir les pods en cours d''exécution ?' UNION ALL
SELECT id, 'D', 'kubectl pods status', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Kubernetes permet de voir les pods en cours d''exécution ?';

-- DO Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel type de volume Docker persiste les données même après la suppression du conteneur ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'tmpfs mount', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de volume Docker persiste les données même après la suppression du conteneur ?' UNION ALL
SELECT id, 'B', 'bind mount', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de volume Docker persiste les données même après la suppression du conteneur ?' UNION ALL
SELECT id, 'C', 'named volume', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de volume Docker persiste les données même après la suppression du conteneur ?' UNION ALL
SELECT id, 'D', 'anonymous volume', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type de volume Docker persiste les données même après la suppression du conteneur ?';

-- DO Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle stratégie de déploiement consiste à remplacer progressivement les anciennes instances par les nouvelles ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Blue/Green deployment', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle stratégie de déploiement consiste à remplacer progressivement les anciennes instances par les nouvelles ?' UNION ALL
SELECT id, 'B', 'Canary deployment', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle stratégie de déploiement consiste à remplacer progressivement les anciennes instances par les nouvelles ?' UNION ALL
SELECT id, 'C', 'Rolling update', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle stratégie de déploiement consiste à remplacer progressivement les anciennes instances par les nouvelles ?' UNION ALL
SELECT id, 'D', 'Recreate deployment', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle stratégie de déploiement consiste à remplacer progressivement les anciennes instances par les nouvelles ?';

-- DO Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel est le rôle de la commande terraform plan ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Appliquer les modifications d''infrastructure', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de la commande terraform plan ?' UNION ALL
SELECT id, 'B', 'Afficher un aperçu des modifications à appliquer', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de la commande terraform plan ?' UNION ALL
SELECT id, 'C', 'Détruire l''infrastructure existante', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de la commande terraform plan ?' UNION ALL
SELECT id, 'D', 'Initialiser le projet Terraform', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de la commande terraform plan ?';

-- DO Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel outil Ansible utilise-t-il pour définir les tâches à exécuter sur les serveurs ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Recipes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil Ansible utilise-t-il pour définir les tâches à exécuter sur les serveurs ?' UNION ALL
SELECT id, 'B', 'Playbooks', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil Ansible utilise-t-il pour définir les tâches à exécuter sur les serveurs ?' UNION ALL
SELECT id, 'C', 'Modules', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil Ansible utilise-t-il pour définir les tâches à exécuter sur les serveurs ?' UNION ALL
SELECT id, 'D', 'Scripts', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil Ansible utilise-t-il pour définir les tâches à exécuter sur les serveurs ?';

-- DO Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande Linux permet de suivre en temps réel les logs d''un fichier ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'cat /var/log/syslog', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de suivre en temps réel les logs d''un fichier ?' UNION ALL
SELECT id, 'B', 'tail -f /var/log/syslog', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de suivre en temps réel les logs d''un fichier ?' UNION ALL
SELECT id, 'C', 'watch /var/log/syslog', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de suivre en temps réel les logs d''un fichier ?' UNION ALL
SELECT id, 'D', 'log -f /var/log/syslog', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Linux permet de suivre en temps réel les logs d''un fichier ?';

-- DO Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quels éléments font partie de la stack ELK pour la gestion des logs ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elasticsearch', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments font partie de la stack ELK pour la gestion des logs ?' UNION ALL
SELECT id, 'B', 'Logstash', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments font partie de la stack ELK pour la gestion des logs ?' UNION ALL
SELECT id, 'C', 'Kibana', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments font partie de la stack ELK pour la gestion des logs ?' UNION ALL
SELECT id, 'D', 'Kafka', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments font partie de la stack ELK pour la gestion des logs ?';

-- DO Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel objet Kubernetes permet d''exposer un service à l''extérieur du cluster ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'ClusterIP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet d''exposer un service à l''extérieur du cluster ?' UNION ALL
SELECT id, 'B', 'NodePort', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet d''exposer un service à l''extérieur du cluster ?' UNION ALL
SELECT id, 'C', 'Ingress', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet d''exposer un service à l''extérieur du cluster ?' UNION ALL
SELECT id, 'D', 'ConfigMap', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet d''exposer un service à l''extérieur du cluster ?';

-- DO Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle instruction Dockerfile permet de définir la commande par défaut exécutée au démarrage du conteneur ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'RUN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de définir la commande par défaut exécutée au démarrage du conteneur ?' UNION ALL
SELECT id, 'B', 'CMD', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de définir la commande par défaut exécutée au démarrage du conteneur ?' UNION ALL
SELECT id, 'C', 'EXEC', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de définir la commande par défaut exécutée au démarrage du conteneur ?' UNION ALL
SELECT id, 'D', 'START', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle instruction Dockerfile permet de définir la commande par défaut exécutée au démarrage du conteneur ?';

-- DO Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel algorithme de load balancing distribue les requêtes de manière séquentielle entre les serveurs ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Least connections', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de load balancing distribue les requêtes de manière séquentielle entre les serveurs ?' UNION ALL
SELECT id, 'B', 'Round robin', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de load balancing distribue les requêtes de manière séquentielle entre les serveurs ?' UNION ALL
SELECT id, 'C', 'Random', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de load balancing distribue les requêtes de manière séquentielle entre les serveurs ?' UNION ALL
SELECT id, 'D', 'IP hash', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de load balancing distribue les requêtes de manière séquentielle entre les serveurs ?';

-- DO Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quels sont des avantages d''utiliser des conteneurs Docker ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Isolation des applications', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des avantages d''utiliser des conteneurs Docker ?' UNION ALL
SELECT id, 'B', 'Portabilité entre environnements', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des avantages d''utiliser des conteneurs Docker ?' UNION ALL
SELECT id, 'C', 'Remplacement complet de la virtualisation', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des avantages d''utiliser des conteneurs Docker ?' UNION ALL
SELECT id, 'D', 'Démarrage rapide par rapport aux VMs', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des avantages d''utiliser des conteneurs Docker ?';

-- DO Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel est le rôle d''un Service de type ClusterIP dans Kubernetes ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Exposer le service sur Internet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Service de type ClusterIP dans Kubernetes ?' UNION ALL
SELECT id, 'B', 'Rendre le service accessible uniquement à l''intérieur du cluster', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Service de type ClusterIP dans Kubernetes ?' UNION ALL
SELECT id, 'C', 'Créer un load balancer externe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Service de type ClusterIP dans Kubernetes ?' UNION ALL
SELECT id, 'D', 'Mapper un port de chaque nœud', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Service de type ClusterIP dans Kubernetes ?';

-- DO Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle directive Nginx permet de définir un pool de serveurs backend pour le load balancing ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'server_pool', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive Nginx permet de définir un pool de serveurs backend pour le load balancing ?' UNION ALL
SELECT id, 'B', 'upstream', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive Nginx permet de définir un pool de serveurs backend pour le load balancing ?' UNION ALL
SELECT id, 'C', 'backend', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive Nginx permet de définir un pool de serveurs backend pour le load balancing ?' UNION ALL
SELECT id, 'D', 'load_balancer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle directive Nginx permet de définir un pool de serveurs backend pour le load balancing ?';

-- DO Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quels outils sont couramment utilisés pour l''Infrastructure as Code ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Terraform', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels outils sont couramment utilisés pour l''Infrastructure as Code ?' UNION ALL
SELECT id, 'B', 'Ansible', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels outils sont couramment utilisés pour l''Infrastructure as Code ?' UNION ALL
SELECT id, 'C', 'Postman', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels outils sont couramment utilisés pour l''Infrastructure as Code ?' UNION ALL
SELECT id, 'D', 'Pulumi', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels outils sont couramment utilisés pour l''Infrastructure as Code ?';

-- DO Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande GitHub Actions permet de mettre en cache les dépendances entre les exécutions ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'actions/save@v3', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande GitHub Actions permet de mettre en cache les dépendances entre les exécutions ?' UNION ALL
SELECT id, 'B', 'actions/cache@v3', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande GitHub Actions permet de mettre en cache les dépendances entre les exécutions ?' UNION ALL
SELECT id, 'C', 'actions/store@v3', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande GitHub Actions permet de mettre en cache les dépendances entre les exécutions ?' UNION ALL
SELECT id, 'D', 'actions/persist@v3', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande GitHub Actions permet de mettre en cache les dépendances entre les exécutions ?';

-- DO Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle est la différence principale entre CMD et ENTRYPOINT dans un Dockerfile ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'CMD ne peut pas être surchargé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre CMD et ENTRYPOINT dans un Dockerfile ?' UNION ALL
SELECT id, 'B', 'ENTRYPOINT définit une commande fixe, CMD fournit des arguments par défaut modifiables', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre CMD et ENTRYPOINT dans un Dockerfile ?' UNION ALL
SELECT id, 'C', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre CMD et ENTRYPOINT dans un Dockerfile ?' UNION ALL
SELECT id, 'D', 'CMD s''exécute avant ENTRYPOINT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre CMD et ENTRYPOINT dans un Dockerfile ?';

-- DO Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel est l''avantage principal d''un build multi-stage dans un Dockerfile ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Exécuter plusieurs conteneurs simultanément', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un build multi-stage dans un Dockerfile ?' UNION ALL
SELECT id, 'B', 'Réduire la taille de l''image finale en séparant build et runtime', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un build multi-stage dans un Dockerfile ?' UNION ALL
SELECT id, 'C', 'Accélérer le téléchargement des images', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un build multi-stage dans un Dockerfile ?' UNION ALL
SELECT id, 'D', 'Permettre le déploiement sur plusieurs clouds', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal d''un build multi-stage dans un Dockerfile ?';

-- DO Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Dans Kubernetes, quel composant du control plane est responsable de la planification des pods sur les nœuds ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'kube-apiserver', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel composant du control plane est responsable de la planification des pods sur les nœuds ?' UNION ALL
SELECT id, 'B', 'etcd', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel composant du control plane est responsable de la planification des pods sur les nœuds ?' UNION ALL
SELECT id, 'C', 'kube-scheduler', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel composant du control plane est responsable de la planification des pods sur les nœuds ?' UNION ALL
SELECT id, 'D', 'kubelet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans Kubernetes, quel composant du control plane est responsable de la planification des pods sur les nœuds ?';

-- DO Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande Terraform permet de détruire toute l''infrastructure gérée ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'terraform delete', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Terraform permet de détruire toute l''infrastructure gérée ?' UNION ALL
SELECT id, 'B', 'terraform remove', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Terraform permet de détruire toute l''infrastructure gérée ?' UNION ALL
SELECT id, 'C', 'terraform destroy', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Terraform permet de détruire toute l''infrastructure gérée ?' UNION ALL
SELECT id, 'D', 'terraform clean', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande Terraform permet de détruire toute l''infrastructure gérée ?';

-- DO Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel mécanisme Kubernetes permet de redémarrer automatiquement un pod en cas d''échec du health check ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'readinessProbe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mécanisme Kubernetes permet de redémarrer automatiquement un pod en cas d''échec du health check ?' UNION ALL
SELECT id, 'B', 'livenessProbe', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mécanisme Kubernetes permet de redémarrer automatiquement un pod en cas d''échec du health check ?' UNION ALL
SELECT id, 'C', 'startupProbe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mécanisme Kubernetes permet de redémarrer automatiquement un pod en cas d''échec du health check ?' UNION ALL
SELECT id, 'D', 'healthCheck', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mécanisme Kubernetes permet de redémarrer automatiquement un pod en cas d''échec du health check ?';

-- DO Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quels éléments sont nécessaires pour configurer un pipeline CI/CD complet avec GitHub Actions ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un fichier YAML dans .github/workflows/', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour configurer un pipeline CI/CD complet avec GitHub Actions ?' UNION ALL
SELECT id, 'B', 'Des secrets configurés dans les settings du repo', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour configurer un pipeline CI/CD complet avec GitHub Actions ?' UNION ALL
SELECT id, 'C', 'Un serveur Jenkins dédié', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour configurer un pipeline CI/CD complet avec GitHub Actions ?' UNION ALL
SELECT id, 'D', 'Des jobs avec des steps définissant les actions', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour configurer un pipeline CI/CD complet avec GitHub Actions ?';

-- DO Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel est le rôle du fichier terraform.tfstate ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Définir les variables d''environnement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier terraform.tfstate ?' UNION ALL
SELECT id, 'B', 'Stocker l''état actuel de l''infrastructure gérée par Terraform', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier terraform.tfstate ?' UNION ALL
SELECT id, 'C', 'Configurer les providers cloud', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier terraform.tfstate ?' UNION ALL
SELECT id, 'D', 'Lister les modules disponibles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier terraform.tfstate ?';

-- DO Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle est la différence entre un Deployment et un StatefulSet dans Kubernetes ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un Deployment et un StatefulSet dans Kubernetes ?' UNION ALL
SELECT id, 'B', 'Le StatefulSet garantit un ordre de déploiement et des identités stables pour les pods', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un Deployment et un StatefulSet dans Kubernetes ?' UNION ALL
SELECT id, 'C', 'Le Deployment est plus récent que le StatefulSet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un Deployment et un StatefulSet dans Kubernetes ?' UNION ALL
SELECT id, 'D', 'Le StatefulSet ne supporte pas les rolling updates', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un Deployment et un StatefulSet dans Kubernetes ?';

-- DO Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel protocole TLS est recommandé en 2024 pour sécuriser les communications HTTPS ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'TLS 1.0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel protocole TLS est recommandé en 2024 pour sécuriser les communications HTTPS ?' UNION ALL
SELECT id, 'B', 'TLS 1.1', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel protocole TLS est recommandé en 2024 pour sécuriser les communications HTTPS ?' UNION ALL
SELECT id, 'C', 'TLS 1.2', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel protocole TLS est recommandé en 2024 pour sécuriser les communications HTTPS ?' UNION ALL
SELECT id, 'D', 'TLS 1.3', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel protocole TLS est recommandé en 2024 pour sécuriser les communications HTTPS ?';

-- DO Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quels sont les composants du control plane Kubernetes ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'kube-apiserver', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les composants du control plane Kubernetes ?' UNION ALL
SELECT id, 'B', 'etcd', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les composants du control plane Kubernetes ?' UNION ALL
SELECT id, 'C', 'kube-scheduler', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les composants du control plane Kubernetes ?' UNION ALL
SELECT id, 'D', 'kube-proxy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les composants du control plane Kubernetes ?';

-- DO Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle commande permet de créer un namespace Kubernetes ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'kubectl new namespace mon-ns', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un namespace Kubernetes ?' UNION ALL
SELECT id, 'B', 'kubectl create namespace mon-ns', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un namespace Kubernetes ?' UNION ALL
SELECT id, 'C', 'kubectl add namespace mon-ns', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un namespace Kubernetes ?' UNION ALL
SELECT id, 'D', 'kubectl namespace create mon-ns', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle commande permet de créer un namespace Kubernetes ?';

-- DO Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel concept Docker permet de créer un réseau isolé entre plusieurs conteneurs ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Docker bridge network', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel concept Docker permet de créer un réseau isolé entre plusieurs conteneurs ?' UNION ALL
SELECT id, 'B', 'Docker volume', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel concept Docker permet de créer un réseau isolé entre plusieurs conteneurs ?' UNION ALL
SELECT id, 'C', 'Docker layer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel concept Docker permet de créer un réseau isolé entre plusieurs conteneurs ?' UNION ALL
SELECT id, 'D', 'Docker swarm', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel concept Docker permet de créer un réseau isolé entre plusieurs conteneurs ?';

-- DO Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelles pratiques sont recommandées pour sécuriser une image Docker en production ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Utiliser une image de base minimale comme Alpine', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques sont recommandées pour sécuriser une image Docker en production ?' UNION ALL
SELECT id, 'B', 'Exécuter le processus en tant que root', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques sont recommandées pour sécuriser une image Docker en production ?' UNION ALL
SELECT id, 'C', 'Scanner les vulnérabilités avec des outils comme Trivy', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques sont recommandées pour sécuriser une image Docker en production ?' UNION ALL
SELECT id, 'D', 'Utiliser un utilisateur non-root dans le conteneur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques sont recommandées pour sécuriser une image Docker en production ?';

-- DO Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel outil permet de gérer les secrets dans Kubernetes de manière sécurisée ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'ConfigMap', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil permet de gérer les secrets dans Kubernetes de manière sécurisée ?' UNION ALL
SELECT id, 'B', 'Vault (HashiCorp)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil permet de gérer les secrets dans Kubernetes de manière sécurisée ?' UNION ALL
SELECT id, 'C', 'kubectl env', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil permet de gérer les secrets dans Kubernetes de manière sécurisée ?' UNION ALL
SELECT id, 'D', 'Docker secrets', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel outil permet de gérer les secrets dans Kubernetes de manière sécurisée ?';

-- DO Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quelle est la particularité d''Ansible par rapport à Chef et Puppet ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il nécessite un agent sur chaque serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la particularité d''Ansible par rapport à Chef et Puppet ?' UNION ALL
SELECT id, 'B', 'Il est agentless et utilise SSH pour se connecter aux serveurs', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la particularité d''Ansible par rapport à Chef et Puppet ?' UNION ALL
SELECT id, 'C', 'Il ne supporte que les serveurs Linux', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la particularité d''Ansible par rapport à Chef et Puppet ?' UNION ALL
SELECT id, 'D', 'Il utilise un langage de programmation compilé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la particularité d''Ansible par rapport à Chef et Puppet ?';

-- DO Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'devops'), 'Quel objet Kubernetes permet de limiter les ressources CPU et mémoire d''un pod ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'ResourceQuota', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet de limiter les ressources CPU et mémoire d''un pod ?' UNION ALL
SELECT id, 'B', 'LimitRange', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet de limiter les ressources CPU et mémoire d''un pod ?' UNION ALL
SELECT id, 'C', 'resources.limits dans la spec du conteneur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet de limiter les ressources CPU et mémoire d''un pod ?' UNION ALL
SELECT id, 'D', 'PodSecurityPolicy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel objet Kubernetes permet de limiter les ressources CPU et mémoire d''un pod ?';


-- ==================== TYPESCRIPT (50 questions) ====================

-- TS Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quel est le type de base utilisé pour annoter une variable contenant du texte en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'String', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type de base utilisé pour annoter une variable contenant du texte en TypeScript ?' UNION ALL
SELECT id, 'B', 'string', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type de base utilisé pour annoter une variable contenant du texte en TypeScript ?' UNION ALL
SELECT id, 'C', 'text', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type de base utilisé pour annoter une variable contenant du texte en TypeScript ?' UNION ALL
SELECT id, 'D', 'char', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type de base utilisé pour annoter une variable contenant du texte en TypeScript ?';

-- TS Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Comment déclare-t-on une variable avec un type explicite en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'let x: number = 5;', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on une variable avec un type explicite en TypeScript ?' UNION ALL
SELECT id, 'B', 'let x = number(5);', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on une variable avec un type explicite en TypeScript ?' UNION ALL
SELECT id, 'C', 'let number x = 5;', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on une variable avec un type explicite en TypeScript ?' UNION ALL
SELECT id, 'D', 'let x as number = 5;', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on une variable avec un type explicite en TypeScript ?';

-- TS Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quel mot-clé permet de définir une interface en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'class', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une interface en TypeScript ?' UNION ALL
SELECT id, 'B', 'type', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une interface en TypeScript ?' UNION ALL
SELECT id, 'C', 'interface', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une interface en TypeScript ?' UNION ALL
SELECT id, 'D', 'struct', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une interface en TypeScript ?';

-- TS Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quel type représente une valeur qui peut être n''importe quoi en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'unknown', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type représente une valeur qui peut être n''importe quoi en TypeScript ?' UNION ALL
SELECT id, 'B', 'any', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type représente une valeur qui peut être n''importe quoi en TypeScript ?' UNION ALL
SELECT id, 'C', 'object', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type représente une valeur qui peut être n''importe quoi en TypeScript ?' UNION ALL
SELECT id, 'D', 'void', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type représente une valeur qui peut être n''importe quoi en TypeScript ?';

-- TS Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelle est l''extension de fichier standard pour un fichier TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '.js', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est l''extension de fichier standard pour un fichier TypeScript ?' UNION ALL
SELECT id, 'B', '.tsx', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est l''extension de fichier standard pour un fichier TypeScript ?' UNION ALL
SELECT id, 'C', '.ts', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est l''extension de fichier standard pour un fichier TypeScript ?' UNION ALL
SELECT id, 'D', '.typ', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est l''extension de fichier standard pour un fichier TypeScript ?';

-- TS Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Comment définit-on un paramètre optionnel dans une fonction TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'En ajoutant ? après le nom du paramètre', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un paramètre optionnel dans une fonction TypeScript ?' UNION ALL
SELECT id, 'B', 'En ajoutant ! après le nom du paramètre', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un paramètre optionnel dans une fonction TypeScript ?' UNION ALL
SELECT id, 'C', 'En utilisant le mot-clé optional', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un paramètre optionnel dans une fonction TypeScript ?' UNION ALL
SELECT id, 'D', 'En entourant le paramètre de crochets []', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un paramètre optionnel dans une fonction TypeScript ?';

-- TS Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quel est le rôle du fichier tsconfig.json ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Définir les dépendances du projet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier tsconfig.json ?' UNION ALL
SELECT id, 'B', 'Configurer les options du compilateur TypeScript', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier tsconfig.json ?' UNION ALL
SELECT id, 'C', 'Gérer les scripts npm', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier tsconfig.json ?' UNION ALL
SELECT id, 'D', 'Définir les variables d''environnement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du fichier tsconfig.json ?';

-- TS Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que signifie le type void en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'La fonction retourne null', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le type void en TypeScript ?' UNION ALL
SELECT id, 'B', 'La fonction ne retourne aucune valeur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le type void en TypeScript ?' UNION ALL
SELECT id, 'C', 'La variable est indéfinie', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le type void en TypeScript ?' UNION ALL
SELECT id, 'D', 'Le type est inconnu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le type void en TypeScript ?';

-- TS Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Comment déclare-t-on un tableau de nombres en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'let arr: number[] = [1, 2, 3];', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on un tableau de nombres en TypeScript ?' UNION ALL
SELECT id, 'B', 'let arr: array(number) = [1, 2, 3];', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on un tableau de nombres en TypeScript ?' UNION ALL
SELECT id, 'C', 'let arr: [number] = [1, 2, 3];', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on un tableau de nombres en TypeScript ?' UNION ALL
SELECT id, 'D', 'let arr: numbers = [1, 2, 3];', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment déclare-t-on un tableau de nombres en TypeScript ?';

-- TS Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quel mot-clé permet de définir une énumération en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'enumerate', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une énumération en TypeScript ?' UNION ALL
SELECT id, 'B', 'enum', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une énumération en TypeScript ?' UNION ALL
SELECT id, 'C', 'const', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une énumération en TypeScript ?' UNION ALL
SELECT id, 'D', 'list', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel mot-clé permet de définir une énumération en TypeScript ?';

-- TS Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelle est la différence entre une interface et un type alias en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre une interface et un type alias en TypeScript ?' UNION ALL
SELECT id, 'B', 'Une interface peut être étendue avec extends, un type alias utilise l''intersection &', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre une interface et un type alias en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un type alias est plus performant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre une interface et un type alias en TypeScript ?' UNION ALL
SELECT id, 'D', 'Une interface ne supporte pas les méthodes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre une interface et un type alias en TypeScript ?';

-- TS Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que produit le compilateur TypeScript (tsc) ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Du bytecode', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que produit le compilateur TypeScript (tsc) ?' UNION ALL
SELECT id, 'B', 'Du code machine', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que produit le compilateur TypeScript (tsc) ?' UNION ALL
SELECT id, 'C', 'Du JavaScript', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que produit le compilateur TypeScript (tsc) ?' UNION ALL
SELECT id, 'D', 'Du WebAssembly', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que produit le compilateur TypeScript (tsc) ?';

-- TS Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Comment définit-on un type union en TypeScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'string & number', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un type union en TypeScript ?' UNION ALL
SELECT id, 'B', 'string + number', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un type union en TypeScript ?' UNION ALL
SELECT id, 'C', 'string | number', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un type union en TypeScript ?' UNION ALL
SELECT id, 'D', 'string, number', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un type union en TypeScript ?';

-- TS Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quel est le type d''un tuple contenant un string et un number ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '[string, number]', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type d''un tuple contenant un string et un number ?' UNION ALL
SELECT id, 'B', 'Array<string, number>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type d''un tuple contenant un string et un number ?' UNION ALL
SELECT id, 'C', '(string, number)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type d''un tuple contenant un string et un number ?' UNION ALL
SELECT id, 'D', 'Tuple<string, number>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le type d''un tuple contenant un string et un number ?';

-- TS Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quel modificateur d''accès rend une propriété accessible uniquement dans la classe ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'public', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel modificateur d''accès rend une propriété accessible uniquement dans la classe ?' UNION ALL
SELECT id, 'B', 'protected', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel modificateur d''accès rend une propriété accessible uniquement dans la classe ?' UNION ALL
SELECT id, 'C', 'private', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel modificateur d''accès rend une propriété accessible uniquement dans la classe ?' UNION ALL
SELECT id, 'D', 'static', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel modificateur d''accès rend une propriété accessible uniquement dans la classe ?';

-- TS Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Partial<T> en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il rend toutes les propriétés de T obligatoires', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Partial<T> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il rend toutes les propriétés de T optionnelles', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Partial<T> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il supprime toutes les propriétés de T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Partial<T> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il rend toutes les propriétés de T en lecture seule', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Partial<T> en TypeScript ?';

-- TS Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Pick<T, K> en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il sélectionne uniquement les propriétés K du type T', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Pick<T, K> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il supprime les propriétés K du type T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Pick<T, K> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il rend les propriétés K obligatoires', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Pick<T, K> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il fusionne T et K', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Pick<T, K> en TypeScript ?';

-- TS Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Omit<T, K> en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il sélectionne les propriétés K du type T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Omit<T, K> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il exclut les propriétés K du type T', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Omit<T, K> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il rend les propriétés K optionnelles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Omit<T, K> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il ajoute les propriétés K au type T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Omit<T, K> en TypeScript ?';

-- TS Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que représente le type Record<K, V> en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un tableau de paires clé-valeur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente le type Record<K, V> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Un objet dont les clés sont de type K et les valeurs de type V', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente le type Record<K, V> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Une Map typée', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente le type Record<K, V> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Un enregistrement de base de données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que représente le type Record<K, V> en TypeScript ?';

-- TS Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Qu''est-ce qu''un type guard en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un mécanisme de sécurité pour protéger les types', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type guard en TypeScript ?' UNION ALL
SELECT id, 'B', 'Une expression qui affine le type d''une variable dans un bloc conditionnel', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type guard en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un décorateur qui valide les types à l''exécution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type guard en TypeScript ?' UNION ALL
SELECT id, 'D', 'Une classe abstraite pour gérer les types', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type guard en TypeScript ?';

-- TS Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelle syntaxe permet de créer une fonction générique en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'function identity<T>(arg: T): T { return arg; }', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet de créer une fonction générique en TypeScript ?' UNION ALL
SELECT id, 'B', 'function identity(arg: generic): generic { return arg; }', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet de créer une fonction générique en TypeScript ?' UNION ALL
SELECT id, 'C', 'function identity(arg: any): any { return arg; }', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet de créer une fonction générique en TypeScript ?' UNION ALL
SELECT id, 'D', 'function identity[T](arg: T): T { return arg; }', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet de créer une fonction générique en TypeScript ?';

-- TS Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait l''opérateur as en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il convertit une valeur d''un type à un autre à l''exécution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''opérateur as en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il effectue une assertion de type (type assertion)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''opérateur as en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il crée un alias de type', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''opérateur as en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il importe un module sous un autre nom', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''opérateur as en TypeScript ?';

-- TS Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelle est la différence entre any et unknown en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre any et unknown en TypeScript ?' UNION ALL
SELECT id, 'B', 'unknown nécessite une vérification de type avant utilisation, any non', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre any et unknown en TypeScript ?' UNION ALL
SELECT id, 'C', 'any est plus strict que unknown', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre any et unknown en TypeScript ?' UNION ALL
SELECT id, 'D', 'unknown ne peut être assigné qu''à des objets', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre any et unknown en TypeScript ?';

-- TS Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Required<T> en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il rend toutes les propriétés de T optionnelles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Required<T> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il rend toutes les propriétés de T obligatoires', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Required<T> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il supprime les propriétés en lecture seule', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Required<T> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il valide que T est un objet requis', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Required<T> en TypeScript ?';

-- TS Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Comment restreindre un type générique à ceux qui ont une propriété length ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'function fn<T extends { length: number }>(arg: T): T', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment restreindre un type générique à ceux qui ont une propriété length ?' UNION ALL
SELECT id, 'B', 'function fn<T implements Lengthable>(arg: T): T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment restreindre un type générique à ceux qui ont une propriété length ?' UNION ALL
SELECT id, 'C', 'function fn<T: { length: number }>(arg: T): T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment restreindre un type générique à ceux qui ont une propriété length ?' UNION ALL
SELECT id, 'D', 'function fn<T where length>(arg: T): T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment restreindre un type générique à ceux qui ont une propriété length ?';

-- TS Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le mot-clé readonly en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il empêche la modification d''une propriété après l''initialisation', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé readonly en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il rend la propriété privée', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé readonly en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il empêche la suppression de la propriété', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé readonly en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il rend la propriété optionnelle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé readonly en TypeScript ?';

-- TS Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quels opérateurs permettent de faire un type guard en TypeScript ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'typeof', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels opérateurs permettent de faire un type guard en TypeScript ?' UNION ALL
SELECT id, 'B', 'instanceof', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels opérateurs permettent de faire un type guard en TypeScript ?' UNION ALL
SELECT id, 'C', 'is', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels opérateurs permettent de faire un type guard en TypeScript ?' UNION ALL
SELECT id, 'D', 'in', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels opérateurs permettent de faire un type guard en TypeScript ?';

-- TS Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que signifie l''opérateur ! après une variable en TypeScript (ex: value!) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'La variable est inversée', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''opérateur ! après une variable en TypeScript (ex: value!) ?' UNION ALL
SELECT id, 'B', 'C''est une assertion de non-nullité (non-null assertion)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''opérateur ! après une variable en TypeScript (ex: value!) ?' UNION ALL
SELECT id, 'C', 'La variable est obligatoire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''opérateur ! après une variable en TypeScript (ex: value!) ?' UNION ALL
SELECT id, 'D', 'La variable est de type boolean', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''opérateur ! après une variable en TypeScript (ex: value!) ?';

-- TS Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Qu''est-ce qu''un type littéral (literal type) en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un type basé sur une valeur exacte, comme "hello" ou 42', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type littéral (literal type) en TypeScript ?' UNION ALL
SELECT id, 'B', 'Un type qui ne peut contenir que des chaînes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type littéral (literal type) en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un type créé avec le mot-clé literal', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type littéral (literal type) en TypeScript ?' UNION ALL
SELECT id, 'D', 'Un type primitif standard', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type littéral (literal type) en TypeScript ?';

-- TS Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait l''option strict dans tsconfig.json ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle active uniquement strictNullChecks', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''option strict dans tsconfig.json ?' UNION ALL
SELECT id, 'B', 'Elle active toutes les options de vérification stricte', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''option strict dans tsconfig.json ?' UNION ALL
SELECT id, 'C', 'Elle empêche l''utilisation de any', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''option strict dans tsconfig.json ?' UNION ALL
SELECT id, 'D', 'Elle rend le projet incompatible avec JavaScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''option strict dans tsconfig.json ?';

-- TS Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quels types utilitaires permettent de transformer les propriétés d''un objet ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Partial<T>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types utilitaires permettent de transformer les propriétés d''un objet ?' UNION ALL
SELECT id, 'B', 'Readonly<T>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types utilitaires permettent de transformer les propriétés d''un objet ?' UNION ALL
SELECT id, 'C', 'ReturnType<T>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types utilitaires permettent de transformer les propriétés d''un objet ?' UNION ALL
SELECT id, 'D', 'Required<T>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels types utilitaires permettent de transformer les propriétés d''un objet ?';

-- TS Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Qu''est-ce qu''un type intersection en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un type qui combine plusieurs types avec l''opérateur &', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type intersection en TypeScript ?' UNION ALL
SELECT id, 'B', 'Un type qui choisit entre plusieurs types avec |', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type intersection en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un type qui exclut les propriétés communes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type intersection en TypeScript ?' UNION ALL
SELECT id, 'D', 'Un type qui ne peut être que null ou undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type intersection en TypeScript ?';

-- TS Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Readonly<T> en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il rend toutes les propriétés de T en lecture seule', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Readonly<T> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il supprime les propriétés readonly de T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Readonly<T> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il rend T immuable à l''exécution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Readonly<T> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il empêche T d''être étendu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Readonly<T> en TypeScript ?';

-- TS Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Qu''est-ce qu''un discriminated union en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un union type où chaque membre a une propriété commune avec une valeur littérale unique', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un discriminated union en TypeScript ?' UNION ALL
SELECT id, 'B', 'Un type qui exclut certaines valeurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un discriminated union en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un union type qui ne contient que des types primitifs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un discriminated union en TypeScript ?' UNION ALL
SELECT id, 'D', 'Un type protégé par un type guard', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un discriminated union en TypeScript ?';

-- TS Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le mot-clé keyof en TypeScript ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il retourne le type union des clés d''un type objet', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé keyof en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il retourne les valeurs d''un objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé keyof en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il crée une nouvelle clé dans un type', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé keyof en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il vérifie si une clé existe dans un objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé keyof en TypeScript ?';

-- TS Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Qu''est-ce qu''un type conditionnel en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un type qui utilise la syntaxe T extends U ? X : Y', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type conditionnel en TypeScript ?' UNION ALL
SELECT id, 'B', 'Un type basé sur une condition if/else', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type conditionnel en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un type qui change à l''exécution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type conditionnel en TypeScript ?' UNION ALL
SELECT id, 'D', 'Un type qui ne peut être utilisé que dans des blocs conditionnels', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un type conditionnel en TypeScript ?';

-- TS Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le mot-clé infer dans un type conditionnel ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il infère automatiquement les types des variables', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé infer dans un type conditionnel ?' UNION ALL
SELECT id, 'B', 'Il permet de capturer un type dans une clause extends pour le réutiliser', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé infer dans un type conditionnel ?' UNION ALL
SELECT id, 'C', 'Il force le compilateur à deviner le type', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé infer dans un type conditionnel ?' UNION ALL
SELECT id, 'D', 'Il désactive la vérification de type', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le mot-clé infer dans un type conditionnel ?';

-- TS Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Qu''est-ce qu''un mapped type en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un type qui itère sur les clés d''un autre type pour créer un nouveau type', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un mapped type en TypeScript ?' UNION ALL
SELECT id, 'B', 'Un type qui mappe des valeurs à des clés', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un mapped type en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un type créé avec la classe Map', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un mapped type en TypeScript ?' UNION ALL
SELECT id, 'D', 'Un type qui convertit un tableau en objet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un mapped type en TypeScript ?';

-- TS Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelle est la syntaxe correcte d''un mapped type en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'type Mapped = { [K in keyof T]: T[K] }', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''un mapped type en TypeScript ?' UNION ALL
SELECT id, 'B', 'type Mapped = { for K in T: T[K] }', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''un mapped type en TypeScript ?' UNION ALL
SELECT id, 'C', 'type Mapped = T.map(K => T[K])', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''un mapped type en TypeScript ?' UNION ALL
SELECT id, 'D', 'type Mapped = { [K of keyof T]: T[K] }', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte d''un mapped type en TypeScript ?';

-- TS Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire ReturnType<T> en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il retourne le type des paramètres de la fonction T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire ReturnType<T> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il extrait le type de retour de la fonction T', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire ReturnType<T> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il force la fonction T à retourner un type spécifique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire ReturnType<T> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il crée un type à partir du nom de la fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire ReturnType<T> en TypeScript ?';

-- TS Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Qu''est-ce qu''un fichier de déclaration (.d.ts) en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un fichier qui contient uniquement des informations de type sans implémentation', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un fichier de déclaration (.d.ts) en TypeScript ?' UNION ALL
SELECT id, 'B', 'Un fichier de configuration TypeScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un fichier de déclaration (.d.ts) en TypeScript ?' UNION ALL
SELECT id, 'C', 'Un fichier TypeScript compilé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un fichier de déclaration (.d.ts) en TypeScript ?' UNION ALL
SELECT id, 'D', 'Un fichier de test TypeScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un fichier de déclaration (.d.ts) en TypeScript ?';

-- TS Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelles affirmations sont vraies concernant les décorateurs en TypeScript ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ils utilisent la syntaxe @expression', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les décorateurs en TypeScript ?' UNION ALL
SELECT id, 'B', 'Ils peuvent être appliqués aux classes, méthodes et propriétés', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les décorateurs en TypeScript ?' UNION ALL
SELECT id, 'C', 'Ils sont activés par défaut sans configuration', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les décorateurs en TypeScript ?' UNION ALL
SELECT id, 'D', 'Ils modifient le type de la cible à la compilation', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les décorateurs en TypeScript ?';

-- TS Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Extract<T, U> en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il extrait de T les types assignables à U', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Extract<T, U> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il exclut de T les types assignables à U', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Extract<T, U> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il extrait les propriétés communes de T et U', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Extract<T, U> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il crée un nouveau type à partir de T et U', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Extract<T, U> en TypeScript ?';

-- TS Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Exclude<T, U> en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il extrait de T les types assignables à U', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Exclude<T, U> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il exclut de T les types assignables à U', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Exclude<T, U> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il rend les propriétés U optionnelles dans T', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Exclude<T, U> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il crée un type sans les clés de U', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Exclude<T, U> en TypeScript ?';

-- TS Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire NonNullable<T> en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il supprime null et undefined du type T', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire NonNullable<T> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il empêche T d''être null à l''exécution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire NonNullable<T> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il rend toutes les propriétés de T non nullables', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire NonNullable<T> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il ajoute une vérification null à l''exécution', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire NonNullable<T> en TypeScript ?';

-- TS Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelles affirmations sont vraies sur les template literal types en TypeScript ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ils utilisent la syntaxe backtick comme les template strings', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les template literal types en TypeScript ?' UNION ALL
SELECT id, 'B', 'Ils permettent de construire des types string à partir d''autres types', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les template literal types en TypeScript ?' UNION ALL
SELECT id, 'C', 'Ils ne fonctionnent qu''avec des types string littéraux', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les template literal types en TypeScript ?' UNION ALL
SELECT id, 'D', 'Ils peuvent générer des combinaisons de types à partir d''unions', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les template literal types en TypeScript ?';

-- TS Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Comment créer un type récursif en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'En référençant le type lui-même dans sa propre définition', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un type récursif en TypeScript ?' UNION ALL
SELECT id, 'B', 'En utilisant le mot-clé recursive', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un type récursif en TypeScript ?' UNION ALL
SELECT id, 'C', 'Ce n''est pas possible en TypeScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un type récursif en TypeScript ?' UNION ALL
SELECT id, 'D', 'En utilisant une boucle de types', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un type récursif en TypeScript ?';

-- TS Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quels sont les avantages de l''option strictNullChecks dans tsconfig.json ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle empêche d''assigner null ou undefined à un type non nullable', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages de l''option strictNullChecks dans tsconfig.json ?' UNION ALL
SELECT id, 'B', 'Elle force la vérification explicite de null avant utilisation', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages de l''option strictNullChecks dans tsconfig.json ?' UNION ALL
SELECT id, 'C', 'Elle supprime automatiquement les valeurs null du code', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages de l''option strictNullChecks dans tsconfig.json ?' UNION ALL
SELECT id, 'D', 'Elle remplace null par undefined partout', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages de l''option strictNullChecks dans tsconfig.json ?';

-- TS Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Que fait le type utilitaire Parameters<T> en TypeScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il extrait les types des paramètres d''une fonction sous forme de tuple', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Parameters<T> en TypeScript ?' UNION ALL
SELECT id, 'B', 'Il retourne le nombre de paramètres d''une fonction', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Parameters<T> en TypeScript ?' UNION ALL
SELECT id, 'C', 'Il rend tous les paramètres optionnels', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Parameters<T> en TypeScript ?' UNION ALL
SELECT id, 'D', 'Il crée un objet à partir des paramètres', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le type utilitaire Parameters<T> en TypeScript ?';

-- TS Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'typescript'), 'Quelles affirmations sont vraies sur les types variadiques (variadic tuple types) en TypeScript ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ils utilisent la syntaxe ...T dans les types tuple', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les types variadiques (variadic tuple types) en TypeScript ?' UNION ALL
SELECT id, 'B', 'Ils permettent de manipuler des tuples de longueur variable au niveau des types', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les types variadiques (variadic tuple types) en TypeScript ?' UNION ALL
SELECT id, 'C', 'Ils ont été introduits dans TypeScript 2.0', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les types variadiques (variadic tuple types) en TypeScript ?' UNION ALL
SELECT id, 'D', 'Ils ne fonctionnent qu''avec des tableaux de nombres', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies sur les types variadiques (variadic tuple types) en TypeScript ?';


-- ==================== REACT (50 questions) ====================

-- RE Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Que signifie JSX en React ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'JavaScript XML', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie JSX en React ?' UNION ALL
SELECT id, 'B', 'JavaScript Extension', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie JSX en React ?' UNION ALL
SELECT id, 'C', 'Java Syntax Extension', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie JSX en React ?' UNION ALL
SELECT id, 'D', 'JSON XML Syntax', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie JSX en React ?';

-- RE Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel hook permet de gérer un état local dans un composant fonctionnel ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useEffect', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de gérer un état local dans un composant fonctionnel ?' UNION ALL
SELECT id, 'B', 'useState', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de gérer un état local dans un composant fonctionnel ?' UNION ALL
SELECT id, 'C', 'useContext', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de gérer un état local dans un composant fonctionnel ?' UNION ALL
SELECT id, 'D', 'useReducer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de gérer un état local dans un composant fonctionnel ?';

-- RE Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Comment passe-t-on des données d''un composant parent à un composant enfant ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Via le state global', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment passe-t-on des données d''un composant parent à un composant enfant ?' UNION ALL
SELECT id, 'B', 'Via les props', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment passe-t-on des données d''un composant parent à un composant enfant ?' UNION ALL
SELECT id, 'C', 'Via les événements', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment passe-t-on des données d''un composant parent à un composant enfant ?' UNION ALL
SELECT id, 'D', 'Via le localStorage', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment passe-t-on des données d''un composant parent à un composant enfant ?';

-- RE Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelle est la commande pour créer une application React avec Vite ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'npx create-react-app mon-app', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la commande pour créer une application React avec Vite ?' UNION ALL
SELECT id, 'B', 'npm init react mon-app', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la commande pour créer une application React avec Vite ?' UNION ALL
SELECT id, 'C', 'npm create vite@latest mon-app -- --template react', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la commande pour créer une application React avec Vite ?' UNION ALL
SELECT id, 'D', 'npx vite create mon-app', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la commande pour créer une application React avec Vite ?';

-- RE Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel est le rôle du Virtual DOM en React ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Remplacer complètement le DOM réel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Virtual DOM en React ?' UNION ALL
SELECT id, 'B', 'Optimiser les mises à jour du DOM en comparant les différences', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Virtual DOM en React ?' UNION ALL
SELECT id, 'C', 'Stocker les données de l''application', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Virtual DOM en React ?' UNION ALL
SELECT id, 'D', 'Gérer le routage de l''application', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Virtual DOM en React ?';

-- RE Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelle syntaxe permet d''afficher une variable dans du JSX ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '{{ variable }}', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet d''afficher une variable dans du JSX ?' UNION ALL
SELECT id, 'B', '{ variable }', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet d''afficher une variable dans du JSX ?' UNION ALL
SELECT id, 'C', '<%= variable %>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet d''afficher une variable dans du JSX ?' UNION ALL
SELECT id, 'D', '${ variable }', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle syntaxe permet d''afficher une variable dans du JSX ?';

-- RE Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelle propriété spéciale doit être ajoutée lors du rendu d''une liste en React ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'id', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété spéciale doit être ajoutée lors du rendu d''une liste en React ?' UNION ALL
SELECT id, 'B', 'key', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété spéciale doit être ajoutée lors du rendu d''une liste en React ?' UNION ALL
SELECT id, 'C', 'index', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété spéciale doit être ajoutée lors du rendu d''une liste en React ?' UNION ALL
SELECT id, 'D', 'ref', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle propriété spéciale doit être ajoutée lors du rendu d''une liste en React ?';

-- RE Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Comment définit-on un composant fonctionnel en React ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Avec une classe qui étend React.Component', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un composant fonctionnel en React ?' UNION ALL
SELECT id, 'B', 'Avec une fonction qui retourne du JSX', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un composant fonctionnel en React ?' UNION ALL
SELECT id, 'C', 'Avec un objet JavaScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un composant fonctionnel en React ?' UNION ALL
SELECT id, 'D', 'Avec un fichier HTML', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment définit-on un composant fonctionnel en React ?';

-- RE Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel attribut remplace "class" en JSX ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'className', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut remplace "class" en JSX ?' UNION ALL
SELECT id, 'B', 'cssClass', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut remplace "class" en JSX ?' UNION ALL
SELECT id, 'C', 'htmlClass', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut remplace "class" en JSX ?' UNION ALL
SELECT id, 'D', 'classList', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut remplace "class" en JSX ?';

-- RE Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Que retourne un composant React qui ne doit rien afficher ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'undefined', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne un composant React qui ne doit rien afficher ?' UNION ALL
SELECT id, 'B', 'false', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne un composant React qui ne doit rien afficher ?' UNION ALL
SELECT id, 'C', 'null', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne un composant React qui ne doit rien afficher ?' UNION ALL
SELECT id, 'D', '""', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que retourne un composant React qui ne doit rien afficher ?';

-- RE Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelle méthode de tableau est couramment utilisée pour afficher une liste en JSX ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'forEach()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle méthode de tableau est couramment utilisée pour afficher une liste en JSX ?' UNION ALL
SELECT id, 'B', 'map()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle méthode de tableau est couramment utilisée pour afficher une liste en JSX ?' UNION ALL
SELECT id, 'C', 'filter()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle méthode de tableau est couramment utilisée pour afficher une liste en JSX ?' UNION ALL
SELECT id, 'D', 'reduce()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle méthode de tableau est couramment utilisée pour afficher une liste en JSX ?';

-- RE Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel est le point d''entrée principal d''une application React ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'App.js', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le point d''entrée principal d''une application React ?' UNION ALL
SELECT id, 'B', 'index.html', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le point d''entrée principal d''une application React ?' UNION ALL
SELECT id, 'C', 'main.jsx ou index.jsx', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le point d''entrée principal d''une application React ?' UNION ALL
SELECT id, 'D', 'package.json', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le point d''entrée principal d''une application React ?';

-- RE Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Que fait le hook useEffect lorsqu''il reçoit un tableau de dépendances vide [] ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il s''exécute à chaque rendu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le hook useEffect lorsqu''il reçoit un tableau de dépendances vide [] ?' UNION ALL
SELECT id, 'B', 'Il ne s''exécute jamais', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le hook useEffect lorsqu''il reçoit un tableau de dépendances vide [] ?' UNION ALL
SELECT id, 'C', 'Il s''exécute uniquement au montage du composant', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le hook useEffect lorsqu''il reçoit un tableau de dépendances vide [] ?' UNION ALL
SELECT id, 'D', 'Il s''exécute au démontage du composant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait le hook useEffect lorsqu''il reçoit un tableau de dépendances vide [] ?';

-- RE Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel fragment permet d''envelopper plusieurs éléments sans ajouter de noeud au DOM ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '<div>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fragment permet d''envelopper plusieurs éléments sans ajouter de noeud au DOM ?' UNION ALL
SELECT id, 'B', '<React.Fragment> ou <>', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fragment permet d''envelopper plusieurs éléments sans ajouter de noeud au DOM ?' UNION ALL
SELECT id, 'C', '<section>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fragment permet d''envelopper plusieurs éléments sans ajouter de noeud au DOM ?' UNION ALL
SELECT id, 'D', '<span>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel fragment permet d''envelopper plusieurs éléments sans ajouter de noeud au DOM ?';

-- RE Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Les props en React sont-elles modifiables par le composant enfant ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Oui, les props sont mutables', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Les props en React sont-elles modifiables par le composant enfant ?' UNION ALL
SELECT id, 'B', 'Non, les props sont en lecture seule (immutables)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Les props en React sont-elles modifiables par le composant enfant ?' UNION ALL
SELECT id, 'C', 'Oui, mais uniquement dans useEffect', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Les props en React sont-elles modifiables par le composant enfant ?' UNION ALL
SELECT id, 'D', 'Oui, avec la méthode setProps()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Les props en React sont-elles modifiables par le composant enfant ?';

-- RE Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel hook permet d''accéder à une valeur du Context API ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useState', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet d''accéder à une valeur du Context API ?' UNION ALL
SELECT id, 'B', 'useReducer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet d''accéder à une valeur du Context API ?' UNION ALL
SELECT id, 'C', 'useContext', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet d''accéder à une valeur du Context API ?' UNION ALL
SELECT id, 'D', 'useRef', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet d''accéder à une valeur du Context API ?';

-- RE Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelle est la différence principale entre useState et useReducer ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useReducer est plus performant que useState', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre useState et useReducer ?' UNION ALL
SELECT id, 'B', 'useReducer est adapté aux états complexes avec plusieurs sous-valeurs', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre useState et useReducer ?' UNION ALL
SELECT id, 'C', 'useState ne fonctionne pas dans les composants fonctionnels', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre useState et useReducer ?' UNION ALL
SELECT id, 'D', 'useReducer remplace complètement Redux', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence principale entre useState et useReducer ?';

-- RE Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel hook permet de mémoriser le résultat d''un calcul coûteux ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useCallback', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser le résultat d''un calcul coûteux ?' UNION ALL
SELECT id, 'B', 'useMemo', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser le résultat d''un calcul coûteux ?' UNION ALL
SELECT id, 'C', 'useRef', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser le résultat d''un calcul coûteux ?' UNION ALL
SELECT id, 'D', 'useEffect', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser le résultat d''un calcul coûteux ?';

-- RE Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel hook permet de mémoriser une fonction pour éviter sa recréation à chaque rendu ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useMemo', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser une fonction pour éviter sa recréation à chaque rendu ?' UNION ALL
SELECT id, 'B', 'useCallback', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser une fonction pour éviter sa recréation à chaque rendu ?' UNION ALL
SELECT id, 'C', 'useEffect', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser une fonction pour éviter sa recréation à chaque rendu ?' UNION ALL
SELECT id, 'D', 'useState', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de mémoriser une fonction pour éviter sa recréation à chaque rendu ?';

-- RE Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel hook permet de stocker une référence mutable qui persiste entre les rendus ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useState', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de stocker une référence mutable qui persiste entre les rendus ?' UNION ALL
SELECT id, 'B', 'useRef', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de stocker une référence mutable qui persiste entre les rendus ?' UNION ALL
SELECT id, 'C', 'useMemo', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de stocker une référence mutable qui persiste entre les rendus ?' UNION ALL
SELECT id, 'D', 'useContext', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook permet de stocker une référence mutable qui persiste entre les rendus ?';

-- RE Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Que fait React.memo() ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il mémorise l''état du composant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait React.memo() ?' UNION ALL
SELECT id, 'B', 'Il empêche le re-rendu si les props n''ont pas changé', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait React.memo() ?' UNION ALL
SELECT id, 'C', 'Il remplace useMemo', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait React.memo() ?' UNION ALL
SELECT id, 'D', 'Il stocke les données en cache côté serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait React.memo() ?';

-- RE Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Comment gérer un formulaire contrôlé en React ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'En utilisant document.getElementById pour lire les valeurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment gérer un formulaire contrôlé en React ?' UNION ALL
SELECT id, 'B', 'En liant la valeur de l''input au state et en utilisant onChange', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment gérer un formulaire contrôlé en React ?' UNION ALL
SELECT id, 'C', 'En utilisant uniquement useRef', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment gérer un formulaire contrôlé en React ?' UNION ALL
SELECT id, 'D', 'En utilisant jQuery pour manipuler le DOM', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment gérer un formulaire contrôlé en React ?';

-- RE Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel composant de React Router v6 remplace Switch ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Router', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel composant de React Router v6 remplace Switch ?' UNION ALL
SELECT id, 'B', 'Routes', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel composant de React Router v6 remplace Switch ?' UNION ALL
SELECT id, 'C', 'Navigate', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel composant de React Router v6 remplace Switch ?' UNION ALL
SELECT id, 'D', 'Outlet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel composant de React Router v6 remplace Switch ?';

-- RE Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quels hooks peuvent déclencher un re-rendu du composant ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useState', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels hooks peuvent déclencher un re-rendu du composant ?' UNION ALL
SELECT id, 'B', 'useReducer', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels hooks peuvent déclencher un re-rendu du composant ?' UNION ALL
SELECT id, 'C', 'useRef', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels hooks peuvent déclencher un re-rendu du composant ?' UNION ALL
SELECT id, 'D', 'useCallback', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels hooks peuvent déclencher un re-rendu du composant ?';

-- RE Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel hook de React Router v6 permet de naviguer programmatiquement ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useHistory', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook de React Router v6 permet de naviguer programmatiquement ?' UNION ALL
SELECT id, 'B', 'useNavigate', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook de React Router v6 permet de naviguer programmatiquement ?' UNION ALL
SELECT id, 'C', 'useLocation', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook de React Router v6 permet de naviguer programmatiquement ?' UNION ALL
SELECT id, 'D', 'useRoute', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook de React Router v6 permet de naviguer programmatiquement ?';

-- RE Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Que fait la fonction de nettoyage retournée par useEffect ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Elle réinitialise le state', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction de nettoyage retournée par useEffect ?' UNION ALL
SELECT id, 'B', 'Elle s''exécute avant le prochain effet ou au démontage du composant', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction de nettoyage retournée par useEffect ?' UNION ALL
SELECT id, 'C', 'Elle supprime le composant du DOM', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction de nettoyage retournée par useEffect ?' UNION ALL
SELECT id, 'D', 'Elle annule le rendu en cours', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait la fonction de nettoyage retournée par useEffect ?';

-- RE Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Comment partager un état entre plusieurs composants éloignés dans l''arbre ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'En passant les props à travers chaque composant intermédiaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment partager un état entre plusieurs composants éloignés dans l''arbre ?' UNION ALL
SELECT id, 'B', 'En utilisant le Context API ou un gestionnaire d''état global', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment partager un état entre plusieurs composants éloignés dans l''arbre ?' UNION ALL
SELECT id, 'C', 'En utilisant des variables globales JavaScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment partager un état entre plusieurs composants éloignés dans l''arbre ?' UNION ALL
SELECT id, 'D', 'En stockant les données dans le localStorage', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment partager un état entre plusieurs composants éloignés dans l''arbre ?';

-- RE Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelles affirmations sont vraies concernant les hooks React ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ils ne peuvent être appelés qu''au niveau supérieur d''un composant', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les hooks React ?' UNION ALL
SELECT id, 'B', 'Ils peuvent être appelés dans des conditions ou des boucles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les hooks React ?' UNION ALL
SELECT id, 'C', 'Ils ne fonctionnent que dans les composants fonctionnels ou les hooks personnalisés', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les hooks React ?' UNION ALL
SELECT id, 'D', 'Ils peuvent être utilisés dans les composants de classe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant les hooks React ?';

-- RE Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel est le rôle du composant Outlet dans React Router v6 ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Rediriger vers une autre page', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du composant Outlet dans React Router v6 ?' UNION ALL
SELECT id, 'B', 'Afficher le composant enfant correspondant à la route imbriquée', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du composant Outlet dans React Router v6 ?' UNION ALL
SELECT id, 'C', 'Définir une route protégée', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du composant Outlet dans React Router v6 ?' UNION ALL
SELECT id, 'D', 'Gérer les erreurs 404', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du composant Outlet dans React Router v6 ?';

-- RE Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce que le lifting state up en React ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Déplacer le state vers un composant parent commun', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le lifting state up en React ?' UNION ALL
SELECT id, 'B', 'Copier le state dans le localStorage', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le lifting state up en React ?' UNION ALL
SELECT id, 'C', 'Supprimer le state d''un composant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le lifting state up en React ?' UNION ALL
SELECT id, 'D', 'Envoyer le state au serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le lifting state up en React ?';

-- RE Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quels sont des cas d''utilisation valides pour useRef ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Accéder à un élément DOM directement', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des cas d''utilisation valides pour useRef ?' UNION ALL
SELECT id, 'B', 'Stocker une valeur qui ne déclenche pas de re-rendu', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des cas d''utilisation valides pour useRef ?' UNION ALL
SELECT id, 'C', 'Remplacer useState pour le state du formulaire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des cas d''utilisation valides pour useRef ?' UNION ALL
SELECT id, 'D', 'Déclencher un re-rendu du composant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des cas d''utilisation valides pour useRef ?';

-- RE Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelle est la syntaxe correcte pour un rendu conditionnel en JSX ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '{if (condition) <Component />}', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte pour un rendu conditionnel en JSX ?' UNION ALL
SELECT id, 'B', '{condition && <Component />}', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte pour un rendu conditionnel en JSX ?' UNION ALL
SELECT id, 'C', '<if condition><Component /></if>', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte pour un rendu conditionnel en JSX ?' UNION ALL
SELECT id, 'D', '{condition ? <Component />}', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la syntaxe correcte pour un rendu conditionnel en JSX ?';

-- RE Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Comment créer un hook personnalisé en React ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'En créant une classe qui étend React.Hook', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un hook personnalisé en React ?' UNION ALL
SELECT id, 'B', 'En créant une fonction dont le nom commence par "use"', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un hook personnalisé en React ?' UNION ALL
SELECT id, 'C', 'En utilisant React.createHook()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un hook personnalisé en React ?' UNION ALL
SELECT id, 'D', 'En enregistrant le hook avec React.registerHook()', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment créer un hook personnalisé en React ?';

-- RE Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel est l''avantage principal du lazy loading avec React.lazy() ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Il accélère le rendu côté serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal du lazy loading avec React.lazy() ?' UNION ALL
SELECT id, 'B', 'Il réduit la taille du bundle initial en chargeant les composants à la demande', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal du lazy loading avec React.lazy() ?' UNION ALL
SELECT id, 'C', 'Il remplace React Router', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal du lazy loading avec React.lazy() ?' UNION ALL
SELECT id, 'D', 'Il permet de charger React plus rapidement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage principal du lazy loading avec React.lazy() ?';

-- RE Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelles sont les étapes pour créer un Context en React ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Créer le contexte avec createContext()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les étapes pour créer un Context en React ?' UNION ALL
SELECT id, 'B', 'Envelopper les composants avec le Provider', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les étapes pour créer un Context en React ?' UNION ALL
SELECT id, 'C', 'Installer une bibliothèque externe comme Redux', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les étapes pour créer un Context en React ?' UNION ALL
SELECT id, 'D', 'Consommer le contexte avec useContext()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les étapes pour créer un Context en React ?';

-- RE Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce que le prop drilling en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une technique d''optimisation des props', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prop drilling en React ?' UNION ALL
SELECT id, 'B', 'Le passage de props à travers plusieurs niveaux de composants intermédiaires', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prop drilling en React ?' UNION ALL
SELECT id, 'C', 'Une méthode pour valider les props', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prop drilling en React ?' UNION ALL
SELECT id, 'D', 'Un pattern de création de composants', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prop drilling en React ?';

-- RE Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce que le Server-Side Rendering (SSR) en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le rendu des composants côté serveur avant l''envoi au client', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Server-Side Rendering (SSR) en React ?' UNION ALL
SELECT id, 'B', 'L''exécution de JavaScript uniquement côté serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Server-Side Rendering (SSR) en React ?' UNION ALL
SELECT id, 'C', 'Le stockage des données sur le serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Server-Side Rendering (SSR) en React ?' UNION ALL
SELECT id, 'D', 'La compilation du code React sur le serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Server-Side Rendering (SSR) en React ?';

-- RE Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel est le rôle de l''algorithme de réconciliation (reconciliation) en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Compiler le JSX en JavaScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''algorithme de réconciliation (reconciliation) en React ?' UNION ALL
SELECT id, 'B', 'Comparer l''ancien et le nouveau Virtual DOM pour déterminer les changements minimaux', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''algorithme de réconciliation (reconciliation) en React ?' UNION ALL
SELECT id, 'C', 'Gérer le routage de l''application', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''algorithme de réconciliation (reconciliation) en React ?' UNION ALL
SELECT id, 'D', 'Fusionner les états de plusieurs composants', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de l''algorithme de réconciliation (reconciliation) en React ?';

-- RE Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce qu''un Higher-Order Component (HOC) en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un composant qui se trouve en haut de l''arbre de composants', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un Higher-Order Component (HOC) en React ?' UNION ALL
SELECT id, 'B', 'Une fonction qui prend un composant et retourne un nouveau composant enrichi', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un Higher-Order Component (HOC) en React ?' UNION ALL
SELECT id, 'C', 'Un composant avec un state complexe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un Higher-Order Component (HOC) en React ?' UNION ALL
SELECT id, 'D', 'Un composant qui utilise plusieurs hooks', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un Higher-Order Component (HOC) en React ?';

-- RE Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel est le rôle de React.StrictMode ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Empêcher l''utilisation de JavaScript non strict', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de React.StrictMode ?' UNION ALL
SELECT id, 'B', 'Détecter les problèmes potentiels en mode développement', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de React.StrictMode ?' UNION ALL
SELECT id, 'C', 'Activer le mode production', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de React.StrictMode ?' UNION ALL
SELECT id, 'D', 'Désactiver les warnings dans la console', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle de React.StrictMode ?';

-- RE Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce que l''hydratation (hydration) en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le processus de mise en cache des composants', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''hydratation (hydration) en React ?' UNION ALL
SELECT id, 'B', 'L''ajout d''interactivité côté client au HTML rendu côté serveur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''hydratation (hydration) en React ?' UNION ALL
SELECT id, 'C', 'Le chargement des données depuis une API', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''hydratation (hydration) en React ?' UNION ALL
SELECT id, 'D', 'La compression du bundle JavaScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''hydratation (hydration) en React ?';

-- RE Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce que le pattern Render Props en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un pattern où un composant reçoit une fonction comme prop pour déterminer ce qu''il doit rendre', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Render Props en React ?' UNION ALL
SELECT id, 'B', 'Un pattern pour valider les props d''un composant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Render Props en React ?' UNION ALL
SELECT id, 'C', 'Un pattern pour gérer les erreurs de rendu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Render Props en React ?' UNION ALL
SELECT id, 'D', 'Un pattern pour optimiser les performances de rendu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Render Props en React ?';

-- RE Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel est le rôle d''un Error Boundary en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Gérer les erreurs dans les promesses', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Error Boundary en React ?' UNION ALL
SELECT id, 'B', 'Attraper les erreurs de rendu dans l''arbre de composants enfants et afficher un fallback', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Error Boundary en React ?' UNION ALL
SELECT id, 'C', 'Valider les types des props', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Error Boundary en React ?' UNION ALL
SELECT id, 'D', 'Empêcher les erreurs de syntaxe JSX', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un Error Boundary en React ?';

-- RE Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelles techniques permettent d''optimiser les performances d''une application React ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Utiliser React.memo pour éviter les re-rendus inutiles', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles techniques permettent d''optimiser les performances d''une application React ?' UNION ALL
SELECT id, 'B', 'Utiliser useMemo et useCallback pour mémoriser valeurs et fonctions', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles techniques permettent d''optimiser les performances d''une application React ?' UNION ALL
SELECT id, 'C', 'Toujours utiliser le state global pour toutes les données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles techniques permettent d''optimiser les performances d''une application React ?' UNION ALL
SELECT id, 'D', 'Implémenter le code splitting avec React.lazy()', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles techniques permettent d''optimiser les performances d''une application React ?';

-- RE Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelle est la différence entre getServerSideProps et getStaticProps dans Next.js ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'getServerSideProps s''exécute à chaque requête, getStaticProps au moment du build', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre getServerSideProps et getStaticProps dans Next.js ?' UNION ALL
SELECT id, 'B', 'getStaticProps est plus récent que getServerSideProps', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre getServerSideProps et getStaticProps dans Next.js ?' UNION ALL
SELECT id, 'C', 'getServerSideProps fonctionne côté client', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre getServerSideProps et getStaticProps dans Next.js ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre getServerSideProps et getStaticProps dans Next.js ?';

-- RE Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Que sont les React Server Components ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Des composants qui s''exécutent uniquement sur le serveur et n''envoient pas de JavaScript au client', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les React Server Components ?' UNION ALL
SELECT id, 'B', 'Des composants qui utilisent Node.js pour le rendu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les React Server Components ?' UNION ALL
SELECT id, 'C', 'Des composants qui remplacent les API REST', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les React Server Components ?' UNION ALL
SELECT id, 'D', 'Des composants qui ne peuvent pas avoir de state', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que sont les React Server Components ?';

-- RE Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce que le Concurrent Mode en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un mode qui permet d''exécuter React sur plusieurs threads', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Concurrent Mode en React ?' UNION ALL
SELECT id, 'B', 'Un mécanisme permettant à React d''interrompre et reprendre le rendu pour garder l''interface réactive', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Concurrent Mode en React ?' UNION ALL
SELECT id, 'C', 'Un mode de débogage avancé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Concurrent Mode en React ?' UNION ALL
SELECT id, 'D', 'Un système de gestion d''état concurrent', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Concurrent Mode en React ?';

-- RE Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quelles affirmations sont vraies concernant useEffect ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Sans tableau de dépendances, il s''exécute après chaque rendu', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant useEffect ?' UNION ALL
SELECT id, 'B', 'La fonction de nettoyage s''exécute avant chaque ré-exécution de l''effet', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant useEffect ?' UNION ALL
SELECT id, 'C', 'Il s''exécute de manière synchrone avant le rendu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant useEffect ?' UNION ALL
SELECT id, 'D', 'Il peut retourner directement une promesse async', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles affirmations sont vraies concernant useEffect ?';

-- RE Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Quel hook React 18 permet de marquer une mise à jour d''état comme non urgente ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'useDeferredValue', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook React 18 permet de marquer une mise à jour d''état comme non urgente ?' UNION ALL
SELECT id, 'B', 'useTransition', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook React 18 permet de marquer une mise à jour d''état comme non urgente ?' UNION ALL
SELECT id, 'C', 'useSyncExternalStore', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook React 18 permet de marquer une mise à jour d''état comme non urgente ?' UNION ALL
SELECT id, 'D', 'useInsertionEffect', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel hook React 18 permet de marquer une mise à jour d''état comme non urgente ?';

-- RE Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'react'), 'Qu''est-ce que le pattern Compound Components en React ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un pattern où plusieurs composants travaillent ensemble en partageant un état implicite', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Compound Components en React ?' UNION ALL
SELECT id, 'B', 'Un pattern pour combiner plusieurs hooks en un seul', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Compound Components en React ?' UNION ALL
SELECT id, 'C', 'Un pattern pour créer des composants avec TypeScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Compound Components en React ?' UNION ALL
SELECT id, 'D', 'Un pattern pour fusionner plusieurs composants en un seul fichier', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Compound Components en React ?';


-- ==================== CULTURE DEV (50 questions) ====================

-- CD Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Que signifie le "S" dans les principes SOLID ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Single Responsibility Principle', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le "S" dans les principes SOLID ?' UNION ALL
SELECT id, 'B', 'Service-oriented Principle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le "S" dans les principes SOLID ?' UNION ALL
SELECT id, 'C', 'Structured Programming Principle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le "S" dans les principes SOLID ?' UNION ALL
SELECT id, 'D', 'Singleton Pattern Principle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le "S" dans les principes SOLID ?';

-- CD Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel design pattern permet de créer une seule instance d''un objet ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Factory', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de créer une seule instance d''un objet ?' UNION ALL
SELECT id, 'B', 'Singleton', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de créer une seule instance d''un objet ?' UNION ALL
SELECT id, 'C', 'Observer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de créer une seule instance d''un objet ?' UNION ALL
SELECT id, 'D', 'Adapter', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de créer une seule instance d''un objet ?';

-- CD Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qui est considéré comme le créateur de Linux ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Richard Stallman', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui est considéré comme le créateur de Linux ?' UNION ALL
SELECT id, 'B', 'Dennis Ritchie', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui est considéré comme le créateur de Linux ?' UNION ALL
SELECT id, 'C', 'Linus Torvalds', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui est considéré comme le créateur de Linux ?' UNION ALL
SELECT id, 'D', 'Ken Thompson', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui est considéré comme le créateur de Linux ?';

-- CD Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle est la complexité temporelle d''une recherche dans un tableau trié avec la recherche binaire ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'O(n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle d''une recherche dans un tableau trié avec la recherche binaire ?' UNION ALL
SELECT id, 'B', 'O(log n)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle d''une recherche dans un tableau trié avec la recherche binaire ?' UNION ALL
SELECT id, 'C', 'O(n log n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle d''une recherche dans un tableau trié avec la recherche binaire ?' UNION ALL
SELECT id, 'D', 'O(1)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle d''une recherche dans un tableau trié avec la recherche binaire ?';

-- CD Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Que signifie l''acronyme REST ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Remote Execution of Server Tasks', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme REST ?' UNION ALL
SELECT id, 'B', 'Representational State Transfer', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme REST ?' UNION ALL
SELECT id, 'C', 'Reliable and Efficient Service Technology', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme REST ?' UNION ALL
SELECT id, 'D', 'Resource Entity State Transmission', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie l''acronyme REST ?';

-- CD Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'En Scrum, comment s''appelle la réunion quotidienne de synchronisation ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Sprint Review', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, comment s''appelle la réunion quotidienne de synchronisation ?' UNION ALL
SELECT id, 'B', 'Sprint Planning', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, comment s''appelle la réunion quotidienne de synchronisation ?' UNION ALL
SELECT id, 'C', 'Daily Standup', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, comment s''appelle la réunion quotidienne de synchronisation ?' UNION ALL
SELECT id, 'D', 'Retrospective', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, comment s''appelle la réunion quotidienne de synchronisation ?';

-- CD Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel langage de programmation a été créé par Brendan Eich en 1995 ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Java', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Brendan Eich en 1995 ?' UNION ALL
SELECT id, 'B', 'Python', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Brendan Eich en 1995 ?' UNION ALL
SELECT id, 'C', 'JavaScript', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Brendan Eich en 1995 ?' UNION ALL
SELECT id, 'D', 'PHP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Brendan Eich en 1995 ?';

-- CD Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Que signifie TDD ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Test Driven Development', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie TDD ?' UNION ALL
SELECT id, 'B', 'Type Driven Design', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie TDD ?' UNION ALL
SELECT id, 'C', 'Technical Design Document', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie TDD ?' UNION ALL
SELECT id, 'D', 'Test Data Definition', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie TDD ?';

-- CD Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle licence open source est considérée comme la plus permissive ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'GPL v3', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle licence open source est considérée comme la plus permissive ?' UNION ALL
SELECT id, 'B', 'MIT', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle licence open source est considérée comme la plus permissive ?' UNION ALL
SELECT id, 'C', 'AGPL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle licence open source est considérée comme la plus permissive ?' UNION ALL
SELECT id, 'D', 'LGPL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle licence open source est considérée comme la plus permissive ?';

-- CD Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel verbe HTTP est utilisé pour créer une nouvelle ressource dans une API REST ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'GET', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel verbe HTTP est utilisé pour créer une nouvelle ressource dans une API REST ?' UNION ALL
SELECT id, 'B', 'PUT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel verbe HTTP est utilisé pour créer une nouvelle ressource dans une API REST ?' UNION ALL
SELECT id, 'C', 'POST', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel verbe HTTP est utilisé pour créer une nouvelle ressource dans une API REST ?' UNION ALL
SELECT id, 'D', 'DELETE', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel verbe HTTP est utilisé pour créer une nouvelle ressource dans une API REST ?';

-- CD Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle est la complexité temporelle du tri par insertion dans le pire des cas ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'O(n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri par insertion dans le pire des cas ?' UNION ALL
SELECT id, 'B', 'O(n log n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri par insertion dans le pire des cas ?' UNION ALL
SELECT id, 'C', 'O(n²)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri par insertion dans le pire des cas ?' UNION ALL
SELECT id, 'D', 'O(log n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri par insertion dans le pire des cas ?';

-- CD Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel est le rôle du Product Owner en Scrum ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Écrire le code de l''application', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Product Owner en Scrum ?' UNION ALL
SELECT id, 'B', 'Gérer le backlog produit et prioriser les fonctionnalités', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Product Owner en Scrum ?' UNION ALL
SELECT id, 'C', 'Animer les Daily Standups', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Product Owner en Scrum ?' UNION ALL
SELECT id, 'D', 'Déployer l''application en production', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du Product Owner en Scrum ?';

-- CD Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel pattern de conception permet de notifier automatiquement plusieurs objets d''un changement d''état ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Strategy', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de notifier automatiquement plusieurs objets d''un changement d''état ?' UNION ALL
SELECT id, 'B', 'Observer', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de notifier automatiquement plusieurs objets d''un changement d''état ?' UNION ALL
SELECT id, 'C', 'Decorator', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de notifier automatiquement plusieurs objets d''un changement d''état ?' UNION ALL
SELECT id, 'D', 'Builder', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de notifier automatiquement plusieurs objets d''un changement d''état ?';

-- CD Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qui a écrit le livre "Clean Code" ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Martin Fowler', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui a écrit le livre "Clean Code" ?' UNION ALL
SELECT id, 'B', 'Robert C. Martin (Uncle Bob)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui a écrit le livre "Clean Code" ?' UNION ALL
SELECT id, 'C', 'Kent Beck', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui a écrit le livre "Clean Code" ?' UNION ALL
SELECT id, 'D', 'Eric Evans', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qui a écrit le livre "Clean Code" ?';

-- CD Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel code HTTP indique une ressource non trouvée ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '200', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel code HTTP indique une ressource non trouvée ?' UNION ALL
SELECT id, 'B', '301', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel code HTTP indique une ressource non trouvée ?' UNION ALL
SELECT id, 'C', '404', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel code HTTP indique une ressource non trouvée ?' UNION ALL
SELECT id, 'D', '500', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel code HTTP indique une ressource non trouvée ?';

-- CD Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quels sont les avantages principaux de GraphQL par rapport à REST ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le client peut demander exactement les données dont il a besoin', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages principaux de GraphQL par rapport à REST ?' UNION ALL
SELECT id, 'B', 'Il est toujours plus rapide que REST', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages principaux de GraphQL par rapport à REST ?' UNION ALL
SELECT id, 'C', 'Il réduit le problème de sur-récupération de données (over-fetching)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages principaux de GraphQL par rapport à REST ?' UNION ALL
SELECT id, 'D', 'Il ne nécessite pas de serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les avantages principaux de GraphQL par rapport à REST ?';

-- CD Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel principe SOLID stipule qu''une classe doit être ouverte à l''extension mais fermée à la modification ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Single Responsibility Principle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel principe SOLID stipule qu''une classe doit être ouverte à l''extension mais fermée à la modification ?' UNION ALL
SELECT id, 'B', 'Open/Closed Principle', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel principe SOLID stipule qu''une classe doit être ouverte à l''extension mais fermée à la modification ?' UNION ALL
SELECT id, 'C', 'Liskov Substitution Principle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel principe SOLID stipule qu''une classe doit être ouverte à l''extension mais fermée à la modification ?' UNION ALL
SELECT id, 'D', 'Dependency Inversion Principle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel principe SOLID stipule qu''une classe doit être ouverte à l''extension mais fermée à la modification ?';

-- CD Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Dans le contexte des microservices, qu''est-ce qu''un API Gateway ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un outil de monitoring de performance', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le contexte des microservices, qu''est-ce qu''un API Gateway ?' UNION ALL
SELECT id, 'B', 'Un point d''entrée unique qui route les requêtes vers les microservices appropriés', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le contexte des microservices, qu''est-ce qu''un API Gateway ?' UNION ALL
SELECT id, 'C', 'Une base de données partagée entre les services', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le contexte des microservices, qu''est-ce qu''un API Gateway ?' UNION ALL
SELECT id, 'D', 'Un système de déploiement automatisé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le contexte des microservices, qu''est-ce qu''un API Gateway ?';

-- CD Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle est la complexité temporelle moyenne d''un accès dans une table de hachage (HashMap) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'O(1)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle moyenne d''un accès dans une table de hachage (HashMap) ?' UNION ALL
SELECT id, 'B', 'O(log n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle moyenne d''un accès dans une table de hachage (HashMap) ?' UNION ALL
SELECT id, 'C', 'O(n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle moyenne d''un accès dans une table de hachage (HashMap) ?' UNION ALL
SELECT id, 'D', 'O(n²)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle moyenne d''un accès dans une table de hachage (HashMap) ?';

-- CD Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelles pratiques font partie du TDD ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Écrire le test avant le code de production', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques font partie du TDD ?' UNION ALL
SELECT id, 'B', 'Refactoriser après que le test passe', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques font partie du TDD ?' UNION ALL
SELECT id, 'C', 'Écrire tout le code avant de tester', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques font partie du TDD ?' UNION ALL
SELECT id, 'D', 'Supprimer les tests après la mise en production', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles pratiques font partie du TDD ?';

-- CD Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel design pattern permet de définir une famille d''algorithmes interchangeables ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Observer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de définir une famille d''algorithmes interchangeables ?' UNION ALL
SELECT id, 'B', 'Strategy', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de définir une famille d''algorithmes interchangeables ?' UNION ALL
SELECT id, 'C', 'Template Method', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de définir une famille d''algorithmes interchangeables ?' UNION ALL
SELECT id, 'D', 'Command', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel design pattern permet de définir une famille d''algorithmes interchangeables ?';

-- CD Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'En architecture logicielle, qu''est-ce que le pattern CQRS ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un pattern qui sépare les opérations de lecture et d''écriture', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture logicielle, qu''est-ce que le pattern CQRS ?' UNION ALL
SELECT id, 'B', 'Un pattern de gestion de cache distribué', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture logicielle, qu''est-ce que le pattern CQRS ?' UNION ALL
SELECT id, 'C', 'Un pattern de routage de requêtes HTTP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture logicielle, qu''est-ce que le pattern CQRS ?' UNION ALL
SELECT id, 'D', 'Un pattern de sérialisation de données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture logicielle, qu''est-ce que le pattern CQRS ?';

-- CD Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel langage de programmation a été créé par Guido van Rossum en 1991 ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ruby', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Guido van Rossum en 1991 ?' UNION ALL
SELECT id, 'B', 'Perl', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Guido van Rossum en 1991 ?' UNION ALL
SELECT id, 'C', 'Python', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Guido van Rossum en 1991 ?' UNION ALL
SELECT id, 'D', 'Lua', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel langage de programmation a été créé par Guido van Rossum en 1991 ?';

-- CD Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle différence principale existe entre PUT et PATCH dans une API REST ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'PUT est plus rapide que PATCH', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle différence principale existe entre PUT et PATCH dans une API REST ?' UNION ALL
SELECT id, 'B', 'PUT remplace la ressource entière, PATCH modifie partiellement', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle différence principale existe entre PUT et PATCH dans une API REST ?' UNION ALL
SELECT id, 'C', 'PATCH crée une ressource, PUT la met à jour', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle différence principale existe entre PUT et PATCH dans une API REST ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle différence principale existe entre PUT et PATCH dans une API REST ?';

-- CD Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que le principe DRY en programmation ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Deploy, Run, Yield', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe DRY en programmation ?' UNION ALL
SELECT id, 'B', 'Don''t Repeat Yourself', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe DRY en programmation ?' UNION ALL
SELECT id, 'C', 'Data Retrieval Yield', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe DRY en programmation ?' UNION ALL
SELECT id, 'D', 'Design Reusable Yields', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe DRY en programmation ?';

-- CD Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quels sont des principes du Manifeste Agile ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les individus et leurs interactions plus que les processus et les outils', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des principes du Manifeste Agile ?' UNION ALL
SELECT id, 'B', 'La documentation exhaustive plus que le logiciel opérationnel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des principes du Manifeste Agile ?' UNION ALL
SELECT id, 'C', 'La collaboration avec le client plus que la négociation contractuelle', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des principes du Manifeste Agile ?' UNION ALL
SELECT id, 'D', 'L''adaptation au changement plus que le suivi d''un plan', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des principes du Manifeste Agile ?';

-- CD Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel pattern de conception permet de construire un objet complexe étape par étape ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Factory Method', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de construire un objet complexe étape par étape ?' UNION ALL
SELECT id, 'B', 'Abstract Factory', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de construire un objet complexe étape par étape ?' UNION ALL
SELECT id, 'C', 'Builder', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de construire un objet complexe étape par étape ?' UNION ALL
SELECT id, 'D', 'Prototype', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel pattern de conception permet de construire un objet complexe étape par étape ?';

-- CD Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que le refactoring en clean code ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Réécrire une application depuis zéro', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le refactoring en clean code ?' UNION ALL
SELECT id, 'B', 'Améliorer la structure interne du code sans changer son comportement externe', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le refactoring en clean code ?' UNION ALL
SELECT id, 'C', 'Ajouter de nouvelles fonctionnalités', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le refactoring en clean code ?' UNION ALL
SELECT id, 'D', 'Corriger des bugs en production', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le refactoring en clean code ?';

-- CD Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle est la complexité temporelle du tri fusion (merge sort) dans le pire des cas ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'O(n²)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri fusion (merge sort) dans le pire des cas ?' UNION ALL
SELECT id, 'B', 'O(n log n)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri fusion (merge sort) dans le pire des cas ?' UNION ALL
SELECT id, 'C', 'O(n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri fusion (merge sort) dans le pire des cas ?' UNION ALL
SELECT id, 'D', 'O(log n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle du tri fusion (merge sort) dans le pire des cas ?';

-- CD Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'En Scrum, quelle est la durée recommandée d''un sprint ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', '1 jour', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, quelle est la durée recommandée d''un sprint ?' UNION ALL
SELECT id, 'B', '1 à 4 semaines', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, quelle est la durée recommandée d''un sprint ?' UNION ALL
SELECT id, 'C', '3 à 6 mois', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, quelle est la durée recommandée d''un sprint ?' UNION ALL
SELECT id, 'D', 'Aucune limite de temps', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En Scrum, quelle est la durée recommandée d''un sprint ?';

-- CD Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que le principe d''inversion de dépendances (Dependency Inversion) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les modules de haut niveau ne doivent pas dépendre des modules de bas niveau, les deux doivent dépendre d''abstractions', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe d''inversion de dépendances (Dependency Inversion) ?' UNION ALL
SELECT id, 'B', 'Les dépendances doivent être inversées dans le fichier de configuration', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe d''inversion de dépendances (Dependency Inversion) ?' UNION ALL
SELECT id, 'C', 'Il faut toujours utiliser l''injection de dépendances', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe d''inversion de dépendances (Dependency Inversion) ?' UNION ALL
SELECT id, 'D', 'Les classes enfants doivent dépendre des classes parentes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe d''inversion de dépendances (Dependency Inversion) ?';

-- CD Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel livre de Martin Fowler traite des patterns d''architecture d''entreprise ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Clean Architecture', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel livre de Martin Fowler traite des patterns d''architecture d''entreprise ?' UNION ALL
SELECT id, 'B', 'Patterns of Enterprise Application Architecture', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel livre de Martin Fowler traite des patterns d''architecture d''entreprise ?' UNION ALL
SELECT id, 'C', 'Design Patterns: Elements of Reusable Object-Oriented Software', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel livre de Martin Fowler traite des patterns d''architecture d''entreprise ?' UNION ALL
SELECT id, 'D', 'Domain-Driven Design', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel livre de Martin Fowler traite des patterns d''architecture d''entreprise ?';

-- CD Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce qu''un code smell en clean code ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un bug critique en production', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un code smell en clean code ?' UNION ALL
SELECT id, 'B', 'Un indicateur de mauvaise conception qui nécessite un refactoring', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un code smell en clean code ?' UNION ALL
SELECT id, 'C', 'Une erreur de compilation', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un code smell en clean code ?' UNION ALL
SELECT id, 'D', 'Un commentaire manquant dans le code', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un code smell en clean code ?';

-- CD Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que le pattern Circuit Breaker dans les microservices ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un mécanisme qui coupe les appels vers un service défaillant pour éviter la propagation des erreurs', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Circuit Breaker dans les microservices ?' UNION ALL
SELECT id, 'B', 'Un système de load balancing', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Circuit Breaker dans les microservices ?' UNION ALL
SELECT id, 'C', 'Un outil de monitoring réseau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Circuit Breaker dans les microservices ?' UNION ALL
SELECT id, 'D', 'Un pare-feu applicatif', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le pattern Circuit Breaker dans les microservices ?';

-- CD Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel type d''architecture sépare l''application en couches Présentation, Métier et Données ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Architecture microservices', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''architecture sépare l''application en couches Présentation, Métier et Données ?' UNION ALL
SELECT id, 'B', 'Architecture en couches (Layered Architecture)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''architecture sépare l''application en couches Présentation, Métier et Données ?' UNION ALL
SELECT id, 'C', 'Architecture événementielle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''architecture sépare l''application en couches Présentation, Métier et Données ?' UNION ALL
SELECT id, 'D', 'Architecture hexagonale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel type d''architecture sépare l''application en couches Présentation, Métier et Données ?';

-- CD Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel est le théorème CAP en systèmes distribués ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un système distribué ne peut garantir simultanément Cohérence, Disponibilité et Tolérance au partitionnement', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le théorème CAP en systèmes distribués ?' UNION ALL
SELECT id, 'B', 'Un système doit toujours prioriser la Cohérence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le théorème CAP en systèmes distribués ?' UNION ALL
SELECT id, 'C', 'Il est possible de garantir les trois propriétés en même temps', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le théorème CAP en systèmes distribués ?' UNION ALL
SELECT id, 'D', 'CAP signifie Cache, API et Performance', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le théorème CAP en systèmes distribués ?';

-- CD Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quels sont des patterns du Gang of Four (GoF) de type structurel ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Adapter', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des patterns du Gang of Four (GoF) de type structurel ?' UNION ALL
SELECT id, 'B', 'Observer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des patterns du Gang of Four (GoF) de type structurel ?' UNION ALL
SELECT id, 'C', 'Decorator', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des patterns du Gang of Four (GoF) de type structurel ?' UNION ALL
SELECT id, 'D', 'Facade', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont des patterns du Gang of Four (GoF) de type structurel ?';

-- CD Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que le principe de substitution de Liskov (LSP) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les sous-classes doivent pouvoir remplacer leurs classes parentes sans altérer le comportement du programme', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe de substitution de Liskov (LSP) ?' UNION ALL
SELECT id, 'B', 'Une classe ne doit avoir qu''une seule raison de changer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe de substitution de Liskov (LSP) ?' UNION ALL
SELECT id, 'C', 'Les interfaces doivent être spécifiques au client', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe de substitution de Liskov (LSP) ?' UNION ALL
SELECT id, 'D', 'Les modules de haut niveau ne doivent pas dépendre des modules de bas niveau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe de substitution de Liskov (LSP) ?';

-- CD Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'En architecture hexagonale, que représentent les "ports" ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les points d''entrée réseau de l''application', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture hexagonale, que représentent les "ports" ?' UNION ALL
SELECT id, 'B', 'Les interfaces définissant comment le domaine interagit avec l''extérieur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture hexagonale, que représentent les "ports" ?' UNION ALL
SELECT id, 'C', 'Les bases de données utilisées par l''application', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture hexagonale, que représentent les "ports" ?' UNION ALL
SELECT id, 'D', 'Les endpoints de l''API REST', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En architecture hexagonale, que représentent les "ports" ?';

-- CD Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle est la complexité temporelle de l''algorithme de Dijkstra avec un tas binaire ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'O(V²)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle de l''algorithme de Dijkstra avec un tas binaire ?' UNION ALL
SELECT id, 'B', 'O((V + E) log V)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle de l''algorithme de Dijkstra avec un tas binaire ?' UNION ALL
SELECT id, 'C', 'O(V * E)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle de l''algorithme de Dijkstra avec un tas binaire ?' UNION ALL
SELECT id, 'D', 'O(E log E)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité temporelle de l''algorithme de Dijkstra avec un tas binaire ?';

-- CD Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que l''Event Sourcing en architecture logicielle ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un pattern où l''état est reconstruit à partir d''une séquence d''événements immutables', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''Event Sourcing en architecture logicielle ?' UNION ALL
SELECT id, 'B', 'Un système de gestion d''événements utilisateur dans le navigateur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''Event Sourcing en architecture logicielle ?' UNION ALL
SELECT id, 'C', 'Une technique de compression de données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''Event Sourcing en architecture logicielle ?' UNION ALL
SELECT id, 'D', 'Un outil de monitoring en temps réel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''Event Sourcing en architecture logicielle ?';

-- CD Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle contrainte de la licence GPL est la plus caractéristique ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Interdiction de toute utilisation commerciale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte de la licence GPL est la plus caractéristique ?' UNION ALL
SELECT id, 'B', 'Le copyleft : tout logiciel dérivé doit aussi être distribué sous GPL', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte de la licence GPL est la plus caractéristique ?' UNION ALL
SELECT id, 'C', 'Obligation de mentionner l''auteur original uniquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte de la licence GPL est la plus caractéristique ?' UNION ALL
SELECT id, 'D', 'Le code source ne peut pas être modifié', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle contrainte de la licence GPL est la plus caractéristique ?';

-- CD Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quels problèmes le pattern Saga résout-il dans les microservices ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'La gestion des transactions distribuées entre plusieurs services', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels problèmes le pattern Saga résout-il dans les microservices ?' UNION ALL
SELECT id, 'B', 'La cohérence des données sans transaction ACID globale', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels problèmes le pattern Saga résout-il dans les microservices ?' UNION ALL
SELECT id, 'C', 'Le load balancing entre les instances', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels problèmes le pattern Saga résout-il dans les microservices ?' UNION ALL
SELECT id, 'D', 'Le déploiement automatique des conteneurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels problèmes le pattern Saga résout-il dans les microservices ?';

-- CD Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quel chercheur a inventé le concept de la programmation orientée objet avec Simula ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Alan Kay', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel chercheur a inventé le concept de la programmation orientée objet avec Simula ?' UNION ALL
SELECT id, 'B', 'Ole-Johan Dahl et Kristen Nygaard', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel chercheur a inventé le concept de la programmation orientée objet avec Simula ?' UNION ALL
SELECT id, 'C', 'Bjarne Stroustrup', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel chercheur a inventé le concept de la programmation orientée objet avec Simula ?' UNION ALL
SELECT id, 'D', 'James Gosling', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel chercheur a inventé le concept de la programmation orientée objet avec Simula ?';

-- CD Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que le principe ISP (Interface Segregation Principle) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Les interfaces doivent être séparées en petites interfaces spécifiques plutôt qu''une interface générale', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe ISP (Interface Segregation Principle) ?' UNION ALL
SELECT id, 'B', 'Chaque service doit avoir sa propre interface réseau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe ISP (Interface Segregation Principle) ?' UNION ALL
SELECT id, 'C', 'Les interfaces graphiques doivent être séparées du backend', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe ISP (Interface Segregation Principle) ?' UNION ALL
SELECT id, 'D', 'Il faut toujours utiliser des interfaces au lieu de classes abstraites', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe ISP (Interface Segregation Principle) ?';

-- CD Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Dans le Domain-Driven Design (DDD), qu''est-ce qu''un Bounded Context ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une limite explicite dans laquelle un modèle de domaine est défini et applicable', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le Domain-Driven Design (DDD), qu''est-ce qu''un Bounded Context ?' UNION ALL
SELECT id, 'B', 'Un contexte de sécurité qui limite l''accès aux données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le Domain-Driven Design (DDD), qu''est-ce qu''un Bounded Context ?' UNION ALL
SELECT id, 'C', 'Une variable globale partagée entre les modules', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le Domain-Driven Design (DDD), qu''est-ce qu''un Bounded Context ?' UNION ALL
SELECT id, 'D', 'Un conteneur Docker isolé pour chaque service', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans le Domain-Driven Design (DDD), qu''est-ce qu''un Bounded Context ?';

-- CD Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quelle est la complexité spatiale d''un algorithme de tri en place comme le tri rapide (quicksort) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'O(n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité spatiale d''un algorithme de tri en place comme le tri rapide (quicksort) ?' UNION ALL
SELECT id, 'B', 'O(n log n)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité spatiale d''un algorithme de tri en place comme le tri rapide (quicksort) ?' UNION ALL
SELECT id, 'C', 'O(log n)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité spatiale d''un algorithme de tri en place comme le tri rapide (quicksort) ?' UNION ALL
SELECT id, 'D', 'O(1)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la complexité spatiale d''un algorithme de tri en place comme le tri rapide (quicksort) ?';

-- CD Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Quels concepts sont au coeur de la Clean Architecture de Robert C. Martin ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'La règle de dépendance : les dépendances pointent vers l''intérieur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels concepts sont au coeur de la Clean Architecture de Robert C. Martin ?' UNION ALL
SELECT id, 'B', 'L''indépendance du domaine métier vis-à-vis des frameworks', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels concepts sont au coeur de la Clean Architecture de Robert C. Martin ?' UNION ALL
SELECT id, 'C', 'L''utilisation obligatoire de microservices', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels concepts sont au coeur de la Clean Architecture de Robert C. Martin ?' UNION ALL
SELECT id, 'D', 'Le couplage fort entre les couches pour la performance', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels concepts sont au coeur de la Clean Architecture de Robert C. Martin ?';

-- CD Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'Qu''est-ce que le Strangler Fig Pattern en migration logicielle ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Remplacer progressivement un système legacy en construisant le nouveau système autour de l''ancien', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Strangler Fig Pattern en migration logicielle ?' UNION ALL
SELECT id, 'B', 'Supprimer immédiatement l''ancien système et le remplacer par le nouveau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Strangler Fig Pattern en migration logicielle ?' UNION ALL
SELECT id, 'C', 'Maintenir les deux systèmes en parallèle indéfiniment', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Strangler Fig Pattern en migration logicielle ?' UNION ALL
SELECT id, 'D', 'Réécrire le système legacy dans un nouveau langage en une seule fois', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Strangler Fig Pattern en migration logicielle ?';

-- CD Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'culture-dev'), 'En théorie des graphes, quelle est la différence entre BFS et DFS ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'BFS utilise une pile, DFS utilise une file', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En théorie des graphes, quelle est la différence entre BFS et DFS ?' UNION ALL
SELECT id, 'B', 'BFS explore en largeur avec une file, DFS explore en profondeur avec une pile', true, NOW(), NOW() FROM quiz_questions WHERE question = 'En théorie des graphes, quelle est la différence entre BFS et DFS ?' UNION ALL
SELECT id, 'C', 'BFS est toujours plus rapide que DFS', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En théorie des graphes, quelle est la différence entre BFS et DFS ?' UNION ALL
SELECT id, 'D', 'DFS ne fonctionne que sur les graphes pondérés', false, NOW(), NOW() FROM quiz_questions WHERE question = 'En théorie des graphes, quelle est la différence entre BFS et DFS ?';


-- ==================== SECURITE (50 questions) ====================

-- SEC Q1
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''une attaque XSS (Cross-Site Scripting) ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une injection de scripts malveillants dans une page web vue par d''autres utilisateurs', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque XSS (Cross-Site Scripting) ?' UNION ALL
SELECT id, 'B', 'Une attaque par déni de service distribué', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque XSS (Cross-Site Scripting) ?' UNION ALL
SELECT id, 'C', 'Un vol de certificat SSL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque XSS (Cross-Site Scripting) ?' UNION ALL
SELECT id, 'D', 'Une attaque sur le protocole SSH', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque XSS (Cross-Site Scripting) ?';

-- SEC Q2
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Que signifie HTTPS ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'HyperText Transfer Protocol Standard', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie HTTPS ?' UNION ALL
SELECT id, 'B', 'HyperText Transfer Protocol Secure', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie HTTPS ?' UNION ALL
SELECT id, 'C', 'High Transfer Protocol System', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie HTTPS ?' UNION ALL
SELECT id, 'D', 'HyperText Transmission Protocol Service', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie HTTPS ?';

-- SEC Q3
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel est le rôle principal d''un certificat SSL/TLS ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Compresser les données transmises', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un certificat SSL/TLS ?' UNION ALL
SELECT id, 'B', 'Accélérer le chargement des pages', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un certificat SSL/TLS ?' UNION ALL
SELECT id, 'C', 'Chiffrer les communications entre le client et le serveur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un certificat SSL/TLS ?' UNION ALL
SELECT id, 'D', 'Bloquer les attaques DDoS', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle principal d''un certificat SSL/TLS ?';

-- SEC Q4
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''une injection SQL ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une technique pour optimiser les requêtes SQL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une injection SQL ?' UNION ALL
SELECT id, 'B', 'L''insertion de code SQL malveillant via les entrées utilisateur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une injection SQL ?' UNION ALL
SELECT id, 'C', 'Un outil de migration de base de données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une injection SQL ?' UNION ALL
SELECT id, 'D', 'Une méthode de sauvegarde de base de données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une injection SQL ?';

-- SEC Q5
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelle est la meilleure façon de stocker un mot de passe en base de données ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'En texte brut (plain text)', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la meilleure façon de stocker un mot de passe en base de données ?' UNION ALL
SELECT id, 'B', 'Chiffré avec AES-256', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la meilleure façon de stocker un mot de passe en base de données ?' UNION ALL
SELECT id, 'C', 'Hashé avec un algorithme comme bcrypt ou Argon2', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la meilleure façon de stocker un mot de passe en base de données ?' UNION ALL
SELECT id, 'D', 'Encodé en Base64', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la meilleure façon de stocker un mot de passe en base de données ?';

-- SEC Q6
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Que signifie CSRF ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Cross-Site Request Forgery', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie CSRF ?' UNION ALL
SELECT id, 'B', 'Cross-Server Resource Fetching', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie CSRF ?' UNION ALL
SELECT id, 'C', 'Client-Side Rendering Framework', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie CSRF ?' UNION ALL
SELECT id, 'D', 'Cached Secure Resource File', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie CSRF ?';

-- SEC Q7
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel attribut de cookie empêche l''accès au cookie via JavaScript ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Secure', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut de cookie empêche l''accès au cookie via JavaScript ?' UNION ALL
SELECT id, 'B', 'SameSite', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut de cookie empêche l''accès au cookie via JavaScript ?' UNION ALL
SELECT id, 'C', 'HttpOnly', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut de cookie empêche l''accès au cookie via JavaScript ?' UNION ALL
SELECT id, 'D', 'Path', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel attribut de cookie empêche l''accès au cookie via JavaScript ?';

-- SEC Q8
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le CORS (Cross-Origin Resource Sharing) ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un protocole de chiffrement des données', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS (Cross-Origin Resource Sharing) ?' UNION ALL
SELECT id, 'B', 'Un mécanisme permettant à un serveur d''autoriser les requêtes provenant d''autres origines', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS (Cross-Origin Resource Sharing) ?' UNION ALL
SELECT id, 'C', 'Un type de firewall applicatif', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS (Cross-Origin Resource Sharing) ?' UNION ALL
SELECT id, 'D', 'Un système de cache distribué', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS (Cross-Origin Resource Sharing) ?';

-- SEC Q9
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelle est la différence entre authentification et autorisation ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Ce sont deux termes synonymes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre authentification et autorisation ?' UNION ALL
SELECT id, 'B', 'L''authentification vérifie l''identité, l''autorisation vérifie les permissions', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre authentification et autorisation ?' UNION ALL
SELECT id, 'C', 'L''autorisation vient toujours avant l''authentification', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre authentification et autorisation ?' UNION ALL
SELECT id, 'D', 'L''authentification est côté client, l''autorisation côté serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre authentification et autorisation ?';

-- SEC Q10
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le principe du moindre privilège ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Donner à chaque utilisateur les droits administrateur par défaut', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe du moindre privilège ?' UNION ALL
SELECT id, 'B', 'Ne donner que les permissions strictement nécessaires à chaque utilisateur ou processus', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe du moindre privilège ?' UNION ALL
SELECT id, 'C', 'Supprimer tous les comptes administrateurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe du moindre privilège ?' UNION ALL
SELECT id, 'D', 'Limiter le nombre d''utilisateurs dans le système', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le principe du moindre privilège ?';

-- SEC Q11
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''un JWT (JSON Web Token) ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un format de base de données NoSQL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un JWT (JSON Web Token) ?' UNION ALL
SELECT id, 'B', 'Un token signé contenant des claims, utilisé pour l''authentification stateless', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un JWT (JSON Web Token) ?' UNION ALL
SELECT id, 'C', 'Un protocole de chiffrement symétrique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un JWT (JSON Web Token) ?' UNION ALL
SELECT id, 'D', 'Un outil de test de pénétration', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un JWT (JSON Web Token) ?';

-- SEC Q12
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Que signifie OWASP ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Open Web Application Security Project', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie OWASP ?' UNION ALL
SELECT id, 'B', 'Online Web Attack Security Protocol', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie OWASP ?' UNION ALL
SELECT id, 'C', 'Open Wireless Access Security Platform', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie OWASP ?' UNION ALL
SELECT id, 'D', 'Operational Web Application Scanning Process', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie OWASP ?';

-- SEC Q13
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel est le rôle du rate limiting ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Accélérer les requêtes vers le serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du rate limiting ?' UNION ALL
SELECT id, 'B', 'Limiter le nombre de requêtes qu''un client peut effectuer dans un intervalle donné', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du rate limiting ?' UNION ALL
SELECT id, 'C', 'Compresser les réponses HTTP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du rate limiting ?' UNION ALL
SELECT id, 'D', 'Mettre en cache les pages statiques', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle du rate limiting ?';

-- SEC Q14
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelle est la différence entre chiffrement symétrique et asymétrique ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le symétrique utilise une seule clé, l''asymétrique utilise une paire de clés (publique/privée)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre chiffrement symétrique et asymétrique ?' UNION ALL
SELECT id, 'B', 'Le symétrique est plus lent que l''asymétrique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre chiffrement symétrique et asymétrique ?' UNION ALL
SELECT id, 'C', 'L''asymétrique ne peut pas être utilisé sur Internet', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre chiffrement symétrique et asymétrique ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune différence', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre chiffrement symétrique et asymétrique ?';

-- SEC Q15
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que l''encodage Base64 ?', NULL, 'easy', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un algorithme de chiffrement puissant', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''encodage Base64 ?' UNION ALL
SELECT id, 'B', 'Une méthode de hachage irréversible', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''encodage Base64 ?' UNION ALL
SELECT id, 'C', 'Un schéma d''encodage réversible qui représente des données binaires en texte ASCII', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''encodage Base64 ?' UNION ALL
SELECT id, 'D', 'Un protocole réseau sécurisé', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''encodage Base64 ?';

-- SEC Q16
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quels sont les trois types d''attaques XSS ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Stored (persistant)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''attaques XSS ?' UNION ALL
SELECT id, 'B', 'Reflected (réfléchi)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''attaques XSS ?' UNION ALL
SELECT id, 'C', 'DOM-based', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''attaques XSS ?' UNION ALL
SELECT id, 'D', 'Server-based', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les trois types d''attaques XSS ?';

-- SEC Q17
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Comment se protéger efficacement contre les injections SQL ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'En utilisant des requêtes paramétrées (prepared statements)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment se protéger efficacement contre les injections SQL ?' UNION ALL
SELECT id, 'B', 'En filtrant uniquement les guillemets simples', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment se protéger efficacement contre les injections SQL ?' UNION ALL
SELECT id, 'C', 'En limitant la longueur des champs de saisie', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment se protéger efficacement contre les injections SQL ?' UNION ALL
SELECT id, 'D', 'En utilisant HTTPS', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Comment se protéger efficacement contre les injections SQL ?';

-- SEC Q18
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelles sont les trois parties d''un JWT ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Header, Payload, Signature', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les trois parties d''un JWT ?' UNION ALL
SELECT id, 'B', 'Key, Value, Hash', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les trois parties d''un JWT ?' UNION ALL
SELECT id, 'C', 'Token, Secret, Expiry', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les trois parties d''un JWT ?' UNION ALL
SELECT id, 'D', 'Username, Password, Role', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les trois parties d''un JWT ?';

-- SEC Q19
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le Content Security Policy (CSP) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un en-tête HTTP qui contrôle quelles ressources le navigateur peut charger pour une page', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Content Security Policy (CSP) ?' UNION ALL
SELECT id, 'B', 'Un protocole de chiffrement côté serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Content Security Policy (CSP) ?' UNION ALL
SELECT id, 'C', 'Un outil de gestion de contenu', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Content Security Policy (CSP) ?' UNION ALL
SELECT id, 'D', 'Une politique de confidentialité légale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Content Security Policy (CSP) ?';

-- SEC Q20
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel est l''avantage de bcrypt par rapport à SHA-256 pour le hachage des mots de passe ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'bcrypt est plus rapide', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage de bcrypt par rapport à SHA-256 pour le hachage des mots de passe ?' UNION ALL
SELECT id, 'B', 'bcrypt intègre un sel et un coût ajustable, le rendant résistant aux attaques par force brute', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage de bcrypt par rapport à SHA-256 pour le hachage des mots de passe ?' UNION ALL
SELECT id, 'C', 'SHA-256 ne peut pas hasher des mots de passe', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage de bcrypt par rapport à SHA-256 pour le hachage des mots de passe ?' UNION ALL
SELECT id, 'D', 'bcrypt produit un hash plus court', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est l''avantage de bcrypt par rapport à SHA-256 pour le hachage des mots de passe ?';

-- SEC Q21
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel en-tête HTTP protège contre le clickjacking ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'X-Content-Type-Options', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête HTTP protège contre le clickjacking ?' UNION ALL
SELECT id, 'B', 'X-Frame-Options', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête HTTP protège contre le clickjacking ?' UNION ALL
SELECT id, 'C', 'X-XSS-Protection', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête HTTP protège contre le clickjacking ?' UNION ALL
SELECT id, 'D', 'Strict-Transport-Security', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête HTTP protège contre le clickjacking ?';

-- SEC Q22
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Dans OAuth2, quel flux est recommandé pour les SPA (Single Page Applications) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Implicit Flow', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans OAuth2, quel flux est recommandé pour les SPA (Single Page Applications) ?' UNION ALL
SELECT id, 'B', 'Client Credentials Flow', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans OAuth2, quel flux est recommandé pour les SPA (Single Page Applications) ?' UNION ALL
SELECT id, 'C', 'Authorization Code Flow avec PKCE', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans OAuth2, quel flux est recommandé pour les SPA (Single Page Applications) ?' UNION ALL
SELECT id, 'D', 'Resource Owner Password Flow', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Dans OAuth2, quel flux est recommandé pour les SPA (Single Page Applications) ?';

-- SEC Q23
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Que fait l''attribut SameSite=Strict sur un cookie ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le cookie est envoyé avec toutes les requêtes cross-site', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''attribut SameSite=Strict sur un cookie ?' UNION ALL
SELECT id, 'B', 'Le cookie n''est jamais envoyé avec des requêtes cross-site', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''attribut SameSite=Strict sur un cookie ?' UNION ALL
SELECT id, 'C', 'Le cookie est chiffré automatiquement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''attribut SameSite=Strict sur un cookie ?' UNION ALL
SELECT id, 'D', 'Le cookie expire après une session', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que fait l''attribut SameSite=Strict sur un cookie ?';

-- SEC Q24
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le RBAC (Role-Based Access Control) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un système où les permissions sont attribuées en fonction des rôles des utilisateurs', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le RBAC (Role-Based Access Control) ?' UNION ALL
SELECT id, 'B', 'Un protocole de chiffrement basé sur des règles', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le RBAC (Role-Based Access Control) ?' UNION ALL
SELECT id, 'C', 'Un firewall applicatif', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le RBAC (Role-Based Access Control) ?' UNION ALL
SELECT id, 'D', 'Un algorithme de hachage', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le RBAC (Role-Based Access Control) ?';

-- SEC Q25
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelles mesures protègent contre les attaques CSRF ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Utiliser des tokens CSRF dans les formulaires', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles mesures protègent contre les attaques CSRF ?' UNION ALL
SELECT id, 'B', 'Vérifier l''en-tête Origin/Referer', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles mesures protègent contre les attaques CSRF ?' UNION ALL
SELECT id, 'C', 'Utiliser l''attribut SameSite sur les cookies', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles mesures protègent contre les attaques CSRF ?' UNION ALL
SELECT id, 'D', 'Compresser les réponses avec gzip', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles mesures protègent contre les attaques CSRF ?';

-- SEC Q26
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que l''en-tête HSTS (Strict-Transport-Security) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un en-tête qui force le navigateur à utiliser uniquement HTTPS pour communiquer avec le serveur', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''en-tête HSTS (Strict-Transport-Security) ?' UNION ALL
SELECT id, 'B', 'Un en-tête qui bloque les scripts inline', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''en-tête HSTS (Strict-Transport-Security) ?' UNION ALL
SELECT id, 'C', 'Un en-tête qui limite la bande passante', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''en-tête HSTS (Strict-Transport-Security) ?' UNION ALL
SELECT id, 'D', 'Un en-tête qui active la compression HTTP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que l''en-tête HSTS (Strict-Transport-Security) ?';

-- SEC Q27
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel algorithme de hachage est considéré comme obsolète pour la sécurité ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Argon2', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de hachage est considéré comme obsolète pour la sécurité ?' UNION ALL
SELECT id, 'B', 'bcrypt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de hachage est considéré comme obsolète pour la sécurité ?' UNION ALL
SELECT id, 'C', 'MD5', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de hachage est considéré comme obsolète pour la sécurité ?' UNION ALL
SELECT id, 'D', 'scrypt', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel algorithme de hachage est considéré comme obsolète pour la sécurité ?';

-- SEC Q28
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''un sel (salt) en cryptographie ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une clé de chiffrement principale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un sel (salt) en cryptographie ?' UNION ALL
SELECT id, 'B', 'Une donnée aléatoire ajoutée avant le hachage pour empêcher les attaques par tables arc-en-ciel', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un sel (salt) en cryptographie ?' UNION ALL
SELECT id, 'C', 'Un type de certificat numérique', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un sel (salt) en cryptographie ?' UNION ALL
SELECT id, 'D', 'Un protocole d''échange de clés', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''un sel (salt) en cryptographie ?';

-- SEC Q29
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelle est la vulnérabilité numéro 1 du OWASP Top 10 (2021) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Injection', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la vulnérabilité numéro 1 du OWASP Top 10 (2021) ?' UNION ALL
SELECT id, 'B', 'Broken Access Control', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la vulnérabilité numéro 1 du OWASP Top 10 (2021) ?' UNION ALL
SELECT id, 'C', 'Cross-Site Scripting', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la vulnérabilité numéro 1 du OWASP Top 10 (2021) ?' UNION ALL
SELECT id, 'D', 'Security Misconfiguration', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la vulnérabilité numéro 1 du OWASP Top 10 (2021) ?';

-- SEC Q30
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quels éléments sont nécessaires pour une validation d''entrée côté serveur efficace ?', NULL, 'medium', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Vérification du type de données', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour une validation d''entrée côté serveur efficace ?' UNION ALL
SELECT id, 'B', 'Vérification de la longueur maximale', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour une validation d''entrée côté serveur efficace ?' UNION ALL
SELECT id, 'C', 'Échappement ou encodage des caractères spéciaux', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour une validation d''entrée côté serveur efficace ?' UNION ALL
SELECT id, 'D', 'Validation uniquement côté client avec JavaScript', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels éléments sont nécessaires pour une validation d''entrée côté serveur efficace ?';

-- SEC Q31
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Que signifie le claim "exp" dans un JWT ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'L''expéditeur du token', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le claim "exp" dans un JWT ?' UNION ALL
SELECT id, 'B', 'La date d''expiration du token', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le claim "exp" dans un JWT ?' UNION ALL
SELECT id, 'C', 'L''exportation des données du token', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le claim "exp" dans un JWT ?' UNION ALL
SELECT id, 'D', 'L''exception levée en cas d''erreur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Que signifie le claim "exp" dans un JWT ?';

-- SEC Q32
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel est le rôle d''un WAF (Web Application Firewall) ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Chiffrer les communications réseau', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un WAF (Web Application Firewall) ?' UNION ALL
SELECT id, 'B', 'Filtrer et surveiller le trafic HTTP entre une application web et Internet', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un WAF (Web Application Firewall) ?' UNION ALL
SELECT id, 'C', 'Gérer les certificats SSL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un WAF (Web Application Firewall) ?' UNION ALL
SELECT id, 'D', 'Compresser les fichiers statiques', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel est le rôle d''un WAF (Web Application Firewall) ?';

-- SEC Q33
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''une attaque par force brute ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Essayer systématiquement toutes les combinaisons possibles pour deviner un mot de passe', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par force brute ?' UNION ALL
SELECT id, 'B', 'Exploiter une faille dans le protocole SSL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par force brute ?' UNION ALL
SELECT id, 'C', 'Envoyer un grand volume de requêtes pour surcharger le serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par force brute ?' UNION ALL
SELECT id, 'D', 'Intercepter les paquets réseau en transit', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par force brute ?';

-- SEC Q34
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quel en-tête CORS indique quelles origines sont autorisées ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Access-Control-Allow-Methods', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête CORS indique quelles origines sont autorisées ?' UNION ALL
SELECT id, 'B', 'Access-Control-Allow-Origin', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête CORS indique quelles origines sont autorisées ?' UNION ALL
SELECT id, 'C', 'Access-Control-Allow-Headers', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête CORS indique quelles origines sont autorisées ?' UNION ALL
SELECT id, 'D', 'Access-Control-Max-Age', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quel en-tête CORS indique quelles origines sont autorisées ?';

-- SEC Q35
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Pourquoi ne faut-il jamais stocker un JWT dans le localStorage ?', NULL, 'medium', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Le localStorage est trop lent', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi ne faut-il jamais stocker un JWT dans le localStorage ?' UNION ALL
SELECT id, 'B', 'Le localStorage est limité à 5 Mo', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi ne faut-il jamais stocker un JWT dans le localStorage ?' UNION ALL
SELECT id, 'C', 'Le localStorage est accessible via JavaScript, donc vulnérable aux attaques XSS', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi ne faut-il jamais stocker un JWT dans le localStorage ?' UNION ALL
SELECT id, 'D', 'Le localStorage ne fonctionne pas en HTTPS', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi ne faut-il jamais stocker un JWT dans le localStorage ?';

-- SEC Q36
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''une attaque Man-in-the-Middle (MITM) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un attaquant qui intercepte et peut modifier les communications entre deux parties', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque Man-in-the-Middle (MITM) ?' UNION ALL
SELECT id, 'B', 'Un utilisateur qui se connecte avec deux comptes simultanément', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque Man-in-the-Middle (MITM) ?' UNION ALL
SELECT id, 'C', 'Un serveur proxy qui met en cache les requêtes', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque Man-in-the-Middle (MITM) ?' UNION ALL
SELECT id, 'D', 'Un middleware qui filtre les requêtes HTTP', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque Man-in-the-Middle (MITM) ?';

-- SEC Q37
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le certificate pinning et pourquoi est-il utilisé ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une technique qui associe un hôte à un certificat spécifique pour prévenir les attaques MITM avec faux certificats', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le certificate pinning et pourquoi est-il utilisé ?' UNION ALL
SELECT id, 'B', 'Un mécanisme pour renouveler automatiquement les certificats SSL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le certificate pinning et pourquoi est-il utilisé ?' UNION ALL
SELECT id, 'C', 'Un outil de gestion des certificats dans le cloud', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le certificate pinning et pourquoi est-il utilisé ?' UNION ALL
SELECT id, 'D', 'Une méthode pour partager des certificats entre plusieurs domaines', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le certificate pinning et pourquoi est-il utilisé ?';

-- SEC Q38
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelle est la différence entre un refresh token et un access token dans OAuth2 ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'L''access token a une courte durée de vie et donne accès aux ressources, le refresh token a une longue durée et sert à obtenir un nouvel access token', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un refresh token et un access token dans OAuth2 ?' UNION ALL
SELECT id, 'B', 'Le refresh token est envoyé à chaque requête API', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un refresh token et un access token dans OAuth2 ?' UNION ALL
SELECT id, 'C', 'L''access token ne peut pas expirer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un refresh token et un access token dans OAuth2 ?' UNION ALL
SELECT id, 'D', 'Il n''y a aucune différence fonctionnelle', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelle est la différence entre un refresh token et un access token dans OAuth2 ?';

-- SEC Q39
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que PKCE (Proof Key for Code Exchange) dans OAuth2 ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un mécanisme qui protège l''Authorization Code Flow contre l''interception du code en utilisant un code_verifier et un code_challenge', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que PKCE (Proof Key for Code Exchange) dans OAuth2 ?' UNION ALL
SELECT id, 'B', 'Un algorithme de chiffrement pour les tokens', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que PKCE (Proof Key for Code Exchange) dans OAuth2 ?' UNION ALL
SELECT id, 'C', 'Un protocole de communication entre serveurs OAuth2', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que PKCE (Proof Key for Code Exchange) dans OAuth2 ?' UNION ALL
SELECT id, 'D', 'Un format de stockage des clés privées', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que PKCE (Proof Key for Code Exchange) dans OAuth2 ?';

-- SEC Q40
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quels sont les risques de sécurité liés à l''algorithme "none" dans un JWT ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Aucun risque, c''est un algorithme valide', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les risques de sécurité liés à l''algorithme "none" dans un JWT ?' UNION ALL
SELECT id, 'B', 'Un attaquant peut forger un JWT sans signature qui sera accepté par le serveur si celui-ci ne valide pas correctement l''algorithme', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les risques de sécurité liés à l''algorithme "none" dans un JWT ?' UNION ALL
SELECT id, 'C', 'Le token sera automatiquement rejeté par tous les navigateurs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les risques de sécurité liés à l''algorithme "none" dans un JWT ?' UNION ALL
SELECT id, 'D', 'Le token expirera immédiatement', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quels sont les risques de sécurité liés à l''algorithme "none" dans un JWT ?';

-- SEC Q41
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''une attaque par confusion d''algorithme (algorithm confusion) sur un JWT ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Utiliser un algorithme de hachage plus rapide', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par confusion d''algorithme (algorithm confusion) sur un JWT ?' UNION ALL
SELECT id, 'B', 'Forcer le serveur à vérifier un token RS256 avec l''algorithme HS256 en utilisant la clé publique comme secret', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par confusion d''algorithme (algorithm confusion) sur un JWT ?' UNION ALL
SELECT id, 'C', 'Changer l''encodage du payload de Base64 à hexadécimal', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par confusion d''algorithme (algorithm confusion) sur un JWT ?' UNION ALL
SELECT id, 'D', 'Dupliquer le header du JWT', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque par confusion d''algorithme (algorithm confusion) sur un JWT ?';

-- SEC Q42
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelles directives CSP permettent de prévenir les attaques XSS ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'script-src ''self''', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles directives CSP permettent de prévenir les attaques XSS ?' UNION ALL
SELECT id, 'B', 'default-src ''none''', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles directives CSP permettent de prévenir les attaques XSS ?' UNION ALL
SELECT id, 'C', 'script-src ''unsafe-inline'' ''unsafe-eval''', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles directives CSP permettent de prévenir les attaques XSS ?' UNION ALL
SELECT id, 'D', 'object-src ''none''', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles directives CSP permettent de prévenir les attaques XSS ?';

-- SEC Q43
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le Subresource Integrity (SRI) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Un mécanisme permettant de vérifier l''intégrité des fichiers chargés depuis un CDN via un hash', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Subresource Integrity (SRI) ?' UNION ALL
SELECT id, 'B', 'Un protocole de mise à jour automatique des dépendances', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Subresource Integrity (SRI) ?' UNION ALL
SELECT id, 'C', 'Un système de gestion des permissions de sous-domaines', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Subresource Integrity (SRI) ?' UNION ALL
SELECT id, 'D', 'Un outil d''analyse statique du code', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le Subresource Integrity (SRI) ?';

-- SEC Q44
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce qu''une attaque SSRF (Server-Side Request Forgery) ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une attaque où l''attaquant force le serveur à effectuer des requêtes vers des ressources internes ou externes non prévues', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque SSRF (Server-Side Request Forgery) ?' UNION ALL
SELECT id, 'B', 'Un type de requête HTTP sécurisée', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque SSRF (Server-Side Request Forgery) ?' UNION ALL
SELECT id, 'C', 'Une faille dans le protocole SSH', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque SSRF (Server-Side Request Forgery) ?' UNION ALL
SELECT id, 'D', 'Un problème de configuration DNS', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce qu''une attaque SSRF (Server-Side Request Forgery) ?';

-- SEC Q45
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Pourquoi Argon2 est-il considéré comme supérieur à bcrypt pour le hachage de mots de passe ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Argon2 est plus rapide à calculer', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi Argon2 est-il considéré comme supérieur à bcrypt pour le hachage de mots de passe ?' UNION ALL
SELECT id, 'B', 'Argon2 est résistant aux attaques GPU/ASIC grâce à son paramètre de mémoire configurable (memory-hard)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi Argon2 est-il considéré comme supérieur à bcrypt pour le hachage de mots de passe ?' UNION ALL
SELECT id, 'C', 'Argon2 ne nécessite pas de sel', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi Argon2 est-il considéré comme supérieur à bcrypt pour le hachage de mots de passe ?' UNION ALL
SELECT id, 'D', 'Argon2 produit des hash de taille fixe de 32 bits', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Pourquoi Argon2 est-il considéré comme supérieur à bcrypt pour le hachage de mots de passe ?';

-- SEC Q46
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelles sont les bonnes pratiques pour sécuriser une API REST ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Implémenter le rate limiting et la pagination', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les bonnes pratiques pour sécuriser une API REST ?' UNION ALL
SELECT id, 'B', 'Valider et assainir toutes les entrées', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les bonnes pratiques pour sécuriser une API REST ?' UNION ALL
SELECT id, 'C', 'Utiliser des clés API transmises dans l''URL', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les bonnes pratiques pour sécuriser une API REST ?' UNION ALL
SELECT id, 'D', 'Utiliser HTTPS et des tokens d''authentification dans les en-têtes', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles sont les bonnes pratiques pour sécuriser une API REST ?';

-- SEC Q47
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le timing attack et comment s''en protéger lors de la comparaison de tokens ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une attaque mesurant le temps de réponse pour deviner un token ; on s''en protège avec une comparaison en temps constant', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le timing attack et comment s''en protéger lors de la comparaison de tokens ?' UNION ALL
SELECT id, 'B', 'Une attaque qui exploite les timeouts de session ; on s''en protège en augmentant le délai', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le timing attack et comment s''en protéger lors de la comparaison de tokens ?' UNION ALL
SELECT id, 'C', 'Une attaque DDoS temporisée ; on s''en protège avec un CDN', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le timing attack et comment s''en protéger lors de la comparaison de tokens ?' UNION ALL
SELECT id, 'D', 'Une attaque sur les timestamps des logs ; on s''en protège en chiffrant les logs', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le timing attack et comment s''en protéger lors de la comparaison de tokens ?';

-- SEC Q48
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le prototype pollution en JavaScript ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une attaque qui modifie le prototype d''Object pour injecter des propriétés dans tous les objets de l''application', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype pollution en JavaScript ?' UNION ALL
SELECT id, 'B', 'Une fuite mémoire causée par trop d''objets en mémoire', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype pollution en JavaScript ?' UNION ALL
SELECT id, 'C', 'Un problème de performance lié à la chaîne de prototypes trop longue', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype pollution en JavaScript ?' UNION ALL
SELECT id, 'D', 'Un bug dans le garbage collector de V8', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le prototype pollution en JavaScript ?';

-- SEC Q49
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Qu''est-ce que le CORS preflight request et quand est-il déclenché ?', NULL, 'hard', false, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Une requête GET envoyée avant chaque requête principale', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS preflight request et quand est-il déclenché ?' UNION ALL
SELECT id, 'B', 'Une requête OPTIONS envoyée automatiquement par le navigateur avant certaines requêtes cross-origin non simples', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS preflight request et quand est-il déclenché ?' UNION ALL
SELECT id, 'C', 'Une requête POST de vérification envoyée par le serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS preflight request et quand est-il déclenché ?' UNION ALL
SELECT id, 'D', 'Une requête HEAD pour vérifier la taille de la réponse', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Qu''est-ce que le CORS preflight request et quand est-il déclenché ?';

-- SEC Q50
INSERT INTO quiz_questions (theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
((SELECT id FROM quiz_themes WHERE slug = 'securite'), 'Quelles vulnérabilités peuvent découler d''une mauvaise gestion de la désérialisation ?', NULL, 'hard', true, true, NOW(), NOW());
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at)
SELECT id, 'A', 'Exécution de code arbitraire à distance (RCE)', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles vulnérabilités peuvent découler d''une mauvaise gestion de la désérialisation ?' UNION ALL
SELECT id, 'B', 'Injection d''objets malveillants', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles vulnérabilités peuvent découler d''une mauvaise gestion de la désérialisation ?' UNION ALL
SELECT id, 'C', 'Amélioration des performances du serveur', false, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles vulnérabilités peuvent découler d''une mauvaise gestion de la désérialisation ?' UNION ALL
SELECT id, 'D', 'Élévation de privilèges', true, NOW(), NOW() FROM quiz_questions WHERE question = 'Quelles vulnérabilités peuvent découler d''une mauvaise gestion de la désérialisation ?';

