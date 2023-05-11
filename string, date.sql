-- 문자열 생성 

CREATE TABLE string_tbl (
	char_fld CHAR(30),
	vchar_fld VARCHAR(30),
	text_fld text
);

INSERT INTO string_tbl
(char_fld, vchar_fld, text_fld)
VALUES
(
	'This is char data',
	'This is varchar data',
	'This is text data'
);

SELECT *, QUOTE (text_fld)
FROM string_tbl;

UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremly long varchar data';

SELECT @@SESSION.sql_mode;

SET sql_mode = 'strict';

SHOW WARNINGS;

-- 중간에 홑따움표 작성하기
UPDATE string_tbl
SET text_fld = 'This string didn\'t work, but it does now';

UPDATE string_tbl
SET text_fld = 'This string didn''t work, but it does now';

-- \이거까지 출력할때는 QUOTE 함수 사용 
UPDATE string_tbl
SET text_fld = 'This s\'tring didn''t work, but it does now';

SELECT lname, fname, CONCAT (lname, ' ', fname) '띄어쓰기'
FROM person;


-- 숫자를 반환하는 문자열 함수
SELECT lname, CHAR_LENGTH (lname)
FROM person;

SELECT fname, POSITION('경' IN fname)
FROM person;

SELECT *
FROM string_tbl;

SELECT text_fld, POSITION('n' IN text_fld), LOCATE ('n',text_fld, 18)
FROM string_tbl;

SELECT '안녕' = '안녕', 'abc' = 'Abc', 'abc' = 'cba', -- 1이나오면 true
STRCMP ('abc','ABC'), -- 0이 나오면 true
STRCMP ('abc','cba'); -- 1이 나오면 false


SELECT 
NAME, 
NAME LIKE '%y',
NAME REGEXP '^[C]'
FROM category;

SELECT first_name, REPLACE (first_name,'BA', 'DA')
FROM customer
WHERE first_name LIKE '%BA%' ;

-- first_name 에서 PH > TH로 바꾸고, NI > NA로 바꾸기
SELECT first_name, customer_id,
REPLACE(REPLACE (first_name, 'PH','TH'),'NI','NA')
FROM customer
WHERE customer_id = 41;

-- 문자열 사이에 값 삽입하기
SELECT 'goodbye world', 
INSERT ('goodbye world',9,0,'cruel ');

-- 영화제목 빈칸에 nice 추가하기
SELECT title, INSERT (title, POSITION(' ' IN title), 0, ' NICE')
FROM film;

-- 문자열 자르기
SELECT email, 
SUBSTRING(email,3,6), 
SUBSTR(email,3,6), 
SUBSTRING(email,1) -- 3번자리 부터 끝까지
FROM customer;

SELECT email, 
LEFT(email, POSITION('@' IN email) - 1),
RIGHT(email, CHAR_LENGTH(email) - POSITION('@' IN email))
FROM customer;

-- 연산 가능
SELECT (38 * 59) / (78 - (8 * 6));

SELECT MOD (9,2);

SELECT 
TRUNCATE (1123.3456, 2), 
ABS(-10), 
ABS(10);

-- 날짜 함수 사용하기
SELECT NOW(), CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

SELECT CAST('2023-05-11 16:46:58' AS DATETIME),
CONVERT ('2023-05-11 17:45:00', DATETIME);

SELECT date_add(CURRENT_DATE(), INTERVAL 500 DAY); -- 디데이계산에 용이하다.
SELECT DATE_ADD(NOW(), INTERVAL '03:27:11' HOUR_SECOND); -- 몇시간 후 출력


SELECT * 
FROM employees
WHERE emp_no = 10001;

UPDATE employees
SET birth_date = DATE_ADD(birth_date, INTERVAL'2-1' YEAR_MONTH)
WHERE emp_no = 10001;

SELECT CURDATE(), SYSDATE(), WEEKDAY (NOW());

SELECT 
CURDATE(),
DAYNAME(NOW()),
WEEKDAY (NOW()), -- 월(0) ~ 일(6)
LAST_DAY(NOW()), -- 그달의 마지막 일 
LAST_DAY('2023-06-11'),
DATE_SUB(NOW(),INTERVAL '2' YEAR),-- 날짜 뺴기 
EXTRACT(YEAR FROM NOW()),
DATEDIFF('2023-09-20', NOW()); 






























