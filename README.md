# Hevo CXE Assignment

## Overview
Solutions for Assessment I (Pipeline Setup & Transformations) and Assessment II (Post-Load Cleaning & Hevo Models).

## Environment Setup
- Postgres via Docker:
  docker run --name hevo_pg -e POSTGRES_USER=hevo -e POSTGRES_PASSWORD=hevo_pass -e POSTGRES_DB=hevo_db -p 5432:5432 -d postgres:15
- Snowflake trial for destination.
- Hevo trial account (Partner Connect).
- Data loaded into Postgres using CSVs.

## Assessment I
- Created tables, loaded sample data, pipeline from Postgres→Snowflake.
- Transformations: username from email, order_events from order status.
- Validation queries in assessment1/validation_queries.sql.

## Assessment II
- Cleaned messy raw data: dedup customers, normalized email/phone/country, cleaned orders, standardized products.
- Final unified dataset: final_analytics.

## Assumptions
- VARCHAR for order status (instead of ENUM).
- Missing timestamps → 1900-01-01.
- Negative amounts → 0, null amounts → median.
- Hardcoded FX rates for conversion.
- Phone normalized to last 10 digits.

## Deliverables
- All SQL scripts in repo.
- Loom video walkthrough.

## Issues
- Hevo connection tunneling, Snowflake schema permissions.

## Loom Link
Add Loom URL here.
