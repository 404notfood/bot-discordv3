-- Add difficulty and sort_order columns to sql_clinic_tasks
ALTER TABLE sql_clinic_tasks ADD COLUMN IF NOT EXISTS difficulty VARCHAR(20) NOT NULL DEFAULT 'beginner';
ALTER TABLE sql_clinic_tasks ADD COLUMN IF NOT EXISTS sort_order INT NOT NULL DEFAULT 0;

-- Update schema_sql for datasets with file content references
-- (Run the update-datasets.sql script after to populate schema_sql)
