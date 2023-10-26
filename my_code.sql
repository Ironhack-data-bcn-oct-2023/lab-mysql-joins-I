USE sakila;

-- 1 Display for each store its ID, city and country
SELECT store_id,
	   city,
       country
	FROM store
    JOIN address ON store.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;
    
-- 2
SELECT store.store_id,
       SUM(amount) AS business
	FROM store
    JOIN inventory ON store.store_id = inventory.store_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY store.store_id;


-- 3 average running time of films by category
SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category ON film.film_id = film_category.film_id
		JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name;
    
-- 4 Answers: Sports, Games, Foreign and Drama
SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category ON film.film_id = film_category.film_id
		JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name
    ORDER BY average_duration DESC;
    
-- 5
SELECT title,
	   COUNT(inventory.film_id) as times_rented
	FROM film
		JOIN inventory ON film.film_id = inventory.film_id
	GROUP BY title
	ORDER BY times_rented DESC;

    
-- 6 Answers: Sports, Sci-fi, Animation, Drama, Comedy
SELECT category.name,
	   SUM(amount) as gross_revenue
	FROM category
		JOIN film_category ON category.category_id = film_category.category_id
        JOIN film ON film_category.film_id = film.film_id
        JOIN inventory ON film.film_id = inventory.film_id
        JOIN rental ON inventory.inventory_id = rental.inventory_id
        JOIN payment ON rental.rental_id = payment.rental_id
    GROUP BY category.name
    ORDER BY gross_revenue DESC
    LIMIT 5;


-- 7
SELECT  rental.inventory_id,
        rental.rental_date,
        return_date
	FROM film
		JOIN inventory ON film.film_id = inventory.film_id
        JOIN rental ON inventory.inventory_ID = rental.inventory_id
	WHERE film.title = 'Academy Dinosaur' AND inventory.store_id = 1
    ORDER BY return_date ASC
    LIMIT 1;
-- Answers: return date = NULL -> not available


