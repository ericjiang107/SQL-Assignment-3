-- Question 1: List all customers who in Texas
SELECT customer_id, first_name, last_name, district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- Answer for Q1: Jennifer, Kim, Richard, Bryan, Ian 


-- Question 2: Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount DESC;
-- Answer for Q2: A long list of people from 11.99 to higher than 6.99 -- 1406 rows


-- Question 3: Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name, SUM(amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) ASC;
-- Answer for Q3: 6 customers who have made payments over $175


-- Question 4: List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal'
-- Answer for Q4: 1 person, Kevin lives in Nepal


-- Question 5: Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(payment_id) DESC
-- Answer for Q5: Jon -- 7304 and Mike -- 7292 


-- Question 6: How many movies of each rating are there?
SELECT rating, COUNT(title)
FROM film
GROUP BY film.rating
-- Answer for Q6: 195 R, 210 NC-17, 178 G, 194 PG, 223 PG-13


-- Question 7: Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer.customer_id IN(
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY payment.customer_id
	HAVING COUNT(payment.customer_id) < 2
);
--Answer for Q7: 130 people


-- Question 8: How many free rentals did our stores give away? 
SELECT COUNT(rental_id), amount
FROM payment
GROUP BY payment.amount
HAVING amount = 0
-- Answer for Q8: 24 rentals