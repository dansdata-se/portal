CREATE SCHEMA IF NOT EXISTS "profiles" AUTHORIZATION "postgres";

GRANT ALL PRIVILEGES ON SCHEMA profiles TO supabase_auth_admin;

GRANT USAGE ON SCHEMA profiles TO postgres, anon, authenticated, service_role;

ALTER DEFAULT privileges IN SCHEMA profiles GRANT ALL ON tables TO supabase_auth_admin;

ALTER DEFAULT privileges IN SCHEMA profiles GRANT ALL ON functions TO supabase_auth_admin;

ALTER DEFAULT privileges IN SCHEMA profiles GRANT ALL ON sequences TO supabase_auth_admin;

