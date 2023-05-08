
SELECT 
	NAME AS nm, 
	'common' AS language_usage,
	FLOOR (language_id * 3.1415927) AS lang_pi_value,
	UPPER(NAME) AS language_name,
	NAME + 'man',
	CONCAT (NAME,'man', 'yep') AS another_name
FROM language;
-- --------------------------------------------------------------
SELECT DISTINCT actor_id FROM film_actor ORDER BY actor_id;

SELECT CONCAT ( cust.FIRST_name, ' ' ,cust.last_name) AS full_name
FROM (
	SELECT first_name, last_name, email
	from customer
	WHERE FIRST_name = 'jessie'
) AS cust;
-- 잠깐동안 table이 됨






