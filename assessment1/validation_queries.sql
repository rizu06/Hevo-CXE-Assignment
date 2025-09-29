-- assessment1/validation_queries.sql
SELECT 'customers' as table_name, COUNT(*) FROM customers;
SELECT 'orders' as table_name, COUNT(*) FROM orders;
SELECT 'feedback' as table_name, COUNT(*) FROM feedback;
SELECT id, email, SPLIT_PART(email,'@',1) as username FROM customers LIMIT 10;
SELECT COUNT(*) as event_count FROM order_events;
SELECT order_id, COUNT(*) FROM orders GROUP BY order_id HAVING COUNT(*)>1;