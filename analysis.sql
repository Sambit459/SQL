use mavenmovies;

select * from rental;
select * from inventory;
select customer_id,rental_date
from rental;
select first_name,last_name,email from customer;
select * from film;
select distinct rating from film;
select distinct rental_duration from film;
select customer_id,rental_id,amount,payment_date
from payment where amount=0.99;
select customer_id,rental_id,amount,payment_date
from payment where payment_Date>"2006-01-01";
select * from payment
where customer_id between 1 and 100;

select customer_id,rental_id,amount,payment_date
from payment where amount=0.99
and payment_Date>"2006-01-01";

select customer_id,rental_id,amount,payment_date
from payment
where customer_id<101 and amount>=5 and payment_date>"2006-01-01";

select customer_id ,rental_id,amount,payment_date from payment
where customer_id=5 or customer_id=11 or customer_id=29;

select customer_id ,rental_id,amount,payment_date from payment
where amount>5 or customer_id =42 or customer_id=43 or customer_id=60
or customer_id=73;

select customer_id ,rental_id,amount,payment_date from payment
where customer_id in (5,11,29);

select title,description
from film 
where description like "%Epic%";

select title,description
from film 
where title like "_LADDIN CALENDAR";

select title,special_features
from film
where special_features like "%Behind the Scenes%";

select rating,count(film_id) as film_with_this_rating
from film group by rating;

select rental_duration,count(film_id) as films_with_this_rental_duration 
from film group by rental_duration;

select rental_duration,rating,replacement_cost,
count(film_id) as films_with_this_rental_duration
from film group by rental_duration,rating,replacement_cost order by rental_duration;

select rating,
count(film_id) as count_of_films,
Min(length) as shortest_film,
max(length) as Longest_film,
avg(length) as average_length_of_film,
avg(rental_duration) as average_rental_duartion
from film
group by rating;

select replacement_cost,
count(film_id)  number_of_films,
min(rental_rate) as cheapest_rental,
max(rental_rate) as most_expensive_rental,
avg(rental_rate) as avg_rental
from film group by 	replacement_cost;

select customer_id,
count(rental_id) as total_rentals
from rental
group by customer_id
having total_rentals=25;
select customer_id,count(rental_id) as total_rentals
from rental
group by customer_id
having total_rentals<15;

select customer_id,rental_id,amount,payment_date
from payment
order by amount desc;

select customer_id,sum(amount) as total_payment_amount
from payment
group by customer_id order by total_payment_amount desc;

select title,length,rental_rate
from film
order by length desc;

select length,
case when length < 60 then "under 1 hours"
	 when length between 60 and 90 then "1-1.5 hours"
	 when length > 60 then "more then 1 hour"
else "please heck logic"
end as length_group
from film;

select distinct title,
case when rental_duration <= 4 then "rental too short"
	 when rental_rate >= 3.99 then "too expensive"
     when rating in ("NC-17","R") then "too adult"
     when length not between 60 and 90 then "too short and too young"
     when description like "%Shark%" then "Shark type movies"
     else "good recommendation"
end as movie_recommendation
from film;

select first_name,last_name,
case when store_id=1 and active =1 then "store 1 is active"
	 when store_id=1 and active =0 then "store 1 is inactive"
     when store_id=2 and active =1 then "store 2 is active"
     when store_id=2 and active =0 then "store 2 is inactive"
	 else "Please check logic"
end as store_status
from customer;

select film_id,
count(case when store_id =1 then inventory_id else null end) as store_1_copies,
count(case when store_id =2 then inventory_id else null end) as store_2_copies,
count(inventory_id)
from inventory
group by film_id
order by film_id;

select store_id ,
count(case when active =1 then store_id else null end) as active,
count(case when active =0 then store_id else null end) as inactive
from customer
group by store_id;

select store_id,count(inventory_id)
from inventory
group by store_id;

select store_id,count(customer_id) as active_customer
from customer
where active=1
group by store_id;

select count(email) as emails
from customer;

select store_id,count(distinct film_id) as unique_film
from inventory
group by store_id;

select count(distinct name) as unique_catagories
from category;

select min(replacement_cost) as least_expensive,
max(replacement_cost) as most_expensive,
avg(replacement_cost) as average_replacement_cost
from film;

select avg(amount) as average_payment,
max(amount) as max_payment
from payment;

select customer_id,
count(rental_id) as number_of_rentals
from rental group by customer_id
order by count(rental_id) desc;

select distinct inventory.inventory_id from inventory
inner join rental on inventory.inventory_id=rental.inventory_id;

select distinct rental_id from inventory
inner join rental on inventory.inventory_id=rental.inventory_id;

select inventory_id,store_id,title,description
from inventory inner join film on
inventory.film_id =film.film_id ;

select distinct inventory.inventory_id from inventory
left join rental on inventory.inventory_id=rental.inventory_id;

select title, count(actor_id)
from film left join film_actor on
film.film_id=film_actor.film_id
group by title;

select actor.actor_id,actor.first_name as actor_first,
actor.last_name as actor_last,actor_award.awards from
actor right join actor_award on
actor.actor_id=actor_award.actor_id;

select film.film_id,film.title,category.name as category_name
from film inner join film_category
on film.film_id=film_category.film_id
inner join category
on category.category_id=film_category.category_id;

select actor.first_name as actor_first_name,
actor.last_name as actor_last_name,
film.title as film_title
from actor inner join film_actor
on actor.actor_id=film_actor.actor_id
inner join film
on film.film_id=film_actor.film_id;

select film.film_id,film.title,film.rating
from film inner join film_category
on film.film_id=film_category.film_id
inner join category
on film_category.category_id=category.category_id
where category.name='horror'; 

select film.film_id,film.title,film.rating
from film inner join film_category
on film.film_id=film_category.film_id
inner join category
on film_category.category_id=category.category_id
and category.name='horror';

select distinct film.title,film.description
from film inner join  inventory on
inventory.film_id=film.film_id
where inventory.store_id=2;

select distinct film.title,film.description
from film inner join  inventory on
inventory.film_id=film.film_id
and inventory.store_id=2;

select 'advisor' as type,first_name,last_name from advisor
union
select 'inverstor' as type,first_name,last_name from investor;

select 'advisor' as type,first_name,last_name from advisor
union
select 'staff' as type,first_name,last_name from staff;

select staff.first_name as manager_first_name,
staff.last_name as manager_last_name,
address.address,
address.district,
city.city,
country.country
from store
left join staff on store.manager_staff_id=staff.staff_id
left join address on store.address_id=address.address_id
left join city on address.city_id=city.city_id
left join country on city.country_id=country.country_id;

select inventory.store_id,
inventory.inventory_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost
from inventory
left join film
on inventory.film_id=film.film_id;

select inventory.store_id,
film.rating,
count(inventory_id) as inventory_items
from inventory
left join film
on inventory.film_id=film.film_id
group by
inventory.store_id,film.rating;

select store_id,
category.name as category,
count(inventory.inventory_id) as films,
avg(film.replacement_cost) as avg_replacement_cost,
sum(film.replacement_cost) as total_replacement_cost
from inventory
left join film on inventory.film_id=film.film_id
left join film_category on film.film_id=film_category.film_id
left join category on category.category_id=film_category.category_id
group by store_id,category.name
order by total_replacement_cost desc;

select customer.first_name,
customer.last_name,
customer.store_id,
customer.active,
address.address,
city.city,
country.country
from customer
left join address on customer.address_id=address.address_id
left join city on city.city_id=address.city_id
left join country on city.country_id=country.country_id;

select customer.first_name,
customer.last_name,
count(rental.rental_id) as total_rentals,
sum(payment.amount) as total_payment_amount
from customer
left join rental on customer.customer_id=rental.customer_id
left join payment on rental.rental_id=payment.rental_id
group by customer.first_name,customer.last_name
order by total_payment_amount desc;

select 'invester' as type,
first_name,last_name,
company_name
from investor
union
select 'advisor' as type,
first_name,last_name,
"N/A"
from advisor;

select 
case when actor_award.awards='Emmy, Oscar, Tony ' then '3 awards'
	 when actor_award.awards in ('Emmy, Oscar','Emmy, Tony','Tony, Emmy') then '2 awards'
     else '1 award'
end as number_of_awards ,
avg(case when actor_award.actor_id is null then 0 else 1 end)as percentage_with_one_film
from actor_award
group by  
case when actor_award.awards='Emmy, Oscar, Tony ' then '3 awards'
	 when actor_award.awards in ('Emmy, Oscar','Emmy, Tony','Tony, Emmy') then '2 awards'
     else '1 award'
     end;









