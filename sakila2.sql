use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
select store_id, city, country
from store
join address on store.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

select sum(amount), store.store_id
from payment
join staff on payment.staff_id = staff.staff_id
join store on staff.store_id = store.store_id
group by store.store_id;

-- Error Code: 1052. Column 'store_id' in field list is ambiguous

-- 3. What is the average running time of films by category?

select avg(length) as avg_running_time, category.name
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name;

-- 4. Which film categories are longest?

select category.name, avg(length) as avg_time
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name
order by average_duration desc;

-- 5. Display the most frequently rented movies in descending order.

select title, count(rental_id) as times
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by title
order by times desc;

-- 6. List the top five genres in gross revenue in descending order.

select category.name, sum(amount) as gross_revenue
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by category.name
order by gross_revenue desc
limit 5;

-- 7. Is "C" available for rent from Store 1?

select title, count(inventory.film_id)
from film
join inventory on film.film_id = inventory.film_id
join store on inventory.store_id = store.store_id
where title = "Academy Dinosaur" and store.store_id = 1

-- Error Code: 1052. Column 'store_id' in where clause is ambiguous




