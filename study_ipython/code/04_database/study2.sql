# Server - Database - Table

#1. 데이터 베이스
#SHOW DATABASES; #현재 데이터 베이스 확인
# 생성
CREATE DATABASE test;
#선택
USE test;
#현재 확인
SELECT DATABASE();

#2. 수정 alter
ALTER DATABASE `test` COLLATE 'utf8_bin'; ALTER TABLE user2 ADD tmp TEXT; CHANGE COLUMN `tmp` `tmp` INT(3) NULL DEFAULT NULL AFTER `rdate`;
CREATE DATABASE tmp;
DROP DATABASE tmp; SHOW DATABASES;
INSERT INTO user1(user_id, name, email, age, rdate) VALUES (1, "jin", "pdj@gmail.com", 30, NOW()),
(2, "peter", "peter@daum.net", 33, '2017-02-20'),
(3, "alice", "alice@naver.com", 23, '2018-01-05'),
(4, "po", "po@gmail.com", 43, '2002-09-16'),
(5, "andy", "andy@gmail.com", 17, '2016-04-28'),
(6, "jin", "jin1224@gmail.com", 33, '2013-09-02');
SELECT user_id, NAME, age
FROM user1;
SELECT user_id AS "ID", NAME AS "UserName", age AS "AGES"
FROM user1;

#where 조건검색
SELECT *
FROM user1
WHERE age !=30;
SELECT *
FROM user1
WHERE age>20 AND age<40;
SELECT DISTINCT(NAME)
FROM user1
WHERE age BETWEEN 20 AND 39
ORDER BY NAME DESC;

#concat
SELECT NAME, age, CONCAT(NAME,"(",age,")") AS "name_age"
FROM user1;

#like : where 절에서 특정 문자열이 들어간 데이터 조회
SELECT *
FROM user1;
WHERE email LIKE "p%";

#in : 여러개의 조건을 조회할때 사용
SELECT *
FROM user1
WHERE name IN ("andy","peter", "po");

#limit :
SELECT *
FROM user1
LIMIT 3;

#limit
SELECT *
FROM user1
LIMIT 3, 5;

# update
UPDATE user1 SET age=20
WHERE age BETWEEN 20 AND 29;

#delete
DELETE
FROM user1
WHERE age BETWEEN 20 AND 29;
SELECT *
FROM user1; USE world;
SELECT DISTINCT(Continent)
FROM country;
SELECT NAME, Population
FROM city
WHERE CountryCode = "KOR" AND Population >= 1000000
ORDER BY Population DESC;
SELECT NAME, CountryCode, Population
FROM city
WHERE Population BETWEEN 8000000 AND 10000000
ORDER BY Population DESC;
SELECT CODE, CONCAT(NAME,"(", IndepYear,")"), Continent, Population
FROM country
WHERE IndepYear BETWEEN 1940 AND 1950
ORDER BY IndepYear;
SELECT CountryCode, LANGUAGE, Percentage
FROM countrylanguage
WHERE LANGUAGE IN ("English","Korean","Spanish") AND Percentage >= 95
ORDER BY Percentage DESC;
SELECT CODE, NAME,Continent, GovernmentForm, Population
WHERE Code LIKE "A%" AND GovernmentForm LIKE "%Republic%";

#city 테이블에서 나라별 도시의 갯수를 출력
SELECT CountryCode, COUNT(CountryCode) AS COUNT
FROM city
GROUP BY CountryCode;
SELECT COUNT(DISTINCT(LANGUAGE))
FROM countrylanguage;

#대륙별 인구수와 GNP의 최대값을 출력
SELECT continent, SUM(population), SUM(GNP), SUM(GNP)/ SUM(population)
FROM country
GROUP BY continent;

#대륙별 전체인구를 구하고 5억 이상인 대륙만 출력
#having : group by가 실행되고 난 결과에 조건을 추가
SELECT continent, SUM(population)
FROM country
GROUP BY continent
having SUM(population)>500000000;

#소숫점 올림, 반올림, 버림 함수
SELECT CEIL(12.345);
SELECT round(12.345);
SELECT truncate(12.345,0);

#if: if(조건,참,거짓)
#도시의 인구가100만이상 bigcity, 이하 small city출력
#column : city_scale
SELECT NAME,population
,if(population >=1000000,"big city","small city")
AS city_scale
FROM city;

#ifnull :ifunll(참,거짓)
#country 테이블에서 독립년도 가 없으면 0으로 출력
SELECT NAME, IFNULL(IndepYear,0) AS IndepYear
FROM country;

#case
#case
#	when(조건1) then(출력1)
#	when(조건2) then(출력2)
#end as (컬럼명)

#나라별 10억이상, 1억이상,1억이하조건을 출력
SELECT NAME,population
CASE
	when population > 1000000000 then "upper 1 bilion"
	when population > 100000000 then "upper 100 milion"
	ELSE " below 100 milion"
END AS result
FROM country;

USE sakila

#paymont 에서 월별 총 매출 출력
SELECT DATE_FORMAT(payment_date, "%Y-%m") AS monthly
,COUNT(amount),SUM(amount)
FROM payment
GROUP BY monthly;

CREATE TABLE user (
	user_id int(11) unsigned NOT NULL AUTO_INCREMENT,
	name varchar(30) DEFAULT NULL,
	PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE addr (
  	id int(11) unsigned NOT NULL AUTO_INCREMENT,
  	addr varchar(30) DEFAULT NULL,
	user_id int(11) DEFAULT NULL,
  	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO user(name)
VALUES ("jin"),
("po"),
("alice"),
("petter");

INSERT INTO addr(addr, user_id)
VALUES ("seoul", 1),
("pusan", 2),
("deajeon", 3),
("deagu", 5),
("seoul", 6); 

#inner join
SELECT addr.addr , addr.user_id,user.name
FROM addr
JOIN user
ON addr.user_id = user.user_id;

#world 도시이름, 국가이름을 출력
SELECT country.name AS city_name, city.name AS country_name
FROM city
JOIN country
ON city.CountryCode = country.code;

#left join
SELECT id, user.name, addr.addr
FROM user 
LEFT JOIN addr
ON user.user_id = addr.user_id;

#right join
SELECT id, user.name, addr.addr
FROM user 
RIGHT JOIN addr
ON user.user_id = addr.user_id;

#union : select 문의 결과를 합쳐서 출력
#자동으로 중복 제거
SELECT name
FROM user
UNION all
SELECT addr
FROM addr;

#outer join
SELECT id, user.name, addr.addr
FROM user 
LEFT JOIN addr
ON user.user_id = addr.user_id
UNION
SELECT id, user.name, addr.addr
FROM user 
RIGHT JOIN addr
ON user.user_id = addr.user_id;

#sub-query : 쿼리문안에 쿼리가 있는 문법
#select,from ,where
#전체 나라수, 전체 도시수, 전체 언어수를 출력
SELECT(
SELECT COUNT(*)
FROM country)AS total_country,
(SELECT COUNT(*)
FROM city) AS total_city,
(SELECT COUNT(DISTINCT(LANGUAGE))
FROM countrylanguage) AS total_language;

#800만 이상이 되는 도시의 국가 코드, 국가 이름 ,도시 이름, 도시인구수를 출력

SELECT *
FROM
(sELECT countrycode, NAME, population
FROM city
WHERE population >= 8000000) AS city
JOIN
(SELECT CODE,NAME
FROM country) AS country
ON city.countrycode = country.Code;

#800만 이상 도시의 국가코드,국가이름,대통령 이름 출력

SELECT CODE,NAME, HeadOfState
FROM country
WHERE CODE IN(
SELECT distinct(countrycode)
FROM city
WHERE population >= 8000000
);

#index : 데이터를 검색할때 빠르게 찾을수 있도록 해주는 기능
USE employees;

explain
SELECT COUNT(*)
FROM salaries
WHERE to_date > "2000-01-01";


CREATE INDEX tdate
ON salaries (to_date);

DROP index tdate
ON salaries;

#view : 특정 쿼리문에 대한 결과를 저장하는 개념
USE world;

CREATE VIEW code_name AS
SELECT code, name
FROM country;

SELECT *
FROM city
JOIN code_name
# ( SELECT code, name
#    FROM country)as code_name
ON city.CountryCode = code_name.code;

