-- 1
select* from store;
select* from city;
select store.store_id, city.city, country.country
from store
inner join address on store.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id;

-- 2
select store.store_id, SUM(payment.amount) as total_sales
from payment
join staff on payment.staff_id = staff.staff_id
join store on staff.store_id = store.store_id
group by store.store_id;

-- 3
select category.name, avg(film.length) as average_running_time
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.name;

-- 4
select category.name, avg(film.length) as average_running_time
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.name
order by average_running_time desc;

-- 5
select film.title, count(rental.rental_id) as rental_count
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.title
order by rental_count desc;

-- 6

select category.name as genre, sum(payment.amount) as gross_revenue
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by category.name
order by gross_revenue desc
limit 5;

-- 7
--  yes it is available
select film.title as movie_title, 
       store.store_id, 
       inventory.inventory_id
from film
join inventory on film.film_id = inventory.film_id
join store on inventory.store_id = store.store_id
where film.title = 'Academy Dinosaur' 
  and store.store_id = 1;
