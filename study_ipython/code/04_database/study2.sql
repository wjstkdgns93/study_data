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
having SUM(population)>500000000