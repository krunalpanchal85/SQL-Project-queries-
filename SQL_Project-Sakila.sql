
select first_name, last_name from actor;
select concat(first_name,' ', last_name) AS 'Actor Name'
FROM actor;

select actor_id, first_name, last_name from actor where first_name = 'Joe';
select * from actor where last_name like '%GEN%';
select last_name, first_name from actor where last_name like '%LI%'
order by last_name and first_name;
select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
  ADD description blob;
ALTER TABLE actor
DROP COLUMN description;

select  last_name, count(last_name) from actor
group by last_name;
select last_name, count(last_name)  from actor
group by last_name
having count(last_name) > 2;
select * from actor where first_name in( 'harpo','groucho');
UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'groucho'
and last_name = 'williams';
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'Harpo'
and last_name = 'williams';

SHOW CREATE TABLE address;

select a.first_name, a.last_name, b.address from staff a 
join address b on a.address_id = b.address_id ;
select a.first_name, a.last_name, sum(b.amount) from staff a 
join payment b on a.staff_id = b.staff_id
where b.payment_date like '2005-08-%'
group by a.staff_id;
select a.title, count(b.actor_id)  from film a 
inner join film_actor b 
on a.film_id = b.film_id 
group by b.film_id;
select a.title, count(b.inventory_id)  from film a 
join inventory b 
on a.film_id = b.film_id
where a.title = 'Hunchback Impossible' ;
select b.first_name, b.last_name, sum(a.amount) as 'Total Amount Paid' from payment a
join customer b 
on a.customer_id = b.customer_id 
group by a.customer_id 
order by b.last_name asc;

select a.title, b.name from film a 
join language b on a.language_id = b.language_id
where a.title like 'K%' 
and b.name = 'English';
select a.title, b.name from film a 
join language b on a.language_id = b.language_id
where a.title like 'Q%' 
and b.name = 'English';
select b.title, a.first_name,a.last_name from actor a
inner join film_actor c on c.actor_id = a.actor_id
inner join film b on c.film_id = b.film_id 
where b.title = 'Alone Trip';

select a.last_name, a.first_name, a.email, c.country from customer a
join address b on a.address_id = b.address_id 
join city d on d.city_id = b.city_id
join country c on c.country_id = d.country_id
where c.country = 'Canada';
select c.title as '_family_' from film_category a
join category b on a.category_id = b.category_id
join film c on a.film_id = c.film_id
where b.name = 'family';
select c.title, count(c.film_id) from rental a
join inventory b on a.inventory_id = b.inventory_id
join film c on b.film_id = c.film_id 
group by a.inventory_id 
order by count(c.film_id) desc;
select b.store_id, sum(a.amount) from payment a 
inner join staff b on a.staff_id = b.staff_id
group by b.store_id;
select a.store_id, c.city, d.country from store a 
inner join address b on a.address_id = b.address_id
inner join city  c on b.city_id = c.city_id
inner join country d on c.country_id = d.country_id;
select a.category_id, a.name, sum(e.amount) from category a
inner join film_category b on a.category_id = b.category_id
inner join inventory c on b.film_id = c.film_id
inner join rental d on d.inventory_id = c.inventory_id
inner join payment e on d.rental_id = e.rental_id
group by a.category_id
order by sum(e.amount) desc
limit 5;

CREATE VIEW Top_5_Movie_Cat_by_Revenue AS
select a.category_id, a.name, sum(e.amount) from category a
inner join film_category b on a.category_id = b.category_id
inner join inventory c on b.film_id = c.film_id
inner join rental d on d.inventory_id = c.inventory_id
inner join payment e on d.rental_id = e.rental_id
group by a.category_id
order by sum(e.amount) desc
limit 5;
select * from Top_5_Movie_Cat_by_Revenue;
DROP VIEW Top_5_Movie_Cat_by_Revenue;