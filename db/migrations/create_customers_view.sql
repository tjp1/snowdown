BEGIN;

CREATE OR REPLACE VIEW vw_customers AS
SELECT
	customer_id,
	CASE
		WHEN LEFT(customer_id, 1) = 'M' THEN 'member'
		WHEN LEFT(customer_id, 1) = 'C' THEN 'non-member'
	END AS customer_type
FROM (
	SELECT customer_id FROM members
	UNION
	SELECT customer_id FROM rental_transactions
	UNION
	SELECT customer_id FROM lift_ticket_transactions
	UNION
	SELECT customer_id FROM cafe_transactions
	UNION
	SELECT customer_id FROM lift_usage
) AS customer_ids;

COMMIT;
