# RUNME.md
Step-by-step guide to run the Hevo CXE assignment locally

## 1. Start Postgres with Docker

```bash
docker run --name hevo_pg -e POSTGRES_USER=hevo -e POSTGRES_PASSWORD=hevo_pass -e POSTGRES_DB=hevo_db -p 5432:5432 -d postgres:15

## Connect to Postgres
bash
Copy code
psql "host=localhost port=5432 user=hevo password=hevo_pass dbname=hevo_db"

## Create Tables
In psql, run:

bash
Copy code
\i assessment1/ddl.sql
\i assessment2/ddl.sql

## Load Sample Data
Run:

bash
Copy code
\i load_data.sql
This loads all CSV files in sample_data/ into the corresponding tables.

## Verify Data Loaded
sql
Copy code
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM feedback;
SELECT COUNT(*) FROM customers_raw;
SELECT COUNT(*) FROM orders_raw;
SELECT COUNT(*) FROM products_raw;
SELECT COUNT(*) FROM country_dim;

## Configure Hevo Pipeline
Source: Local Postgres (hevo_db, user hevo, password hevo_pass).

Destination: Snowflake (trial account).

Ingestion Mode: Logical Replication.

Note pipeline ID and team name.

## Run Assessment I Queries in Snowflake
Add username field transformation:

sql
Copy code
SELECT id, email, SPLIT_PART(email,'@',1) AS username FROM customers;
Create order_events:

sql
Copy code
CREATE OR REPLACE TABLE order_events AS
SELECT id AS order_id, customer_id, 'order_'||LOWER(status) AS event_type, CURRENT_TIMESTAMP() AS event_created_at FROM orders;
Validate:

sql
Copy code
\i assessment1/validation_queries.sql

## Run Assessment II Cleaning SQL in Snowflake
Execute in order:

sql
Copy code
\i assessment2/cleaning_sql/customers_clean.sql
\i assessment2/cleaning_sql/orders_clean.sql
\i assessment2/cleaning_sql/products_clean.sql
\i assessment2/final_analytics.sql


## Validate Final Dataset
sql
Copy code
SELECT * FROM final_analytics LIMIT 20;
SELECT COUNT(*) FROM final_analytics;