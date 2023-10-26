USE SAKILA;

-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM store
    JOIN address ON store.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;
    
SELECT store.store_id,
       SUM(amount) AS business
	FROM store
    JOIN inventory ON store.store_id = inventory.store_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY store.store_id;
-- What is the average running time of films by category?
SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category ON film.film_id = film_category.film_id
		JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name;

-- Display the most frequently rented movies in descending order.

-- List the top five genres in gross revenue in descending order.
SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category ON film.film_id = film_category.film_id
		JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name
    ORDER BY average_duration DESC
LIMIT 10;
-- Is "Academy Dinosaur" available for rent from Store 1?