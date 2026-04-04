-- ============================================================================
-- Migration des donnees Doc + SQL Clinic (MySQL → PostgreSQL)
-- Taureau Celtique v3
-- ============================================================================

-- ==================== TABLES: creation si absentes ====================

-- Les tables devraient deja exister via Prisma, mais au cas ou:
CREATE TABLE IF NOT EXISTS doc_super_categories (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  icon VARCHAR(10),
  color VARCHAR(7) NOT NULL DEFAULT '#0099FF',
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS doc_categories (
  id BIGSERIAL PRIMARY KEY,
  super_category_id BIGINT REFERENCES doc_super_categories(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  icon VARCHAR(10),
  color VARCHAR(7) NOT NULL DEFAULT '#0099FF',
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS doc_categories_sort_order_idx ON doc_categories(sort_order);
CREATE INDEX IF NOT EXISTS doc_categories_is_active_idx ON doc_categories(is_active);
CREATE INDEX IF NOT EXISTS doc_categories_super_category_id_idx ON doc_categories(super_category_id);

CREATE TABLE IF NOT EXISTS doc_resources (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  url TEXT NOT NULL,
  language VARCHAR(100) NOT NULL,
  category_id BIGINT REFERENCES doc_categories(id) ON DELETE SET NULL,
  tags JSONB,
  difficulty_level "DifficultyLevel" NOT NULL DEFAULT 'beginner',
  search_url TEXT,
  tutorial_url TEXT,
  popularity INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  view_count INT NOT NULL DEFAULT 0,
  added_by VARCHAR(50),
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS doc_resources_category_id_idx ON doc_resources(category_id);

CREATE TABLE IF NOT EXISTS sql_clinic_datasets (
  id BIGSERIAL PRIMARY KEY,
  slug VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  meta JSONB,
  schema_sql TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS sql_clinic_tasks (
  id BIGSERIAL PRIMARY KEY,
  dataset_id BIGINT NOT NULL REFERENCES sql_clinic_datasets(id),
  slug VARCHAR(255) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  statement TEXT NOT NULL,
  expected_sql TEXT NOT NULL,
  expected_result JSONB NOT NULL,
  points INT NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ,
  UNIQUE(dataset_id, slug)
);
CREATE INDEX IF NOT EXISTS sql_clinic_tasks_dataset_id_idx ON sql_clinic_tasks(dataset_id);

CREATE TABLE IF NOT EXISTS sql_clinic_submissions (
  id BIGSERIAL PRIMARY KEY,
  task_id BIGINT NOT NULL,
  user_discord_id VARCHAR(20) NOT NULL,
  submitted_sql TEXT NOT NULL,
  result_snapshot JSONB,
  is_correct BOOLEAN NOT NULL DEFAULT false,
  awarded_points INT NOT NULL DEFAULT 0,
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ,
  UNIQUE(task_id, user_discord_id)
);
CREATE INDEX IF NOT EXISTS sql_clinic_submissions_task_id_idx ON sql_clinic_submissions(task_id);
CREATE INDEX IF NOT EXISTS sql_clinic_submissions_user_discord_id_idx ON sql_clinic_submissions(user_discord_id);

CREATE TABLE IF NOT EXISTS sql_clinic_challenges (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  sql_query TEXT NOT NULL,
  expected_result TEXT,
  difficulty "QuizDifficulty" NOT NULL DEFAULT 'medium',
  points INT DEFAULT 50,
  time_limit_minutes INT DEFAULT 60,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS sql_clinic_challenges_is_active_idx ON sql_clinic_challenges(is_active);

-- ==================== DOC SUPER CATEGORIES ====================

INSERT INTO doc_super_categories (id, name, description, icon, color, sort_order, is_active, created_at, updated_at) VALUES
(1, 'Frontend', 'Technologies pour le developpement frontend', '🎨', '#FF6B6B', 1, true, '2025-08-30 12:13:49+00', '2025-08-30 12:13:49+00'),
(2, 'Backend', 'Technologies pour le developpement backend', '⚙️', '#4ECDC4', 2, true, '2025-08-30 12:13:49+00', '2025-08-30 12:13:49+00'),
(3, 'Database', 'Systemes de gestion de bases de donnees', '🗄️', '#45B7D1', 3, true, '2025-08-30 12:13:49+00', '2025-08-30 12:13:49+00'),
(4, 'DevOps', 'Outils et technologies DevOps', '🚀', '#96CEB4', 4, true, '2025-08-30 12:13:49+00', '2025-08-30 12:13:49+00'),
(5, 'Security', 'Securite informatique', '🔒', '#FFEAA7', 5, true, '2025-08-30 12:13:49+00', '2025-08-30 12:13:49+00'),
(6, 'Tools', 'Outils de developpement', '🛠️', '#DDA0DD', 6, true, '2025-08-30 12:13:49+00', '2025-08-30 12:13:49+00')
ON CONFLICT (name) DO NOTHING;

-- Reset sequence
SELECT setval('doc_super_categories_id_seq', (SELECT COALESCE(MAX(id), 0) FROM doc_super_categories));

-- ==================== DOC CATEGORIES ====================

INSERT INTO doc_categories (id, super_category_id, name, description, icon, color, sort_order, is_active, created_at, updated_at) VALUES
(1, 1, 'HTML', 'Langage de balisage pour creer des pages web', '🌐', '#e34c26', 1, true, '2025-08-30 11:20:19+00', '2025-08-30 11:20:19+00'),
(2, 1, 'CSS', 'Langage de style pour la presentation des pages web', '🎨', '#1572b6', 2, true, '2025-08-30 11:20:19+00', '2025-08-30 11:20:19+00'),
(3, 1, 'JavaScript', 'Langage de programmation pour le web', '⚡', '#f7df1e', 3, true, '2025-08-30 11:20:19+00', '2025-08-30 11:20:19+00'),
(4, 2, 'PHP', 'Langage de programmation cote serveur', '🐘', '#777bb4', 4, true, '2025-08-30 11:20:19+00', '2025-08-30 11:20:19+00'),
(5, 2, 'Python', 'Langage de programmation polyvalent', '🐍', '#3776ab', 5, true, '2025-08-30 11:20:19+00', '2025-08-30 11:20:19+00'),
(6, 1, 'TypeScript', 'Superset type de JavaScript', '📘', '#3178C6', 4, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(7, 1, 'React', 'Bibliotheque UI JavaScript', '⚛️', '#61DAFB', 5, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(8, 1, 'Vue.js', 'Framework JavaScript progressif', '💚', '#4FC08D', 6, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(9, 1, 'Angular', 'Framework web TypeScript', '🅰️', '#DD0031', 7, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(10, 1, 'SASS', 'Preprocesseur CSS', '💅', '#CC6699', 8, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(11, 1, 'Tailwind', 'Framework CSS utilitaire', '🎨', '#06B6D4', 9, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(12, 1, 'Bootstrap', 'Framework CSS responsive', '🅱️', '#7952B3', 10, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(13, 2, 'Node.js', 'Runtime JavaScript cote serveur', '💚', '#339933', 3, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(14, 2, 'Express', 'Framework web minimaliste Node.js', '🚂', '#000000', 4, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(15, 2, 'Laravel', 'Framework web PHP elegant', '🔴', '#FF2D20', 5, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(16, 2, 'Symfony', 'Framework PHP professionnel', '⚫', '#000000', 6, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(17, 2, 'Django', 'Framework web Python', '🐍', '#092E20', 7, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(18, 2, 'Flask', 'Micro-framework web Python', '🧪', '#000000', 8, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(19, 3, 'SQL', 'Langage de requete structure', '🗃️', '#336791', 1, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(20, 3, 'MySQL', 'Systeme de gestion de base de donnees', '🐬', '#4479A1', 2, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(21, 3, 'PostgreSQL', 'Base de donnees relationnelle avancee', '🐘', '#336791', 3, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(22, 3, 'MongoDB', 'Base de donnees NoSQL orientee documents', '🍃', '#47A248', 4, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(23, 3, 'Redis', 'Store cle-valeur en memoire', '🔴', '#DC382D', 5, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(24, 3, 'SQLite', 'Base de donnees legere et embarquee', '📦', '#003B57', 6, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(25, 3, 'NoSQL', 'Bases de donnees non-relationnelles', '📦', '#4DB33D', 7, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(26, 4, 'Docker', 'Plateforme de conteneurisation', '🐳', '#2496ED', 1, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(27, 4, 'Git', 'Systeme de controle de version', '📝', '#F05032', 2, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(28, 4, 'Kubernetes', 'Orchestrateur de conteneurs', '☸️', '#326CE5', 3, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(29, 4, 'Jenkins', 'Serveur d''integration continue', '🔧', '#D24939', 4, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(30, 4, 'Webpack', 'Bundler de modules JavaScript', '📦', '#8DD6F9', 5, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(31, 5, 'Security', 'Securite informatique generale', '🔒', '#FF6B6B', 1, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(32, 5, 'OWASP', 'Standards de securite web', '🛡️', '#000000', 2, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(33, 5, 'Pentest', 'Tests de penetration', '🔓', '#CC0000', 3, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(34, 6, 'Editor', 'Editeurs de code', '📝', '#007ACC', 1, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(35, 6, 'npm', 'Gestionnaire de paquets Node.js', '📦', '#CB3837', 2, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(36, 6, 'Yarn', 'Gestionnaire de paquets rapide', '📦', '#2C8EBB', 3, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00'),
(37, 6, 'Composer', 'Gestionnaire de dependances PHP', '🎼', '#885630', 4, true, '2026-01-27 21:36:57+00', '2026-01-27 21:36:57+00')
ON CONFLICT (id) DO NOTHING;

-- Reset sequence
SELECT setval('doc_categories_id_seq', (SELECT COALESCE(MAX(id), 0) FROM doc_categories));

-- ==================== DOC RESOURCES ====================

INSERT INTO doc_resources (id, name, description, url, language, category_id, tags, difficulty_level, search_url, tutorial_url, popularity, is_active, view_count, added_by, created_at, updated_at) VALUES
(1, 'MDN HTML', 'Documentation officielle HTML par Mozilla', 'https://developer.mozilla.org/fr/docs/Web/HTML', 'HTML', 1, '["html", "mozilla", "mdn", "documentation"]', 'beginner', 'https://developer.mozilla.org/fr/search', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(2, 'MDN CSS', 'Guide complet CSS par Mozilla', 'https://developer.mozilla.org/fr/docs/Web/CSS', 'CSS', 2, '["css", "mozilla", "mdn", "styles"]', 'beginner', 'https://developer.mozilla.org/fr/search', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(3, 'MDN JavaScript', 'Documentation JavaScript complete', 'https://developer.mozilla.org/fr/docs/Web/JavaScript', 'JavaScript', 3, '["javascript", "mdn", "programming"]', 'intermediate', 'https://developer.mozilla.org/fr/search', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(4, 'React Docs', 'Documentation officielle React', 'https://react.dev/', 'React', 3, '["react", "frontend", "library"]', 'intermediate', 'https://react.dev/learn', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(5, 'Vue.js Guide', 'Guide officiel Vue.js', 'https://vuejs.org/', 'Vue.js', 3, '["vue", "frontend", "framework"]', 'intermediate', 'https://vuejs.org/guide/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(10, 'W3Schools HTML', 'Tutoriels HTML avec exemples interactifs', 'https://www.w3schools.com/html/', 'HTML', 1, '["html", "w3schools", "tutorial", "examples"]', 'beginner', 'https://www.w3schools.com/html/html_examples.asp', 'https://www.w3schools.com/html/html_intro.asp', 0, true, 0, 'SYSTEM', '2025-08-30 12:14:05+00', '2025-08-30 12:14:05+00'),
(11, 'CSS Tricks', 'Astuces et techniques CSS avancees', 'https://css-tricks.com/', 'CSS', 2, '["css", "tricks", "advanced", "techniques"]', 'intermediate', 'https://css-tricks.com/search/', 'https://css-tricks.com/guides/', 0, true, 0, 'SYSTEM', '2025-08-30 12:14:05+00', '2025-08-30 12:14:05+00'),
(12, 'JavaScript.info', 'Tutoriel JavaScript moderne', 'https://javascript.info/', 'JavaScript', 3, '["javascript", "tutorial", "modern", "es6"]', 'intermediate', 'https://javascript.info/search', 'https://javascript.info/intro', 0, true, 0, 'SYSTEM', '2025-08-30 12:14:05+00', '2025-08-30 12:14:05+00'),
(13, 'PHP Manual', 'Documentation officielle PHP', 'https://www.php.net/manual/fr/', 'PHP', 4, '["php", "backend", "programming", "server"]', 'intermediate', 'https://www.php.net/search.php', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(14, 'Python Docs', 'Documentation officielle Python', 'https://docs.python.org/fr/3/', 'Python', 5, '["python", "programming", "documentation"]', 'beginner', 'https://docs.python.org/fr/3/search.html', 'https://docs.python.org/fr/3/tutorial/', 0, true, 0, 'SYSTEM', '2025-08-30 12:14:05+00', '2025-08-30 12:14:05+00'),
(15, 'Angular Docs', 'Documentation officielle Angular', 'https://angular.io/', 'Angular', 9, '["angular", "frontend", "framework", "typescript"]', 'advanced', 'https://angular.io/docs', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(16, 'Tailwind CSS', 'Framework CSS utilitaire', 'https://tailwindcss.com/', 'CSS', 2, '["css", "framework", "utility", "responsive"]', 'intermediate', 'https://tailwindcss.com/docs', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(17, 'Bootstrap', 'Framework CSS responsive', 'https://getbootstrap.com/', 'CSS', 2, '["css", "framework", "responsive", "components"]', 'beginner', 'https://getbootstrap.com/docs/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(18, 'SASS/SCSS', 'Preprocesseur CSS avance', 'https://sass-lang.com/', 'SASS', 10, '["css", "preprocessor", "sass", "scss"]', 'intermediate', 'https://sass-lang.com/documentation/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(19, 'TypeScript Handbook', 'Guide complet TypeScript', 'https://www.typescriptlang.org/', 'TypeScript', 6, '["typescript", "javascript", "types", "programming"]', 'intermediate', 'https://www.typescriptlang.org/docs/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(20, 'Webpack', 'Bundler de modules JavaScript', 'https://webpack.js.org/', 'JavaScript', 3, '["webpack", "bundler", "javascript", "build"]', 'advanced', 'https://webpack.js.org/concepts/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(21, 'Laravel Documentation', 'Framework web PHP elegant', 'https://laravel.com/docs', 'PHP', 15, '["php", "laravel", "framework", "mvc"]', 'intermediate', 'https://laravel.com/docs/master', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(22, 'Symfony Documentation', 'Framework PHP professionnel', 'https://symfony.com/doc/current/index.html', 'PHP', 16, '["php", "symfony", "framework", "enterprise"]', 'advanced', 'https://symfony.com/search', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(23, 'Node.js Documentation', 'Runtime JavaScript cote serveur', 'https://nodejs.org/en/docs/', 'JavaScript', 13, '["nodejs", "javascript", "backend", "runtime"]', 'intermediate', 'https://nodejs.org/en/docs/guides/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(24, 'Express.js Guide', 'Framework web minimaliste pour Node.js', 'https://expressjs.com/', 'JavaScript', 14, '["express", "nodejs", "web", "framework"]', 'intermediate', 'https://expressjs.com/en/4x/api.html', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(25, 'Python Documentation', 'Langage de programmation Python', 'https://docs.python.org/3/', 'Python', 5, '["python", "programming", "backend"]', 'beginner', 'https://docs.python.org/3/search.html', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(26, 'Django Documentation', 'Framework web Python', 'https://docs.djangoproject.com/', 'Python', 17, '["django", "python", "web", "framework"]', 'intermediate', 'https://docs.djangoproject.com/en/stable/search/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(27, 'Flask Documentation', 'Micro-framework web Python', 'https://flask.palletsprojects.com/', 'Python', 18, '["flask", "python", "microframework", "web"]', 'intermediate', 'https://flask.palletsprojects.com/en/latest/api/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(28, 'MySQL Documentation', 'Systeme de gestion de base de donnees', 'https://dev.mysql.com/doc/', 'SQL', 19, '["mysql", "database", "sql", "relational"]', 'intermediate', 'https://dev.mysql.com/doc/search/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(29, 'PostgreSQL Documentation', 'Base de donnees relationnelle avancee', 'https://www.postgresql.org/docs/', 'SQL', 19, '["postgresql", "database", "sql", "advanced"]', 'intermediate', 'https://www.postgresql.org/search/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(30, 'MongoDB Manual', 'Base de donnees NoSQL orientee documents', 'https://docs.mongodb.com/', 'NoSQL', 22, '["mongodb", "nosql", "database", "document"]', 'intermediate', 'https://docs.mongodb.com/manual/search/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(31, 'Redis Documentation', 'Store cle-valeur en memoire', 'https://redis.io/documentation', 'NoSQL', 23, '["redis", "cache", "memory", "keyvalue"]', 'intermediate', 'https://redis.io/commands/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(32, 'SQLite Documentation', 'Base de donnees legere et embarquee', 'https://www.sqlite.org/docs.html', 'SQL', 19, '["sqlite", "database", "embedded", "lightweight"]', 'beginner', 'https://www.sqlite.org/search', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(33, 'SQL Tutorial', 'Langage de requete structure', 'https://www.w3schools.com/sql/', 'SQL', 19, '["sql", "query", "database", "tutorial"]', 'beginner', 'https://www.w3schools.com/sql/sql_syntax.asp', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(34, 'Docker Documentation', 'Plateforme de conteneurisation', 'https://docs.docker.com/', 'Docker', 26, '["docker", "containers", "devops", "deployment"]', 'intermediate', 'https://docs.docker.com/search/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(35, 'Git Documentation', 'Systeme de controle de version', 'https://git-scm.com/doc', 'Git', 27, '["git", "version-control", "scm", "devops"]', 'beginner', 'https://git-scm.com/docs', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(36, 'Jenkins User Guide', 'Serveur d''integration continue', 'https://www.jenkins.io/doc/', 'Jenkins', 29, '["jenkins", "ci-cd", "automation", "devops"]', 'advanced', 'https://www.jenkins.io/doc/book/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(37, 'Kubernetes Documentation', 'Orchestrateur de conteneurs', 'https://kubernetes.io/docs/', 'Kubernetes', 28, '["kubernetes", "containers", "orchestration", "k8s"]', 'advanced', 'https://kubernetes.io/docs/home/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(38, 'OWASP Top 10', 'Top 10 des vulnerabilites web', 'https://owasp.org/www-project-top-ten/', 'Security', 31, '["owasp", "security", "vulnerabilities", "web"]', 'intermediate', NULL, NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(39, 'Kali Linux Tools', 'Distribution pour tests de penetration', 'https://www.kali.org/tools/', 'Security', 31, '["kali", "linux", "pentest", "security"]', 'advanced', NULL, NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(40, 'HackTricks', 'Techniques de hacking ethique', 'https://book.hacktricks.xyz/', 'Security', 31, '["hacktricks", "pentest", "hacking", "security"]', 'advanced', 'https://book.hacktricks.xyz/welcome/readme', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(41, 'NIST Cybersecurity', 'Framework de cybersecurite', 'https://www.nist.gov/cyberframework', 'Security', 31, '["nist", "cybersecurity", "framework", "standards"]', 'advanced', NULL, NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(42, 'PortSwigger Web Security', 'Academie de securite web', 'https://portswigger.net/web-security', 'Security', 31, '["portswigger", "web-security", "burp", "academy"]', 'intermediate', 'https://portswigger.net/web-security/all-topics', 'https://portswigger.net/web-security/learning-path', 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(43, 'Composer Documentation', 'Gestionnaire de dependances PHP', 'https://getcomposer.org/doc/', 'PHP', 4, '["composer", "php", "dependencies", "packages"]', 'beginner', 'https://packagist.org/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(44, 'npm Documentation', 'Gestionnaire de paquets Node.js', 'https://docs.npmjs.com/', 'JavaScript', 3, '["npm", "nodejs", "packages", "dependencies"]', 'beginner', 'https://www.npmjs.com/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(45, 'Yarn Documentation', 'Gestionnaire de paquets rapide', 'https://yarnpkg.com/getting-started', 'JavaScript', 3, '["yarn", "packages", "javascript", "fast"]', 'beginner', 'https://yarnpkg.com/cli/', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00'),
(46, 'VS Code Documentation', 'Editeur de code extensible', 'https://code.visualstudio.com/docs', 'Editor', 34, '["vscode", "editor", "microsoft", "extensions"]', 'beginner', 'https://code.visualstudio.com/docs/editor/codebasics', NULL, 0, true, 0, 'SYSTEM', '2025-08-30 15:12:11+00', '2025-08-30 15:12:11+00')
ON CONFLICT (id) DO NOTHING;

-- Reset sequence
SELECT setval('doc_resources_id_seq', (SELECT COALESCE(MAX(id), 0) FROM doc_resources));

-- ==================== SQL CLINIC DATASETS ====================

INSERT INTO sql_clinic_datasets (id, slug, name, description, meta, schema_sql, is_active, created_at, updated_at) VALUES
(1, 'employees', 'Base de donnees Employes', 'Dataset simple avec employes, departements et salaires', NULL, NULL, true, NULL, NULL),
(2, 'ecommerce', 'E-commerce', 'Base de donnees d''un site e-commerce', NULL, NULL, true, NULL, NULL)
ON CONFLICT (slug) DO NOTHING;

-- Reset sequence
SELECT setval('sql_clinic_datasets_id_seq', (SELECT COALESCE(MAX(id), 0) FROM sql_clinic_datasets));

-- ============================================================================
-- Fin de la migration
-- ============================================================================
