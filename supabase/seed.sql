-- Create test users
-- email: alice@example.com password: password
-- email: bob@example.com password: password
INSERT INTO auth.audit_log_entries (
  instance_id,
  id,
  payload,
  created_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  '1428b495-a59e-49ae-ad59-e061f7b2ca42',
  '{"action":"user_signedup","actor_id":"f79a5ba6-7eaf-400e-8f70-c1e8cbd9631b","actor_username":"alice@example.com","log_type":"team","timestamp":"2022-08-05T14:06:38Z","traits":{"provider":"email"}}',
  '2022-08-05 14:06:38.55586+00');

INSERT INTO auth.audit_log_entries (
  instance_id,
  id,
  payload,
  created_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  '41e018de-2791-4990-bb31-1a85b432409c',
  '{"action":"login","actor_id":"f79a5ba6-7eaf-400e-8f70-c1e8cbd9631b","actor_username":"alice@example.com","log_type":"account","timestamp":"2022-08-05T14:06:38Z","traits":{"provider":"email"}}',
  '2022-08-05 14:06:38.561871+00');

INSERT INTO auth.audit_log_entries (
  instance_id,
  id,
  payload,
  created_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  '21b3bcee-50f3-4cac-8bbe-7d9ebac7dd8b',
  '{"action":"user_signedup","actor_id":"1912ff43-e876-4961-9631-ecd09fe019bb","actor_username":"bob@example.com","log_type":"team","timestamp":"2022-08-05T14:06:47Z","traits":{"provider":"email"}}',
  '2022-08-05 14:06:47.337326+00');

INSERT INTO auth.audit_log_entries (
  instance_id,
  id,
  payload,
  created_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  '1c45fe3a-6493-4d06-8acb-d646c902919e',
  '{"action":"login","actor_id":"1912ff43-e876-4961-9631-ecd09fe019bb","actor_username":"bob@example.com","log_type":"account","timestamp":"2022-08-05T14:06:47Z","traits":{"provider":"email"}}',
  '2022-08-05 14:06:47.340904+00');

INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  ROLE,
  email,
  encrypted_password,
  email_confirmed_at,
  invited_at,
  confirmation_token,
  confirmation_sent_at,
  recovery_token,
  recovery_sent_at,
  email_change_token_new,
  email_change,
  email_change_sent_at,
  last_sign_in_at,
  raw_app_meta_data,
  raw_user_meta_data,
  is_super_admin,
  created_at,
  updated_at,
  phone,
  phone_confirmed_at,
  phone_change,
  phone_change_token,
  phone_change_sent_at,
  email_change_token_current,
  email_change_confirm_status,
  banned_until,
  reauthentication_token,
  reauthentication_sent_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  'f79a5ba6-7eaf-400e-8f70-c1e8cbd9631b',
  'authenticated',
  'authenticated',
  'alice@example.com',
  '$2a$10$mbTt9hIfVQK6mtjM0evvJOyO4QGFcfs2lW7cIdTtc7jxTDvXUE0rG',
  '2022-08-05 14:06:38.556364+00',
  NULL,
  '', NULL, '',
  NULL,
  '', '',
  NULL,
  '2022-08-05 14:06:38.562479+00',
  '{"provider": "email", "providers": ["email"]}',
  '{}',
  FALSE,
  '2022-08-05 14:06:38.553239+00',
  '2022-08-05 14:06:38.553242+00',
  NULL,
  NULL,
  '', '',
  NULL,
  '', 0, NULL, '',
  NULL);

INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  ROLE,
  email,
  encrypted_password,
  email_confirmed_at,
  invited_at,
  confirmation_token,
  confirmation_sent_at,
  recovery_token,
  recovery_sent_at,
  email_change_token_new,
  email_change,
  email_change_sent_at,
  last_sign_in_at,
  raw_app_meta_data,
  raw_user_meta_data,
  is_super_admin,
  created_at,
  updated_at,
  phone,
  phone_confirmed_at,
  phone_change,
  phone_change_token,
  phone_change_sent_at,
  email_change_token_current,
  email_change_confirm_status,
  banned_until,
  reauthentication_token,
  reauthentication_sent_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  '1912ff43-e876-4961-9631-ecd09fe019bb',
  'authenticated',
  'authenticated',
  'bob@example.com',
  '$2a$10$GUruEatuNmaT7ftdyfLaf.aoerVJIdmfkYWLOP3zN7jiBxQBmQUsq',
  '2022-08-05 14:06:47.337536+00',
  NULL,
  '', NULL, '',
  NULL,
  '', '',
  NULL,
  '2022-08-05 14:06:47.341379+00',
  '{"provider": "email", "providers": ["email"]}',
  '{}',
  FALSE,
  '2022-08-05 14:06:47.33564+00',
  '2022-08-05 14:06:47.335643+00',
  NULL,
  NULL,
  '', '',
  NULL,
  '', 0, NULL, '',
  NULL);

INSERT INTO auth.identities (
  id,
  user_id,
  identity_data,
  provider,
  last_sign_in_at,
  created_at,
  updated_at)
VALUES (
  'f79a5ba6-7eaf-400e-8f70-c1e8cbd9631b',
  'f79a5ba6-7eaf-400e-8f70-c1e8cbd9631b',
  '{"sub": "f79a5ba6-7eaf-400e-8f70-c1e8cbd9631b"}',
  'email',
  '2022-08-05 14:06:38.555048+00',
  '2022-08-05 14:06:38.555067+00',
  '2022-08-05 14:06:38.555069+00');

INSERT INTO auth.identities (
  id,
  user_id,
  identity_data,
  provider,
  last_sign_in_at,
  created_at,
  updated_at)
VALUES (
  '1912ff43-e876-4961-9631-ecd09fe019bb',
  '1912ff43-e876-4961-9631-ecd09fe019bb',
  '{"sub": "1912ff43-e876-4961-9631-ecd09fe019bb"}',
  'email',
  '2022-08-05 14:06:47.33698+00',
  '2022-08-05 14:06:47.337+00',
  '2022-08-05 14:06:47.337002+00');

