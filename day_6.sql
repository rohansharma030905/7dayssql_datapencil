use sql7challenge;

-- Q1. Understand order status distribution
-- How many orders belong to each order status

SELECT status, count(order_id) as total_orders
FROM orders 
GROUP BY status 
ORDER BY total_orders DESC;

-- Q2. Analyze delivery status and performance
-- How many deliveries belong to each delivery status
 
SELECT delivery_status, count(*) as total_deliveries
FROM deliveries 
GROUP BY delivery_status
ORDER BY total_deliveries DESC;
 
-- Q3. Average delivery time and long deliveries
-- On average, how many days does a completed delivery take

SELECT ROUND(AVG(DATEDIFF(delivery_date,dispatch_date)),2) AS avg_delivery_days
FROM deliveries 
where delivery_status ='Delivered'
AND delivery_date is NOT NULL
AND dispatch_date is NOT NULL;
 
-- Q4. Top 10 longest deliveries
-- Which 10 delivered orders took the longest to arrive
 
SELECT order_id, dispatch_date, delivery_date,
datediff(delivery_date,dispatch_date) AS delivery_days
FROM deliveries
WHERE delivery_status = 'Delivered'
AND delivery_date is NOT NULL
AND dispatch_date is NOT NULL
ORDER BY delivery_days DESC
limit 10;
 
-- Q5. Track monthly order volumes
-- How does order volume change month by month
 
SELECT YEAR(order_date) AS order_year,month(order_date) AS order_month,
COUNT(order_id) AS total_orders 
FROM orders 
GROUP BY year(order_date), month(order_date)
ORDER BY order_year,order_month;
 
-- Q6. Analyze payment status distribution
-- How are payment records distributed across statuses
 
SELECT payment_status, COUNT(payment_status) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;
 
-- Q7. Identify delayed deliveries (> 5 days)
-- Which completed deliveries took longer than five days
 
 SELECT delivery_id, order_id,delivery_date,dispatch_date,DATEDIFF(delivery_date,dispatch_date) AS delivery_days
 FROM deliveries 
 WHERE delivery_status = 'Delivered'
 AND delivery_date IS NOT NULL
 AND dispatch_date IS NOT NULL
 AND DATEDIFF(delivery_date,dispatch_date) > 5
 ORDER BY delivery_days DESC;
 
-- Q8. Compare delivery performance by city
-- Which customer cities have the longest average delivery times

SELECT c.city, AVG(DATEDIFF(d.delivery_date,d.dispatch_date)) AS avg_delivery_days,
COUNT(d.delivery_id) AS total_delivery_days
FROM customers AS c 
JOIN orders AS o 
ON c.customer_id = o.customer_id
JOIN deliveries AS d
ON o.order_id = d.order_id
WHERE d.delivery_status = 'Deliverd'
AND d.delivery_date IS NOT NULL
AND d.dispatch_date IS NOT NULL
GROUP BY c.city
ORDER BY avg_delivery_days DESC;
 
 -- Business Insights:
 -- Helps management understand the distribution of orders across different statuses and monitor order processing performance.
--  Identifies how many deliveries are completed, pending, or delayed, helping the company monitor delivery operations.
--  Measures average delivery speed and helps identify opportunities to improve delivery efficiency.
--  Identifies deliveries exceeding the five-day threshold and helps management investigate logistics issues and improve customer satisfaction.
--  City-wise delivery analysis identifies locations with longer average delivery times, helping management evaluate logistics performance and improve regional delivery efficiency.
 