USE SAKILA; 

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city.city, country.country
FROM store
JOIN ADDRESS ON	STORE.ADDRESS_ID = ADDRESS.ADDRESS_ID
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, sum(payment.amount) as revenue
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store_id ;


-- 3. What is the average running time of films by category?
SELECT category.name, avg(film.length) as average_runtime
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- 4. Which film categories are longest?
SELECT category.name, avg(film.length) as average_runtime
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY average_runtime DESC
LIMIT 5; 

-- 5. Display the most frequently rented movies in descending order.
SELECT film.title, COUNT(rental_id) as rental_frequency 
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_frequency DESC;


-- 6. List the top five genres in gross revenue in descending order.
SELECT category.name, sum(payment.amount) as gross 
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment on rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross DESC
LIMIT 5;


