CREATE OR REPLACE TABLE orders_unique AS
SELECT DISTINCT * FROM orders_raw;

CREATE OR REPLACE TEMP TABLE cust_median AS
SELECT customer_id, MEDIAN(NULLIF(amount,0)) as median_amt
FROM orders_unique
WHERE amount IS NOT NULL AND amount >= 0
GROUP BY customer_id;

CREATE OR REPLACE TEMP TABLE global_median AS
SELECT MEDIAN(NULLIF(amount,0)) as med FROM orders_unique WHERE amount IS NOT NULL AND amount >= 0;

CREATE OR REPLACE TABLE orders_clean AS
SELECT
  o.order_id,
  o.customer_id,
  o.product_id,
  CASE WHEN o.amount IS NULL THEN COALESCE(c.median_amt, gm.med, 0)
       WHEN o.amount < 0 THEN 0
       ELSE o.amount
  END as amount,
  UPPER(COALESCE(o.currency,'USD')) as currency,
  o.created_at
FROM orders_unique o
LEFT JOIN cust_median c ON o.customer_id=c.customer_id
CROSS JOIN global_median gm;

CREATE OR REPLACE TABLE fx_rates AS
SELECT 'USD' as currency,1.0 as rate UNION ALL
SELECT 'INR',0.0125 UNION ALL
SELECT 'SGD',0.73 UNION ALL
SELECT 'EUR',1.08;

CREATE OR REPLACE TABLE orders_with_usd AS
SELECT o.*, o.amount*COALESCE(f.rate,1.0) as amount_usd
FROM orders_clean o
LEFT JOIN fx_rates f ON o.currency=f.currency;