BEGIN;

DROP TABLE IF EXISTS lift_usage CASCADE;
DROP TABLE IF EXISTS cafe_transactions CASCADE;
DROP TABLE IF EXISTS lift_ticket_transactions CASCADE;
DROP TABLE IF EXISTS rental_transactions CASCADE;
DROP TABLE IF EXISTS members CASCADE;

COMMIT;

\ir init_tables.sql
\ir import_raw.sql
\ir migrations/create_customers_view.sql