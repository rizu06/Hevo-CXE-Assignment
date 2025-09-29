CREATE OR REPLACE TABLE products_clean AS
SELECT
  product_id,
  INITCAP(LOWER(product_name)) as product_name_clean,
  INITCAP(LOWER(category)) as category_clean,
  CASE WHEN active_flag IN ('N','0','false') THEN 'Discontinued Product'
       ELSE 'Active Product' END as product_status
FROM products_raw;