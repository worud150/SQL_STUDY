CREATE TABLE t_deal(
	id INT UNSIGNED AUTO_INCREMENT,
	deal_date DATE NOT NULL,
	price INT UNSIGNED NOT NULL,
	PRIMARY KEY (id)
);

-- 테이블을 수정하겠다.
ALTER TABLE t_deal MODIFY price INT NOT NULL DEFAULT 0;



CREATE TABLE t_provider(
	cd CHAR(1) PRIMARY KEY,
	nm VARCHAR(10) NOT NULL
);

CREATE TABLE t_parts(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nm VARCHAR(10) NOT NULL,
	price INT UNSIGNED NOT NULL	
);

CREATE TABLE t_deal_sub(
	deal_id INT UNSIGNED,
	seq INT UNSIGNED,
	provider_cd CHAR(1) NOT NULL,
	parts_id INT UNSIGNED NOT NULL,
	quantity INT UNSIGNED NOT NULL,
	PRIMARY KEY(deal_id, seq),
	FOREIGN KEY (provider_cd) REFERENCES t_provider (cd),
	FOREIGN KEY (parts_id) REFERENCES t_parts (id),
	FOREIGN KEY (deal_id) REFERENCES t_deal (id)
);

-- 공급자 테이블, 부품 테이블 데이터 입력
INSERT INTO t_provider 
(cd, nm)
VALUES
('A', '알파'),
('B', '브라보'),
('C', '찰리');

INSERT INTO t_parts 
(nm, price)
VALUES 
('모니터', 200000),
('키보드', 30000),
('마우스', 10000);
 
SELECT *
FROM t_parts;

SELECT *
FROM t_provider;

INSERT INTO t_deal
(deal_date)
VALUES 
('2023-10-20'),
('2023-10-20'),
('2023-10-22');

INSERT INTO t_deal_sub
(deal_id, seq, provider_cd, parts_id, quantity)
VALUES 
(1,1,'A',1,10),
(1,2,'B',3,10),
(1,3,'C',2,10),

(2,1,'A',1,20),
(2,2,'B',3,10),

(3,1,'A',3,30),
(3,2,'C',2,5);

-- 고급 업데이트문 
UPDATE t_deal A
INNER JOIN (
	SELECT deal_id, SUM(A.quantity *  C.price) total_price
	FROM t_deal_sub A
	INNER JOIN t_parts C
	ON A.parts_id = C.id
	GROUP BY deal_id
) B
ON A.id = B.deal_id
SET A.price = B.total_price;

SELECT * -- 날짜 총합금액 
FROM t_deal;

SELECT * -- 전표번호 일련번호 
FROM t_deal_sub;

SELECT * -- 제품 / 단가
FROM t_parts;

SELECT * -- abc / 알파
FROM t_provider;


-- 전체 출력하기
SELECT A.deal_id `전표번호`, date_format(B.deal_date, '%m월 - %d일') `날짜`, C.cd `공급자`, C.nm `공급자명`
, D.nm `부품명`, D.price `단가`, A.quantity `수량`, A.quantity * D.price `금액` 
FROM t_deal_sub A
INNER JOIN t_deal B
ON A.deal_id = B.id
INNER JOIN t_provider C
ON A.provider_cd = C.cd
INNER JOIN t_parts D
ON A.parts_id = D.id
ORDER BY B.id, C.cd;

