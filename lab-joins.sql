USE sakila;

-- Write a query to display for each store its store ID, city, and country.
select store_id , city , country
	from store
		join address
			on store.address_id = address.address_id
		join city
			on address.city_id = city.city_id
		join country
			on city.country_id = country.country_id;


-- Write a query to display how much business, in dollars, each store brought in.
 select store.store_id, sum(amount) as business
	from store
		join customer
			on customer.store_id = store.store_id
		join payment
			on payment.customer_id = customer.customer_id
		group by store_id;


 -- What is the average running time of films by category? Which film categories are longest?
select name as category_name, AVG(length) as average_running_time
	from film
		join film_category
			on  film_category.category_id = film.film_id
		join category
			on  category.category_id = film_category.category_id
	group by category_name
    order by average_running_time DESC;

-- ANSWER: Top 3 longest categories are Travel, Documentary and New


-- Display the most frequently rented movies in descending order.
select title , count(rental_id) AS times_rented
	from film
		join inventory
			on  inventory.film_id = film.film_id
		join rental
			on  rental.inventory_id = inventory.inventory_id
	group by title
    order by times_rented DESC;

-- List the top five genres in gross revenue in descending order.
select category.name as genre , count(amount) AS gross_revenue
	from category
		join film_category
			on  film_category.category_id = category.category_id
		join film
			on  film.film_id = film_category.film_id
		join inventory
			on  inventory.film_id = film.film_id
        join rental
			on  rental.inventory_id = inventory.inventory_id
		join payment
			on  payment.rental_id = rental.rental_id
	group by genre
    order by gross_revenue DESC
	limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
select title, count(inventory.film_id) as unities_available
from film
	join inventory
		on inventory.film_id = film.film_id
	join store
		on store.store_id = inventory.store_id
	where title = "Academy Dinosaur"
        and store.store_id = "1";

-- ANSWER: Yes, there are 4 unities available