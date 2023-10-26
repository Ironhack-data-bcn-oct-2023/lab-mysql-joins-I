-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city.city, country.country
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

-- 5. Display the most frequently rented movies in descending order.
SELECT inventory_id, rental_id, film_id, title
FROM (
  SELECT inventory_id, COUNT(*) AS count
  FROM rental
  GROUP BY inventory_id
  ORDER BY count DESC
) 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;

-- 6. List the top five genres in gross revenue in descending order.

-- 7. Is "Academy Dinosaur" available for rent from Store 1?