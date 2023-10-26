 USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.


SELECT store_id as store_id, city, country
	FROM STORE
		JOIN ADDRESS
			ON store.address_id = address.address_id
		JOIN CITY
			ON address.city_id = city.city_id
		JOIN COUNTRY
			ON city.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, sum(amount) as business
	from store
		join staff
			on store.store_id = staff.store_id
		join payment
			on staff.staff_id = payment.staff_id
	group by store.store_id;

-- Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'sakila.store.store_id'; this is incompatible with sql_mode=only_full_group_by	0.0012 sec

-- 3. What is the average running time of films by category?

SELECT name, avg(length) as Avg_length
	from film
    join film_category
    on film.film_id = film_category.film_id
    join category
    on film_category.category_id = category.category_id
    group by name;
    

-- 4 Which film categories are longest?

SELECT name, max(length) as Avg_length
	from film
    join film_category
    on film.film_id = film_category.film_id
    join category
    on film_category.category_id = category.category_id
    group by name
    limit 5;
    
-- 5. Display the most frequently rented movies in descending order.

SELECT title, rental_id
	FROM film
    JOIN inventory
		ON film.film_id = inventory.film_id
	JOIN rental
		ON inventory.inventory_id = rental.inventory_id
Group by title;

-- 6. List the top five genres in gross revenue in descending order.

SELECT name as category, sum(amount)
from category
join film_category
on category.category_id = film_category.category_id
join film
on film_category.film_id = film.film_id
join inventory
on film.film_id = inventory.film_id
join rental
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by category;

-- 7 Is "Academy Dinosaur" available for rent from Store 1?

SELECT SUM(store.store_id) as num_available
FROM store
JOIN inventory ON store.store_id=inventory.store_id
JOIN film ON inventory.film_id=film.film_id
WHERE film.title = "Academy Dinosaur"
AND store.store_id = 1