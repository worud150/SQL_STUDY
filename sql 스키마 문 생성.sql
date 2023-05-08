CREATE DATABASE exam;
DROP TABLE favorite_food;

CREATE TABLE person(
	person_id INT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	eye_color CHAR(2) CHECK (eye_color IN ('BR','BL','GR')),
	-- eye_color CHAR(2) ENUM ('BR','BL','GR'),
	birth_date DATE,
	street VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(20),
	PRIMARY KEY(person_id)
);

CREATE TABLE favorite_food (
	person_id INT UNSIGNED
	, food VARCHAR (20)
	, PRIMARY KEY(person_id, food)
	, FOREIGN KEY (person_id) REFERENCES person (person_id)
);


-- CRUD

INSERT INTO person 
(
	person_id, fname, lname, birth_date, eye_color
)
VALUES
(
	1, 'william', 'Turner', '1972-05-27', 'BR'
);

SELECT *
FROM person;

INSERT INTO favorite_food 
(
	person_id, food
)
VALUES
(
	1, 'pizza' 
);

INSERT INTO favorite_food 
(
	person_id, food
)
VALUES
(
	1, 'cookies'
);

INSERT INTO favorite_food 
(
	person_id, food
)
VALUES
(
	1, 'nachos'
);

DELETE FROM favorite_food; -- 전체삭제가 가능하다.
TRUNCATE favorite_food; -- 속도가 더 빠름
-- 오라클은 사용이 불가능하고 mysql만 한꺼번에 작성이 가능하다.
INSERT INTO favorite_food 
(person_id, food)
VALUES
(1, 'pizza'),
(1, 'cookies'),
(1, 'nachos');

SELECT * FROM favorite_food
FOR XML auto;

-- update문 (수정문)

UPDATE person
SET fname = '윌리엄'
,lname = '터너'
,country = '대한미국'
WHERE person_id = 1;

UPDATE person
SET birth_date = STR_TO_DATE ('DEC-21-1980', '%b-%d-%Y')
WHERE person_id = 1;

SELECT STR_TO_DATE ('DEC-21-1980', '%b-%d-%Y');

SELECT * FROM person;

INSERT INTO person
SET person_id = 2,
fname = '재경',
lname = '김',
birth_date = '1997-06-05',
eye_color = 'GR';

INSERT INTO person
SET person_id = 3,
fname = '규진',
lname = '남',
birth_date = '1999-08-17',
eye_color = 'BR';

INSERT INTO favorite_food 
(person_id, food)
VALUES
(3, 'nachos');







