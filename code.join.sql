#1 Write a query to display for each store its store ID, city, and country.
-- 1. Columns to select
	-- store
    -- city
    -- country
-- 2. Tables
	-- store
    -- staff
    -- address
    -- city
-- 3. KEYS that are shared between these tables
	-- store.store_id
    -- staff.store_id and staff.address_id
    -- address.address_id and address.city_id
    -- city.city_id and city.city

use sakila;
select store.store_id, city, country
	from store
		join staff 
			on store.store_id = staff.store_id
		join address
			on staff.address_id = address.address_id
		join city
			on address.city_id = city.city_id
		join country
			on city.country_id = country.country_id;
# 3 Write a query to display how much business, in dollars, each store brought in.
select name, length
	from category
		join film_category
			on category.category_id = film_category.category_id
		join film
			on film_category.film_id = film.film_id;
            