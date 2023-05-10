-- 와일드카드
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';

-- 고객 중에 이메일값이 네번째 자리에 . 이있고 13번째가 @인 사람.
-- KIRK.STCLAIR@sakilacustomer.org
SELECT *
FROM customer
WHERE email LIKE '____.%' AND MID(email, 13, 1) = '@';

-- 정규식
SELECT  * 
FROM customer 
WHERE last_name LIKE 'Q%' OR last_name LIKE 'Y%';

-- 위의 예제를 정규식으로 바꾸기
SELECT * 
FROM customer
WHERE last_name REGEXP '^[LY]';


-- null

SELECT *
FROM rental 
WHERE return_date IS NULL;

-- null 값 제외
SELECT *
FROM rental 
WHERE return_date IS NOT NULL;

-- 반납일이 '2005-05-01' ~ '2005-09-01'이 아닌 렌탈 정보를 알고싶습니다.

SELECT *
FROM rental
WHERE date(return_date) NOT BETWEEN '2005-05-01' AND '2005-08-31'
OR return_date IS NULL;

-- p.126
SELECT payment_id, customer_id, amount, DATE(payment_date)
FROM payment 
WHERE payment_id BETWEEN 101 AND 120
-- AND (customer_id != 5 AND NOT (amount > 8 OR DATE(payment_date) = '2005-08-23'));
AND (customer_id = 5 AND NOT (amount > 6 OR DATE(payment_date) = '2005-06-19'));

SELECT *
FROM payment;

SELECT *
FROM payment
WHERE amount IN (1.98,7.98,9.98);

SELECT *
FROM customer
WHERE last_name LIKE '_A%W%';

-- ch05 
-- 다중 테이블 쿼리 


SELECT *
FROM customer;

SELECT *
FROM address;

SELECT *
FROM city;

-- 고객id 이름 성 adress district값이 나오는 쿼리문 완성.
SELECT A.customer_id, A.first_name, A.last_name, B.address, B.district
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id; 


-- 고객id 이름 성 도시명이 나오는 쿼리문 완성.
SELECT 
A.customer_id, A.first_name, A.last_name,
B.address, B.district,
C.city
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id
INNER JOIN city C
ON B.city_id = C.city_id;


-- 'California' 값만 알고 있다. 미국 주중에 사는 California에사는 소비자 정보를 알고싶다.

SELECT *
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id
WHERE B.district = 'California';

-- 서브쿼리로 작성하겠다

SELECT * 
FROM customer A
INNER JOIN ( -- 임시테이블 처럼 사용이 가능하다.
	SELECT address_id 
	FROM address
	WHERE district = 'California'
) B
ON A.address_id = B.address_id;


SELECT *
FROM actor;

SELECT * 
FROM film;

SELECT *
FROM film_actor;



-- 배우이름 CATE MCQUEEN, CUBA BIRCH 가 출연한 영화를 쿼리문으로 작성하라
SELECT DISTINCT F.title, A.first_name, A.last_name 
FROM film_actor FA
INNER JOIN  actor A
ON A.actor_id = FA.actor_id
INNER JOIN film F
ON F.film_id = FA.film_id
WHERE (first_name, last_name) IN (('CATE','MCQUEEN'),('CUBA','BIRCH'));

SELECT F.title
FROM film F
INNER JOIN (
	SELECT B.film_id
	FROM actor A 
	INNER JOIN film_actor B
	ON A.actor_id = B.actor_id
	WHERE (A.first_name, A.last_name) 
	IN (('CATE','MCQUEEN'),('CUBA','BIRCH')) 
	GROUP BY B.film_id
	HAVING COUNT(*) = 2
) S
ON S.film_id = F.film_id;

-- 학습 점검

SELECT *
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California';  

SELECT F.title
FROM film_actor FA
INNER JOIN  actor A
ON A.actor_id = FA.actor_id
INNER JOIN film F
ON F.film_id = FA.film_id
WHERE first_name = 'JOHN';

-- 셀프조인하기
SELECT A.address, B.address, A.city_id, B.city_id
FROM address A
INNER JOIN address B
ON B.city_id = A.city_id
WHERE A.address_id != B.address_id;

SELECT address, address_id, city_id
FROM address;


