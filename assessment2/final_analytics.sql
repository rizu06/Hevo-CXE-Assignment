CREATE OR REPLACE TABLE final_analytics AS
SELECT
  o.order_id,
  o.customer_id,
  COALESCE(c.email,'Orphan Customer') as customer_email,
  COALESCE(c.phone_clean,'Unknown') as customer_phone,
  COALESCE(c.country_code,'Unknown') as customer_country,
  o.product_id,
  COALESCE(p.product_name_clean,'Unknown Product') as product_name,
  COALESCE(p.category_clean,'Unknown') as product_category,
  p.product_status,
  o.amount,
  o.currency,
  o.amount_usd,
  o.created_at
FROM orders_with_usd o
LEFT JOIN customers_country c ON o.customer_id=c.customer_id
LEFT JOIN products_clean p ON o.product_id=p.product_id;