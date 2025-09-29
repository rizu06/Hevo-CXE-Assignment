CREATE OR REPLACE TABLE customers_clean AS
WITH ranked AS (
  SELECT
    customer_id,
    LOWER(NULLIF(TRIM(email),'')) AS email,
    phone,
    UPPER(TRIM(country_code)) AS raw_country,
    created_at,
    updated_at,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY COALESCE(updated_at, created_at) DESC) as rn
  FROM customers_raw
)
SELECT * FROM ranked WHERE rn=1;

CREATE OR REPLACE TABLE customers_phone_clean AS
SELECT
  customer_id,
  email,
  CASE
    WHEN LENGTH(REGEXP_REPLACE(phone,'\D','','g')) = 10 THEN REGEXP_REPLACE(phone,'\D','','g')
    WHEN LENGTH(REGEXP_REPLACE(phone,'\D','','g')) > 10 THEN RIGHT(REGEXP_REPLACE(phone,'\D','','g'),10)
    ELSE 'Unknown'
  END AS phone_clean,
  raw_country,
  created_at,
  updated_at
FROM customers_clean;

CREATE OR REPLACE TABLE customers_country AS
SELECT
  c.customer_id,
  c.email,
  c.phone_clean,
  COALESCE(cd.iso_code,'Unknown') AS country_code,
  c.created_at,
  c.updated_at
FROM customers_phone_clean c
LEFT JOIN country_dim cd
  ON LOWER(cd.country_name)=LOWER(c.raw_country);