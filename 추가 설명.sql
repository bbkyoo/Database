DROP DATABASE IF EXISTS sqldb; -- 만약 sqldb가 존재하면 우선 삭제한다.
CREATE DATABASE sqldb;

USE sqldb;
CREATE TABLE usertbl -- 회원 테이블
( userID   	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
  -- CONSTRAINT PRIMARY KEY PK_userTBL_userID (userID)
);
CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
   -- CONSTRAINT FK_usertbl_buytbl FOREIGN KEY(userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl ()VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;

-- CONSTRAINT --------------------------------------------------
DROP TABLE IF EXISTS memberTBL, prodTBL;

USE sqldb;
CREATE TABLE memberTBL (SELECT userID, name, addr FROM usertbl LIMIT 3); -- 3건만 가져옴
SHOW INDEX FROM userTBL;
SHOW INDEX FROM memberTBL;

ALTER TABLE memberTBL 
	ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID); -- PK를 지정함
    
SELECT * FROM memberTBL;
SHOW INDEX FROM memberTBL;


CREATE TABLE prodTBL (SELECT * FROM buyTBL LIMIT 0); -- 0건만 가져옴
SELECT * FROM prodTBL;
SHOW INDEX FROM buyTBL;
SHOW INDEX FROM prodTBL;

ALTER TABLE prodTBL 
	ADD CONSTRAINT pk_prodTBL PRIMARY KEY (num); -- PK를 지정함

ALTER TABLE prodTBL
    ADD CONSTRAINT FK_membertbl_prodtbl 
    FOREIGN KEY (userID) 
    REFERENCES memberTBL(userID);

/*
ALTER TABLE prodTBL
    ADD CONSTRAINT FK_membertbl_prodtbl 
    FOREIGN KEY (userID) 
    REFERENCES memberTBL(userID)
    ON DELETE CASCADE; -- prodTBL의 값이 삭제되면 memberTBL 값이 함께 적용된다
    
ALTER TABLE prodTBL
    ADD CONSTRAINT FK_membertbl_prodtbl 
    FOREIGN KEY (userID) 
    REFERENCES memberTBL(userID)
    ON UPDATE CASCADE; -- prodTBL의 값이 수정되면 memberTBL 값이 함께 적용된다
*/

SHOW INDEX FROM usertbl;
SHOW INDEX FROM membertbl;
SHOW INDEX FROM buytbl;
SHOW INDEX FROM prodtbl;

-- INSERT vs INSERT IGNORE vs INSERT INTO ~ ON DUPLICATE KEY UPDATE

INSERT INTO memberTBL VALUES('BBK' , '비비코', '미국');
INSERT INTO memberTBL VALUES('SJH' , '서장훈', '서울');
INSERT INTO memberTBL VALUES('HJY' , '현주엽', '경기');
SELECT * FROM memberTBL;

INSERT IGNORE INTO memberTBL VALUES('BBK' , '비비코', '미국');
INSERT IGNORE INTO memberTBL VALUES('SJH' , '서장훈', '서울');
INSERT IGNORE INTO memberTBL VALUES('HJY' , '현주엽', '경기');
SELECT * FROM memberTBL;

SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES('BBK' , '비비코', '미국')
	ON DUPLICATE KEY UPDATE name='비비코', addr='미국';
    
INSERT INTO memberTBL VALUES('DJM' , '동짜몽', '일본')
	ON DUPLICATE KEY UPDATE name='동짜몽', addr='일본';
SELECT * FROM memberTBL;

UPDATE memberTBL SET userID = 'BBK',
	name = '비비코', 
	addr = '미국'
    WHERE userID = 'BBK';

