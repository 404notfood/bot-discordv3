-- Migration: Create SQL Challenge tables
-- Run on VPS with: psql "$DATABASE_URL" -f prisma/migrations/add_sql_challenge_tables.sql

-- 1. SQL Challenge Sessions
CREATE TABLE IF NOT EXISTS sql_challenge_sessions (
  id BIGSERIAL PRIMARY KEY,
  guild_id VARCHAR(20) NOT NULL,
  dataset_id BIGINT NOT NULL,
  title VARCHAR(255) NOT NULL,
  channel_id VARCHAR(20) NOT NULL,
  questions_json TEXT NOT NULL,
  total_questions INT NOT NULL DEFAULT 15,
  status VARCHAR(20) NOT NULL DEFAULT 'active',
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ended_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_sql_challenge_sessions_guild_status ON sql_challenge_sessions (guild_id, status);

-- 2. SQL Challenge Participants
CREATE TABLE IF NOT EXISTS sql_challenge_participants (
  id BIGSERIAL PRIMARY KEY,
  session_id BIGINT NOT NULL REFERENCES sql_challenge_sessions(id),
  user_discord_id VARCHAR(20) NOT NULL,
  username VARCHAR(100) NOT NULL,
  guild_id VARCHAR(20) NOT NULL,
  current_question INT NOT NULL DEFAULT 1,
  total_points INT NOT NULL DEFAULT 0,
  hints_used INT NOT NULL DEFAULT 0,
  is_finished BOOLEAN NOT NULL DEFAULT false,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_activity_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(session_id, user_discord_id)
);

CREATE INDEX IF NOT EXISTS idx_sql_challenge_participants_user ON sql_challenge_participants (user_discord_id);

-- 3. SQL Challenge Responses
CREATE TABLE IF NOT EXISTS sql_challenge_responses (
  id BIGSERIAL PRIMARY KEY,
  participant_id BIGINT NOT NULL REFERENCES sql_challenge_participants(id),
  task_id BIGINT NOT NULL,
  question_number INT NOT NULL,
  submitted_sql TEXT NOT NULL,
  is_correct BOOLEAN NOT NULL DEFAULT false,
  points_earned INT NOT NULL DEFAULT 0,
  hints_used INT NOT NULL DEFAULT 0,
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_sql_challenge_responses_participant ON sql_challenge_responses (participant_id);

-- 4. Add hint column to sql_clinic_tasks (if not exists)
ALTER TABLE sql_clinic_tasks ADD COLUMN IF NOT EXISTS hint TEXT;
