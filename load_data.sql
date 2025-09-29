-- load_data.sql
-- Run in psql client after creating tables

\copy customers(id,first_name,last_name,email,address) FROM './sample_data/customers.csv' CSV HEADER;
\copy orders(id,customer_id,status) FROM './sample_data/orders.csv' CSV HEADER;
\copy feedback(id,order_id,feedback_comment,rating) FROM './sample_data/feedback.csv' CSV HEADER;

\copy customers_raw(customer_id,email,phone,country_code,created_at,updated_at) FROM './sample_data/customers_raw.csv' CSV HEADER;
\copy orders_raw(order_id,customer_id,product_id,amount,currency,created_at) FROM './sample_data/orders_raw.csv' CSV HEADER;
\copy products_raw(product_id,product_name,category,active_flag) FROM './sample_data/products_raw.csv' CSV HEADER;
\copy country_dim(iso_code,country_name) FROM './sample_data/country_dim.csv' CSV HEADER;
