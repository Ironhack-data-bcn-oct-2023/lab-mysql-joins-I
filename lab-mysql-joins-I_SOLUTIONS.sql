USE Sakila;
Select * FROM Store;
 -- 1. Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country FROM store
	JOIN address ON store.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;
    
-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, sum(amount) as Business
	FROM store
	JOIN staff ON store.store_id = staff.store_id
    JOIN Payment ON staff.staff_id = payment.staff_id
    GROUP BY store.store_id;
    
-- 3. What is the average running time of films by category?

SELECT film_category.category_id, avg(length) AS avg_running_time
	FROM film
	JOIN film_category ON film.film_id = film_category.film_id
    GROUP BY category_id;
    
-- 4. Which film categories are longest?

SELECT film_category.category_id, avg(length) AS avg_running_time
	FROM film
	JOIN film_category ON film.film_id = film_category.film_id
	GROUP BY category_id
		ORDER BY avg_running_time DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT COUNT(rental_id) as Rental_Count, film.title as Most_frequentrly_rented_movies
	FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    GROUP BY title
		ORDER BY Rental_Count DESC
        LIMIT 8;
        
-- 6. List the top five genres in gross revenue in descending order.

select category.name as Genre, sum(payment.amount) as gross_rev
	from film 
		join film_category on film.film_id = film_category.film_id
        join category on film_category.category_id = category.category_id
		join inventory on film.film_id = inventory.film_id
		join rental on inventory.inventory_id = rental.inventory_id
		join payment on rental.rental_id = payment.rental_id
	group by genre 
    order by gross_rev desc limit 5;
    
-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT title, store_id, COUNT(title) AS availability
	FROM film
		JOIN inventory  ON film.film_id = inventory.film_id
	WHERE film.title = 'Academy Dinosaur' AND inventory.store_id = 1;


    