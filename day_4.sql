use sql7challenge;

-- Q1. TOTAL CUSTOMERS.
-- count the total number of customers registered in the database.

select count(*) as total_customers from customers;

-- Q2.CUSTOMERS BY CITY.
-- count the number of customers in each city to identify which cities have the most customers.

select city, count(*) as no_of_customers from customers group by city order by no_of_customers desc limit 5;

-- Q3. Top 10 Customers by Order Count 
-- Identify thr top 10 customers who placed the highest number of non-cancelled orders.

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY order_count DESC
limit 5;

-- Q4. Customer Spending
-- Calculate the total spending of each customer based on order item values, excluding cancelled orders.

SELECT c.customer_id, c.full_name, SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
AND o.status <> 'Cancelled'
JOIN order_items AS oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spending DESC;

-- Q5. Average Spending per Customer
-- Calculate the average spending per customer among customers who have placed at least one non-cancelled order.

SELECT AVG(spend) AS avg_customer_spend 
FROM 
(SELECT o.customer_id, SUM(oi.quantity*oi.unit_price) AS spend
FROM orders o 
JOIN order_items as oi 
ON oi.order_id = o.order_id
where o.status <> 'cancelled'
group by o.customer_id)t;

-- Q6. Customers with More Than 5 Orders
-- Find customers who have placed more than five non-cancelled orders.

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;

-- Q7. Customer Segment Analysis
-- Count the number of customers in each customer segment.

SELECT segment, COUNT(*) AS total_customers
FROM customers
GROUP BY segment
ORDER BY total_customers DESC;

-- Q8. Average Orders per Customer
-- Calculate the average number of non-cancelled orders per customer, including customers with zero qualifying orders.

SELECT AVG(CAST(order_count AS DECIMAL(10,2))) AS average_orders_per_customer
FROM (
SELECT c.customer_id, COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id AND o.status <> 'Cancelled'
GROUP BY c.customer_id
) AS CustomerOrders;

-- Q9. Top 10 Customers by Spending
-- Identify the top 10 customers who generated the highest item sales value from non-cancelled orders.

SELECT c.customer_id, c.full_name, SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN order_items AS oi
ON o.order_id = oi.order_id
WHERE o.status <> 'Cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY total_spending DESC
LIMIT 10;

-- Q10. Customer Signups by Month
-- Count the number of new customer registrations per month and display the results chronologically.

SELECT YEAR(signup_date) AS signup_year, MONTH(signup_date) AS signup_month, COUNT(customer_id) AS total_signups
FROM customers
GROUP BY YEAR(signup_date), MONTH(signup_date)
ORDER BY signup_year ASC, signup_month ASC;
