-- union

SELECT 1 num, 'abc' as str
UNION ALL 
SELECT 9, 'asd'
UNION ALL 
SELECT 1, 'abc';

-- 고객의 이름 성, 배우의 이름, 성 같이 볼 수  있는 쿼리문 작성
SELECT 'customer' AS typ, first_name, last_name
FROM customer
-- ORDER BY first_name 에러
UNION  
SELECT 'actor' AS typ, first_name, last_name
FROM actor;
ORDER BY first_name; -- 정렬까지 


-- 배우 고객 둘다 이름이(first_name) 이 J or D 로 시작하는 사람 리스트 
SELECT 'customer' AS typ, first_name, last_name
FROM customer
WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
UNION  
SELECT 'actor' AS typ, first_name, last_name
FROM actor
WHERE first_name REGEXP '^J' AND last_name REGEXP '^D';


-- 서브쿼리로 작성하기(intersect) 
SELECT T.first_name, T.last_name
FROM (
	SELECT 'customer' AS typ, first_name, last_name
	FROM customer
	UNION  
	SELECT 'actor' AS typ, first_name, last_name
	FROM actor 
) T
WHERE T.first_name REGEXP '^J' AND T.last_name REGEXP '^D'
GROUP BY T.first_name, T.last_name
HAVING COUNT(*) >= 2;

-- 서브쿼리로 작성하기(except) 
SELECT T.first_name, T.last_name
FROM (
	SELECT 'customer' AS typ, first_name, last_name
	FROM customer
	UNION  
	SELECT 'actor' AS typ, first_name, last_name
	FROM actor 
) T
WHERE T.first_name REGEXP '^J' AND T.last_name REGEXP '^D'
GROUP BY T.first_name, T.last_name
HAVING COUNT(*) = 1;


-- 실습하기 
-- 6.5.2 실습 6-2
SELECT A.first_name, A.last_name
FROM (
	SELECT first_name, last_name
	FROM customer
	UNION  
	SELECT first_name, last_name
	FROM actor
) A
WHERE last_name REGEXP '^L';

-- 6.5.3 실습 6-3
SELECT A.first_name, A.last_name
FROM (
	SELECT first_name, last_name
	FROM customer
	UNION  
	SELECT first_name, last_name
	FROM actor
) A
WHERE last_name REGEXP '^L'
ORDER BY A.last_name;















