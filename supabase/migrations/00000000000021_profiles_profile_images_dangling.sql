-- As noted [here](https://github.com/orgs/supabase/discussions/7067#discussioncomment-3773245)
-- Supabase does not support image deletion via SQL at this time.
--
-- The least we can do is create a view of "dangling" images for admins to take a look at.
CREATE VIEW "profiles"."profile_images_dangling" AS (
  SELECT
    *
  FROM
    "storage"."objects"
  WHERE
    path_tokens[1] = 'profiles'
    AND NOT EXISTS (
      SELECT
        1
      FROM
        "profiles"."profiles"
      WHERE
        id::text = path_tokens[2]));

