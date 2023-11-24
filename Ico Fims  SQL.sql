use lco_films;
show table status;

# 1 Update the address of the actor id 36 to '677 zazz street'.
update address set address2='677 zazz street' where address_id=36;
select * from address;

# 2 how many actors from united states?
select count(*) as total_actors_from_us from actor
join address on actor.address_id=address.address_id
join city on address.city_id=city.city_id
join country on city.country_id=country.country_id
where country.country='United States';

# 3 Get all languages in which films released in the year 2002 and 2010.
select distinct_language.name from film
join language on film.language_id=language.language_id where film.release_year in (2002,2010);
select * from film;

# 4 In which year most film were released?
select release_year,count(*) as num_movies from film
group by release_year order by num_movies desc limit 1;

# 5Which actor acted in most movies?
select actor.actor_id,actor.first_name,actor.last_name, count(*) as num_movies from actor
join film_actor on actor.actor_id=film_actor.actor_id 
group by actor.actor_id,actor.first_name,actor.last_name order by num_movies desc limit 1;

#other method
SELECT actor_id, COUNT(*) AS num_movies
FROM film_actor
GROUP BY actor_id
ORDER BY num_movies DESC
LIMIT 1;

# 6 How many actors acted in the film released in 2007?
select count(distinct actor.actor_id) as num_actor_in_2017 from actor
join film_actor on actor.actor_id=film_actor.actor_id
join film on film_actor.film_id=film.film_id where film.release_year=2017;


# 7 Fetch the actor of the movie westward seabiscuit with the city live in.
select actor.actor_id,actor.first_name,actor.last_name,address.city_id from actor
join film_actor on actor.actor_id=film_actor.actor_id
join film on film_actor.film_id=film.film_id 
join address on actor.address_id=address.address_id
where film.title = 'westward seabiscuit';

# 8 What is total length of all movies played in 2007?
select SUM(length) from film where release_year=2008;
select SUM(length) as total_length_2008 from film where release_year=2008;
select SUM(length) from film where release_year=2008;

# 9 Which actor did least movie?
select actor.actor_id,actor.first_name,actor.last_name, count(*) as num_movies from actor
left join film_actor on actor.actor_id=film_actor.actor_id
group by actor.actor_id,actor.first_name,actor.last_name
order by num_movies;

# other method
SELECT actor_id, COUNT(*) AS num_movies
FROM film_actor
GROUP BY actor_id
ORDER BY num_movies
LIMIT 1;


# 10 Which categories of movies released in 2018? Fetch with number of movies.
select category.category_id,category.name, count(film.film_id) as num_movies from film
join film_category on film.film_id=film_category.film_id
join category on film_category.category_id=category.category_id
where film.release_year=2008
group by category.category_id,category.name;

# other method
SELECT c.name AS category, COUNT(*) AS num_movies
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.release_year = 2018
GROUP BY c.name;