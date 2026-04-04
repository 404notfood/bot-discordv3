-- Migration: Systeme Dev Actif
-- Ajoute les champs activeDevRoleId et immuneRoleId dans guild_configs
-- Cree la table daily_message_counts pour le suivi quotidien

-- Ajout des colonnes dans guild_configs
ALTER TABLE "guild_configs" ADD COLUMN IF NOT EXISTS "active_dev_role_id" VARCHAR(20);
ALTER TABLE "guild_configs" ADD COLUMN IF NOT EXISTS "active_dev_channel_id" VARCHAR(20);
ALTER TABLE "guild_configs" ADD COLUMN IF NOT EXISTS "immune_role_id" VARCHAR(20);

-- Table de comptage quotidien des messages
CREATE TABLE IF NOT EXISTS "daily_message_counts" (
    "id" SERIAL PRIMARY KEY,
    "guild_id" VARCHAR(20) NOT NULL,
    "user_id" VARCHAR(20) NOT NULL,
    "date" DATE NOT NULL,
    "count" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE ("guild_id", "user_id", "date")
);

-- Index pour les requetes de la fenetre glissante
CREATE INDEX IF NOT EXISTS "idx_daily_msg_guild_date" ON "daily_message_counts" ("guild_id", "date");
CREATE INDEX IF NOT EXISTS "idx_daily_msg_user_date" ON "daily_message_counts" ("user_id", "date");
