### Instructions

--  Write a query to display for each store its store ID, city, and country.
use sakila;
select store_ID, city, country
from store
JOIN address
on store.address_ID = address.address_ID
join city
on address.city_ID = city.city_ID
join country
on city.country_ID = country.country_ID
GROUP BY store_ID;

--  Write a query to display how much business, in dollars, each store brought in.
select store.store_ID, sum(amount) as business
from store
JOIN inventory
on store.store_ID = inventory.store_ID
join rental
on inventory.inventory_ID = rental.inventory_ID
join payment
on rental.rental_ID = payment.rental_ID
GROUP BY store_ID;

-- What is the average running time of films by category?
select category.name, 
	avg(length)
	from film
	join film_category
	on film.film_ID = film_category.film_ID
	join category
	on film_category.category_id = category.category_ID
	group by category.name;

-- Which film categories are longest?
select category.name, 
	avg(length)
	from film
	join film_category
	on film.film_ID = film_category.film_ID
	join category
	on film_category.category_id = category.category_ID
	group by category.name
    order by avg(length) desc;

--  Display the most frequently rented movies in descending order.
select title, rental_rate
from film
order by rental_rate desc
limit 10;
