use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
	select store_id, city, country 
	from store as s
		join address as a
			on s.address_id = a.address_id
		join city as c
			on a.city_id = c.city_id
		join country as ct
			on c.country_id = ct.country_id
	group by store_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
	-- store, staff, payment
	select s.store_id, sum(amount) as business
    from store as s
		join staff on s.store_id = staff.store_id
        join payment on staff.staff_id = payment.staff_id
	group by s.store_id;
    
-- 3. What is the average running time of films by category?
	-- running time es minutos de duración no?
    
-- 4. Which film categories are longest?
-- 5. Display the most frequently rented movies in descending order.
-- 6. List the top five genres in gross revenue in descending order.
-- 7. Is "Academy Dinosaur" available for rent from Store 1?