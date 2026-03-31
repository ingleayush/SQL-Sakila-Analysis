-- Sakila SQL Analysis Project

-- 1. Overview of Tables
SELECT * FROM actor LIMIT 10;
SELECT * FROM film LIMIT 10;
SELECT * FROM customer LIMIT 10;
SELECT * FROM rental LIMIT 10;

-- 2. Actor Full Name
SELECT actor_id,
       CONCAT(first_name, ' ', last_name) AS full_name
FROM actor;

-- 3. Films per Category
SELECT c.name AS category,
       COUNT(f.film_id) AS total_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY total_films DESC;

-- 4. Most Rented Films
SELECT f.title,
       COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 10;

-- 5. Films per Year
SELECT release_year,
       COUNT(film_id) AS total_films
FROM film
GROUP BY release_year;

-- 6. Movies by Language
SELECT l.name AS language,
       COUNT(f.film_id) AS total_movies
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.name;

-- 7. Rentals per Customer
SELECT customer_id,
       COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY customer_id
ORDER BY total_rentals DESC;

-- 8. Rating Count
SELECT rating,
       COUNT(film_id) AS total_movies
FROM film
GROUP BY rating;

-- 9. Total Revenue
SELECT SUM(amount) AS total_revenue
FROM payment;

-- 10. Top 5 Movies by Revenue
SELECT f.title,
       SUM(p.amount) AS revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY revenue DESC
LIMIT 5;

-- 11. Revenue by Store
SELECT s.store_id,
       SUM(p.amount) AS revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;

-- 12. Monthly Revenue
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY month;

-- 13. Revenue by Category
SELECT c.name AS category,
       SUM(p.amount) AS revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY revenue DESC;

-- 14. Customer Expense
SELECT customer_id,
       SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;

-- 15. Customer Type (One-Time vs Repeat)
SELECT customer_id,
       COUNT(rental_id) AS total_rentals,
       CASE
           WHEN COUNT(rental_id) = 1 THEN 'One-Time'
           ELSE 'Repeat'
       END AS customer_type
FROM rental
GROUP BY customer_id;

-- 16. Rental Duration
SELECT rental_id,
       DATEDIFF(return_date, rental_date) AS rental_days
FROM rental;

-- 17. Average Rental Duration
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_days
FROM rental;

-- 18. Total Rentals
SELECT COUNT(*) AS total_rentals
FROM rental;

-- 19. Unique Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM rental;

-- 20. Total Films
SELECT COUNT(*) AS total_films
FROM film;
