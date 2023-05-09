SELECT * 
FROM film;

-- where절의 조건식 작성하기 

SELECT title
FROM film
WHERE rental_duration >= 7 AND rating = 'G';



SELECT title, rating, rental_duration
FROM film
WHERE (rental_duration >= 7 AND rating = 'G') 
OR (rental_duration < 4 AND rating = 'PG-13')
ORDER BY rating DESC;

-- group by, having

SELECT *
FROM customer;

SELECT 
COUNT(*),
SUM(active),
COUNT(*) - SUM(active),
MAX(address_id),
MIN(address_id),
ROUND (AVG(address_id))
FROM customer;

SELECT store_id, COUNT(*)
FROM customer
GROUP BY store_id
HAVING COUNT(*) >= 300;

SELECT store_id, COUNT(*)
FROM customer
WHERE active = 1
GROUP BY store_id
HAVING COUNT(*) >= 300;

-- study

SELECT actor_id, first_name,last_name
FROM actor
ORDER BY last_name, first_name;

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'WILLIAMS' 
OR last_name = 'DAVIS'; 

SELECT DISTINCT customer_id
FROM rental
WHERE DATE(rental_date) = '2005-07-05'
ORDER BY customer_id;


SELECT c.email, r.return_date
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY r.return_date desc;


-- where 절의 다양한 작성 
SELECT *
FROM customer
WHERE first_name = 'STEVEN'
AND create_date > '2006-01-01';

SELECT *
FROM customer
WHERE first_name = 'STEVEN'
AND create_date <= '2006-01-01';

SELECT * 
FROM customer
WHERE first_name != 'STEVEN'
AND create_date > '2006-01-01';

SELECT * 
FROM customer
WHERE (first_name != 'STEVEN' OR last_name = 'YOUNG')
AND create_date > '2006-01-01';


SELECT * 
FROM customer
WHERE (first_name != 'STEVEN' OR last_name != 'YOUNG')
AND create_date > '2006-01-01';


-- file-id : 762 대여기간 보다 짧은 영홤나 알고 싶다.
-- select 절 안에 select절 사용하기

SELECT * 
FROM film;

SELECT * 
FROM film
WHERE rental_duration < (
	SELECT rental_duration
	FROM film
	WHERE film_id = 762
);


-- '2005-06-14'일날 렌탈을 한 사람들의 이메일을 알고싶다.
SELECT DISTINCT c.email -- distinct 중복값제거
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY c.email; -- 정렬하기

-- rental 정보 2004,2005년을 제외한 정보를 보고싶다.

SELECT *
FROM rental
WHERE YEAR(rental_date) NOT IN (2004, 2005);




SELECT * 
FROM rental
WHERE DATE (rental_date)
BETWEEN '2005-06-14' AND '2005-06-16'
ORDER BY rental_date DESC ;

-- 고객 성이 'FA'와 'FR' 사이에 속하는 사람이 알고 싶다.
SELECT *
FROM customer
WHERE last_name
BETWEEN 'FA' AND 'FR';

-- 영화등급이 g 혹은 pg인 영화 정보 알고싶다

SELECT *
FROM film
WHERE rating IN ('G' , 'PG'); -- IN 조건


-- 제목에 pet이포함된영화와 같은 등급을 가진영화가 궁금하다.

SELECT DISTINCT rating
FROM film
WHERE title LIKE '%PET%';

SELECT title, rating
FROM film 
WHERE rating IN  (
	SELECT DISTINCT rating
	FROM film
	WHERE title LIKE '%PET%'
	
);

-- 등급이 'PG-13' 'R' 'NC-17'이 아닌 영화 정보 알고싶다.

SELECT title, rating
FROM film 
WHERE rating NOT IN  ('PG-13', 'R', 'NC-17');

SELECT mid('abcdefg', 2, 3)
left('abcdefg', 2)
right('abcdefg', 2);


SELECT *
FROM customer
WHERE LEFT (last_name, 1) = 'Q';



