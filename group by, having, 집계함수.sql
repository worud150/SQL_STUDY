-- ch08

-- group by

-- 제일 많이 빌린 id값 정렬하기
SELECT customer_id, COUNT(*)
FROM rental
GROUP BY customer_id
ORDER BY COUNT(*) DESC; 


-- limit (1), limit (1, 1)
SELECT *
FROM rental
LIMIT 3; -- 처음부터 3번째 줄까지 반환한다.

-- 전체 내림차순의 순으로 3가지 가져온다. 만약에 1/2/3/4/5 값이 있으면 5/4/3번 값을 가져옴
SELECT *
FROM rental
ORDER BY rental_id desc
LIMIT 3;

-- 정렬한 곳에서 시작위치 반환갯수를 정해서 반환할 수 가 있다.
SELECT *
FROM rental
ORDER BY rental_id
-- LIMIT 0, 2; -- 시작위치는 0번방부터 시작한다.
LIMIT 1, 2;

SELECT customer_id, COUNT(*)
FROM rental
GROUP BY customer_id
ORDER BY COUNT(*) DESC
LIMIT 1; 

-- join 이용하여 사용자 이름 찍어주세요
SELECT B.first_name,B.last_name
FROM rental A
INNER JOIN customer B
ON A.customer_id = B.customer_id
GROUP BY B.customer_id
ORDER BY COUNT(*) DESC
LIMIT 1; 

-- 위의문자 서브쿼리로 작성하기
SELECT B.first_name,B.last_name
FROM (
	SELECT customer_id, COUNT(*) cnt
	FROM rental
	GROUP BY customer_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
)A
INNER JOIN customer B
ON A.customer_id = B.customer_id;

-- 가장적게 빌린 사람의 pk 이름 빌린 수 입력하기 
SELECT A.customer_id, COUNT(1), B.first_name, B.last_name 
FROM rental A
INNER JOIN customer B
ON A.customer_id = B.customer_id
GROUP BY customer_id
ORDER BY COUNT(1) 
LIMIT 1; 

-- ORDER BY 위 셀렉트 두번째 자리 값을 대신해서 작성할 수 있다.
SELECT customer_id, COUNT(1)
FROM rental
GROUP BY customer_id  
ORDER BY 2 DESC;

-- 렌탈횟수가 40회 이상인 사람들 pk 이름 성 렌탈수 
SELECT A.customer_id AS pk, B.first_name, B.last_name, COUNT(1) AS cnt 
FROM rental A
INNER JOIN customer B
ON A.customer_id = B.customer_id
GROUP BY pk
HAVING cnt >= 40
ORDER BY cnt; 

-- 서브쿼리 작성해보기


-- 집계함수(group함수)
-- max, min, avg, count, sum

SELECT customer_id,
MAX(amount), MIN(amount),
AVG(amount), SUM(amount) / COUNT(amount)
FROM payment
GROUP BY customer_id;  

SELECT COUNT(customer_id), -- 전체 카운트값
COUNT(DISTINCT customer_id) -- 전체 카운트값에서 중복값을 해야함 
FROM payment;

SELECT COUNT(*), COUNT(return_date), COUNT(1)
FROM rental
WHERE return_date IS NULL;

-- 제일 늦게 반납한 날짜 정보 반환하기
SELECT max(DATEDIFF(return_date, rental_date))
FROM rental;

-- 제일 늦게 반납한 사람 정보 
SELECT B.customer_id, B.first_name, B.last_name
FROM (
	SELECT DISTINCT customer_id
	FROM rental
	WHERE DATEDIFF(return_date, rental_date) =
	(
		SELECT  max(DATEDIFF(return_date, rental_date))
		FROM rental
	)
) A
INNER JOIN customer B
ON A.customer_id = B.customer_id
ORDER BY B.customer_id;


-- 배우의 등급별 출연횟수 

SELECT rating, COUNT(1)
FROM film
GROUP BY rating
ORDER BY COUNT(1);

SELECT *
FROM film;

SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT *
FROM category;

SELECT *
FROM film_category;

SELECT A.actor_id, B.rating, COUNT(1)
FROM film_actor A
INNER JOIN film B
ON A.film_id = B.film_id
GROUP BY A.actor_id, B.rating
-- GROUP BY A.actor_id ; rating등급은 의미가 없다
ORDER BY COUNT(1) DESC; -- 107번 배우가 NC-17등급의 영화출연을 제일 많이 함

-- 배우의 카테고리별 출연횟수 
SELECT A.actor_id, C.category_id, NAME, COUNT(1)
FROM film_actor A
INNER JOIN film_category B
ON A.film_id = B.film_id
INNER JOIN category C
ON B.category_id = C.category_id
GROUP BY A.actor_id, B.category_id;

SELECT Y.actor_id, Y.first_name, Y.last_name, X.category_id, X.name
FROM (
	SELECT A.actor_id, C.category_id, NAME, COUNT(1) cnt
	FROM film_actor A
	INNER JOIN film_category C
	ON A.film_id = C.film_id
	GROUP BY A.actor_id, C.category_id
)Z
INNER JOIN actor Y
ON Y.actor_id = Z.actor_id
INNER JOIN category X
ON Z.category_id = X.category_id
ORDER BY Y.actor_id;

-- 연도별 렌탈 횟수를 반환하는 쿼리를 작성하라 
SELECT CONCAT(YEAR(rental_date),'년') AS `연도`, COUNT(*)
FROM rental
GROUP BY `연도`;

-- 롤업생성(잘 안쓰는 편 db에서 보기 편하라고 있다.)
-- 롤업과 ORDER BY는 같이 쓸 수 없다.
SELECT fa.actor_id, f.rating, COUNT(1)
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
GROUP BY fa.actor_id, f.rating WITH ROLLUP;

-- 배우의 등급별('G','PG') 출연 횟수가 궁금하다. 
SELECT A.actor_id, B.rating, COUNT(1) cnt
FROM film_actor A
INNER JOIN film B
ON A.film_id = B.film_id
GROUP BY A.actor_id, B.rating
HAVING B.rating IN ('G','PG') AND cnt > 9
ORDER BY cnt;

-- 실습
SELECT *
FROM payment;

-- 8-1
SELECT COUNT(*)
FROM payment;

-- 8-2
SELECT customer_id, SUM(amount), COUNT(1)
FROM payment
GROUP BY customer_id;

-- 8-3
SELECT customer_id, SUM(amount), COUNT(1) cnt
FROM payment
GROUP BY customer_id
HAVING cnt >= 40;
