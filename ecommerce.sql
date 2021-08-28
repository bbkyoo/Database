CREATE DATABASE ecommerce;
USE ecommerce;
SHOW DATABASES;

DROP TABLE IF EXISTS product;
CREATE TABLE product(
	product_code VARCHAR(20) NOT NULL,
	title VARCHAR(200) NOT NULL,
	ori_price INT,
	discount_price INT,
	discount_percent INT,
    delivery VARCHAR(2),
	PRIMARY KEY(product_code)
);
DESC product;
SELECT * FROM product;

CREATE TABLE ranking(
	id INT UNSIGNED AUTO_INCREMENT NOT NULL  PRIMARY KEY,
	category VARCHAR(50),
	subcategory VARCHAR(50),
	ranking INT,
	product_code VARCHAR(20)
);
SELECT * FROM ranking;

INSERT INTO product VALUES(
"962002144", "(씨투엠에듀 도형학습지 플라토 유치~초등 단계별 선택구매(전4권)", 48000, 24000, 50, "F");

SELECT * FROM product;
DELETE FROM product;
DROP TABLE product;