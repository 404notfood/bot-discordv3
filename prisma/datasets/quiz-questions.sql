-- =============================================================================
-- Quiz Questions Seed Data
-- 200 questions across 10 themes for a developer quiz Discord bot
-- All questions are in French
-- =============================================================================

BEGIN;

-- =============================================================================
-- THEMES
-- =============================================================================
INSERT INTO quiz_themes (id, name, slug, description, color, is_active, created_at, updated_at) VALUES
(1,  'JavaScript',          'javascript',   'Questions sur JS (ES6+, DOM, async, closures, etc.)',              '#f7df1e', true, NOW(), NOW()),
(2,  'HTML & CSS',          'html-css',     'Questions sur HTML5, CSS3, Flexbox, Grid, semantique',             '#e34c26', true, NOW(), NOW()),
(3,  'Python',              'python',       'Questions sur Python (syntaxe, structures, modules)',               '#3776ab', true, NOW(), NOW()),
(4,  'SQL & Bases de donnees', 'sql-db',    'Questions sur SQL, normalisation, index',                          '#00758f', true, NOW(), NOW()),
(5,  'Git & Versioning',    'git',          'Questions sur Git, branches, merge, rebase',                       '#f05032', true, NOW(), NOW()),
(6,  'React',               'react',        'Questions sur React, hooks, state, composants',                    '#61dafb', true, NOW(), NOW()),
(7,  'DevOps & Infra',      'devops',       'Questions sur Docker, CI/CD, Linux, reseau',                       '#2496ed', true, NOW(), NOW()),
(8,  'Algorithmes & Logique','algo',         'Questions sur complexite, tri, structures de donnees',             '#9b59b6', true, NOW(), NOW()),
(9,  'Securite Web',        'securite',     'Questions sur XSS, CSRF, injection SQL, CORS, HTTPS',              '#e74c3c', true, NOW(), NOW()),
(10, 'Culture Dev',         'culture-dev',  'Questions sur l''histoire de l''informatique, concepts generaux',   '#2ecc71', true, NOW(), NOW())
ON CONFLICT (slug) DO NOTHING;

SELECT setval('quiz_themes_id_seq', (SELECT MAX(id) FROM quiz_themes));

-- =============================================================================
-- QUESTIONS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Theme 1: JavaScript (questions 1-20)
-- 7 easy, 8 medium, 5 hard
-- -----------------------------------------------------------------------------
INSERT INTO quiz_questions (id, theme_id, question, description, difficulty, allow_multiple, is_active, created_at, updated_at) VALUES
(1,  1, 'Quel mot-cle permet de declarer une variable dont la valeur ne peut pas etre reassignee en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW()),
(2,  1, 'Quel est le resultat de typeof null en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW()),
(3,  1, 'Quelle methode permet de transformer un tableau en chaine de caracteres ?', NULL, 'easy', false, true, NOW(), NOW()),
(4,  1, 'Comment ecrire une fonction flechee qui retourne le double de son argument ?', NULL, 'easy', false, true, NOW(), NOW()),
(5,  1, 'Quelle methode permet d''ajouter un element a la fin d''un tableau ?', NULL, 'easy', false, true, NOW(), NOW()),
(6,  1, 'Quel operateur permet de verifier l''egalite stricte (valeur et type) en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW()),
(7,  1, 'Quelle est la valeur de Boolean("") en JavaScript ?', NULL, 'easy', false, true, NOW(), NOW()),
(8,  1, 'Que retourne la methode Array.isArray([1, 2, 3]) ?', NULL, 'medium', false, true, NOW(), NOW()),
(9,  1, 'Quel est le resultat de [..."hello"] en JavaScript ?', NULL, 'medium', false, true, NOW(), NOW()),
(10, 1, 'Quelle est la difference principale entre let et var ?', NULL, 'medium', false, true, NOW(), NOW()),
(11, 1, 'Que fait la methode Promise.all() ?', NULL, 'medium', false, true, NOW(), NOW()),
(12, 1, 'Quel est le resultat de 0.1 + 0.2 === 0.3 en JavaScript ?', NULL, 'medium', false, true, NOW(), NOW()),
(13, 1, 'Quelle methode de tableau retourne un nouveau tableau avec les elements filtres ?', NULL, 'medium', false, true, NOW(), NOW()),
(14, 1, 'Que signifie le mot-cle "this" dans une fonction flechee ?', NULL, 'medium', false, true, NOW(), NOW()),
(15, 1, 'Quel est le resultat de console.log(1 + "2" + 3) ?', NULL, 'medium', false, true, NOW(), NOW()),
(16, 1, 'Qu''est-ce qu''une closure en JavaScript ?', NULL, 'hard', false, true, NOW(), NOW()),
(17, 1, 'Quel est le resultat de typeof NaN ?', NULL, 'hard', false, true, NOW(), NOW()),
(18, 1, 'Comment fonctionne l''event loop en JavaScript ?', NULL, 'hard', false, true, NOW(), NOW()),
(19, 1, 'Que fait Object.freeze() sur un objet imbrique ?', NULL, 'hard', false, true, NOW(), NOW()),
(20, 1, 'Quel est le comportement du hoisting avec let et const ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 2: HTML & CSS (questions 21-40)
-- -----------------------------------------------------------------------------
(21, 2, 'Quelle balise HTML5 est utilisee pour definir une section de navigation ?', NULL, 'easy', false, true, NOW(), NOW()),
(22, 2, 'Quelle propriete CSS permet de changer la couleur du texte ?', NULL, 'easy', false, true, NOW(), NOW()),
(23, 2, 'Quelle balise HTML est utilisee pour inserer une image ?', NULL, 'easy', false, true, NOW(), NOW()),
(24, 2, 'Quelle propriete CSS permet de rendre un element invisible tout en conservant son espace ?', NULL, 'easy', false, true, NOW(), NOW()),
(25, 2, 'Quel attribut HTML rend un champ de formulaire obligatoire ?', NULL, 'easy', false, true, NOW(), NOW()),
(26, 2, 'Quelle est la balise semantique HTML5 pour le contenu principal d''une page ?', NULL, 'easy', false, true, NOW(), NOW()),
(27, 2, 'Quelle unite CSS est relative a la taille de la police de l''element parent ?', NULL, 'easy', false, true, NOW(), NOW()),
(28, 2, 'Quelle propriete Flexbox permet d''aligner les elements sur l''axe principal ?', NULL, 'medium', false, true, NOW(), NOW()),
(29, 2, 'Quelle est la difference entre display: none et visibility: hidden ?', NULL, 'medium', false, true, NOW(), NOW()),
(30, 2, 'Quelle propriete CSS Grid permet de definir les colonnes d''une grille ?', NULL, 'medium', false, true, NOW(), NOW()),
(31, 2, 'Quel selecteur CSS cible le premier enfant d''un element ?', NULL, 'medium', false, true, NOW(), NOW()),
(32, 2, 'Quelle est la specificite d''un selecteur #id .class element ?', NULL, 'medium', false, true, NOW(), NOW()),
(33, 2, 'Quelle propriete CSS permet de creer une animation de transition ?', NULL, 'medium', false, true, NOW(), NOW()),
(34, 2, 'Que fait la propriete CSS position: sticky ?', NULL, 'medium', false, true, NOW(), NOW()),
(35, 2, 'Quelle balise HTML5 permet d''integrer une video ?', NULL, 'medium', false, true, NOW(), NOW()),
(36, 2, 'Que signifie le "C" dans CSS ?', NULL, 'hard', false, true, NOW(), NOW()),
(37, 2, 'Quelle propriete CSS permet de gerer le debordement de texte avec des points de suspension ?', NULL, 'hard', false, true, NOW(), NOW()),
(38, 2, 'Qu''est-ce que le BEM en CSS ?', NULL, 'hard', false, true, NOW(), NOW()),
(39, 2, 'Quelle est la difference entre les pseudo-elements ::before et ::after ?', NULL, 'hard', false, true, NOW(), NOW()),
(40, 2, 'Quelle propriete CSS permet de creer un contexte d''empilement (stacking context) ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 3: Python (questions 41-60)
-- -----------------------------------------------------------------------------
(41, 3, 'Quel mot-cle est utilise pour definir une fonction en Python ?', NULL, 'easy', false, true, NOW(), NOW()),
(42, 3, 'Quelle est la syntaxe pour creer une liste vide en Python ?', NULL, 'easy', false, true, NOW(), NOW()),
(43, 3, 'Comment afficher "Bonjour" dans la console en Python ?', NULL, 'easy', false, true, NOW(), NOW()),
(44, 3, 'Quel type de donnees represente True et False en Python ?', NULL, 'easy', false, true, NOW(), NOW()),
(45, 3, 'Quelle methode permet d''ajouter un element a la fin d''une liste en Python ?', NULL, 'easy', false, true, NOW(), NOW()),
(46, 3, 'Comment ecrire un commentaire sur une seule ligne en Python ?', NULL, 'easy', false, true, NOW(), NOW()),
(47, 3, 'Quel operateur est utilise pour la division entiere en Python ?', NULL, 'easy', false, true, NOW(), NOW()),
(48, 3, 'Que retourne la fonction len("Python") ?', NULL, 'medium', false, true, NOW(), NOW()),
(49, 3, 'Quelle est la difference entre une liste et un tuple en Python ?', NULL, 'medium', false, true, NOW(), NOW()),
(50, 3, 'Que fait le mot-cle yield en Python ?', NULL, 'medium', false, true, NOW(), NOW()),
(51, 3, 'Quelle structure de donnees Python utilise des paires cle-valeur ?', NULL, 'medium', false, true, NOW(), NOW()),
(52, 3, 'Comment ouvrir un fichier en lecture en Python ?', NULL, 'medium', false, true, NOW(), NOW()),
(53, 3, 'Que fait la comprehension de liste [x**2 for x in range(5)] ?', NULL, 'medium', false, true, NOW(), NOW()),
(54, 3, 'Quel module Python est utilise pour travailler avec des expressions regulieres ?', NULL, 'medium', false, true, NOW(), NOW()),
(55, 3, 'Quelle est la sortie de print(type({})) en Python ?', NULL, 'medium', false, true, NOW(), NOW()),
(56, 3, 'Qu''est-ce qu''un decorateur en Python ?', NULL, 'hard', false, true, NOW(), NOW()),
(57, 3, 'Que fait la methode __init__ dans une classe Python ?', NULL, 'hard', false, true, NOW(), NOW()),
(58, 3, 'Quelle est la difference entre deepcopy et copy en Python ?', NULL, 'hard', false, true, NOW(), NOW()),
(59, 3, 'Qu''est-ce que le GIL (Global Interpreter Lock) en Python ?', NULL, 'hard', false, true, NOW(), NOW()),
(60, 3, 'Comment fonctionne le garbage collector en Python ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 4: SQL & Bases de donnees (questions 61-80)
-- -----------------------------------------------------------------------------
(61, 4, 'Quelle commande SQL permet de recuperer des donnees d''une table ?', NULL, 'easy', false, true, NOW(), NOW()),
(62, 4, 'Quel mot-cle SQL permet de filtrer les resultats d''une requete ?', NULL, 'easy', false, true, NOW(), NOW()),
(63, 4, 'Quelle commande SQL permet de supprimer des lignes d''une table ?', NULL, 'easy', false, true, NOW(), NOW()),
(64, 4, 'Quel mot-cle est utilise pour trier les resultats en SQL ?', NULL, 'easy', false, true, NOW(), NOW()),
(65, 4, 'Quelle commande SQL permet d''inserer des donnees dans une table ?', NULL, 'easy', false, true, NOW(), NOW()),
(66, 4, 'Quelle contrainte SQL garantit qu''une colonne ne peut pas contenir de valeur NULL ?', NULL, 'easy', false, true, NOW(), NOW()),
(67, 4, 'Quel mot-cle SQL permet de limiter le nombre de resultats retournes ?', NULL, 'easy', false, true, NOW(), NOW()),
(68, 4, 'Quelle est la difference entre INNER JOIN et LEFT JOIN ?', NULL, 'medium', false, true, NOW(), NOW()),
(69, 4, 'Que fait la clause GROUP BY en SQL ?', NULL, 'medium', false, true, NOW(), NOW()),
(70, 4, 'Quelle est la difference entre WHERE et HAVING en SQL ?', NULL, 'medium', false, true, NOW(), NOW()),
(71, 4, 'Qu''est-ce qu''un index en base de donnees ?', NULL, 'medium', false, true, NOW(), NOW()),
(72, 4, 'Quelle fonction d''agregation SQL retourne le nombre de lignes ?', NULL, 'medium', false, true, NOW(), NOW()),
(73, 4, 'Quelle est la difference entre UNION et UNION ALL ?', NULL, 'medium', false, true, NOW(), NOW()),
(74, 4, 'Que signifie l''acronyme ACID dans le contexte des bases de donnees ?', NULL, 'medium', false, true, NOW(), NOW()),
(75, 4, 'Qu''est-ce qu''une cle etrangere (foreign key) ?', NULL, 'medium', false, true, NOW(), NOW()),
(76, 4, 'Qu''est-ce que la troisieme forme normale (3NF) ?', NULL, 'hard', false, true, NOW(), NOW()),
(77, 4, 'Quelle est la difference entre une vue et une table materialisee ?', NULL, 'hard', false, true, NOW(), NOW()),
(78, 4, 'Qu''est-ce qu''un deadlock en base de donnees ?', NULL, 'hard', false, true, NOW(), NOW()),
(79, 4, 'Que fait une requete CTE (Common Table Expression) ?', NULL, 'hard', false, true, NOW(), NOW()),
(80, 4, 'Quelle est la difference entre un index B-Tree et un index Hash ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 5: Git & Versioning (questions 81-100)
-- -----------------------------------------------------------------------------
(81, 5, 'Quelle commande Git permet de cloner un depot distant ?', NULL, 'easy', false, true, NOW(), NOW()),
(82, 5, 'Quelle commande permet de voir l''etat actuel du depot Git ?', NULL, 'easy', false, true, NOW(), NOW()),
(83, 5, 'Quelle commande Git permet d''ajouter des fichiers a la zone de staging ?', NULL, 'easy', false, true, NOW(), NOW()),
(84, 5, 'Quelle commande permet de creer un nouveau commit ?', NULL, 'easy', false, true, NOW(), NOW()),
(85, 5, 'Comment creer une nouvelle branche en Git ?', NULL, 'easy', false, true, NOW(), NOW()),
(86, 5, 'Quelle commande permet de voir l''historique des commits ?', NULL, 'easy', false, true, NOW(), NOW()),
(87, 5, 'Quelle commande permet d''envoyer les commits vers un depot distant ?', NULL, 'easy', false, true, NOW(), NOW()),
(88, 5, 'Quelle est la difference entre git merge et git rebase ?', NULL, 'medium', false, true, NOW(), NOW()),
(89, 5, 'Que fait la commande git stash ?', NULL, 'medium', false, true, NOW(), NOW()),
(90, 5, 'Quelle commande permet d''annuler le dernier commit tout en gardant les modifications ?', NULL, 'medium', false, true, NOW(), NOW()),
(91, 5, 'Que fait la commande git fetch ?', NULL, 'medium', false, true, NOW(), NOW()),
(92, 5, 'Qu''est-ce qu''un conflit de merge en Git ?', NULL, 'medium', false, true, NOW(), NOW()),
(93, 5, 'Quelle commande permet de voir les differences entre deux commits ?', NULL, 'medium', false, true, NOW(), NOW()),
(94, 5, 'Que contient le fichier .gitignore ?', NULL, 'medium', false, true, NOW(), NOW()),
(95, 5, 'Quelle commande permet de changer de branche ?', NULL, 'medium', false, true, NOW(), NOW()),
(96, 5, 'Qu''est-ce que git cherry-pick ?', NULL, 'hard', false, true, NOW(), NOW()),
(97, 5, 'Quelle est la difference entre git reset --soft, --mixed et --hard ?', NULL, 'hard', false, true, NOW(), NOW()),
(98, 5, 'Qu''est-ce que le git reflog ?', NULL, 'hard', false, true, NOW(), NOW()),
(99, 5, 'Que fait la commande git bisect ?', NULL, 'hard', false, true, NOW(), NOW()),
(100, 5, 'Comment fonctionne le modele de stockage d''objets de Git (blob, tree, commit) ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 6: React (questions 101-120)
-- -----------------------------------------------------------------------------
(101, 6, 'Quel hook React permet de gerer l''etat local d''un composant ?', NULL, 'easy', false, true, NOW(), NOW()),
(102, 6, 'Quelle est la syntaxe pour creer un composant fonctionnel React ?', NULL, 'easy', false, true, NOW(), NOW()),
(103, 6, 'Que sont les props en React ?', NULL, 'easy', false, true, NOW(), NOW()),
(104, 6, 'Quel est le role de la methode render() dans un composant classe React ?', NULL, 'easy', false, true, NOW(), NOW()),
(105, 6, 'Quelle syntaxe est utilisee pour ecrire du HTML dans du JavaScript en React ?', NULL, 'easy', false, true, NOW(), NOW()),
(106, 6, 'Comment afficher conditionnellement un element en React ?', NULL, 'easy', false, true, NOW(), NOW()),
(107, 6, 'A quoi sert la prop key dans une liste React ?', NULL, 'easy', false, true, NOW(), NOW()),
(108, 6, 'Quel hook React est utilise pour executer des effets de bord ?', NULL, 'medium', false, true, NOW(), NOW()),
(109, 6, 'Que fait React.memo() ?', NULL, 'medium', false, true, NOW(), NOW()),
(110, 6, 'Quelle est la difference entre un composant controle et non controle ?', NULL, 'medium', false, true, NOW(), NOW()),
(111, 6, 'A quoi sert le hook useContext ?', NULL, 'medium', false, true, NOW(), NOW()),
(112, 6, 'Que fait le hook useRef en React ?', NULL, 'medium', false, true, NOW(), NOW()),
(113, 6, 'Qu''est-ce que le Virtual DOM en React ?', NULL, 'medium', false, true, NOW(), NOW()),
(114, 6, 'Comment passer des donnees d''un composant enfant vers un composant parent ?', NULL, 'medium', false, true, NOW(), NOW()),
(115, 6, 'Quel est le cycle de vie d''un composant classe React (equivalent avec hooks) ?', NULL, 'medium', false, true, NOW(), NOW()),
(116, 6, 'A quoi sert le hook useReducer ?', NULL, 'hard', false, true, NOW(), NOW()),
(117, 6, 'Qu''est-ce que le pattern de render props en React ?', NULL, 'hard', false, true, NOW(), NOW()),
(118, 6, 'Comment fonctionne la reconciliation dans React ?', NULL, 'hard', false, true, NOW(), NOW()),
(119, 6, 'Qu''est-ce que React.lazy() et Suspense ?', NULL, 'hard', false, true, NOW(), NOW()),
(120, 6, 'Quelle est la difference entre useMemo et useCallback ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 7: DevOps & Infra (questions 121-140)
-- -----------------------------------------------------------------------------
(121, 7, 'Que signifie l''acronyme CI/CD ?', NULL, 'easy', false, true, NOW(), NOW()),
(122, 7, 'Quelle commande permet de lister les conteneurs Docker en cours d''execution ?', NULL, 'easy', false, true, NOW(), NOW()),
(123, 7, 'Quel fichier est utilise pour definir les services dans Docker Compose ?', NULL, 'easy', false, true, NOW(), NOW()),
(124, 7, 'Quelle commande Linux permet de voir les processus en cours d''execution ?', NULL, 'easy', false, true, NOW(), NOW()),
(125, 7, 'Quel port est utilise par defaut pour le protocole HTTP ?', NULL, 'easy', false, true, NOW(), NOW()),
(126, 7, 'Quelle commande Linux permet de changer les permissions d''un fichier ?', NULL, 'easy', false, true, NOW(), NOW()),
(127, 7, 'Que fait la commande docker build ?', NULL, 'easy', false, true, NOW(), NOW()),
(128, 7, 'Quelle est la difference entre une image Docker et un conteneur Docker ?', NULL, 'medium', false, true, NOW(), NOW()),
(129, 7, 'Que fait un reverse proxy comme Nginx ?', NULL, 'medium', false, true, NOW(), NOW()),
(130, 7, 'Qu''est-ce qu''un volume Docker ?', NULL, 'medium', false, true, NOW(), NOW()),
(131, 7, 'Quelle est la difference entre TCP et UDP ?', NULL, 'medium', false, true, NOW(), NOW()),
(132, 7, 'Que fait la commande Linux grep ?', NULL, 'medium', false, true, NOW(), NOW()),
(133, 7, 'Qu''est-ce qu''un pipeline CI/CD ?', NULL, 'medium', false, true, NOW(), NOW()),
(134, 7, 'Quelle commande Docker permet de voir les logs d''un conteneur ?', NULL, 'medium', false, true, NOW(), NOW()),
(135, 7, 'A quoi sert un fichier Dockerfile ?', NULL, 'medium', false, true, NOW(), NOW()),
(136, 7, 'Qu''est-ce que Kubernetes ?', NULL, 'hard', false, true, NOW(), NOW()),
(137, 7, 'Quelle est la difference entre un deploiement blue-green et un canary deployment ?', NULL, 'hard', false, true, NOW(), NOW()),
(138, 7, 'Qu''est-ce qu''un multi-stage build en Docker ?', NULL, 'hard', false, true, NOW(), NOW()),
(139, 7, 'Comment fonctionne le DNS (Domain Name System) ?', NULL, 'hard', false, true, NOW(), NOW()),
(140, 7, 'Qu''est-ce que l''Infrastructure as Code (IaC) ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 8: Algorithmes & Logique (questions 141-160)
-- -----------------------------------------------------------------------------
(141, 8, 'Quelle est la complexite temporelle d''une recherche dans un tableau non trie ?', NULL, 'easy', false, true, NOW(), NOW()),
(142, 8, 'Quelle structure de donnees fonctionne selon le principe FIFO (First In, First Out) ?', NULL, 'easy', false, true, NOW(), NOW()),
(143, 8, 'Quelle structure de donnees fonctionne selon le principe LIFO (Last In, First Out) ?', NULL, 'easy', false, true, NOW(), NOW()),
(144, 8, 'Que signifie O(1) en notation Big O ?', NULL, 'easy', false, true, NOW(), NOW()),
(145, 8, 'Quel est le resultat de 10 en binaire ?', NULL, 'easy', false, true, NOW(), NOW()),
(146, 8, 'Qu''est-ce qu''un algorithme de tri ?', NULL, 'easy', false, true, NOW(), NOW()),
(147, 8, 'Combien de fois une boucle for(i=0; i<n; i++) s''execute-t-elle ?', NULL, 'easy', false, true, NOW(), NOW()),
(148, 8, 'Quelle est la complexite temporelle du tri par insertion dans le pire cas ?', NULL, 'medium', false, true, NOW(), NOW()),
(149, 8, 'Qu''est-ce qu''un algorithme recursif ?', NULL, 'medium', false, true, NOW(), NOW()),
(150, 8, 'Quelle est la complexite temporelle de la recherche binaire (dichotomique) ?', NULL, 'medium', false, true, NOW(), NOW()),
(151, 8, 'Qu''est-ce qu''une table de hachage (hash table) ?', NULL, 'medium', false, true, NOW(), NOW()),
(152, 8, 'Quelle est la complexite du tri fusion (merge sort) ?', NULL, 'medium', false, true, NOW(), NOW()),
(153, 8, 'Qu''est-ce qu''un arbre binaire de recherche (BST) ?', NULL, 'medium', false, true, NOW(), NOW()),
(154, 8, 'Que fait l''algorithme BFS (Breadth-First Search) ?', NULL, 'medium', false, true, NOW(), NOW()),
(155, 8, 'Quelle est la difference entre un graphe oriente et non oriente ?', NULL, 'medium', false, true, NOW(), NOW()),
(156, 8, 'Qu''est-ce que la programmation dynamique ?', NULL, 'hard', false, true, NOW(), NOW()),
(157, 8, 'Quelle est la complexite temporelle moyenne du tri rapide (quicksort) ?', NULL, 'hard', false, true, NOW(), NOW()),
(158, 8, 'Qu''est-ce qu''un algorithme glouton (greedy) ?', NULL, 'hard', false, true, NOW(), NOW()),
(159, 8, 'Quelle structure de donnees est ideale pour implementer une file de priorite ?', NULL, 'hard', false, true, NOW(), NOW()),
(160, 8, 'Qu''est-ce que le probleme P vs NP ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 9: Securite Web (questions 161-180)
-- -----------------------------------------------------------------------------
(161, 9, 'Que signifie l''acronyme XSS ?', NULL, 'easy', false, true, NOW(), NOW()),
(162, 9, 'Quel protocole assure le chiffrement des echanges sur le web ?', NULL, 'easy', false, true, NOW(), NOW()),
(163, 9, 'Qu''est-ce qu''une injection SQL ?', NULL, 'easy', false, true, NOW(), NOW()),
(164, 9, 'A quoi sert un certificat SSL/TLS ?', NULL, 'easy', false, true, NOW(), NOW()),
(165, 9, 'Quelle est la methode la plus simple pour prevenir les injections SQL ?', NULL, 'easy', false, true, NOW(), NOW()),
(166, 9, 'Que signifie l''acronyme HTTPS ?', NULL, 'easy', false, true, NOW(), NOW()),
(167, 9, 'Qu''est-ce qu''un mot de passe hache ?', NULL, 'easy', false, true, NOW(), NOW()),
(168, 9, 'Que signifie CSRF (Cross-Site Request Forgery) ?', NULL, 'medium', false, true, NOW(), NOW()),
(169, 9, 'Qu''est-ce que le CORS (Cross-Origin Resource Sharing) ?', NULL, 'medium', false, true, NOW(), NOW()),
(170, 9, 'Quel header HTTP aide a prevenir les attaques XSS ?', NULL, 'medium', false, true, NOW(), NOW()),
(171, 9, 'Qu''est-ce qu''un token JWT (JSON Web Token) ?', NULL, 'medium', false, true, NOW(), NOW()),
(172, 9, 'A quoi sert le header Content-Security-Policy ?', NULL, 'medium', false, true, NOW(), NOW()),
(173, 9, 'Quelle est la difference entre l''authentification et l''autorisation ?', NULL, 'medium', false, true, NOW(), NOW()),
(174, 9, 'Qu''est-ce que le principe du moindre privilege ?', NULL, 'medium', false, true, NOW(), NOW()),
(175, 9, 'Qu''est-ce qu''une attaque par force brute ?', NULL, 'medium', false, true, NOW(), NOW()),
(176, 9, 'Qu''est-ce que l''OWASP Top 10 ?', NULL, 'hard', false, true, NOW(), NOW()),
(177, 9, 'Qu''est-ce qu''une attaque de type Man-in-the-Middle (MITM) ?', NULL, 'hard', false, true, NOW(), NOW()),
(178, 9, 'Comment fonctionne le mecanisme de SameSite pour les cookies ?', NULL, 'hard', false, true, NOW(), NOW()),
(179, 9, 'Qu''est-ce que le HSTS (HTTP Strict Transport Security) ?', NULL, 'hard', false, true, NOW(), NOW()),
(180, 9, 'Quelle est la difference entre le chiffrement symetrique et asymetrique ?', NULL, 'hard', false, true, NOW(), NOW()),

-- -----------------------------------------------------------------------------
-- Theme 10: Culture Dev (questions 181-200)
-- -----------------------------------------------------------------------------
(181, 10, 'Qui est considere comme le createur du World Wide Web ?', NULL, 'easy', false, true, NOW(), NOW()),
(182, 10, 'En quelle annee a ete cree le langage JavaScript ?', NULL, 'easy', false, true, NOW(), NOW()),
(183, 10, 'Que signifie l''acronyme API ?', NULL, 'easy', false, true, NOW(), NOW()),
(184, 10, 'Quel langage est souvent appele "le langage du web" ?', NULL, 'easy', false, true, NOW(), NOW()),
(185, 10, 'Que signifie l''acronyme IDE ?', NULL, 'easy', false, true, NOW(), NOW()),
(186, 10, 'Qui est la premiere programmeuse de l''histoire ?', NULL, 'easy', false, true, NOW(), NOW()),
(187, 10, 'Que signifie l''acronyme HTTP ?', NULL, 'easy', false, true, NOW(), NOW()),
(188, 10, 'Qu''est-ce que l''Open Source ?', NULL, 'medium', false, true, NOW(), NOW()),
(189, 10, 'Qu''est-ce que la methodologie Agile ?', NULL, 'medium', false, true, NOW(), NOW()),
(190, 10, 'Que signifie le principe DRY en programmation ?', NULL, 'medium', false, true, NOW(), NOW()),
(191, 10, 'Qu''est-ce que le pattern MVC ?', NULL, 'medium', false, true, NOW(), NOW()),
(192, 10, 'Quel est le role d''un linter dans le developpement ?', NULL, 'medium', false, true, NOW(), NOW()),
(193, 10, 'Qu''est-ce que le Semantic Versioning (SemVer) ?', NULL, 'medium', false, true, NOW(), NOW()),
(194, 10, 'Que signifie REST dans le contexte des API ?', NULL, 'medium', false, true, NOW(), NOW()),
(195, 10, 'Qu''est-ce que le Test-Driven Development (TDD) ?', NULL, 'medium', false, true, NOW(), NOW()),
(196, 10, 'Qu''est-ce que les principes SOLID en programmation orientee objet ?', NULL, 'hard', false, true, NOW(), NOW()),
(197, 10, 'Qu''est-ce que le theoreme CAP dans les systemes distribues ?', NULL, 'hard', false, true, NOW(), NOW()),
(198, 10, 'Qu''est-ce que la loi de Moore ?', NULL, 'hard', false, true, NOW(), NOW()),
(199, 10, 'Quel probleme resout le pattern Observer (Observateur) ?', NULL, 'hard', false, true, NOW(), NOW()),
(200, 10, 'Qu''est-ce que le concept de dette technique ?', NULL, 'hard', false, true, NOW(), NOW())
ON CONFLICT DO NOTHING;

SELECT setval('quiz_questions_id_seq', (SELECT MAX(id) FROM quiz_questions));

-- =============================================================================
-- ANSWERS
-- =============================================================================

INSERT INTO quiz_answers (question_id, label, text, is_correct, created_at, updated_at) VALUES

-- =============================================================================
-- Theme 1: JavaScript (Q1-Q20)
-- =============================================================================

-- Q1: Quel mot-cle permet de declarer une variable dont la valeur ne peut pas etre reassignee ? (easy)
(1, 'A', 'var', false, NOW(), NOW()),
(1, 'B', 'let', false, NOW(), NOW()),
(1, 'C', 'const', true, NOW(), NOW()),
(1, 'D', 'static', false, NOW(), NOW()),

-- Q2: Quel est le resultat de typeof null ? (easy)
(2, 'A', 'null', false, NOW(), NOW()),
(2, 'B', 'undefined', false, NOW(), NOW()),
(2, 'C', 'object', true, NOW(), NOW()),
(2, 'D', 'boolean', false, NOW(), NOW()),

-- Q3: Quelle methode permet de transformer un tableau en chaine de caracteres ? (easy)
(3, 'A', 'toString()', false, NOW(), NOW()),
(3, 'B', 'join()', true, NOW(), NOW()),
(3, 'C', 'concat()', false, NOW(), NOW()),
(3, 'D', 'split()', false, NOW(), NOW()),

-- Q4: Comment ecrire une fonction flechee qui retourne le double ? (easy)
(4, 'A', 'function double(x) { return x * 2 }', false, NOW(), NOW()),
(4, 'B', 'const double = (x) -> x * 2', false, NOW(), NOW()),
(4, 'C', 'const double = x => x * 2', true, NOW(), NOW()),
(4, 'D', 'const double = x -> { x * 2 }', false, NOW(), NOW()),

-- Q5: Quelle methode permet d''ajouter un element a la fin d''un tableau ? (easy)
(5, 'A', 'unshift()', false, NOW(), NOW()),
(5, 'B', 'append()', false, NOW(), NOW()),
(5, 'C', 'add()', false, NOW(), NOW()),
(5, 'D', 'push()', true, NOW(), NOW()),

-- Q6: Quel operateur verifie l''egalite stricte ? (easy)
(6, 'A', '==', false, NOW(), NOW()),
(6, 'B', '===', true, NOW(), NOW()),
(6, 'C', '!=', false, NOW(), NOW()),
(6, 'D', '>=', false, NOW(), NOW()),

-- Q7: Quelle est la valeur de Boolean("") ? (easy)
(7, 'A', 'true', false, NOW(), NOW()),
(7, 'B', 'false', true, NOW(), NOW()),
(7, 'C', 'undefined', false, NOW(), NOW()),
(7, 'D', 'null', false, NOW(), NOW()),

-- Q8: Que retourne Array.isArray([1, 2, 3]) ? (medium)
(8, 'A', 'true', true, NOW(), NOW()),
(8, 'B', 'false', false, NOW(), NOW()),
(8, 'C', 'undefined', false, NOW(), NOW()),
(8, 'D', '[1, 2, 3]', false, NOW(), NOW()),

-- Q9: Quel est le resultat de [..."hello"] ? (medium)
(9, 'A', '["hello"]', false, NOW(), NOW()),
(9, 'B', '["h", "e", "l", "l", "o"]', true, NOW(), NOW()),
(9, 'C', 'Erreur de syntaxe', false, NOW(), NOW()),
(9, 'D', '["h-e-l-l-o"]', false, NOW(), NOW()),

-- Q10: Difference entre let et var ? (medium)
(10, 'A', 'let a une portee de bloc, var a une portee de fonction', true, NOW(), NOW()),
(10, 'B', 'var a une portee de bloc, let a une portee de fonction', false, NOW(), NOW()),
(10, 'C', 'Il n''y a aucune difference', false, NOW(), NOW()),
(10, 'D', 'let est plus rapide que var', false, NOW(), NOW()),

-- Q11: Que fait Promise.all() ? (medium)
(11, 'A', 'Execute les promesses une par une', false, NOW(), NOW()),
(11, 'B', 'Retourne la premiere promesse resolue', false, NOW(), NOW()),
(11, 'C', 'Attend que toutes les promesses soient resolues ou qu''une soit rejetee', true, NOW(), NOW()),
(11, 'D', 'Annule toutes les promesses en cours', false, NOW(), NOW()),

-- Q12: 0.1 + 0.2 === 0.3 ? (medium)
(12, 'A', 'true', false, NOW(), NOW()),
(12, 'B', 'false', true, NOW(), NOW()),
(12, 'C', 'NaN', false, NOW(), NOW()),
(12, 'D', 'undefined', false, NOW(), NOW()),

-- Q13: Quelle methode retourne un nouveau tableau filtre ? (medium)
(13, 'A', 'map()', false, NOW(), NOW()),
(13, 'B', 'forEach()', false, NOW(), NOW()),
(13, 'C', 'reduce()', false, NOW(), NOW()),
(13, 'D', 'filter()', true, NOW(), NOW()),

-- Q14: "this" dans une fonction flechee ? (medium)
(14, 'A', 'Il reference l''objet global window', false, NOW(), NOW()),
(14, 'B', 'Il est undefined', false, NOW(), NOW()),
(14, 'C', 'Il herite du contexte englobant (lexical this)', true, NOW(), NOW()),
(14, 'D', 'Il reference l''objet qui appelle la fonction', false, NOW(), NOW()),

-- Q15: console.log(1 + "2" + 3) ? (medium)
(15, 'A', '6', false, NOW(), NOW()),
(15, 'B', '"123"', true, NOW(), NOW()),
(15, 'C', '"33"', false, NOW(), NOW()),
(15, 'D', 'NaN', false, NOW(), NOW()),

-- Q16: Qu''est-ce qu''une closure ? (hard)
(16, 'A', 'Une fonction qui s''auto-execute immediatement', false, NOW(), NOW()),
(16, 'B', 'Une methode pour fermer une connexion reseau', false, NOW(), NOW()),
(16, 'C', 'Une fonction qui a acces aux variables de sa portee parente meme apres que celle-ci a termine son execution', true, NOW(), NOW()),
(16, 'D', 'Un bloc try-catch pour gerer les erreurs', false, NOW(), NOW()),

-- Q17: typeof NaN ? (hard)
(17, 'A', 'NaN', false, NOW(), NOW()),
(17, 'B', 'undefined', false, NOW(), NOW()),
(17, 'C', 'null', false, NOW(), NOW()),
(17, 'D', 'number', true, NOW(), NOW()),

-- Q18: Event loop ? (hard)
(18, 'A', 'Il execute tout le code de maniere parallele', false, NOW(), NOW()),
(18, 'B', 'Il gere la pile d''appels, la file de taches et les microtaches pour executer le code asynchrone', true, NOW(), NOW()),
(18, 'C', 'Il cree un nouveau thread pour chaque evenement', false, NOW(), NOW()),
(18, 'D', 'Il est specifique a Node.js et n''existe pas dans le navigateur', false, NOW(), NOW()),

-- Q19: Object.freeze() sur un objet imbrique ? (hard)
(19, 'A', 'Il gele l''objet et tous ses sous-objets recursivement', false, NOW(), NOW()),
(19, 'B', 'Il gele uniquement les proprietes de premier niveau (shallow freeze)', true, NOW(), NOW()),
(19, 'C', 'Il lance une erreur si l''objet contient des sous-objets', false, NOW(), NOW()),
(19, 'D', 'Il convertit l''objet en chaine JSON immutable', false, NOW(), NOW()),

-- Q20: Hoisting avec let et const ? (hard)
(20, 'A', 'let et const ne sont pas hoisted du tout', false, NOW(), NOW()),
(20, 'B', 'Ils sont hoistes mais dans une "temporal dead zone" jusqu''a leur declaration', true, NOW(), NOW()),
(20, 'C', 'Ils sont hoistes exactement comme var', false, NOW(), NOW()),
(20, 'D', 'Seul const est hoiste, pas let', false, NOW(), NOW()),

-- =============================================================================
-- Theme 2: HTML & CSS (Q21-Q40)
-- =============================================================================

-- Q21: Balise de navigation HTML5 ? (easy)
(21, 'A', '<navigation>', false, NOW(), NOW()),
(21, 'B', '<nav>', true, NOW(), NOW()),
(21, 'C', '<menu>', false, NOW(), NOW()),
(21, 'D', '<links>', false, NOW(), NOW()),

-- Q22: Propriete CSS pour la couleur du texte ? (easy)
(22, 'A', 'text-color', false, NOW(), NOW()),
(22, 'B', 'font-color', false, NOW(), NOW()),
(22, 'C', 'color', true, NOW(), NOW()),
(22, 'D', 'foreground', false, NOW(), NOW()),

-- Q23: Balise pour inserer une image ? (easy)
(23, 'A', '<image>', false, NOW(), NOW()),
(23, 'B', '<pic>', false, NOW(), NOW()),
(23, 'C', '<img>', true, NOW(), NOW()),
(23, 'D', '<figure>', false, NOW(), NOW()),

-- Q24: Rendre invisible en conservant l''espace ? (easy)
(24, 'A', 'display: none', false, NOW(), NOW()),
(24, 'B', 'visibility: hidden', true, NOW(), NOW()),
(24, 'C', 'opacity: 0', false, NOW(), NOW()),
(24, 'D', 'hidden: true', false, NOW(), NOW()),

-- Q25: Attribut pour un champ obligatoire ? (easy)
(25, 'A', 'mandatory', false, NOW(), NOW()),
(25, 'B', 'needed', false, NOW(), NOW()),
(25, 'C', 'obligatory', false, NOW(), NOW()),
(25, 'D', 'required', true, NOW(), NOW()),

-- Q26: Balise pour le contenu principal ? (easy)
(26, 'A', '<content>', false, NOW(), NOW()),
(26, 'B', '<main>', true, NOW(), NOW()),
(26, 'C', '<body>', false, NOW(), NOW()),
(26, 'D', '<primary>', false, NOW(), NOW()),

-- Q27: Unite relative a la taille de police du parent ? (easy)
(27, 'A', 'px', false, NOW(), NOW()),
(27, 'B', 'rem', false, NOW(), NOW()),
(27, 'C', 'em', true, NOW(), NOW()),
(27, 'D', 'vh', false, NOW(), NOW()),

-- Q28: Propriete Flexbox pour l''axe principal ? (medium)
(28, 'A', 'align-items', false, NOW(), NOW()),
(28, 'B', 'justify-content', true, NOW(), NOW()),
(28, 'C', 'flex-direction', false, NOW(), NOW()),
(28, 'D', 'align-content', false, NOW(), NOW()),

-- Q29: display: none vs visibility: hidden ? (medium)
(29, 'A', 'Aucune difference, ce sont des synonymes', false, NOW(), NOW()),
(29, 'B', 'display: none retire l''element du flux, visibility: hidden le cache en gardant l''espace', true, NOW(), NOW()),
(29, 'C', 'visibility: hidden retire l''element du flux, display: none le cache', false, NOW(), NOW()),
(29, 'D', 'display: none ne fonctionne que sur les blocs', false, NOW(), NOW()),

-- Q30: Propriete Grid pour les colonnes ? (medium)
(30, 'A', 'grid-columns', false, NOW(), NOW()),
(30, 'B', 'grid-template-rows', false, NOW(), NOW()),
(30, 'C', 'grid-template-columns', true, NOW(), NOW()),
(30, 'D', 'columns', false, NOW(), NOW()),

-- Q31: Selecteur pour le premier enfant ? (medium)
(31, 'A', ':first-element', false, NOW(), NOW()),
(31, 'B', ':first', false, NOW(), NOW()),
(31, 'C', ':first-child', true, NOW(), NOW()),
(31, 'D', ':nth-child(0)', false, NOW(), NOW()),

-- Q32: Specificite de #id .class element ? (medium)
(32, 'A', '1-0-0', false, NOW(), NOW()),
(32, 'B', '0-1-1', false, NOW(), NOW()),
(32, 'C', '1-1-1', true, NOW(), NOW()),
(32, 'D', '0-2-1', false, NOW(), NOW()),

-- Q33: Propriete pour les animations de transition ? (medium)
(33, 'A', 'animation', false, NOW(), NOW()),
(33, 'B', 'transition', true, NOW(), NOW()),
(33, 'C', 'transform', false, NOW(), NOW()),
(33, 'D', 'motion', false, NOW(), NOW()),

-- Q34: position: sticky ? (medium)
(34, 'A', 'L''element est fixe par rapport a la fenetre', false, NOW(), NOW()),
(34, 'B', 'L''element se comporte comme relative puis fixed quand on scroll au-dela de son seuil', true, NOW(), NOW()),
(34, 'C', 'L''element est retire du flux du document', false, NOW(), NOW()),
(34, 'D', 'L''element colle au bas de la page', false, NOW(), NOW()),

-- Q35: Balise HTML5 pour la video ? (medium)
(35, 'A', '<media>', false, NOW(), NOW()),
(35, 'B', '<movie>', false, NOW(), NOW()),
(35, 'C', '<video>', true, NOW(), NOW()),
(35, 'D', '<embed>', false, NOW(), NOW()),

-- Q36: Que signifie le "C" dans CSS ? (hard)
(36, 'A', 'Computer', false, NOW(), NOW()),
(36, 'B', 'Creative', false, NOW(), NOW()),
(36, 'C', 'Cascading', true, NOW(), NOW()),
(36, 'D', 'Coded', false, NOW(), NOW()),

-- Q37: Points de suspension pour debordement de texte ? (hard)
(37, 'A', 'text-truncate: ellipsis', false, NOW(), NOW()),
(37, 'B', 'text-overflow: ellipsis (avec overflow: hidden et white-space: nowrap)', true, NOW(), NOW()),
(37, 'C', 'overflow: ellipsis', false, NOW(), NOW()),
(37, 'D', 'word-break: ellipsis', false, NOW(), NOW()),

-- Q38: BEM en CSS ? (hard)
(38, 'A', 'Un framework CSS comme Bootstrap', false, NOW(), NOW()),
(38, 'B', 'Un preprocesseur CSS', false, NOW(), NOW()),
(38, 'C', 'Une methodologie de nommage : Block, Element, Modifier', true, NOW(), NOW()),
(38, 'D', 'Un outil de minification CSS', false, NOW(), NOW()),

-- Q39: Difference entre ::before et ::after ? (hard)
(39, 'A', '::before insere du contenu avant le contenu de l''element, ::after apres', true, NOW(), NOW()),
(39, 'B', '::before insere un element avant dans le DOM, ::after apres', false, NOW(), NOW()),
(39, 'C', 'Il n''y a aucune difference fonctionnelle', false, NOW(), NOW()),
(39, 'D', '::before est pour le texte, ::after pour les images', false, NOW(), NOW()),

-- Q40: Creer un stacking context ? (hard)
(40, 'A', 'Uniquement avec z-index', false, NOW(), NOW()),
(40, 'B', 'Avec position: relative ou absolute combinee a un z-index, ou opacity inferieure a 1, ou transform', true, NOW(), NOW()),
(40, 'C', 'Avec display: block uniquement', false, NOW(), NOW()),
(40, 'D', 'Un stacking context est cree automatiquement pour chaque element', false, NOW(), NOW()),

-- =============================================================================
-- Theme 3: Python (Q41-Q60)
-- =============================================================================

-- Q41: Mot-cle pour definir une fonction ? (easy)
(41, 'A', 'function', false, NOW(), NOW()),
(41, 'B', 'def', true, NOW(), NOW()),
(41, 'C', 'func', false, NOW(), NOW()),
(41, 'D', 'define', false, NOW(), NOW()),

-- Q42: Creer une liste vide ? (easy)
(42, 'A', 'list = {}', false, NOW(), NOW()),
(42, 'B', 'list = ()', false, NOW(), NOW()),
(42, 'C', 'list = []', true, NOW(), NOW()),
(42, 'D', 'list = new List()', false, NOW(), NOW()),

-- Q43: Afficher "Bonjour" ? (easy)
(43, 'A', 'echo("Bonjour")', false, NOW(), NOW()),
(43, 'B', 'console.log("Bonjour")', false, NOW(), NOW()),
(43, 'C', 'System.out.println("Bonjour")', false, NOW(), NOW()),
(43, 'D', 'print("Bonjour")', true, NOW(), NOW()),

-- Q44: Type de True et False ? (easy)
(44, 'A', 'int', false, NOW(), NOW()),
(44, 'B', 'string', false, NOW(), NOW()),
(44, 'C', 'bool', true, NOW(), NOW()),
(44, 'D', 'binary', false, NOW(), NOW()),

-- Q45: Ajouter un element a la fin d''une liste ? (easy)
(45, 'A', 'add()', false, NOW(), NOW()),
(45, 'B', 'push()', false, NOW(), NOW()),
(45, 'C', 'append()', true, NOW(), NOW()),
(45, 'D', 'insert()', false, NOW(), NOW()),

-- Q46: Commentaire sur une ligne ? (easy)
(46, 'A', '// commentaire', false, NOW(), NOW()),
(46, 'B', '/* commentaire */', false, NOW(), NOW()),
(46, 'C', '# commentaire', true, NOW(), NOW()),
(46, 'D', '-- commentaire', false, NOW(), NOW()),

-- Q47: Operateur de division entiere ? (easy)
(47, 'A', '/', false, NOW(), NOW()),
(47, 'B', '%', false, NOW(), NOW()),
(47, 'C', '//', true, NOW(), NOW()),
(47, 'D', 'div', false, NOW(), NOW()),

-- Q48: len("Python") ? (medium)
(48, 'A', '5', false, NOW(), NOW()),
(48, 'B', '6', true, NOW(), NOW()),
(48, 'C', '7', false, NOW(), NOW()),
(48, 'D', 'Erreur', false, NOW(), NOW()),

-- Q49: Difference entre liste et tuple ? (medium)
(49, 'A', 'Les listes sont immutables, les tuples sont mutables', false, NOW(), NOW()),
(49, 'B', 'Les tuples sont immutables, les listes sont mutables', true, NOW(), NOW()),
(49, 'C', 'Il n''y a aucune difference', false, NOW(), NOW()),
(49, 'D', 'Les tuples ne peuvent contenir que des nombres', false, NOW(), NOW()),

-- Q50: Que fait yield ? (medium)
(50, 'A', 'Arrete definitivement la fonction', false, NOW(), NOW()),
(50, 'B', 'Retourne une valeur et met la fonction en pause, creant un generateur', true, NOW(), NOW()),
(50, 'C', 'Fait la meme chose que return', false, NOW(), NOW()),
(50, 'D', 'Leve une exception', false, NOW(), NOW()),

-- Q51: Structure avec paires cle-valeur ? (medium)
(51, 'A', 'Liste', false, NOW(), NOW()),
(51, 'B', 'Tuple', false, NOW(), NOW()),
(51, 'C', 'Set', false, NOW(), NOW()),
(51, 'D', 'Dictionnaire', true, NOW(), NOW()),

-- Q52: Ouvrir un fichier en lecture ? (medium)
(52, 'A', 'open("fichier.txt", "w")', false, NOW(), NOW()),
(52, 'B', 'open("fichier.txt", "r")', true, NOW(), NOW()),
(52, 'C', 'read("fichier.txt")', false, NOW(), NOW()),
(52, 'D', 'file.open("fichier.txt")', false, NOW(), NOW()),

-- Q53: [x**2 for x in range(5)] ? (medium)
(53, 'A', '[0, 1, 4, 9, 16]', true, NOW(), NOW()),
(53, 'B', '[1, 4, 9, 16, 25]', false, NOW(), NOW()),
(53, 'C', '[0, 2, 4, 6, 8]', false, NOW(), NOW()),
(53, 'D', '[1, 2, 3, 4, 5]', false, NOW(), NOW()),

-- Q54: Module pour les expressions regulieres ? (medium)
(54, 'A', 'regex', false, NOW(), NOW()),
(54, 'B', 'regexp', false, NOW(), NOW()),
(54, 'C', 're', true, NOW(), NOW()),
(54, 'D', 'pattern', false, NOW(), NOW()),

-- Q55: print(type({})) ? (medium)
(55, 'A', '<class ''list''>', false, NOW(), NOW()),
(55, 'B', '<class ''set''>', false, NOW(), NOW()),
(55, 'C', '<class ''tuple''>', false, NOW(), NOW()),
(55, 'D', '<class ''dict''>', true, NOW(), NOW()),

-- Q56: Qu''est-ce qu''un decorateur ? (hard)
(56, 'A', 'Un commentaire special pour documenter le code', false, NOW(), NOW()),
(56, 'B', 'Une fonction qui modifie le comportement d''une autre fonction sans changer son code', true, NOW(), NOW()),
(56, 'C', 'Un design pattern specifique a Django', false, NOW(), NOW()),
(56, 'D', 'Un outil de formatage de code', false, NOW(), NOW()),

-- Q57: __init__ dans une classe ? (hard)
(57, 'A', 'Il detruit l''instance de la classe', false, NOW(), NOW()),
(57, 'B', 'Il declare les methodes statiques', false, NOW(), NOW()),
(57, 'C', 'C''est le constructeur qui initialise les attributs de l''instance', true, NOW(), NOW()),
(57, 'D', 'Il importe les modules necessaires', false, NOW(), NOW()),

-- Q58: deepcopy vs copy ? (hard)
(58, 'A', 'copy cree une copie superficielle, deepcopy copie recursivement tous les objets imbriques', true, NOW(), NOW()),
(58, 'B', 'Il n''y a aucune difference', false, NOW(), NOW()),
(58, 'C', 'deepcopy est plus rapide que copy', false, NOW(), NOW()),
(58, 'D', 'copy fonctionne uniquement sur les listes', false, NOW(), NOW()),

-- Q59: GIL en Python ? (hard)
(59, 'A', 'Un outil de gestion des packages Python', false, NOW(), NOW()),
(59, 'B', 'Un verrou qui empeche l''execution simultanee de plusieurs threads Python natifs', true, NOW(), NOW()),
(59, 'C', 'Un module de securite pour le reseau', false, NOW(), NOW()),
(59, 'D', 'Un systeme de gestion de la memoire graphique', false, NOW(), NOW()),

-- Q60: Garbage collector en Python ? (hard)
(60, 'A', 'Il supprime les fichiers temporaires du systeme', false, NOW(), NOW()),
(60, 'B', 'Il nettoie le code source des commentaires inutiles', false, NOW(), NOW()),
(60, 'C', 'Il utilise le comptage de references et un detecteur de cycles pour liberer la memoire inutilisee', true, NOW(), NOW()),
(60, 'D', 'Il optimise le bytecode Python avant execution', false, NOW(), NOW()),

-- =============================================================================
-- Theme 4: SQL & Bases de donnees (Q61-Q80)
-- =============================================================================

-- Q61: Commande pour recuperer des donnees ? (easy)
(61, 'A', 'GET', false, NOW(), NOW()),
(61, 'B', 'FETCH', false, NOW(), NOW()),
(61, 'C', 'SELECT', true, NOW(), NOW()),
(61, 'D', 'RETRIEVE', false, NOW(), NOW()),

-- Q62: Mot-cle pour filtrer ? (easy)
(62, 'A', 'FILTER', false, NOW(), NOW()),
(62, 'B', 'WHERE', true, NOW(), NOW()),
(62, 'C', 'HAVING', false, NOW(), NOW()),
(62, 'D', 'WHEN', false, NOW(), NOW()),

-- Q63: Supprimer des lignes ? (easy)
(63, 'A', 'REMOVE', false, NOW(), NOW()),
(63, 'B', 'DROP', false, NOW(), NOW()),
(63, 'C', 'DELETE', true, NOW(), NOW()),
(63, 'D', 'ERASE', false, NOW(), NOW()),

-- Q64: Trier les resultats ? (easy)
(64, 'A', 'SORT BY', false, NOW(), NOW()),
(64, 'B', 'GROUP BY', false, NOW(), NOW()),
(64, 'C', 'ARRANGE BY', false, NOW(), NOW()),
(64, 'D', 'ORDER BY', true, NOW(), NOW()),

-- Q65: Inserer des donnees ? (easy)
(65, 'A', 'ADD INTO', false, NOW(), NOW()),
(65, 'B', 'INSERT INTO', true, NOW(), NOW()),
(65, 'C', 'PUT INTO', false, NOW(), NOW()),
(65, 'D', 'CREATE INTO', false, NOW(), NOW()),

-- Q66: Contrainte NOT NULL ? (easy)
(66, 'A', 'UNIQUE', false, NOW(), NOW()),
(66, 'B', 'PRIMARY KEY', false, NOW(), NOW()),
(66, 'C', 'NOT NULL', true, NOW(), NOW()),
(66, 'D', 'CHECK', false, NOW(), NOW()),

-- Q67: Limiter le nombre de resultats ? (easy)
(67, 'A', 'TOP', false, NOW(), NOW()),
(67, 'B', 'LIMIT', true, NOW(), NOW()),
(67, 'C', 'MAX', false, NOW(), NOW()),
(67, 'D', 'FIRST', false, NOW(), NOW()),

-- Q68: INNER JOIN vs LEFT JOIN ? (medium)
(68, 'A', 'INNER JOIN retourne toutes les lignes, LEFT JOIN seulement les correspondances', false, NOW(), NOW()),
(68, 'B', 'Il n''y a aucune difference', false, NOW(), NOW()),
(68, 'C', 'INNER JOIN retourne les correspondances, LEFT JOIN retourne tout de la table gauche avec NULL si pas de correspondance', true, NOW(), NOW()),
(68, 'D', 'LEFT JOIN est plus rapide que INNER JOIN', false, NOW(), NOW()),

-- Q69: GROUP BY ? (medium)
(69, 'A', 'Trie les resultats par ordre alphabetique', false, NOW(), NOW()),
(69, 'B', 'Regroupe les lignes ayant les memes valeurs pour appliquer des fonctions d''agregation', true, NOW(), NOW()),
(69, 'C', 'Filtre les resultats selon une condition', false, NOW(), NOW()),
(69, 'D', 'Joint deux tables ensemble', false, NOW(), NOW()),

-- Q70: WHERE vs HAVING ? (medium)
(70, 'A', 'WHERE filtre avant le GROUP BY, HAVING filtre apres le GROUP BY', true, NOW(), NOW()),
(70, 'B', 'WHERE est pour les nombres, HAVING est pour le texte', false, NOW(), NOW()),
(70, 'C', 'HAVING est plus rapide que WHERE', false, NOW(), NOW()),
(70, 'D', 'Il n''y a aucune difference', false, NOW(), NOW()),

-- Q71: Qu''est-ce qu''un index ? (medium)
(71, 'A', 'Une copie de sauvegarde de la table', false, NOW(), NOW()),
(71, 'B', 'Une structure de donnees qui accelere la recherche dans une table', true, NOW(), NOW()),
(71, 'C', 'Une contrainte d''integrite referentielle', false, NOW(), NOW()),
(71, 'D', 'Un synonyme pour cle primaire', false, NOW(), NOW()),

-- Q72: Fonction d''agregation pour le nombre de lignes ? (medium)
(72, 'A', 'SUM()', false, NOW(), NOW()),
(72, 'B', 'TOTAL()', false, NOW(), NOW()),
(72, 'C', 'COUNT()', true, NOW(), NOW()),
(72, 'D', 'NUM()', false, NOW(), NOW()),

-- Q73: UNION vs UNION ALL ? (medium)
(73, 'A', 'UNION supprime les doublons, UNION ALL les conserve', true, NOW(), NOW()),
(73, 'B', 'UNION ALL supprime les doublons, UNION les conserve', false, NOW(), NOW()),
(73, 'C', 'UNION combine les colonnes, UNION ALL combine les lignes', false, NOW(), NOW()),
(73, 'D', 'Il n''y a aucune difference', false, NOW(), NOW()),

-- Q74: ACID ? (medium)
(74, 'A', 'Access, Control, Integrity, Database', false, NOW(), NOW()),
(74, 'B', 'Atomicity, Consistency, Isolation, Durability', true, NOW(), NOW()),
(74, 'C', 'Automatic, Cached, Indexed, Distributed', false, NOW(), NOW()),
(74, 'D', 'Aggregate, Count, Insert, Delete', false, NOW(), NOW()),

-- Q75: Cle etrangere ? (medium)
(75, 'A', 'Une colonne qui identifie de maniere unique chaque ligne', false, NOW(), NOW()),
(75, 'B', 'Une contrainte qui reference la cle primaire d''une autre table', true, NOW(), NOW()),
(75, 'C', 'Un index cree automatiquement', false, NOW(), NOW()),
(75, 'D', 'Une colonne qui accepte uniquement des valeurs NULL', false, NOW(), NOW()),

-- Q76: 3NF ? (hard)
(76, 'A', 'Chaque table doit avoir exactement 3 colonnes', false, NOW(), NOW()),
(76, 'B', 'Les donnees doivent etre stockees dans 3 tables maximum', false, NOW(), NOW()),
(76, 'C', 'Aucun attribut non-cle ne depend transitivement de la cle primaire', true, NOW(), NOW()),
(76, 'D', 'Chaque requete doit etre executee en 3 etapes maximum', false, NOW(), NOW()),

-- Q77: Vue vs table materialisee ? (hard)
(77, 'A', 'Une vue stocke les donnees physiquement, une table materialisee est virtuelle', false, NOW(), NOW()),
(77, 'B', 'Une vue est une requete virtuelle executee a chaque appel, une table materialisee stocke le resultat physiquement', true, NOW(), NOW()),
(77, 'C', 'Il n''y a aucune difference de performance', false, NOW(), NOW()),
(77, 'D', 'Une table materialisee ne peut pas etre mise a jour', false, NOW(), NOW()),

-- Q78: Deadlock ? (hard)
(78, 'A', 'Une erreur de syntaxe dans une requete SQL', false, NOW(), NOW()),
(78, 'B', 'Une situation ou deux transactions s''attendent mutuellement, bloquant indefiniment', true, NOW(), NOW()),
(78, 'C', 'Une table qui a atteint sa capacite maximale', false, NOW(), NOW()),
(78, 'D', 'Un verrou permanent sur une base de donnees', false, NOW(), NOW()),

-- Q79: CTE ? (hard)
(79, 'A', 'Elle cree une table temporaire permanente', false, NOW(), NOW()),
(79, 'B', 'Elle chiffre les donnees de la requete', false, NOW(), NOW()),
(79, 'C', 'Elle definit un resultat temporaire nomme utilisable dans une requete, avec le mot-cle WITH', true, NOW(), NOW()),
(79, 'D', 'Elle convertit les types de donnees automatiquement', false, NOW(), NOW()),

-- Q80: Index B-Tree vs Hash ? (hard)
(80, 'A', 'B-Tree est ideal pour les recherches par plage, Hash est optimal pour les egalites exactes', true, NOW(), NOW()),
(80, 'B', 'Hash est meilleur pour les plages, B-Tree pour les egalites', false, NOW(), NOW()),
(80, 'C', 'Il n''y a aucune difference de performance', false, NOW(), NOW()),
(80, 'D', 'B-Tree est obsolete, Hash est le standard moderne', false, NOW(), NOW()),

-- =============================================================================
-- Theme 5: Git & Versioning (Q81-Q100)
-- =============================================================================

-- Q81: Cloner un depot ? (easy)
(81, 'A', 'git copy', false, NOW(), NOW()),
(81, 'B', 'git clone', true, NOW(), NOW()),
(81, 'C', 'git download', false, NOW(), NOW()),
(81, 'D', 'git pull', false, NOW(), NOW()),

-- Q82: Etat du depot ? (easy)
(82, 'A', 'git info', false, NOW(), NOW()),
(82, 'B', 'git check', false, NOW(), NOW()),
(82, 'C', 'git status', true, NOW(), NOW()),
(82, 'D', 'git state', false, NOW(), NOW()),

-- Q83: Ajouter a la zone de staging ? (easy)
(83, 'A', 'git stage', false, NOW(), NOW()),
(83, 'B', 'git commit', false, NOW(), NOW()),
(83, 'C', 'git add', true, NOW(), NOW()),
(83, 'D', 'git push', false, NOW(), NOW()),

-- Q84: Creer un commit ? (easy)
(84, 'A', 'git save -m "message"', false, NOW(), NOW()),
(84, 'B', 'git commit -m "message"', true, NOW(), NOW()),
(84, 'C', 'git push -m "message"', false, NOW(), NOW()),
(84, 'D', 'git snapshot -m "message"', false, NOW(), NOW()),

-- Q85: Creer une nouvelle branche ? (easy)
(85, 'A', 'git new-branch nom', false, NOW(), NOW()),
(85, 'B', 'git create nom', false, NOW(), NOW()),
(85, 'C', 'git branch nom', true, NOW(), NOW()),
(85, 'D', 'git fork nom', false, NOW(), NOW()),

-- Q86: Voir l''historique des commits ? (easy)
(86, 'A', 'git history', false, NOW(), NOW()),
(86, 'B', 'git log', true, NOW(), NOW()),
(86, 'C', 'git commits', false, NOW(), NOW()),
(86, 'D', 'git show-all', false, NOW(), NOW()),

-- Q87: Envoyer les commits vers le distant ? (easy)
(87, 'A', 'git send', false, NOW(), NOW()),
(87, 'B', 'git upload', false, NOW(), NOW()),
(87, 'C', 'git commit --remote', false, NOW(), NOW()),
(87, 'D', 'git push', true, NOW(), NOW()),

-- Q88: git merge vs git rebase ? (medium)
(88, 'A', 'merge cree un commit de fusion, rebase reapplique les commits sur une autre base pour un historique lineaire', true, NOW(), NOW()),
(88, 'B', 'rebase est la meme chose que merge mais plus rapide', false, NOW(), NOW()),
(88, 'C', 'merge supprime l''historique, rebase le conserve', false, NOW(), NOW()),
(88, 'D', 'rebase est uniquement pour les branches distantes', false, NOW(), NOW()),

-- Q89: git stash ? (medium)
(89, 'A', 'Supprime definitivement les modifications non commitees', false, NOW(), NOW()),
(89, 'B', 'Met de cote les modifications en cours pour les restaurer plus tard', true, NOW(), NOW()),
(89, 'C', 'Cree un nouveau commit avec les modifications', false, NOW(), NOW()),
(89, 'D', 'Envoie les modifications sur le depot distant', false, NOW(), NOW()),

-- Q90: Annuler le dernier commit en gardant les modifications ? (medium)
(90, 'A', 'git revert HEAD', false, NOW(), NOW()),
(90, 'B', 'git undo', false, NOW(), NOW()),
(90, 'C', 'git reset --soft HEAD~1', true, NOW(), NOW()),
(90, 'D', 'git delete HEAD', false, NOW(), NOW()),

-- Q91: git fetch ? (medium)
(91, 'A', 'Telecharge les modifications distantes sans les fusionner', true, NOW(), NOW()),
(91, 'B', 'Telecharge et fusionne automatiquement les modifications', false, NOW(), NOW()),
(91, 'C', 'Envoie les commits locaux vers le distant', false, NOW(), NOW()),
(91, 'D', 'Supprime les branches distantes obsoletes', false, NOW(), NOW()),

-- Q92: Conflit de merge ? (medium)
(92, 'A', 'Une erreur dans la syntaxe de la commande git merge', false, NOW(), NOW()),
(92, 'B', 'Quand Git ne peut pas fusionner automatiquement car les memes lignes ont ete modifiees dans les deux branches', true, NOW(), NOW()),
(92, 'C', 'Quand deux personnes travaillent sur le meme depot', false, NOW(), NOW()),
(92, 'D', 'Quand une branche a ete supprimee', false, NOW(), NOW()),

-- Q93: Voir les differences entre deux commits ? (medium)
(93, 'A', 'git compare', false, NOW(), NOW()),
(93, 'B', 'git diff commit1 commit2', true, NOW(), NOW()),
(93, 'C', 'git show commit1 commit2', false, NOW(), NOW()),
(93, 'D', 'git changes commit1..commit2', false, NOW(), NOW()),

-- Q94: Contenu du .gitignore ? (medium)
(94, 'A', 'La liste des contributeurs du projet', false, NOW(), NOW()),
(94, 'B', 'Les commandes Git a desactiver', false, NOW(), NOW()),
(94, 'C', 'Les patterns de fichiers et dossiers que Git doit ignorer', true, NOW(), NOW()),
(94, 'D', 'Les configurations du depot distant', false, NOW(), NOW()),

-- Q95: Changer de branche ? (medium)
(95, 'A', 'git switch nom-branche ou git checkout nom-branche', true, NOW(), NOW()),
(95, 'B', 'git change nom-branche', false, NOW(), NOW()),
(95, 'C', 'git move nom-branche', false, NOW(), NOW()),
(95, 'D', 'git go nom-branche', false, NOW(), NOW()),

-- Q96: git cherry-pick ? (hard)
(96, 'A', 'Supprime un commit specifique de l''historique', false, NOW(), NOW()),
(96, 'B', 'Applique les modifications d''un commit specifique sur la branche courante', true, NOW(), NOW()),
(96, 'C', 'Selectionne la meilleure branche pour le merge', false, NOW(), NOW()),
(96, 'D', 'Trie les commits par date', false, NOW(), NOW()),

-- Q97: git reset --soft, --mixed, --hard ? (hard)
(97, 'A', '--soft garde le staging et les fichiers, --mixed unstage mais garde les fichiers, --hard supprime tout', true, NOW(), NOW()),
(97, 'B', 'Les trois font exactement la meme chose', false, NOW(), NOW()),
(97, 'C', '--hard est le plus sur, --soft est le plus dangereux', false, NOW(), NOW()),
(97, 'D', '--soft supprime tout, --hard garde les fichiers', false, NOW(), NOW()),

-- Q98: git reflog ? (hard)
(98, 'A', 'Affiche les logs du serveur distant', false, NOW(), NOW()),
(98, 'B', 'Affiche l''historique de toutes les references HEAD, permettant de recuperer des commits "perdus"', true, NOW(), NOW()),
(98, 'C', 'Reformate les messages de commit', false, NOW(), NOW()),
(98, 'D', 'Cree un fichier de log pour le debugging', false, NOW(), NOW()),

-- Q99: git bisect ? (hard)
(99, 'A', 'Divise un gros commit en plusieurs petits commits', false, NOW(), NOW()),
(99, 'B', 'Effectue une recherche binaire dans l''historique pour trouver le commit qui a introduit un bug', true, NOW(), NOW()),
(99, 'C', 'Fusionne deux branches en divisant les conflits', false, NOW(), NOW()),
(99, 'D', 'Separe un depot en deux depots distincts', false, NOW(), NOW()),

-- Q100: Modele blob, tree, commit ? (hard)
(100, 'A', 'Ce sont des types de branches Git', false, NOW(), NOW()),
(100, 'B', 'blob stocke le contenu des fichiers, tree represente les dossiers, commit pointe vers un tree avec des metadonnees', true, NOW(), NOW()),
(100, 'C', 'Ce sont les trois etapes du staging', false, NOW(), NOW()),
(100, 'D', 'Ce sont des commandes Git avancees', false, NOW(), NOW()),

-- =============================================================================
-- Theme 6: React (Q101-Q120)
-- =============================================================================

-- Q101: Hook pour l''etat local ? (easy)
(101, 'A', 'useEffect', false, NOW(), NOW()),
(101, 'B', 'useState', true, NOW(), NOW()),
(101, 'C', 'useContext', false, NOW(), NOW()),
(101, 'D', 'useRef', false, NOW(), NOW()),

-- Q102: Composant fonctionnel ? (easy)
(102, 'A', 'class MyComponent extends React.Component {}', false, NOW(), NOW()),
(102, 'B', 'React.createComponent("MyComponent")', false, NOW(), NOW()),
(102, 'C', 'function MyComponent() { return <div /> }', true, NOW(), NOW()),
(102, 'D', 'new Component("MyComponent")', false, NOW(), NOW()),

-- Q103: Que sont les props ? (easy)
(103, 'A', 'Des variables globales de l''application', false, NOW(), NOW()),
(103, 'B', 'Des proprietes passees d''un composant parent a un composant enfant', true, NOW(), NOW()),
(103, 'C', 'Des styles CSS specifiques a React', false, NOW(), NOW()),
(103, 'D', 'Des evenements du navigateur', false, NOW(), NOW()),

-- Q104: Role de render() ? (easy)
(104, 'A', 'Supprimer le composant du DOM', false, NOW(), NOW()),
(104, 'B', 'Initialiser l''etat du composant', false, NOW(), NOW()),
(104, 'C', 'Retourner les elements JSX a afficher dans le DOM', true, NOW(), NOW()),
(104, 'D', 'Envoyer des requetes HTTP', false, NOW(), NOW()),

-- Q105: Syntaxe HTML dans JS ? (easy)
(105, 'A', 'HTML-in-JS', false, NOW(), NOW()),
(105, 'B', 'XML', false, NOW(), NOW()),
(105, 'C', 'JSX', true, NOW(), NOW()),
(105, 'D', 'Template Literals', false, NOW(), NOW()),

-- Q106: Affichage conditionnel ? (easy)
(106, 'A', 'Avec une directive v-if', false, NOW(), NOW()),
(106, 'B', 'Avec l''operateur ternaire ou le && en JSX', true, NOW(), NOW()),
(106, 'C', 'Avec un attribut HTML hidden', false, NOW(), NOW()),
(106, 'D', 'Ce n''est pas possible en React', false, NOW(), NOW()),

-- Q107: Prop key dans une liste ? (easy)
(107, 'A', 'Ajouter du style a chaque element', false, NOW(), NOW()),
(107, 'B', 'Definir l''ordre d''affichage', false, NOW(), NOW()),
(107, 'C', 'Aider React a identifier les elements qui ont change pour optimiser le rendu', true, NOW(), NOW()),
(107, 'D', 'Definir un raccourci clavier', false, NOW(), NOW()),

-- Q108: Hook pour les effets de bord ? (medium)
(108, 'A', 'useState', false, NOW(), NOW()),
(108, 'B', 'useMemo', false, NOW(), NOW()),
(108, 'C', 'useEffect', true, NOW(), NOW()),
(108, 'D', 'useCallback', false, NOW(), NOW()),

-- Q109: React.memo() ? (medium)
(109, 'A', 'Stocke des donnees en memoire persistante', false, NOW(), NOW()),
(109, 'B', 'Memorise un composant et evite son re-rendu si les props n''ont pas change', true, NOW(), NOW()),
(109, 'C', 'Cree un memo ou une note dans le code', false, NOW(), NOW()),
(109, 'D', 'Optimise le chargement des images', false, NOW(), NOW()),

-- Q110: Controle vs non controle ? (medium)
(110, 'A', 'Controle signifie que le composant est teste, non controle signifie qu''il ne l''est pas', false, NOW(), NOW()),
(110, 'B', 'Un composant controle a sa valeur geree par React via state, un non controle gere sa propre valeur via le DOM', true, NOW(), NOW()),
(110, 'C', 'Un composant controle est en production, un non controle est en developpement', false, NOW(), NOW()),
(110, 'D', 'Il n''y a pas de difference en React', false, NOW(), NOW()),

-- Q111: useContext ? (medium)
(111, 'A', 'Gerer l''etat local d''un composant', false, NOW(), NOW()),
(111, 'B', 'Acceder a des donnees partagees sans passer par les props a chaque niveau', true, NOW(), NOW()),
(111, 'C', 'Creer des effets de bord', false, NOW(), NOW()),
(111, 'D', 'Gerer les references DOM', false, NOW(), NOW()),

-- Q112: useRef ? (medium)
(112, 'A', 'Creer une reference mutable qui persiste entre les rendus sans provoquer de re-rendu', true, NOW(), NOW()),
(112, 'B', 'Gerer l''etat du composant', false, NOW(), NOW()),
(112, 'C', 'Effectuer des requetes API', false, NOW(), NOW()),
(112, 'D', 'Definir le style d''un composant', false, NOW(), NOW()),

-- Q113: Virtual DOM ? (medium)
(113, 'A', 'Le DOM reel du navigateur', false, NOW(), NOW()),
(113, 'B', 'Un framework CSS', false, NOW(), NOW()),
(113, 'C', 'Une representation en memoire du DOM reel que React utilise pour optimiser les mises a jour', true, NOW(), NOW()),
(113, 'D', 'Un outil de debugging du navigateur', false, NOW(), NOW()),

-- Q114: Passer des donnees enfant vers parent ? (medium)
(114, 'A', 'En utilisant des variables globales', false, NOW(), NOW()),
(114, 'B', 'En passant une fonction callback du parent via les props', true, NOW(), NOW()),
(114, 'C', 'En utilisant le mot-cle super', false, NOW(), NOW()),
(114, 'D', 'C''est impossible en React', false, NOW(), NOW()),

-- Q115: Cycle de vie equivalent hooks ? (medium)
(115, 'A', 'useEffect sans dependances = componentDidMount + componentDidUpdate, avec [] = componentDidMount, avec cleanup = componentWillUnmount', true, NOW(), NOW()),
(115, 'B', 'useState remplace tout le cycle de vie', false, NOW(), NOW()),
(115, 'C', 'Les hooks n''ont pas d''equivalent au cycle de vie', false, NOW(), NOW()),
(115, 'D', 'useRef gere le cycle de vie', false, NOW(), NOW()),

-- Q116: useReducer ? (hard)
(116, 'A', 'Reduire la taille des composants', false, NOW(), NOW()),
(116, 'B', 'Gerer un etat complexe avec des actions et un reducer, alternative a useState pour la logique avancee', true, NOW(), NOW()),
(116, 'C', 'Optimiser les performances de rendu', false, NOW(), NOW()),
(116, 'D', 'Reduire le nombre de re-rendus', false, NOW(), NOW()),

-- Q117: Render props ? (hard)
(117, 'A', 'Les proprietes CSS de rendu du composant', false, NOW(), NOW()),
(117, 'B', 'Un pattern ou un composant recoit une fonction en prop qui retourne du JSX pour partager la logique', true, NOW(), NOW()),
(117, 'C', 'La methode render() des composants classe', false, NOW(), NOW()),
(117, 'D', 'Les props par defaut d''un composant', false, NOW(), NOW()),

-- Q118: Reconciliation React ? (hard)
(118, 'A', 'Le processus de fusion de deux branches Git dans un projet React', false, NOW(), NOW()),
(118, 'B', 'L''algorithme qui compare le Virtual DOM precedent avec le nouveau pour appliquer les changements minimaux au DOM reel', true, NOW(), NOW()),
(118, 'C', 'Le processus de resolution des conflits entre les props et le state', false, NOW(), NOW()),
(118, 'D', 'La synchronisation entre le serveur et le client', false, NOW(), NOW()),

-- Q119: React.lazy() et Suspense ? (hard)
(119, 'A', 'Un systeme de gestion d''erreurs en React', false, NOW(), NOW()),
(119, 'B', 'Un outil pour tester les composants lents', false, NOW(), NOW()),
(119, 'C', 'React.lazy charge un composant de maniere differee, Suspense affiche un fallback pendant le chargement', true, NOW(), NOW()),
(119, 'D', 'Un pattern pour gerer les animations', false, NOW(), NOW()),

-- Q120: useMemo vs useCallback ? (hard)
(120, 'A', 'useMemo memorise une valeur calculee, useCallback memorise une fonction', true, NOW(), NOW()),
(120, 'B', 'useMemo est pour les composants classe, useCallback pour les fonctionnels', false, NOW(), NOW()),
(120, 'C', 'Ils font exactement la meme chose', false, NOW(), NOW()),
(120, 'D', 'useMemo memorise une fonction, useCallback memorise une valeur', false, NOW(), NOW()),

-- =============================================================================
-- Theme 7: DevOps & Infra (Q121-Q140)
-- =============================================================================

-- Q121: CI/CD ? (easy)
(121, 'A', 'Code Integration / Code Delivery', false, NOW(), NOW()),
(121, 'B', 'Continuous Integration / Continuous Delivery (ou Deployment)', true, NOW(), NOW()),
(121, 'C', 'Computer Interface / Computer Design', false, NOW(), NOW()),
(121, 'D', 'Central Intelligence / Central Database', false, NOW(), NOW()),

-- Q122: Lister les conteneurs Docker en cours ? (easy)
(122, 'A', 'docker list', false, NOW(), NOW()),
(122, 'B', 'docker show', false, NOW(), NOW()),
(122, 'C', 'docker ps', true, NOW(), NOW()),
(122, 'D', 'docker containers', false, NOW(), NOW()),

-- Q123: Fichier Docker Compose ? (easy)
(123, 'A', 'Dockerfile', false, NOW(), NOW()),
(123, 'B', 'docker-compose.yml (ou compose.yml)', true, NOW(), NOW()),
(123, 'C', 'docker.config', false, NOW(), NOW()),
(123, 'D', 'compose.json', false, NOW(), NOW()),

-- Q124: Voir les processus Linux ? (easy)
(124, 'A', 'ls -la', false, NOW(), NOW()),
(124, 'B', 'top ou ps', true, NOW(), NOW()),
(124, 'C', 'cat /proc', false, NOW(), NOW()),
(124, 'D', 'df -h', false, NOW(), NOW()),

-- Q125: Port HTTP par defaut ? (easy)
(125, 'A', '443', false, NOW(), NOW()),
(125, 'B', '8080', false, NOW(), NOW()),
(125, 'C', '80', true, NOW(), NOW()),
(125, 'D', '3000', false, NOW(), NOW()),

-- Q126: Changer les permissions ? (easy)
(126, 'A', 'chown', false, NOW(), NOW()),
(126, 'B', 'chmod', true, NOW(), NOW()),
(126, 'C', 'chperm', false, NOW(), NOW()),
(126, 'D', 'setperm', false, NOW(), NOW()),

-- Q127: docker build ? (easy)
(127, 'A', 'Lance un conteneur existant', false, NOW(), NOW()),
(127, 'B', 'Construit une image Docker a partir d''un Dockerfile', true, NOW(), NOW()),
(127, 'C', 'Met a jour Docker vers la derniere version', false, NOW(), NOW()),
(127, 'D', 'Compile le code source de l''application', false, NOW(), NOW()),

-- Q128: Image vs conteneur Docker ? (medium)
(128, 'A', 'Il n''y a aucune difference', false, NOW(), NOW()),
(128, 'B', 'Une image est un modele en lecture seule, un conteneur est une instance en cours d''execution de cette image', true, NOW(), NOW()),
(128, 'C', 'Un conteneur est le fichier Dockerfile, une image est le resultat', false, NOW(), NOW()),
(128, 'D', 'Une image est toujours plus grande qu''un conteneur', false, NOW(), NOW()),

-- Q129: Reverse proxy Nginx ? (medium)
(129, 'A', 'Il bloque tout le trafic entrant', false, NOW(), NOW()),
(129, 'B', 'Il recoit les requetes clients et les redistribue vers les serveurs backend', true, NOW(), NOW()),
(129, 'C', 'Il sert uniquement des fichiers statiques', false, NOW(), NOW()),
(129, 'D', 'Il remplace le serveur DNS', false, NOW(), NOW()),

-- Q130: Volume Docker ? (medium)
(130, 'A', 'Le niveau sonore des logs Docker', false, NOW(), NOW()),
(130, 'B', 'La taille maximale d''un conteneur', false, NOW(), NOW()),
(130, 'C', 'Un mecanisme de stockage persistant pour les donnees des conteneurs', true, NOW(), NOW()),
(130, 'D', 'Le nombre de conteneurs pouvant tourner simultanement', false, NOW(), NOW()),

-- Q131: TCP vs UDP ? (medium)
(131, 'A', 'TCP est sans connexion, UDP est oriente connexion', false, NOW(), NOW()),
(131, 'B', 'TCP garantit la livraison ordonnee des paquets, UDP est plus rapide mais sans garantie', true, NOW(), NOW()),
(131, 'C', 'UDP est plus fiable que TCP', false, NOW(), NOW()),
(131, 'D', 'TCP est uniquement pour le web, UDP pour les emails', false, NOW(), NOW()),

-- Q132: grep sous Linux ? (medium)
(132, 'A', 'Compresse des fichiers', false, NOW(), NOW()),
(132, 'B', 'Recherche des motifs (patterns) dans des fichiers texte', true, NOW(), NOW()),
(132, 'C', 'Deplace des fichiers entre dossiers', false, NOW(), NOW()),
(132, 'D', 'Affiche l''espace disque disponible', false, NOW(), NOW()),

-- Q133: Pipeline CI/CD ? (medium)
(133, 'A', 'Un outil pour gerer les versions de Node.js', false, NOW(), NOW()),
(133, 'B', 'Une serie d''etapes automatisees (build, test, deploy) declenchees par un changement de code', true, NOW(), NOW()),
(133, 'C', 'Un type de connexion reseau', false, NOW(), NOW()),
(133, 'D', 'Un gestionnaire de paquets', false, NOW(), NOW()),

-- Q134: Logs d''un conteneur Docker ? (medium)
(134, 'A', 'docker output <container>', false, NOW(), NOW()),
(134, 'B', 'docker logs <container>', true, NOW(), NOW()),
(134, 'C', 'docker show <container>', false, NOW(), NOW()),
(134, 'D', 'docker print <container>', false, NOW(), NOW()),

-- Q135: Fichier Dockerfile ? (medium)
(135, 'A', 'Il configure le reseau Docker', false, NOW(), NOW()),
(135, 'B', 'Il definit les instructions pour construire une image Docker', true, NOW(), NOW()),
(135, 'C', 'Il liste les conteneurs a demarrer', false, NOW(), NOW()),
(135, 'D', 'Il stocke les logs des conteneurs', false, NOW(), NOW()),

-- Q136: Kubernetes ? (hard)
(136, 'A', 'Un langage de programmation pour le cloud', false, NOW(), NOW()),
(136, 'B', 'Un systeme d''orchestration de conteneurs pour automatiser le deploiement, la mise a l''echelle et la gestion', true, NOW(), NOW()),
(136, 'C', 'Une alternative a Docker', false, NOW(), NOW()),
(136, 'D', 'Un service de base de donnees cloud', false, NOW(), NOW()),

-- Q137: Blue-green vs canary deployment ? (hard)
(137, 'A', 'Ce sont deux noms pour la meme strategie', false, NOW(), NOW()),
(137, 'B', 'Blue-green bascule tout le trafic d''un coup entre deux environnements, canary envoie progressivement le trafic vers la nouvelle version', true, NOW(), NOW()),
(137, 'C', 'Blue-green est pour les tests, canary est pour la production', false, NOW(), NOW()),
(137, 'D', 'Canary est plus ancien que blue-green', false, NOW(), NOW()),

-- Q138: Multi-stage build Docker ? (hard)
(138, 'A', 'Construire plusieurs conteneurs en parallele', false, NOW(), NOW()),
(138, 'B', 'Utiliser plusieurs FROM dans un Dockerfile pour reduire la taille de l''image finale en separant build et runtime', true, NOW(), NOW()),
(138, 'C', 'Deployer sur plusieurs serveurs simultanement', false, NOW(), NOW()),
(138, 'D', 'Executer plusieurs commandes RUN a la fois', false, NOW(), NOW()),

-- Q139: DNS ? (hard)
(139, 'A', 'Il compresse les donnees pour le transfert reseau', false, NOW(), NOW()),
(139, 'B', 'Il traduit les noms de domaine en adresses IP via un systeme hierarchique de serveurs', true, NOW(), NOW()),
(139, 'C', 'Il chiffre les communications reseau', false, NOW(), NOW()),
(139, 'D', 'Il gere l''attribution des adresses MAC', false, NOW(), NOW()),

-- Q140: Infrastructure as Code ? (hard)
(140, 'A', 'Ecrire du code directement sur les serveurs', false, NOW(), NOW()),
(140, 'B', 'Gerer et provisionner l''infrastructure via des fichiers de configuration declaratifs et versionnables (Terraform, Ansible)', true, NOW(), NOW()),
(140, 'C', 'Heberger le code source sur un serveur d''infrastructure', false, NOW(), NOW()),
(140, 'D', 'Un langage de programmation specifique au cloud', false, NOW(), NOW()),

-- =============================================================================
-- Theme 8: Algorithmes & Logique (Q141-Q160)
-- =============================================================================

-- Q141: Complexite recherche dans un tableau non trie ? (easy)
(141, 'A', 'O(1)', false, NOW(), NOW()),
(141, 'B', 'O(log n)', false, NOW(), NOW()),
(141, 'C', 'O(n)', true, NOW(), NOW()),
(141, 'D', 'O(n^2)', false, NOW(), NOW()),

-- Q142: FIFO ? (easy)
(142, 'A', 'Pile (Stack)', false, NOW(), NOW()),
(142, 'B', 'File (Queue)', true, NOW(), NOW()),
(142, 'C', 'Arbre binaire', false, NOW(), NOW()),
(142, 'D', 'Tableau', false, NOW(), NOW()),

-- Q143: LIFO ? (easy)
(143, 'A', 'File (Queue)', false, NOW(), NOW()),
(143, 'B', 'Liste chainee', false, NOW(), NOW()),
(143, 'C', 'Pile (Stack)', true, NOW(), NOW()),
(143, 'D', 'Graphe', false, NOW(), NOW()),

-- Q144: O(1) ? (easy)
(144, 'A', 'Le temps d''execution croit lineairement', false, NOW(), NOW()),
(144, 'B', 'Le temps d''execution est constant, independant de la taille de l''entree', true, NOW(), NOW()),
(144, 'C', 'Le temps d''execution est logarithmique', false, NOW(), NOW()),
(144, 'D', 'L''algorithme ne fonctionne qu''une seule fois', false, NOW(), NOW()),

-- Q145: 10 en binaire ? (easy)
(145, 'A', '1000', false, NOW(), NOW()),
(145, 'B', '1010', true, NOW(), NOW()),
(145, 'C', '1100', false, NOW(), NOW()),
(145, 'D', '0010', false, NOW(), NOW()),

-- Q146: Algorithme de tri ? (easy)
(146, 'A', 'Un algorithme qui recherche un element dans une liste', false, NOW(), NOW()),
(146, 'B', 'Un algorithme qui compresse des donnees', false, NOW(), NOW()),
(146, 'C', 'Un algorithme qui organise les elements d''une collection dans un ordre defini', true, NOW(), NOW()),
(146, 'D', 'Un algorithme qui supprime les doublons', false, NOW(), NOW()),

-- Q147: Combien de fois la boucle s''execute ? (easy)
(147, 'A', 'n + 1 fois', false, NOW(), NOW()),
(147, 'B', 'n - 1 fois', false, NOW(), NOW()),
(147, 'C', 'n fois', true, NOW(), NOW()),
(147, 'D', 'Infiniment', false, NOW(), NOW()),

-- Q148: Complexite tri par insertion pire cas ? (medium)
(148, 'A', 'O(n)', false, NOW(), NOW()),
(148, 'B', 'O(n log n)', false, NOW(), NOW()),
(148, 'C', 'O(n^2)', true, NOW(), NOW()),
(148, 'D', 'O(1)', false, NOW(), NOW()),

-- Q149: Algorithme recursif ? (medium)
(149, 'A', 'Un algorithme qui s''execute en parallele sur plusieurs processeurs', false, NOW(), NOW()),
(149, 'B', 'Un algorithme qui s''appelle lui-meme pour resoudre des sous-problemes', true, NOW(), NOW()),
(149, 'C', 'Un algorithme qui utilise uniquement des boucles', false, NOW(), NOW()),
(149, 'D', 'Un algorithme qui trie des donnees', false, NOW(), NOW()),

-- Q150: Complexite recherche binaire ? (medium)
(150, 'A', 'O(n)', false, NOW(), NOW()),
(150, 'B', 'O(1)', false, NOW(), NOW()),
(150, 'C', 'O(log n)', true, NOW(), NOW()),
(150, 'D', 'O(n^2)', false, NOW(), NOW()),

-- Q151: Table de hachage ? (medium)
(151, 'A', 'Un tableau trie par ordre alphabetique', false, NOW(), NOW()),
(151, 'B', 'Une structure qui associe des cles a des valeurs via une fonction de hachage pour un acces en O(1) moyen', true, NOW(), NOW()),
(151, 'C', 'Un arbre binaire equilibre', false, NOW(), NOW()),
(151, 'D', 'Une liste doublement chainee', false, NOW(), NOW()),

-- Q152: Complexite du merge sort ? (medium)
(152, 'A', 'O(n)', false, NOW(), NOW()),
(152, 'B', 'O(n^2)', false, NOW(), NOW()),
(152, 'C', 'O(n log n)', true, NOW(), NOW()),
(152, 'D', 'O(log n)', false, NOW(), NOW()),

-- Q153: Arbre binaire de recherche ? (medium)
(153, 'A', 'Un arbre ou chaque noeud a exactement 2 enfants', false, NOW(), NOW()),
(153, 'B', 'Un arbre ou les valeurs a gauche sont inferieures et a droite superieures au noeud parent', true, NOW(), NOW()),
(153, 'C', 'Un arbre qui ne peut stocker que des nombres binaires', false, NOW(), NOW()),
(153, 'D', 'Un arbre utilise uniquement pour la compression', false, NOW(), NOW()),

-- Q154: BFS ? (medium)
(154, 'A', 'Parcourt un graphe en profondeur d''abord', false, NOW(), NOW()),
(154, 'B', 'Trie les noeuds d''un graphe par valeur', false, NOW(), NOW()),
(154, 'C', 'Parcourt un graphe niveau par niveau (en largeur d''abord)', true, NOW(), NOW()),
(154, 'D', 'Recherche le chemin le plus long dans un graphe', false, NOW(), NOW()),

-- Q155: Graphe oriente vs non oriente ? (medium)
(155, 'A', 'Dans un graphe oriente les aretes ont une direction, dans un non oriente les aretes sont bidirectionnelles', true, NOW(), NOW()),
(155, 'B', 'Un graphe oriente contient des cycles, un non oriente n''en contient pas', false, NOW(), NOW()),
(155, 'C', 'Un graphe oriente a des poids sur les aretes', false, NOW(), NOW()),
(155, 'D', 'Il n''y a pas de difference', false, NOW(), NOW()),

-- Q156: Programmation dynamique ? (hard)
(156, 'A', 'Un style de programmation qui change a l''execution', false, NOW(), NOW()),
(156, 'B', 'Une technique qui resout les problemes en decomposant en sous-problemes et memorisant les resultats pour eviter les recalculs', true, NOW(), NOW()),
(156, 'C', 'Un langage de programmation dynamique comme Python', false, NOW(), NOW()),
(156, 'D', 'Une methode pour creer des interfaces animees', false, NOW(), NOW()),

-- Q157: Complexite moyenne du quicksort ? (hard)
(157, 'A', 'O(n)', false, NOW(), NOW()),
(157, 'B', 'O(n^2)', false, NOW(), NOW()),
(157, 'C', 'O(n log n)', true, NOW(), NOW()),
(157, 'D', 'O(log n)', false, NOW(), NOW()),

-- Q158: Algorithme glouton ? (hard)
(158, 'A', 'Un algorithme qui essaie toutes les solutions possibles', false, NOW(), NOW()),
(158, 'B', 'Un algorithme qui fait le choix localement optimal a chaque etape, sans revenir en arriere', true, NOW(), NOW()),
(158, 'C', 'Un algorithme qui utilise beaucoup de memoire', false, NOW(), NOW()),
(158, 'D', 'Un algorithme specifique au tri de donnees', false, NOW(), NOW()),

-- Q159: File de priorite ? (hard)
(159, 'A', 'Tableau trie', false, NOW(), NOW()),
(159, 'B', 'Liste chainee', false, NOW(), NOW()),
(159, 'C', 'Tas (Heap)', true, NOW(), NOW()),
(159, 'D', 'Pile (Stack)', false, NOW(), NOW()),

-- Q160: P vs NP ? (hard)
(160, 'A', 'P = problemes rapides a resoudre, NP = problemes impossibles a resoudre', false, NOW(), NOW()),
(160, 'B', 'La question de savoir si tout probleme dont la solution est verifiable en temps polynomial est aussi resolvable en temps polynomial', true, NOW(), NOW()),
(160, 'C', 'P = programmation procedurale, NP = non procedurale', false, NOW(), NOW()),
(160, 'D', 'Un theoreme prouve par Alan Turing', false, NOW(), NOW()),

-- =============================================================================
-- Theme 9: Securite Web (Q161-Q180)
-- =============================================================================

-- Q161: XSS ? (easy)
(161, 'A', 'Extra XML Syntax', false, NOW(), NOW()),
(161, 'B', 'Cross-Site Scripting', true, NOW(), NOW()),
(161, 'C', 'Cross-Server Security', false, NOW(), NOW()),
(161, 'D', 'XML Secure Socket', false, NOW(), NOW()),

-- Q162: Protocole de chiffrement web ? (easy)
(162, 'A', 'FTP', false, NOW(), NOW()),
(162, 'B', 'HTTP', false, NOW(), NOW()),
(162, 'C', 'HTTPS (utilisant TLS)', true, NOW(), NOW()),
(162, 'D', 'SSH', false, NOW(), NOW()),

-- Q163: Injection SQL ? (easy)
(163, 'A', 'Une methode pour optimiser les requetes SQL', false, NOW(), NOW()),
(163, 'B', 'L''insertion de code SQL malveillant dans les entrees utilisateur pour manipuler la base de donnees', true, NOW(), NOW()),
(163, 'C', 'Un outil pour migrer les bases de donnees', false, NOW(), NOW()),
(163, 'D', 'Un type de sauvegarde de base de donnees', false, NOW(), NOW()),

-- Q164: Certificat SSL/TLS ? (easy)
(164, 'A', 'Bloquer les publicites sur un site web', false, NOW(), NOW()),
(164, 'B', 'Accelerer le chargement des pages', false, NOW(), NOW()),
(164, 'C', 'Authentifier l''identite du serveur et chiffrer les communications', true, NOW(), NOW()),
(164, 'D', 'Compresser les donnees transmises', false, NOW(), NOW()),

-- Q165: Prevention injection SQL ? (easy)
(165, 'A', 'Utiliser des requetes parametrees (prepared statements)', true, NOW(), NOW()),
(165, 'B', 'Utiliser uniquement des requetes SELECT', false, NOW(), NOW()),
(165, 'C', 'Desactiver JavaScript dans le navigateur', false, NOW(), NOW()),
(165, 'D', 'Utiliser un mot de passe fort pour la base de donnees', false, NOW(), NOW()),

-- Q166: HTTPS ? (easy)
(166, 'A', 'HyperText Transfer Protocol Standard', false, NOW(), NOW()),
(166, 'B', 'HyperText Transfer Protocol Secure', true, NOW(), NOW()),
(166, 'C', 'High Transfer Protocol System', false, NOW(), NOW()),
(166, 'D', 'HyperText Transport Protocol Safe', false, NOW(), NOW()),

-- Q167: Mot de passe hache ? (easy)
(167, 'A', 'Un mot de passe coupe en plusieurs parties', false, NOW(), NOW()),
(167, 'B', 'Un mot de passe chiffre de maniere reversible', false, NOW(), NOW()),
(167, 'C', 'Un mot de passe transforme par une fonction a sens unique en une empreinte fixe', true, NOW(), NOW()),
(167, 'D', 'Un mot de passe stocke en texte brut dans un fichier cache', false, NOW(), NOW()),

-- Q168: CSRF ? (medium)
(168, 'A', 'Une attaque qui force un utilisateur authentifie a executer des actions non voulues sur un site', true, NOW(), NOW()),
(168, 'B', 'Un protocole de securisation des formulaires', false, NOW(), NOW()),
(168, 'C', 'Un type de chiffrement pour les cookies', false, NOW(), NOW()),
(168, 'D', 'Une methode de compression des requetes HTTP', false, NOW(), NOW()),

-- Q169: CORS ? (medium)
(169, 'A', 'Un type de virus informatique', false, NOW(), NOW()),
(169, 'B', 'Un mecanisme qui permet a un serveur d''indiquer quelles origines sont autorisees a acceder a ses ressources', true, NOW(), NOW()),
(169, 'C', 'Un algorithme de chiffrement', false, NOW(), NOW()),
(169, 'D', 'Un framework de securite web', false, NOW(), NOW()),

-- Q170: Header pour prevenir XSS ? (medium)
(170, 'A', 'X-Frame-Options', false, NOW(), NOW()),
(170, 'B', 'Content-Security-Policy', true, NOW(), NOW()),
(170, 'C', 'Access-Control-Allow-Origin', false, NOW(), NOW()),
(170, 'D', 'X-Powered-By', false, NOW(), NOW()),

-- Q171: JWT ? (medium)
(171, 'A', 'Un format de base de donnees', false, NOW(), NOW()),
(171, 'B', 'Un standard ouvert pour transmettre des informations de maniere securisee sous forme d''objet JSON signe', true, NOW(), NOW()),
(171, 'C', 'Un langage de programmation web', false, NOW(), NOW()),
(171, 'D', 'Un protocole de transfert de fichiers', false, NOW(), NOW()),

-- Q172: Content-Security-Policy ? (medium)
(172, 'A', 'Il bloque tous les scripts JavaScript', false, NOW(), NOW()),
(172, 'B', 'Il definit les sources de contenu autorisees pour prevenir les attaques XSS et d''injection', true, NOW(), NOW()),
(172, 'C', 'Il compresse le contenu de la page', false, NOW(), NOW()),
(172, 'D', 'Il gere le cache du navigateur', false, NOW(), NOW()),

-- Q173: Authentification vs autorisation ? (medium)
(173, 'A', 'Ce sont deux mots pour la meme chose', false, NOW(), NOW()),
(173, 'B', 'L''authentification verifie l''identite, l''autorisation verifie les permissions', true, NOW(), NOW()),
(173, 'C', 'L''autorisation vient avant l''authentification', false, NOW(), NOW()),
(173, 'D', 'L''authentification est pour les API, l''autorisation pour les sites web', false, NOW(), NOW()),

-- Q174: Principe du moindre privilege ? (medium)
(174, 'A', 'Donner le maximum d''acces a tous les utilisateurs pour simplifier la gestion', false, NOW(), NOW()),
(174, 'B', 'Accorder uniquement les permissions minimales necessaires a un utilisateur pour accomplir sa tache', true, NOW(), NOW()),
(174, 'C', 'Bloquer l''acces a tous les utilisateurs par defaut sans exception', false, NOW(), NOW()),
(174, 'D', 'Utiliser le moins de mots de passe possible', false, NOW(), NOW()),

-- Q175: Attaque par force brute ? (medium)
(175, 'A', 'Une attaque physique sur le serveur', false, NOW(), NOW()),
(175, 'B', 'Essayer systematiquement toutes les combinaisons possibles de mots de passe jusqu''a trouver le bon', true, NOW(), NOW()),
(175, 'C', 'Une attaque par deni de service', false, NOW(), NOW()),
(175, 'D', 'Un virus qui corrompt les fichiers', false, NOW(), NOW()),

-- Q176: OWASP Top 10 ? (hard)
(176, 'A', 'Les 10 meilleurs frameworks de securite web', false, NOW(), NOW()),
(176, 'B', 'Les 10 langages les plus securises', false, NOW(), NOW()),
(176, 'C', 'La liste des 10 risques de securite les plus critiques pour les applications web, publiee par l''OWASP', true, NOW(), NOW()),
(176, 'D', 'Les 10 certifications de securite les plus reconnues', false, NOW(), NOW()),

-- Q177: Man-in-the-Middle ? (hard)
(177, 'A', 'Un attaquant s''interpose entre deux parties pour intercepter ou modifier les communications', true, NOW(), NOW()),
(177, 'B', 'Un pare-feu place entre deux reseaux', false, NOW(), NOW()),
(177, 'C', 'Un serveur proxy officiel', false, NOW(), NOW()),
(177, 'D', 'Un mediateur en cas de conflit de merge Git', false, NOW(), NOW()),

-- Q178: SameSite cookies ? (hard)
(178, 'A', 'Il oblige les cookies a avoir le meme nom', false, NOW(), NOW()),
(178, 'B', 'Il controle si les cookies sont envoyes avec les requetes cross-site (Strict, Lax ou None) pour prevenir le CSRF', true, NOW(), NOW()),
(178, 'C', 'Il duplique les cookies sur tous les sous-domaines', false, NOW(), NOW()),
(178, 'D', 'Il supprime automatiquement les cookies expires', false, NOW(), NOW()),

-- Q179: HSTS ? (hard)
(179, 'A', 'Un protocole de transfert de fichiers securise', false, NOW(), NOW()),
(179, 'B', 'Un en-tete HTTP qui force le navigateur a utiliser exclusivement HTTPS pour un domaine', true, NOW(), NOW()),
(179, 'C', 'Un systeme de gestion des sessions HTTP', false, NOW(), NOW()),
(179, 'D', 'Un outil de test de securite', false, NOW(), NOW()),

-- Q180: Chiffrement symetrique vs asymetrique ? (hard)
(180, 'A', 'Symetrique utilise une seule cle pour chiffrer et dechiffrer, asymetrique utilise une paire de cles (publique et privee)', true, NOW(), NOW()),
(180, 'B', 'Symetrique est plus securise qu''asymetrique', false, NOW(), NOW()),
(180, 'C', 'Asymetrique utilise une seule cle, symetrique utilise deux cles', false, NOW(), NOW()),
(180, 'D', 'Il n''y a pas de difference en termes de securite', false, NOW(), NOW()),

-- =============================================================================
-- Theme 10: Culture Dev (Q181-Q200)
-- =============================================================================

-- Q181: Createur du World Wide Web ? (easy)
(181, 'A', 'Steve Jobs', false, NOW(), NOW()),
(181, 'B', 'Bill Gates', false, NOW(), NOW()),
(181, 'C', 'Tim Berners-Lee', true, NOW(), NOW()),
(181, 'D', 'Linus Torvalds', false, NOW(), NOW()),

-- Q182: Annee de creation de JavaScript ? (easy)
(182, 'A', '1991', false, NOW(), NOW()),
(182, 'B', '1995', true, NOW(), NOW()),
(182, 'C', '2000', false, NOW(), NOW()),
(182, 'D', '1989', false, NOW(), NOW()),

-- Q183: API ? (easy)
(183, 'A', 'Advanced Programming Interface', false, NOW(), NOW()),
(183, 'B', 'Application Programming Interface', true, NOW(), NOW()),
(183, 'C', 'Automated Process Integration', false, NOW(), NOW()),
(183, 'D', 'Application Process Internet', false, NOW(), NOW()),

-- Q184: Langage du web ? (easy)
(184, 'A', 'Python', false, NOW(), NOW()),
(184, 'B', 'Java', false, NOW(), NOW()),
(184, 'C', 'JavaScript', true, NOW(), NOW()),
(184, 'D', 'C++', false, NOW(), NOW()),

-- Q185: IDE ? (easy)
(185, 'A', 'Internet Development Engine', false, NOW(), NOW()),
(185, 'B', 'Integrated Development Environment', true, NOW(), NOW()),
(185, 'C', 'Interactive Design Editor', false, NOW(), NOW()),
(185, 'D', 'Internal Debug Engine', false, NOW(), NOW()),

-- Q186: Premiere programmeuse ? (easy)
(186, 'A', 'Grace Hopper', false, NOW(), NOW()),
(186, 'B', 'Ada Lovelace', true, NOW(), NOW()),
(186, 'C', 'Margaret Hamilton', false, NOW(), NOW()),
(186, 'D', 'Hedy Lamarr', false, NOW(), NOW()),

-- Q187: HTTP ? (easy)
(187, 'A', 'HyperText Transfer Protocol', true, NOW(), NOW()),
(187, 'B', 'High-Tech Transfer Process', false, NOW(), NOW()),
(187, 'C', 'HyperText Transport Platform', false, NOW(), NOW()),
(187, 'D', 'Home Tool Transfer Protocol', false, NOW(), NOW()),

-- Q188: Open Source ? (medium)
(188, 'A', 'Un logiciel gratuit sans code source disponible', false, NOW(), NOW()),
(188, 'B', 'Un logiciel dont le code source est accessible, modifiable et redistribuable par tous', true, NOW(), NOW()),
(188, 'C', 'Un logiciel developpe uniquement par des benevoles', false, NOW(), NOW()),
(188, 'D', 'Un logiciel sans licence', false, NOW(), NOW()),

-- Q189: Methodologie Agile ? (medium)
(189, 'A', 'Un langage de programmation pour les startups', false, NOW(), NOW()),
(189, 'B', 'Une approche de developpement iterative et incrementale privilegiant la collaboration et l''adaptation au changement', true, NOW(), NOW()),
(189, 'C', 'Un framework CSS responsive', false, NOW(), NOW()),
(189, 'D', 'Un outil de gestion de versions', false, NOW(), NOW()),

-- Q190: DRY ? (medium)
(190, 'A', 'Don''t Run Yourself', false, NOW(), NOW()),
(190, 'B', 'Do Repeat Yourself', false, NOW(), NOW()),
(190, 'C', 'Don''t Repeat Yourself', true, NOW(), NOW()),
(190, 'D', 'Dynamic Resource Yielding', false, NOW(), NOW()),

-- Q191: MVC ? (medium)
(191, 'A', 'Multiple Version Control', false, NOW(), NOW()),
(191, 'B', 'Model-View-Controller, un pattern separant donnees, presentation et logique', true, NOW(), NOW()),
(191, 'C', 'Main Virtual Computer', false, NOW(), NOW()),
(191, 'D', 'Module Value Chain', false, NOW(), NOW()),

-- Q192: Linter ? (medium)
(192, 'A', 'Un outil de compression de code', false, NOW(), NOW()),
(192, 'B', 'Un outil qui analyse le code source pour detecter les erreurs, bugs et problemes de style', true, NOW(), NOW()),
(192, 'C', 'Un compilateur en ligne', false, NOW(), NOW()),
(192, 'D', 'Un gestionnaire de dependances', false, NOW(), NOW()),

-- Q193: Semantic Versioning ? (medium)
(193, 'A', 'Nommer les versions avec des noms de code (ex: "Buster", "Focal")', false, NOW(), NOW()),
(193, 'B', 'Un systeme MAJEUR.MINEUR.PATCH ou chaque numero a une signification precise (breaking, feature, fix)', true, NOW(), NOW()),
(193, 'C', 'Incrementer un numero a chaque commit', false, NOW(), NOW()),
(193, 'D', 'Utiliser la date comme numero de version', false, NOW(), NOW()),

-- Q194: REST ? (medium)
(194, 'A', 'Remote Execution Standard Technology', false, NOW(), NOW()),
(194, 'B', 'Real-time Event Streaming Transfer', false, NOW(), NOW()),
(194, 'C', 'Representational State Transfer', true, NOW(), NOW()),
(194, 'D', 'Request-Execute-Send-Terminate', false, NOW(), NOW()),

-- Q195: TDD ? (medium)
(195, 'A', 'Ecrire le code puis les tests a la fin du projet', false, NOW(), NOW()),
(195, 'B', 'Ecrire les tests avant le code, puis implementer le code pour que les tests passent', true, NOW(), NOW()),
(195, 'C', 'Tester uniquement en production', false, NOW(), NOW()),
(195, 'D', 'Deleguer les tests a une equipe dediee', false, NOW(), NOW()),

-- Q196: SOLID ? (hard)
(196, 'A', 'Un framework de tests unitaires', false, NOW(), NOW()),
(196, 'B', 'Cinq principes de conception : Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion', true, NOW(), NOW()),
(196, 'C', 'Un langage de modelisation', false, NOW(), NOW()),
(196, 'D', 'Les cinq etapes de compilation d''un programme', false, NOW(), NOW()),

-- Q197: Theoreme CAP ? (hard)
(197, 'A', 'Un systeme distribue ne peut garantir simultanement que deux des trois proprietes : Coherence, Disponibilite, Tolerance au partitionnement', true, NOW(), NOW()),
(197, 'B', 'Les trois etapes de creation d''une API : Create, Authenticate, Publish', false, NOW(), NOW()),
(197, 'C', 'Un algorithme de chiffrement a trois cles', false, NOW(), NOW()),
(197, 'D', 'Les trois couches d''une architecture web', false, NOW(), NOW()),

-- Q198: Loi de Moore ? (hard)
(198, 'A', 'Le nombre de bugs double a chaque mise a jour', false, NOW(), NOW()),
(198, 'B', 'La taille des logiciels double tous les 18 mois', false, NOW(), NOW()),
(198, 'C', 'Le nombre de transistors sur une puce double environ tous les deux ans', true, NOW(), NOW()),
(198, 'D', 'La vitesse d''Internet double chaque annee', false, NOW(), NOW()),

-- Q199: Pattern Observer ? (hard)
(199, 'A', 'Il permet de surveiller les performances d''un serveur', false, NOW(), NOW()),
(199, 'B', 'Il permet a des objets de s''abonner et d''etre notifies automatiquement des changements d''etat d''un autre objet', true, NOW(), NOW()),
(199, 'C', 'Il observe et corrige les erreurs de syntaxe', false, NOW(), NOW()),
(199, 'D', 'Il gere les droits d''acces des utilisateurs', false, NOW(), NOW()),

-- Q200: Dette technique ? (hard)
(200, 'A', 'Le cout financier d''achat de licences logicielles', false, NOW(), NOW()),
(200, 'B', 'Le cout futur engendre par des choix techniques rapides ou sous-optimaux qui devront etre corriges plus tard', true, NOW(), NOW()),
(200, 'C', 'Le salaire des developpeurs d''une equipe technique', false, NOW(), NOW()),
(200, 'D', 'Le cout des serveurs cloud', false, NOW(), NOW())

ON CONFLICT (question_id, label) DO NOTHING;

COMMIT;
