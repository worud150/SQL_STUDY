/*
주석처리이렇게
-- 혹은이렇게
*/
CREATE TABLE t_test(
	id BIGINT UNSIGNED AUTO_INCREMENT
	,nm VARCHAR(100) NOT NULL
	,jumin CHAR(9) NOT NULL
	,age INT NOT NULL
	,addr VARCHAR (200)
	,created_at DATETIME DEFAULT NOW()
	,PRIMARY KEY(id)
);

DROP TABLE t_test;

INSERT INTO t_test
(nm, jumin, age, addr)
VALUES
('홍길동','987654321','11','서울시');

INSERT t_test
SET nm = '강감찬', jumin = '970605123',age = 98, addr = '경북';

UPDATE t_test
SET age = 22, addr = '부산시'
WHERE id = 4;

-- read
-- *이건 all의 의미를 가짐
SELECT * FROM t_test;

SELECT nm, jumin FROM t_test;

SELECT nm, jumin AS '주민번호' FROM t_test;

SELECT * 
from t_test
WHERE nm = '홍길동';

SELECT * FROM t_test
WHERE nm = '신사임당'
AND age > 27;

SELECT * FROM t_test
WHERE age IN (25,27);

SELECT * FROM t_test
WHERE age BETWEEN 27 AND 30;

SELECT * FROM t_test
WHERE nm LIKE '홍%동';


-- update

UPDATE t_test
SET nm = '유관순'
WHERE id = 2;

UPDATE t_test
SET age = 22, addr = '부산시'
WHERE id = 4;


-- delete

DELETE FROM t_test
WHERE id = 4;