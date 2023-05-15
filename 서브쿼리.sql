-- ()가 있고 안에 select문이 존재한다.

-- 가장 나중에 가입한 고객의 pk 이름 성 출력
SELECT *
FROM customer;

SELECT customer_id, first_name, last_name
FROM customer 
ORDER BY customer_id DESC
LIMIT 1;

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id = (
	SELECT MAX(customer_id)
	FROM customer
);

-- 도시id 도시명 > 인도가 아닌 나라들의 도시id와 도시명

-- 속도차이가 서브쿼리가 더 빠를 수도 있다.
SELECT city_id, city
FROM city
WHERE country_id != (
	SELECT country_id
	FROM country 
	WHERE country = 'India'
);

-- 이건 정렬하는 기준이 없기에 정렬이 안됨
SELECT city_id, city
FROM city A
INNER JOIN country B
ON A.country_id != B.country_id
WHERE B.country = 'India';

-- Canada, Mexico의 도시id, 도시명 출력
SELECT city_id, city
FROM city 
WHERE country_id IN (
	SELECT country_id 
	FROM country
	WHERE country IN ('Canada', 'Mexico')
);

-- inner join으로 작성하기
SELECT city_id, city
FROM city A
INNER JOIN country B
ON A.country_id = B.country_id
WHERE B.country IN ('Canada', 'Mexico');

-- ALL 연산자 
SELECT *
FROM customer
WHERE customer_id != ALL(
	SELECT customer_id
	FROM payment
	WHERE amount = 0
);

-- United States, Mexico, Canada에 거주하는 소비자의 렌탈횟수보다 많이
-- 렌탈한 사람들의 고객 id, 횟수를 알아내는 쿼리문을 작성해라.
SELECT *
FROM view_test; 
-- 지우고 싶을때는
DROP VIEW view_test; 

CREATE VIEW view_test AS 
SELECT customer_id, COUNT(customer_id)
FROM rental
GROUP BY customer_id
HAVING COUNT(customer_id) > all(
	SELECT COUNT(customer_id)
	FROM rental
	WHERE customer_id IN (
		SELECT customer_id
		FROM customer
		WHERE address_id IN (
			SELECT address_id
			FROM address 
			WHERE city_id IN (
				SELECT city_id
				FROM city 
				WHERE country_id IN (
					SELECT country_id 
					FROM country 
					WHERE country 
					IN ('United States','Mexico','Canada')
				)
			)
		)
	)
	GROUP BY customer_id
);

-- 다중컬럼 서브쿼리
-- 배우 성이 'MONROE'인 사람이 PG 영화등급에 출연했다. 배우 ID와 영화ID가 궁금하다.
SELECT A.actor_id, F.film_id
FROM actor A
INNER JOIN film_actor FA
ON A.actor_id = FA.actor_id
INNER JOIN film F
ON F.film_id = FA.film_id 
WHERE A.last_name = 'MONROE'
AND F.rating = 'PG';

-- 다중컬럼 서브쿼리 좀 더 작게 작성하기
SELECT A.actor_id, F.film_id
FROM actor A
INNER JOIN film_actor FA
ON A.actor_id = FA.actor_id
INNER JOIN film F
ON F.film_id = FA.film_id 
WHERE (A.last_name, F.rating ) = ('MONROE', 'PG');

-- case문 무조건 alias를 줘야한다.
SELECT active,
	case
		when active = 1
		then '활성화'
		ELSE '비활성화'
	END active_str,
	if (active = 1, '활성화', '비활성화') active_str2 
FROM customer;

-- 만약에 PG, G면 전체이용 NC-17 17세이상관람가능, PG-13은 13세이상관람가능, R은 청소년관람불가 
SELECT rating,
	case 
		when rating IN ('PG','G') then '전체관람가능'
		when rating = 'NC-17' then '17세이상관람가능'
		when rating = 'PG-13' then '13세이상관람가능'
		ELSE '청소년관람불가'
	END rating_str
FROM film
ORDER BY rating;

SELECT rating,
	case 
		when 'PG' then '전체관람가능'
		when 'G' then '전체관람가능'
		when 'NC-17' then '17세이상관람가능'
		when 'PG-13' then '13세이상관람가능'
		ELSE '청소년관람불가'
	END rating_str
FROM film
ORDER BY rating;


-- first_name, last_name, num_rentals(active = 0 -> 0)

SELECT C.first_name, C.last_name,  C.active, COUNT(1),
	case
	when C.active = 0 then 0
	ELSE COUNT(1)
	end num_rentals
FROM customer C
INNER JOIN rental R
ON R.customer_id = C.customer_id
GROUP BY C.customer_id;
ORDER BY C.active;


-- 굉장히 느리다.
SELECT first_name, last_name, active, 
	case 
		when active = 0 then 0
		ELSE (
			SELECT COUNT(*)
			FROM rental B
			WHERE A.customer_id = B.customer_id
		)
	END num_rentals
FROM customer A
ORDER BY num_rentals;

-- rental 테이블에서 2005-05 - 2005-08 각 달의 렌탈 수
SELECT rental_date, COUNT(1)
FROM rental
WHERE YEAR(rental_date) = 2005
AND MONTH(rental_date) IN (05,06,07)
GROUP BY MONTH(rental_date);

SELECT DATE_FORMAT(rental_date,'%Y-%m') mon, COUNT(rental_date) cnt
FROM rental
WHERE DATE_FORMAT(rental_date,'%Y-%m') BETWEEN '2005-05' AND '2005-07'
GROUP BY mon;

-- 윗 쿼리 한줄로 출력하기
SELECT 
SUM(
	CASE DATE_FORMAT(rental_date, '%Y-%m') when '2005-05' then 1 ELSE 0 END
) may_rentals,

SUM(
	CASE DATE_FORMAT(rental_date, '%Y-%m') when '2005-06' then 1 ELSE 0 END
) june_rentals,

SUM(
	CASE DATE_FORMAT(rental_date, '%Y-%m') when '2005-07' then 1 ELSE 0 END
) july_rentals

FROM rental
WHERE DATE_FORMAT(rental_date,'%Y-%m') BETWEEN '2005-05' AND '2005-07';




































