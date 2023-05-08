SELECT * FROM film_actor
ORDER BY actor_id DESC, film_id;

SELECT
	staff_id, rental_id, rental_date, return_date, customer_id
FROM rental
WHERE staff_id = 1;
