#Use sakila
-- 1a
select first_name, last_name from actor;
-- 1b
select concat(first_name, ' ',last_name) as Actor_Name from actor;
-- 2a
select actor_id, first_name, last_name from actor WHERE first_name = "joe";
-- 2b
select * FROM actor WHERE last_name like ("%gen%");
-- 2c
select last_name, first_name from actor WHERE last_name like ("%li%");
-- 2d
select country_id, country FROM country where country IN ("Afghanistan", "Bangladesh", "China");
-- 3a
ALTER TABLE actor ADD column discription BLOB;
-- 3b
ALTER TABLE actor drop discription; 
-- 4a
select last_name, count(last_name) 
from actor 
group by last_name;
-- 4b
select last_name, count(last_name) 
from actor 
group by last_name
having count(last_name) >= 2;
-- 4c
select * from actor
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

Update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';
-- 4d
select * from actor
where first_name = 'HARPO' and last_name = 'WILLIAMS';

Update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO' and last_name = 'WILLIAMS';

-- 5a
SHOW CREATE TABLE address;

-- 6a
select first_name, last_name from staff join address on staff.address_id = address.address_id;

-- 6b
select amount from staff join payment on staff.staff_id = payment.staff_id;

-- 6c
select title, count(*) as ct from film Join film_actor on film_actor.film_id = film.film_id group by film.title;
-- 6d
-- select film_id, count(*) as ct from inventory;

select title, count(inventory.film_id) as ct 
from film 
Join inventory on inventory.film_id = film.film_id
where film.title = 'Hunchback Impossible';
-- 6e
select customer.first_name, customer.last_name, sum(payment.amount) 
from customer Inner Join payment on payment.customer_id = customer.customer_id 
group by payment.customer_id
ORDER BY customer.last_name;

-- 7a
SELECT title FROM film WHERE title LIKE 'K%' or title like 'Q%' and language_id in 
(
	Select language_id from language where language_id = '1'
);
select * from film; 
-- 7b 
select first_name, last_name from actor where actor_id in
(
	select actor_id from film_actor where film_id = 
(
	select film_id from film where title = 'Alone Trip'
)
);
 
-- 7c You want to run an email marketing campaign in Canada, 
--  for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
select first_name, last_name, email from customer 
Inner Join address on address.address_id = customer.address_id
Inner Join city on city.city_id = address.city_id
Inner Join country on country.country_id = city.country_id
where country.country = 'Canada';

-- 7d Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

select title from film 
Inner join film_category on film_category.film_id = film.film_id
inner join category on category.category_id = film_category.category_id
where name = 'Family';


-- 7e. Display the most frequently rented movies in descending order.
select title, count(title) as "rental_count" from film 
Inner join inventory on inventory.film_id = film.film_id
Inner join rental on rental.inventory_id = inventory.inventory_id
Group by title
order by rental_count desc;

-- 7f Write a query to display how much business, in dollars, each store brought in.

select store.store_id, sum(amount) from payment
Inner Join rental on rental.rental_id = payment.rental_id
Inner join inventory on inventory.inventory_id = rental.inventory_id
Inner Join store on store.store_id = inventory.store_id
group by store.store_id;


-- 7g. Write a query to display for each store its store ID, city, and country.
select store_id, city, country from store
inner join address on address.address_id = store.address_id
inner join city on city.city_id = address.city_id
inner join country on country.country_id = city.country_id;

-- 7h List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select name, sum(amount) from payment
inner join rental on rental.rental_id = payment.rental_id
Inner join inventory on inventory.inventory_id = rental.inventory_id
inner join film_category on Film_category.film_id = inventory.film_id
Inner join category on film_category.category_id = category.category_id
group by category.name
Order by Sum(amount) Desc limit 5;


-- 8a In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
-- Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW `Top_5Gross_genres` AS SELECT name, sum(amount) from payment
inner join rental on rental.rental_id = payment.rental_id
Inner join inventory on inventory.inventory_id = rental.inventory_id
inner join film_category on Film_category.film_id = inventory.film_id
Inner join category on film_category.category_id = category.category_id
group by category.name
Order by Sum(amount) Desc limit 5;

-- 8b How would you display the view that you created in 8a

select * from top_5gross_genres;

-- 8c You find that you no longer need the view top_five_genres. Write a query to delete it.

DROP VIEW top_5gross_genres;


















