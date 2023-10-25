USE sakila;
SET SQL_SAFE_UPDATES = 0;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city,country
	FROM store
    JOIN address ON store.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id,
       SUM(amount) AS business
	FROM store
    JOIN inventory ON store.store_id = inventory.store_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY store.store_id;
    
-- 3. What is the average running time of films by category?
SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category ON film.film_id = film_category.film_id
		JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name;

-- 4. Which film categories are longest?
SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category ON film.film_id = film_category.film_id
		JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name
    ORDER BY average_duration DESC;
    -- Answers: Sports, Games, Foreign and Drama

-- 5. Display the most frequently rented movies in descending order.
SELECT inventory.film_id, film.title, COUNT(*) rental_count
	FROM rental
		JOIN inventory ON rental.inventory_id = inventory.inventory_id
		JOIN film ON inventory.film_id = film.film_id
    GROUP BY inventory.film_id, film.title
    ORDER BY rental_count DESC;
    -- Asnwer: Bucket Brotherhood, Rocketter Mother, Forward Temple, Grit Clockwork, Juggler Hardly

-- 6. List the top five genres in gross revenue in descending order.
SELECT category.name AS genre,
    SUM(payment.amount) AS gross_revenue
FROM film
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;
	-- Answer: Sports, Sci-Fi, Animation, Drama, Comedy

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT film.title AS title,
	CASE
		WHEN rental.rental_id = 1 THEN "Available"
		ELSE "Not available"
	END AS availability
    FROM film
		JOIN inventory ON film.film_id = inventory.film_id
        LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
	WHERE film.title = "Academy Dinosaur";
    