use sakila;


-- Write a query to display for each store its store ID, city, and country
SELECT 
    store_id, city, country
FROM
    store s
        JOIN
    city ct,
    address ad,
    country c
WHERE
    s.address_id = ad.address_id
        AND c.country_id = ct.country_id
        AND ct.city_id = ad.city_id
GROUP BY store_id
ORDER BY store_id ASC;



-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM
    store s
JOIN
    staff st ON s.store_id = st.store_id
JOIN
    payment p ON st.staff_id = p.staff_id
GROUP BY
    s.store_id
ORDER BY
    total_revenue DESC;
    
-- 3. What is the average running time of films by category?

SELECT 
    c.name, AVG(f.length) AS average_running_time
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time desc;
    
-- 4. Which film categories are longest?
SELECT 
    c.name, MAX(f.length) AS longest_film
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY longest_film DESC
LIMIT 5;

-- 5. Display the most frequently rented movies in descending order.

SELECT 
    f.title AS movie_titles, COUNT(r.rental_id) AS rental_count
FROM
    film f
        JOIN
    inventory inv ON f.film_id = inv.film_id
        JOIN
    rental r ON inv.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

-- 6. List the top five genres in gross revenue in descending order.

SELECT 
    c.name AS genre, SUM(p.amount) AS gross_revenue
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
        JOIN
    inventory inv ON f.film_id = inv.film_id
        JOIN
    rental r ON inv.inventory_id = r.inventory_id
        JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
    
    -- I don't know if I'm answering correctly to the last question but I tried it!!!

SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN 'Yes, the movie is available to rent.'
        ELSE 'No, the movie is not available to rent.'
    END AS availability
FROM 
    inventory i
WHERE 
    i.film_id = (SELECT film_id FROM film WHERE title = 'Academy Dinosaur')
    AND i.store_id = 1;