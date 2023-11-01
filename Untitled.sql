USE SAKILA;
-- 1
SELECT store_id, city, country
FROM store
	JOIN address ON store.address_id = address.address_id 
	JOIN city ON address.city_id = city.city_id
	JOIN country ON country.country_id = city.country_id;
    
-- 2
SELECT amount AS business, store.store_id
FROM payment
	JOIN staff ON payment.staff_id = staff.staff_id 
	JOIN store ON staff.store_id = store.store_id;
        
-- 3
SELECT AVG(length) AS running_time,category.name
FROM film
	JOIN film_category ON film.film_id = film_category.film_id
	JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name;
-- 4
SELECT max(length) AS max_length,category.name
FROM film
	JOIN film_category ON film.film_id = film_category.film_id
	JOIN category ON film_category.category_id = category.category_id
	GROUP BY category.name
    ORDER BY max_length DESC;
        
        
-- 5
SELECT COUNT(rental_id),film.title 
FROM rental
	JOIN inventory ON inventory.inventory_id = rental.inventory_id
	JOIN film ON film.film_id = inventory.film_id
group by film.title
ORDER BY COUNT(rental_id) DESC;

-- 6
SELECT category.name AS genre, SUM(payment.amount) as gross_revenue
FROM category
	JOIN film_category ON film_category.category_id = category.category_id
	JOIN film ON film.film_id = film_category.film_id
	JOIN inventory ON inventory.film_id = film.film_id
	JOIN  rental ON inventory.inventory_id = rental.inventory_id
	JOIN payment ON payment.rental_id = rental.rental_id
	group by genre
    ORDER BY gross_revenue DESC
    LIMIT 5;

-- 7

SELECT title, count(inventory.film_id)
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
WHERE  title = "Academy Dinosaur" AND store.store_id = 1;