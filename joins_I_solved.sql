USE SAKILA;

-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM store
    JOIN address ON store.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;
-- Write a query to display how much business, in dollars, each store brought in.
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
SELECT title, count(rental.rental_id) as most_rented
	FROM film
JOIN inventory on film.film_id = inventory.film_id
JOIN rental on inventory.inventory_id = rental.inventory_id
group by title
order by most_rented desc;

-- List the top five genres in gross revenue in descending order.
SELECT name, SUM(payment.amount) AS gross_rev 
	FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_rev DESC
LIMIT 5;
-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT title, store.store_id
	FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN staff ON rental.staff_id = staff.staff_id
JOIN store on staff.store_id = store.store_id
WHERE
    film.title = "Academy Dinosaur"
    AND store.store_id = 1;