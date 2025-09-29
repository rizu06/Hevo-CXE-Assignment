-- assessment1/ddl.sql
CREATE TABLE customers (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(255),
  address JSONB
);
CREATE TABLE orders (
  id INTEGER PRIMARY KEY,
  customer_id INTEGER REFERENCES customers(id),
  status VARCHAR(50)
);
CREATE TABLE feedback (
  id INTEGER PRIMARY KEY,
  order_id INTEGER UNIQUE REFERENCES orders(id),
  feedback_comment TEXT,
  rating INTEGER
);