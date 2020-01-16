USE world;


SELECT city.countrycode,city.name,city.population,cl.language_count,cl.languages
FROM(
SELECT countrycode,COUNT(language) AS language_count , GROUP_CONCAT(LANGUAGE) AS languages
FROM countrylanguage
GROUP BY countrycode
HAVING language_count <= 3
) AS cl
JOIN (
SELECT countrycode, NAME,population
FROM city
WHERE population > 3000000
)AS city
ON cl.countrycode = city.countrycode
;

SELECT payment.amount, category.name
FROM payment, rental, inventory, film_category, category
WHERE 
	category.category_id = film_category.category_id
	AND film_category.film_id = inventory.film_id
	AND inventory.inventory_id = rental.inventory_id
	AND rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY amount DESC;
	