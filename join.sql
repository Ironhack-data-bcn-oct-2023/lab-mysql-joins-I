USE sakila;

-- Write a query to display for each store its store ID, city, and country.

select store_ID, city, country
from store
JOIN address
on store.address_ID = address.address_ID
join city
on address.city_ID = city.city_ID
join country
on city.country_ID = country.country_ID
GROUP BY store_ID

-- Write a query to display how much business, in dollars, each store brought in.

select store.store_ID, SUM(amount) as business
	from store
		JOIN inventory
			on store.store_ID = inventory.store_ID
		join rental
			on inventory.inventory_id = rental.inventory_id
		join payment
			on rental.rental_ID = payment.rental_ID
GROUP BY store.store_ID



-- What is the average running time of films by category?


SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category
			ON film.film_id = film_category.film_id
		JOIN category
			ON film_category.category_id = category.category_id
	GROUP BY category.name;


-- Which film categories are longest?

SELECT category.name,
	   AVG(length) as average_duration
	FROM film
		JOIN film_category ON film.film_id = film_category.film_id
		JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name
    ORDER BY average_duration DESC;

-- Display the most frequently rented movies in descending order.

SELECT film.title AS movie_title,
COUNT(rental.rental_id) AS rental_count
	FROM film
		JOIN inventory
			ON film.film_id = inventory.film_id
		JOIN rental
			ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY rental_count DESC;

-- List the top five genres in gross revenue in descending order.

SELECT category.name AS genre, SUM(payment.amount) AS total_revenue
	FROM category
		JOIN film_category
			ON category.category_id = film_category.category_id
		JOIN film
			ON film_category.film_id = film.film_id
		JOIN inventory
			ON film.film_id = inventory.film_id
		JOIN rental
			ON inventory.inventory_id = rental.inventory_id
		JOIN payment
			ON rental.rental_id = payment.rental_id
GROUP BY category.category_id
ORDER BY total_revenue DESC
LIMIT 5;



-- Is "Academy Dinosaur" available for rent from Store 1?

SELECT
    CASE
        WHEN COUNT(*) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM inventory AS i
	JOIN film AS f ON i.film_id = f.film_id
	JOIN store AS s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur'
AND s.store_id = 1;
