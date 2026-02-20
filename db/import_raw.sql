\if :{?project_root}
\else
\set project_root '.'
\endif

\cd :project_root

\copy members(member_id, customer_id, first_name, last_name, member_since) FROM 'data/raw/members.csv' DELIMITER ',' CSV HEADER;

\copy rental_transactions(transaction_id, item_id, customer_id, rental_item, net_price, date_time_out, date_time_in) FROM 'data/raw/rental_transactions.csv' DELIMITER ',' CSV HEADER;

\copy lift_ticket_transactions(date, customer_id, ticket_price, discount_code, discount_pct, net_price) FROM 'data/raw/lift_ticket_transactions.csv' DELIMITER ',' CSV HEADER;

\copy cafe_transactions(cafe_location, transaction_id, date_time, customer_id, item, item_quantity, net_price) FROM 'data/raw/cafe_transactions.csv' DELIMITER ',' CSV HEADER;

\copy lift_usage(lift_usage_id, customer_id, ticket_type, usage_datetime, lift_zone) FROM 'data/raw/lift_usage.csv' DELIMITER ',' CSV HEADER;
