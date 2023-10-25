-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM country
JOIN city ON country.country_id=city.country_id
JOIN address ON city.city_id=address.city_id
JOIN store ON address.address_id=store.address_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(payment.amount) AS business
FROM payment
JOIN staff ON payment.staff_id=staff.staff_id
JOIN store ON staff.store_id=store.store_id
GROUP BY store.store_id;

-- 3. What is the average running time of films by category?
SELECT category.name, AVG(film.length) AS running_time
FROM film
JOIN film_category ON film.film_id=film_category.film_id
JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name;

-- 4. Which film categories are longest?
SELECT category.name, AVG(film.length) AS running_time
FROM film
JOIN film_category ON film.film_id=film_category.film_id
JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name
ORDER BY running_time DESC
LIMIT 5;

-- 5. Display the most frequently rented movies in descending order.
SELECT film.title, rental.rental_date
FROM rental
JOIN inventory ON rental.inventory_id=inventory.inventory_id
JOIN film ON inventory.film_id=film.film_id
ORDER BY rental_date DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT category.name, SUM(payment.amount) as gross_revenue
FROM payment
JOIN rental ON payment.rental_id=rental.rental_id
JOIN inventory ON rental.inventory_id=inventory.inventory_id
JOIN film ON inventory.film_id=film.film_id
JOIN film_category ON film.film_id=film_category.film_id
JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT SUM(store.store_id) as num_available
FROM store
JOIN inventory ON store.store_id=inventory.store_id
JOIN film ON inventory.film_id=film.film_id
WHERE film.title = "Academy Dinosaur"
AND store.store_id = 1