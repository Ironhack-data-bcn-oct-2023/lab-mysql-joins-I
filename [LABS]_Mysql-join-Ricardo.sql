-- 1. Write a query to display for each store its store ID, city, and country.
USE sakila;

SELECT store_id, city, country
	from store
		join address
			on store.address_id = address.address_id
				join city
					on address.city_id = city.city_id
						join country
							on city.country_id = country.country_id;
            
-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, sum(amount) as business_store_brought
	from store
		join inventory
			on store.store_id = inventory.store_id
				join rental
					on inventory.inventory_id = rental.inventory_id
						join payment
							on rental.rental_id = payment.rental_id;
                            
-- 3. What is the average running time of films by category?          
SELECT category.name, AVG(length) as mean_duration_movies
	FROM film
		JOIN film_category 
			ON film.film_id = film_category.film_id
				JOIN category 
					ON film_category.category_id = category.category_id
	GROUP BY category.name;

-- 4. Which film categories are longest?
SELECT category.name, avg(length) as average_lenght
	FROM film
		JOIN film_category 
			ON film.film_id = film_category.film_id
				JOIN category 
					ON film_category.category_id = category.category_id
	GROUP BY category.name ORDER BY average_lenght DESC;

-- 5. Display the most frequently rented movies in descending order. 
SELECT title, count(rental_id) as number_times_rented -- ok I know I'm messing up here
	from film
		join inventory
			on film.film_id = inventory.film_id
				join rental
					on inventory.inventory_id = rental.inventory_id
ORDER BY number_times_rented DESC;

SELECT * from category;

-- 6. List the top five genres in gross revenue in descending order.
SELECT category.name, sum(amount) as top_revenue
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
		group by category.name
        order BY top_revenue DESC;


