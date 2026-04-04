-- ============================================================
-- Theme 11 : Histoire du Web
-- 30 questions (IDs 201-230) - 10 easy, 12 medium, 8 hard
-- ============================================================

BEGIN;

-- -----------------------------------------------------------
-- 1. Theme
-- -----------------------------------------------------------
INSERT INTO quiz_themes (id, name, slug, description, color, is_active, created_at, updated_at) VALUES
(11, 'Histoire du Web', 'histoire-web',
 'L''histoire d''Internet, du Web et des technologies qui ont change le monde. Dates, acronymes, inventeurs et anecdotes !',
 '#8e44ad', true, NOW(), NOW())
ON CONFLICT (slug) DO NOTHING;

SELECT setval('quiz_themes_id_seq', GREATEST((SELECT MAX(id) FROM quiz_themes), 11));

-- -----------------------------------------------------------
-- 2. Questions
-- -----------------------------------------------------------
INSERT INTO quiz_questions (id, theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES

-- === EASY (10) ===
(201, 11, 'Que signifie HTML ?', NULL, 'easy', false, true, NOW(), NOW()),
(202, 11, 'Que signifie CSS ?', NULL, 'easy', false, true, NOW(), NOW()),
(203, 11, 'Que signifie WWW ?', NULL, 'easy', false, true, NOW(), NOW()),
(204, 11, 'Qui a invente le World Wide Web ?', NULL, 'easy', false, true, NOW(), NOW()),
(205, 11, 'En quelle annee Google a-t-il ete fonde ?', NULL, 'easy', false, true, NOW(), NOW()),
(206, 11, 'Que signifie URL ?', NULL, 'easy', false, true, NOW(), NOW()),
(207, 11, 'En quelle annee le premier iPhone a-t-il ete presente ?', NULL, 'easy', false, true, NOW(), NOW()),
(208, 11, 'Que signifie HTTP ?', NULL, 'easy', false, true, NOW(), NOW()),
(209, 11, 'Qui a cree le systeme d''exploitation Linux ?', NULL, 'easy', false, true, NOW(), NOW()),
(210, 11, 'En quelle annee Facebook a-t-il ete lance ?', NULL, 'easy', false, true, NOW(), NOW()),

-- === MEDIUM (12) ===
(211, 11, 'En quelle annee le World Wide Web a-t-il ete invente ?', NULL, 'medium', false, true, NOW(), NOW()),
(212, 11, 'En quelle annee JavaScript a-t-il ete cree ?', NULL, 'medium', false, true, NOW(), NOW()),
(213, 11, 'Que signifie PHP a l''origine ?', NULL, 'medium', false, true, NOW(), NOW()),
(214, 11, 'En quelle annee le premier site web a-t-il ete mis en ligne ?', NULL, 'medium', false, true, NOW(), NOW()),
(215, 11, 'Que signifie SQL ?', NULL, 'medium', false, true, NOW(), NOW()),
(216, 11, 'Que signifie API ?', NULL, 'medium', false, true, NOW(), NOW()),
(217, 11, 'En quelle annee le langage Python a-t-il ete cree ?', NULL, 'medium', false, true, NOW(), NOW()),
(218, 11, 'En quelle annee le langage Java a-t-il ete cree ?', NULL, 'medium', false, true, NOW(), NOW()),
(219, 11, 'En quelle annee CSS a-t-il ete propose pour la premiere fois ?', NULL, 'medium', false, true, NOW(), NOW()),
(220, 11, 'Quel a ete le premier navigateur web largement populaire ?', NULL, 'medium', false, true, NOW(), NOW()),
(221, 11, 'Que signifie JSON ?', NULL, 'medium', false, true, NOW(), NOW()),
(222, 11, 'Que signifie DNS ?', NULL, 'medium', false, true, NOW(), NOW()),

-- === HARD (8) ===
(223, 11, 'En combien de jours le langage JavaScript a-t-il ete cree ?', NULL, 'hard', false, true, NOW(), NOW()),
(224, 11, 'Qui a fonde Apple aux cotes de Steve Jobs ?', NULL, 'hard', false, true, NOW(), NOW()),
(225, 11, 'En quelle annee le premier e-mail a-t-il ete envoye ?', NULL, 'hard', false, true, NOW(), NOW()),
(226, 11, 'Quel est le premier nom de domaine .com a avoir ete enregistre ?', NULL, 'hard', false, true, NOW(), NOW()),
(227, 11, 'En quelle annee le langage PHP a-t-il ete cree ?', NULL, 'hard', false, true, NOW(), NOW()),
(228, 11, 'Quel est considere comme le premier langage de programmation de haut niveau ?', NULL, 'hard', false, true, NOW(), NOW()),
(229, 11, 'Que represente le "++" dans le nom du langage C++ ?', NULL, 'hard', false, true, NOW(), NOW()),
(230, 11, 'Qui a envoye le tout premier e-mail de l''histoire ?', NULL, 'hard', false, true, NOW(), NOW())

ON CONFLICT DO NOTHING;

SELECT setval('quiz_questions_id_seq', GREATEST((SELECT MAX(id) FROM quiz_questions), 230));

-- -----------------------------------------------------------
-- 3. Answers (4 par question, exactement 1 correcte)
-- -----------------------------------------------------------
INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at) VALUES

-- Q201 (easy) - Que signifie HTML ?
(201, 'A', 'HyperText Markup Language', true, NOW(), NOW()),
(201, 'B', 'Hot Tamales Make Lunch', false, NOW(), NOW()),
(201, 'C', 'HyperText Modeling Library', false, NOW(), NOW()),
(201, 'D', 'Hamsters Tres Mignons en Ligne', false, NOW(), NOW()),

-- Q202 (easy) - Que signifie CSS ?
(202, 'A', 'Chaussettes Super Stylees', false, NOW(), NOW()),
(202, 'B', 'Computer Style Syntax', false, NOW(), NOW()),
(202, 'C', 'Cascading Style Sheets', true, NOW(), NOW()),
(202, 'D', 'Creative Software System', false, NOW(), NOW()),

-- Q203 (easy) - Que signifie WWW ?
(203, 'A', 'World Wrestling Web', false, NOW(), NOW()),
(203, 'B', 'World Wide Web', true, NOW(), NOW()),
(203, 'C', 'Web World Wide', false, NOW(), NOW()),
(203, 'D', 'Waouh Waouh Waouh, c''est Internet !', false, NOW(), NOW()),

-- Q204 (easy) - Qui a invente le World Wide Web ?
(204, 'A', 'Bill Gates', false, NOW(), NOW()),
(204, 'B', 'Un chat qui a marche sur un clavier en 1987', false, NOW(), NOW()),
(204, 'C', 'Steve Jobs', false, NOW(), NOW()),
(204, 'D', 'Tim Berners-Lee', true, NOW(), NOW()),

-- Q205 (easy) - En quelle annee Google a-t-il ete fonde ?
(205, 'A', '1998', true, NOW(), NOW()),
(205, 'B', '2001', false, NOW(), NOW()),
(205, 'C', '1995', false, NOW(), NOW()),
(205, 'D', '1515, juste apres la bataille de Marignan', false, NOW(), NOW()),

-- Q206 (easy) - Que signifie URL ?
(206, 'A', 'Universal Resource Link', false, NOW(), NOW()),
(206, 'B', 'Ultra Rapide en Ligne', false, NOW(), NOW()),
(206, 'C', 'Uniform Resource Locator', true, NOW(), NOW()),
(206, 'D', 'United Robots League', false, NOW(), NOW()),

-- Q207 (easy) - En quelle annee le premier iPhone ?
(207, 'A', '2005', false, NOW(), NOW()),
(207, 'B', '2009', false, NOW(), NOW()),
(207, 'C', 'En l''an 800, par Charlemagne qui voulait envoyer des SMS', false, NOW(), NOW()),
(207, 'D', '2007', true, NOW(), NOW()),

-- Q208 (easy) - Que signifie HTTP ?
(208, 'A', 'HyperText Transfer Protocol', true, NOW(), NOW()),
(208, 'B', 'HyperText Transmission Page', false, NOW(), NOW()),
(208, 'C', 'Hyper Tortue Turbo Puissante', false, NOW(), NOW()),
(208, 'D', 'High Tech Transfer Program', false, NOW(), NOW()),

-- Q209 (easy) - Qui a cree Linux ?
(209, 'A', 'Un pingouin tres motive', false, NOW(), NOW()),
(209, 'B', 'Linus Torvalds', true, NOW(), NOW()),
(209, 'C', 'Richard Stallman', false, NOW(), NOW()),
(209, 'D', 'Dennis Ritchie', false, NOW(), NOW()),

-- Q210 (easy) - En quelle annee Facebook a-t-il ete lance ?
(210, 'A', '2002', false, NOW(), NOW()),
(210, 'B', '2006', false, NOW(), NOW()),
(210, 'C', '2004', true, NOW(), NOW()),
(210, 'D', 'En 1789, c''etait la Revolution des reseaux sociaux', false, NOW(), NOW()),

-- Q211 (medium) - En quelle annee le WWW a-t-il ete invente ?
(211, 'A', '1993', false, NOW(), NOW()),
(211, 'B', '1985', false, NOW(), NOW()),
(211, 'C', '1989', true, NOW(), NOW()),
(211, 'D', 'En 1492, Christophe Colomb a decouvert le Web en meme temps que l''Amerique', false, NOW(), NOW()),

-- Q212 (medium) - En quelle annee JavaScript a-t-il ete cree ?
(212, 'A', '2005', false, NOW(), NOW()),
(212, 'B', '1995', true, NOW(), NOW()),
(212, 'C', '1492, par Christophe Colomb entre deux decouvertes', false, NOW(), NOW()),
(212, 'D', '1999', false, NOW(), NOW()),

-- Q213 (medium) - Que signifie PHP a l'origine ?
(213, 'A', 'Professional Hypertext Processor', false, NOW(), NOW()),
(213, 'B', 'Patates Hyperactives en Pantoufles', false, NOW(), NOW()),
(213, 'C', 'Personal Home Page', true, NOW(), NOW()),
(213, 'D', 'Pre-Hyper Programming', false, NOW(), NOW()),

-- Q214 (medium) - En quelle annee le premier site web ?
(214, 'A', '1989', false, NOW(), NOW()),
(214, 'B', '1991', true, NOW(), NOW()),
(214, 'C', '1995', false, NOW(), NOW()),
(214, 'D', 'En 1654, grave sur une tablette de pierre par un moine geek', false, NOW(), NOW()),

-- Q215 (medium) - Que signifie SQL ?
(215, 'A', 'Super Questions Logiques', false, NOW(), NOW()),
(215, 'B', 'System Query Logic', false, NOW(), NOW()),
(215, 'C', 'Sequential Query Language', false, NOW(), NOW()),
(215, 'D', 'Structured Query Language', true, NOW(), NOW()),

-- Q216 (medium) - Que signifie API ?
(216, 'A', 'Application Programming Interface', true, NOW(), NOW()),
(216, 'B', 'Automatic Program Installation', false, NOW(), NOW()),
(216, 'C', 'Appareil Pour Informaticiens', false, NOW(), NOW()),
(216, 'D', 'Advanced Protocol Integration', false, NOW(), NOW()),

-- Q217 (medium) - En quelle annee Python a-t-il ete cree ?
(217, 'A', '1995', false, NOW(), NOW()),
(217, 'B', '1991', true, NOW(), NOW()),
(217, 'C', '1988', false, NOW(), NOW()),
(217, 'D', 'En meme temps que les vrais pythons, il y a 30 millions d''annees', false, NOW(), NOW()),

-- Q218 (medium) - En quelle annee Java a-t-il ete cree ?
(218, 'A', '1992', false, NOW(), NOW()),
(218, 'B', 'En 1773, pendant la Boston Tea Party (c''est du the, pas du cafe)', false, NOW(), NOW()),
(218, 'C', '1995', true, NOW(), NOW()),
(218, 'D', '1998', false, NOW(), NOW()),

-- Q219 (medium) - En quelle annee CSS a-t-il ete propose ?
(219, 'A', '1994', false, NOW(), NOW()),
(219, 'B', '1996', true, NOW(), NOW()),
(219, 'C', '1999', false, NOW(), NOW()),
(219, 'D', 'Avant Jesus-Christ, les Romains stylaient deja leurs pages', false, NOW(), NOW()),

-- Q220 (medium) - Premier navigateur web populaire ?
(220, 'A', 'Netscape Navigator', false, NOW(), NOW()),
(220, 'B', 'Internet Explorer', false, NOW(), NOW()),
(220, 'C', 'Mosaic', true, NOW(), NOW()),
(220, 'D', 'Un pigeon voyageur avec une cle USB', false, NOW(), NOW()),

-- Q221 (medium) - Que signifie JSON ?
(221, 'A', 'Java Serialized Object Notation', false, NOW(), NOW()),
(221, 'B', 'Jason, le mec du film d''horreur qui code la nuit', false, NOW(), NOW()),
(221, 'C', 'JavaScript Object Notation', true, NOW(), NOW()),
(221, 'D', 'JavaScript Online Network', false, NOW(), NOW()),

-- Q222 (medium) - Que signifie DNS ?
(222, 'A', 'Domain Name System', true, NOW(), NOW()),
(222, 'B', 'Digital Network Service', false, NOW(), NOW()),
(222, 'C', 'Data Name Server', false, NOW(), NOW()),
(222, 'D', 'Des Noms Super-compliques', false, NOW(), NOW()),

-- Q223 (hard) - En combien de jours JavaScript a-t-il ete cree ?
(223, 'A', '30 jours', false, NOW(), NOW()),
(223, 'B', '10 jours', true, NOW(), NOW()),
(223, 'C', '90 jours', false, NOW(), NOW()),
(223, 'D', '1 seule nuit, apres 47 cafes et une pizza', false, NOW(), NOW()),

-- Q224 (hard) - Qui a fonde Apple avec Steve Jobs ?
(224, 'A', 'Steve Ballmer', false, NOW(), NOW()),
(224, 'B', 'Un pommier dans un garage en Californie', false, NOW(), NOW()),
(224, 'C', 'Steve Wozniak', true, NOW(), NOW()),
(224, 'D', 'Bill Gates', false, NOW(), NOW()),

-- Q225 (hard) - En quelle annee le premier e-mail ?
(225, 'A', '1965', false, NOW(), NOW()),
(225, 'B', '1978', false, NOW(), NOW()),
(225, 'C', '1971', true, NOW(), NOW()),
(225, 'D', 'En 1515, Francois Ier a envoye "lol" a son cousin', false, NOW(), NOW()),

-- Q226 (hard) - Premier nom de domaine .com ?
(226, 'A', 'google.com', false, NOW(), NOW()),
(226, 'B', 'symbolics.com', true, NOW(), NOW()),
(226, 'C', 'ibm.com', false, NOW(), NOW()),
(226, 'D', 'pizza-gratuite-a-vie.com', false, NOW(), NOW()),

-- Q227 (hard) - En quelle annee PHP a-t-il ete cree ?
(227, 'A', '1998', false, NOW(), NOW()),
(227, 'B', '1995', true, NOW(), NOW()),
(227, 'C', '1992', false, NOW(), NOW()),
(227, 'D', 'PHP a toujours existe, comme les moustiques et les bugs', false, NOW(), NOW()),

-- Q228 (hard) - Premier langage de haut niveau ?
(228, 'A', 'COBOL', false, NOW(), NOW()),
(228, 'B', 'Le langage des signes entre developpeurs fatigues', false, NOW(), NOW()),
(228, 'C', 'Pascal', false, NOW(), NOW()),
(228, 'D', 'Fortran', true, NOW(), NOW()),

-- Q229 (hard) - Que represente le "++" dans C++ ?
(229, 'A', 'Cela signifie que le langage est deux fois meilleur que C', false, NOW(), NOW()),
(229, 'B', 'C''est l''operateur d''incrementation du langage C', true, NOW(), NOW()),
(229, 'C', 'C''est la version premium payante du C', false, NOW(), NOW()),
(229, 'D', 'Cela represente les deux createurs du langage', false, NOW(), NOW()),

-- Q230 (hard) - Qui a envoye le premier e-mail ?
(230, 'A', 'Tim Berners-Lee', false, NOW(), NOW()),
(230, 'B', 'Vint Cerf', false, NOW(), NOW()),
(230, 'C', 'Un pigeon qui en avait marre de voler', false, NOW(), NOW()),
(230, 'D', 'Ray Tomlinson', true, NOW(), NOW())

ON CONFLICT (question_id, label) DO NOTHING;

COMMIT;
