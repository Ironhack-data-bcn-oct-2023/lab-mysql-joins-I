USE sakila;
-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country FROM store
	JOIN address
		ON store.address_id = address.address_id
	JOIN city
		ON address.city_id = city.city_id
	JOIN country
		ON city.country_id = country.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT SUM(amount) AS business_in_dollars, store.store_id FROM payment
	JOIN staff
		ON payment.staff_id = staff.staff_id
	JOIN store
		ON staff.store_id = store.store_id
	GROUP BY store.store_id;

-- What is the average running time of films by category?
SELECT AVG(length) AS average_length, name FROM film
	JOIN film_category
		ON film.film_id = film_category.film_id
	JOIN category
		ON film_category.category_id = category.category_id
	GROUP BY film_category.category_id;
    
-- Which film categories are longest?
SELECT AVG(length) AS average_length, name FROM film
	JOIN film_category
		ON film.film_id = film_category.film_id
	JOIN category
		ON film_category.category_id = category.category_id
	GROUP BY film_category.category_id
    ORDER BY average_length DESC; -- Sports, Games and Foreign

-- Display the most frequently rented movies in descending order.
SELECT COUNT(film.film_id) AS frequency, title FROM film
	JOIN inventory
		ON film.film_id = inventory.film_id
	JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	GROUP BY film.film_id
    ORDER BY frequency DESC;

-- List the top five genres in gross revenue in descending order.
SELECT SUM(amount) AS revenue, category.name FROM payment
	JOIN rental
		ON payment.rental_id = rental.rental_ID
	JOIN inventory
		ON rental.inventory_id = inventory.inventory_id
	JOIN film
		ON inventory.film_id = film.film_id
	JOIN film_category
		ON film.film_id = film_category.film_id
	JOIN category
		ON film_category.category_id = category.category_id
	GROUP BY category.name
    ORDER BY revenue DESC;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT * FROM store
	JOIN inventory
		ON store.store_id = inventory.store_id
	JOIN film
		ON inventory.film_id = film.film_id
	WHERE title = "Academy Dinosaur" AND store.store_id = 1; -- It's available 4 times