---the complete sql bootcamp 2020 course

SELECT * FROM actor;

SELECT first_name, last_name FROM actor;

SELECT * FROM city;

---------

select first_name, last_name, email from customer where active = 1;


--- distinct (unique)
select * from film;
select distinct release_year from film;
select distinct(release_year) from film;

SELECT distinct rental_rate FROM film;

---challenge - find all ratings
SELECT DISTINCT rating FROM film;

--count
SELECT COUNT(*) FROM film;

-- how many ratings in db
SELECT COUNT(DISTINCT(rating)) FROM film;

-- SELECT WHERE

SELECT first_name FROM customer WHERE first_name = 'Maria';

SELECT * FROM customer WHERE first_name = 'Jared';

select title from film where rental_rate > 4 and replacement_cost >= 19.99 and rating = 'R';

select COUNT(title) from film where rental_rate > 4 and replacement_cost >= 19.99 and rating = 'R';

select * from film where rating = 'R' OR rating = 'PG-13'; 

select * from film where rating != 'R';

--- challenge

SELECT email from customer where first_name = 'Nancy' and last_name = 'Thomas';

SELECT description from film where title = 'Outlaw Hanky';

SELECT phone from address where address = '259 Ipoh Drive';

--- order by

SELECT * from customer ORDER BY first_name ASC; 

SELECT store_id, first_name, last_name from customer ORDER BY store_id, first_name ASC; 

--- Limit

SELECT * FROM PAYMENT 
ORDER BY payment_date ASC
LIMIT 5;


-- Challenge

SELECT customer_id FROM PAYMENT ORDER BY payment_date LIMIT 10;

SELECT title, length FROM film ORDER BY length ASC LIMIT 5;

SELECT COUNT(*) from film where length <= 50;

-- BETWEEN DATES ISO 8601 standard format '2007-02-01'

SELECT * FROM PAYMENT
LIMIT 2;

SELECT * FROM payment
where amount BETWEEN 8 AND 9;

SELECT * FROM payment
where amount NOT BETWEEN 8 AND 9;

SELECT * FROM payment
where payment_date BETWEEN '2007-02-01' AND '2007-02-15';

-- this is different doesn't include 2007-02-14 results, need to go to 15th
SELECT * FROM payment
where payment_date BETWEEN '2007-02-01' AND '2007-02-14';

-- IN
SELECT DISTINCT(amount) FROM payment ORDER BY amount;

SELECT * FROM payment where amount IN (.99, 1.98, 1.99);

-- number of payments that have this
SELECT COUNT(*) FROM payment where amount IN (.99, 1.98, 1.99);

SELECT COUNT(*) FROM payment where amount NOT IN (.99, 1.98, 1.99);

SELECT * FROM customer
WHERE first_name IN ('John', 'Jake', 'Julie');

-- LIKE ILIKE match with wildcard character % or _
-- LIKE is case-sensitive
-- ILIKE is case-insensitive
-- Postgresql does support full regex but not looking into it with course

SELECT * FROM customer
WHERE first_name LIKE 'J%';

SELECT COUNT(*) FROM customer
WHERE first_name LIKE 'J%';

SELECT * FROM customer
WHERE first_name LIKE 'J%' and last_name LIKE 'S%';

--case insensitive
SELECT * FROM customer
WHERE first_name ILIKE 'j%' and last_name ILIKE 's%';

SELECT * FROM customer
WHERE first_name LIKE '%er%';

-- _ one character % multiple
SELECT * FROM customer
WHERE first_name LIKE '_er%';

SELECT * FROM customer
WHERE first_name NOT LIKE '_er%';

--First name starts with A
SELECT * FROM customer
WHERE first_name LIKE 'A%';

SELECT * FROM customer
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%';

--General Challenge
SELECT COUNT(amount) from payment where amount > 5.00;

SELECT COUNT(first_name) FROM actor
WHERE first_name LIKE 'P%';

SELECT COUNT(DISTINCT(district)) FROM address;

SELECT DISTINCT(district) FROM address;

SELECT COUNT(rating) FROM film 
WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;


SELECT COUNT(*) FROM film
WHERE title LIKE '%Truman%';

--- Aggregation
SELECT MIN(replacement_cost) FROM film;

SELECT MAX(replacement_cost) FROM film;

SELECT MIN(replacement_cost), MAX(replacement_cost) FROM film;

SELECT AVG(replacement_cost) FROM film;

-- round(value, decimal places)
SELECT ROUND(AVG(replacement_cost), 2) FROM film;

SELECT SUM(replacement_cost) FROM film;


---GROUP BY

-- also distinct
SELECT customer_id FROM payment 
GROUP BY customer_id
ORDER BY customer_id;


SELECT customer_id, SUM(amount) FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount);

SELECT customer_id, COUNT(amount) FROM payment 
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY customer_id;

SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY customer_id, staff_id
ORDER BY customer_id, staff_id;

-- how much money is made on the day
SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;


--- GROUP BY challenges
 SELECT staff_id, COUNT(amount) FROM payment 
 WHERE staff_id IN (1,2)
 GROUP BY staff_id 
 ORDER BY COUNT(amount) DESC;
 
 SELECT rating, ROUND(AVG(replacement_cost),2) FROM film
 GROUP BY rating
 ORDER BY ROUND(AVG(replacement_cost)) DESC;
 
 
 SELECT customer_id, SUM(amount) FROM payment
 GROUP BY customer_id
 ORDER BY SUM(amount) DESC
 limit 5;
 
 
 --- HAVING
 
 SELECT customer_id, SUM(amount) FROM payment
 GROUP BY customer_id
 HAVING SUM(amount) > 100;
 
 SELECT store_id, COUNT(customer_id) FROM customer
 GROUP BY store_id
 HAVING COUNT(customer_id) > 300;
 
 
 -- HAVING Challenge
 
 SELECT customer_id, COUNT(amount) FROM payment
 GROUP BY customer_id
 HAVING COUNT(amount) >= 40;

 SELECT customer_id, SUM(amount) FROM payment
 WHERE staff_id = 2
 GROUP BY customer_id
 HAVING SUM(amount) > 100;
 
 -- AS
 --can't use alias anywhere else
 SELECT customer_id, SUM(amount) as total_spent FROM payment
 GROUP BY customer_id
 HAVING SUM(amount) > 100;
 
 -- INNER JOIN anything in both
 SELECT * FROM payment
 INNER JOIN customer
 ON payment.customer_id = customer.customer_id;
 
  SELECT payment_id, payment.customer_id, first_name 
  FROM payment
 INNER JOIN customer
 ON payment.customer_id = customer.customer_id;
 
 -- Full Outer Joins, fills in missing data with null
 -- can exclude anything the tables share to figure out things that are missing
 
 --make sure all payments are available for custoemrs.  No customers without payment 
 
 SELECT * FROM customer
 FULL OUTER JOIN payment
 on customer.customer_id = payment.customer_id;
 
 -- are there any customers or payments not assosiated with the other?
  SELECT * FROM customer
 FULL OUTER JOIN payment
 on customer.customer_id = payment.customer_id
 WHERE customer.customer_id IS null
 OR payment.payment_id IS null;
 
 -- could verify by checking counts in each teable to see if they match
SELECT COUNT(DISTINCT(customer_id)) from payment;

SELECT COUNT(DISTINCT(customer_id)) from customer;

-- LEFT OUTER JOIN
-- find something in one table where there doesn't exist values in the other
-- find people who haven't logged in but have registered.  

SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory ON
inventory.film_id = film.film_id;

--films that we don't have in inventory
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory ON
inventory.film_id = film.film_id
WHERE inventory.film_id IS null;


--RIGHT JOIN
--Same as left join with tables switched

--UNION
--combine two tables to compare results.  For example different company quarters stored in two different tables.


--challenge
-- find all customer emails that live in California so they can be notified
SELECT * from customer;
SELECT * from address;

SELECT email FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id
WHERE district = 'California';
 

SELECT * from actor;
SELECT * from film;
SELECT * FROM film_actor;

SELECT title FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film.film_id = film_actor.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';
 