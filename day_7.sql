use sql7challenge;
show TABLES;

Q1. Total Orders and Order Status Distribution

SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;

Q2. Total Sales Value from Non-Cancelled Orders

SELECT SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'cancelled';

Q3. Months with the Highest and Lowest Order Volumes

WITH monthly_order_volume AS (
    SELECT YEAR(order_date) AS order_year,
           MONTH(order_date) AS order_month,
           COUNT(*) AS total_orders
    FROM orders
    GROUP BY YEAR(order_date), MONTH(order_date)
),
volume_extremes AS (
    SELECT MIN(total_orders) AS min_orders,
           MAX(total_orders) AS max_orders
    FROM monthly_order_volume
)
SELECT m.order_year,
       m.order_month,
       m.total_orders,
       CASE
           WHEN m.total_orders = e.max_orders THEN 'Highest Volume'
           WHEN m.total_orders = e.min_orders THEN 'Lowest Volume'
       END AS volume_type
FROM monthly_order_volume m
CROSS JOIN volume_extremes e
WHERE m.total_orders = e.max_orders
   OR m.total_orders = e.min_orders
ORDER BY m.total_orders DESC, m.order_year, m.order_month;

Q4. Sales Value by Sales Channel

SELECT o.channel, SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status != 'cancelled'
GROUP BY o.channel
ORDER BY total_sales DESC;

Q5. Sales Value by Product Category

SELECT p.category, SUM(oi.quantity * oi.unit_price) AS total_sales_value
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.category
ORDER BY total_sales_value DESC;

Q6. Top 10 Products by Sales Value

SELECT p.product_id,
       p.product_name,
       SUM(oi.quantity * oi.unit_price) AS total_sales_value
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY total_sales_value DESC
LIMIT 10;

Q7. Products with No Sales from Non-Cancelled Orders
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
                  AND o.status != 'Cancelled'
WHERE o.order_id IS NULL;





Q8. Estimated Product Profit by Category
SELECT p.category,
       SUM((oi.unit_price - p.cost) * oi.quantity) AS estimated_profit
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status != 'Cancelled'
GROUP BY p.category
ORDER BY estimated_profit DESC;

Q9. Top 10 Customers by Non-Cancelled Order Count
select c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS order_count
from customers c
left join orders o on c.customer_id = o.customer_id and o.status != 'Cancelled'
group by c.customer_id, c.first_name, c.last_name
order by order_count desc
limit 10;

Q10. Top 10 Customers by Calculated Spending
select c.customer_id, c.full_name, SUM(oi.quantity * oi.unit_price) AS total_spending
from customers c
left join orders o on c.customer_id = o.customer_id and o.status != 'Cancelled'
left join order_items oi on o.order_id = oi.order_id
group by c.customer_id, c.full_name
order by total_spending desc
limit 10;

Q11. Cities with the Largest Customer Base
select c.city, COUNT(DISTINCT c.customer_id) AS customer_count
from customers c
group by c.city
order by customer_count desc;

Q12. Average Customer Spending by Segment
select c.segment, AVG(oi.quantity * oi.unit_price) AS average_spending
from customers c
left join orders o on c.customer_id = o.customer_id and o.status != 'Cancelled'
left join order_items oi on o.order_id = oi.order_id
group by c.segment;

Q13. Payment Status Distribution
select p.payment_status, COUNT(*) AS total_payments
from payments p
group by p.payment_status;

Q14. Average Delivery Time
select ROUND(AVG(DATEDIFF(d.delivery_date, o.order_date)), 2) AS average_delivery_time
from orders o
left join deliveries d on o.order_id = d.order_id
where d.delivery_date is not null and o.order_date is not null;

Q15. Orders Taking More Than Five Days to Deliver
select o.order_id, o.order_date, d.delivery_date, DATEDIFF(d.delivery_date, o.order_date) AS delivery_time
from orders o
left join deliveries d on o.order_id = d.order_id
where d.delivery_date is not null and o.order_date is not null
and DATEDIFF(d.delivery_date, o.order_date) > 5
order by delivery_time desc;

