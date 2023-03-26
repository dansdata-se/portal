-- `INSERT INTO profiles` should never be performed - instead inserts should be
-- performed on e.g. `organizations`. However, IF an `INSERT INTO profiles` is
-- made, that can lead to a "dangling" profile - meaning a profile which is not
-- further specialized in a sub-table.
--
-- Currently, I (FelixZY) see no way around this. Instead, let's set up a view
-- to monitor this case, allowing admins to take action if necessary.
CREATE VIEW "profiles"."profiles_dangling" AS (
  SELECT
    *
  FROM
    "profiles"."profiles" p
  WHERE
    NOT EXISTS (
      SELECT
        1
      FROM
        "profiles"."organizations" po
      WHERE
        p.id = po.id)
      AND NOT EXISTS (
        SELECT
          1
        FROM
          "profiles"."individuals" pi
        WHERE
          p.id = pi.id)
        AND NOT EXISTS (
          SELECT
            1
          FROM
            "profiles"."venues" pv
          WHERE
            p.id = pv.id));

