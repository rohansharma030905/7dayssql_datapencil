use sql7challenge; 

-- 1 total_orders 

select count(*) as total_orders 
from orders;

-- 2 order status count 

select  status, count(*) as order_status
 from orders group by status;

-- 3. 10 most recent orders 

select order_id, order_date
from orders
order by order_date desc limit 10;

-- 4. 10 highest order with highest total amount

SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total_amount
FROM orders AS o
JOIN order_items AS oi
ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY total_amount DESC limit 10;

-- 5 Daily order volume

select order_date , count(*) as total_count
from orders
group by order_date
order by order_date asc;

-- 6 monthly order trend

select month(order_date) as month , count(*) as total_orders
from orders
group by month(order_date)
order by month(order_date) asc;

-- 7 average order value (rounded)

select round(avg(order_amount),2) as avg_value
from 
(select order_id, sum(quantity*unit_price) as order_amount
from order_items 
group by order_id ) as order_total;

-- 8. top 10 customers by order count 

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY order_count DESC limit 10;

-- INSIGHTS FROM ABOVE QUERIES IS:

-- 1. Total Orders
-- 3,000 orders
-- The database contains 3,000 total orders, providing a solid dataset for analyzing order trends, customer behavior, and business performance.

-- 2. Order Status Analysis
-- - Delivered: 1,796 orders — the largest category, representing approximately 59.9% of all orders.
-- - Returned: 280 orders, while Cancelled: 236 orders.

-- 3. Recent Orders by Date

-- The latest orders shown are dated September 29–30, 2026, indicating recent order activity at the end of September.
-- September 30 has five orders in the displayed sample; this is not the total for that date.

-- 4. Top 10 Highest-Value Orders
-- - Highest order value: 62,489.96
-- - 10th order value: 55,483.76

-- 5. Daily Order Trend 
--  This query shows the number of orders placed on each date, helping the business identify daily demand patterns, 
-- monitor order activity, and recognize peak and low-demand days to support better inventory and staffing decisions.

-- 6. Monthly Order Trends
-- - Highest month: August — 300 orders.
-- - Second-highest: April — 293 orders.
-- - Lowest month: November — 130 orders.

-- 7. Average Order Value
-- 20,886.06
-- The average order value is 20,886.06 currency units per order, providing a baseline for evaluating customer spending and tracking changes in transaction value.

-- 8. Top 10 Customers by Order Count
-- - Most active customers: Tanya Kulkarni and Siddharth Khanna, with 10 orders each.
-- - Next: Neha Kumar, Krishna Das, and Priya Verma, with 9 orders each.
-- - Insight: These customers are frequent purchasers and may be good candidates for loyalty programs and targeted retention campaigns.
