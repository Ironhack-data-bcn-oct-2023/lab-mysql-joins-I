use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
	-- store, adress, city, country
	select store_id, city, country 
	from store as s
		join address as a on s.address_id = a.address_id
		join city as c on a.city_id = c.city_id
		join country as ct on c.country_id = ct.country_id
	group by store_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
	-- store, staff, payment
	select s.store_id, sum(amount) as business
    from store as s
		join staff on s.store_id = staff.store_id
        join payment on staff.staff_id = payment.staff_id
	group by s.store_id;
    
-- 3. What is the average running time of films by category?
	-- film, film_category, category
	select avg(length) as running_time, name as category
    from film as f
		join film_category as fc on f.film_id = fc.film_id
        join category as c on fc.category_id = c.category_id
	group by c.name
	order by running_time desc;
    
-- 4. Which film categories are longest?
	-- film, film_category, category
	select c.name as category, max(f.length) as length
	from film as f
		join film_category as fc on f.film_id = fc.film_id
        join category as c on fc.category_id = c.category_id
	group by category
	order by length desc limit 5;

-- 5. Display the most frequently rented movies in descending order.
	-- film, inventory, rental
	select f.title as movie_title, count(r.rental_id) as rental_times
	from film as f
		join inventory as inv on f.film_id = inv.film_id
		join rental as r on inv.inventory_id = r.inventory_id
	group by movie_title
	order by rental_times desc
	limit 10;

-- 6. List the top five genres in gross revenue in descending order.
	-- film, film_category, category, inventory, rental, payment
	select c.name as genre, sum(p.amount) as gross_rev
	from film as f
		join film_category as fc on f.film_id = fc.film_id
        join category as c on fc.category_id = c.category_id
		join inventory as inv on f.film_id = inv.film_id
		join rental as r on inv.inventory_id = r.inventory_id
		join payment as p on r.rental_id = p.rental_id
	group by genre 
    order by gross_rev desc limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
	-- film, inventory
	select title, store_id
	from film as f
		join inventory as inv on f.film_id = inv.film_id
	where f.title = 'Academy Dinosaur' and inv.store_id = 1;
	-- The result table shows 4 registers, so there's availability of the asked title.