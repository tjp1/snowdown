BEGIN;

CREATE TABLE IF NOT EXISTS members (
	member_id TEXT PRIMARY KEY,
	customer_id TEXT NOT NULL UNIQUE,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	member_since DATE NOT NULL,
	CONSTRAINT members_member_customer_match_chk CHECK (member_id = customer_id),
	CONSTRAINT members_member_id_prefix_chk CHECK (member_id LIKE 'M%'),
	CONSTRAINT members_customer_id_prefix_chk CHECK (customer_id LIKE 'M%')
);

CREATE TABLE IF NOT EXISTS rental_transactions (
	transaction_id TEXT NOT NULL,
	item_id TEXT NOT NULL,
	customer_id TEXT NOT NULL,
	rental_item TEXT NOT NULL,
	net_price NUMERIC(10, 2) NOT NULL CHECK (net_price >= 0),
	date_time_out TIMESTAMP NOT NULL,
	date_time_in TIMESTAMP NOT NULL,
	CONSTRAINT rental_transactions_pk PRIMARY KEY (transaction_id, item_id),
	CONSTRAINT rental_time_window_chk CHECK (date_time_in >= date_time_out)
);

CREATE TABLE IF NOT EXISTS lift_ticket_transactions (
	date DATE NOT NULL,
	customer_id TEXT NOT NULL,
	ticket_price NUMERIC(10, 2) NOT NULL CHECK (ticket_price >= 0),
	discount_code TEXT,
	discount_pct NUMERIC(5, 2),
	net_price NUMERIC(10, 2) NOT NULL CHECK (net_price >= 0),
	CONSTRAINT lift_ticket_discount_pct_chk CHECK (discount_pct IS NULL OR (discount_pct >= 0 AND discount_pct <= 100))
);

CREATE TABLE IF NOT EXISTS cafe_transactions (
	cafe_location TEXT NOT NULL,
	transaction_id TEXT NOT NULL,
	date_time TIMESTAMP NOT NULL,
	customer_id TEXT NOT NULL,
	item TEXT NOT NULL,
	item_quantity INTEGER NOT NULL CHECK (item_quantity > 0),
	net_price NUMERIC(10, 2) NOT NULL CHECK (net_price >= 0),
	CONSTRAINT cafe_transactions_pk PRIMARY KEY (transaction_id, item)
);

CREATE TABLE IF NOT EXISTS lift_usage (
	lift_usage_id TEXT PRIMARY KEY,
	customer_id TEXT NOT NULL,
	ticket_type TEXT NOT NULL,
	usage_datetime TIMESTAMP NOT NULL,
	lift_zone TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_members_customer_id
	ON members (customer_id);

CREATE INDEX IF NOT EXISTS idx_rental_transactions_customer_id
	ON rental_transactions (customer_id);

CREATE INDEX IF NOT EXISTS idx_lift_ticket_transactions_customer_id
	ON lift_ticket_transactions (customer_id);

CREATE INDEX IF NOT EXISTS idx_lift_ticket_transactions_date
	ON lift_ticket_transactions (date);

CREATE INDEX IF NOT EXISTS idx_cafe_transactions_customer_id
	ON cafe_transactions (customer_id);

CREATE INDEX IF NOT EXISTS idx_cafe_transactions_date_time
	ON cafe_transactions (date_time);

CREATE INDEX IF NOT EXISTS idx_lift_usage_customer_id
	ON lift_usage (customer_id);

CREATE INDEX IF NOT EXISTS idx_lift_usage_usage_datetime
	ON lift_usage (usage_datetime);

COMMIT;
