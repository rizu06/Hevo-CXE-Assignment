-- assessment2/ddl.sql
CREATE TABLE customers_raw (
  customer_id INTEGER,
  email VARCHAR,
  phone VARCHAR,
  country_code VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE TABLE orders_raw (
  order_id INTEGER,
  customer_id INTEGER,
  product_id INTEGER,
  amount FLOAT,
  currency VARCHAR,
  created_at TIMESTAMP
);
CREATE TABLE products_raw (
  product_id INTEGER,
  product_name VARCHAR,
  category VARCHAR,
  active_flag VARCHAR
);
CREATE TABLE country_dim (
  iso_code VARCHAR,
  country_name VARCHAR
);