use sql7challenge;

-- Q1. TOTAL SALES VALUE.
-- calculate the total values of all order items.

select sum(oi.quantity*oi.unit_price) as total_sales
from orders o 
join order_items oi on o.order_id = oi.order_id
where status <> 'cancelled';

-- Q2. revenue by product category.
-- identify which product categories generate that most sales.

select p.category, sum(oi.quantity*oi.unit_price) as revenue 
from orders o 
join order_items oi on o.order_id = oi.order_id 
join products p on oi.product_id = p.product_id 
where o.status <> 'cancelled'
group by p.category 
order by revenue asc;

-- Q3. top 10 products by revenue. 
-- find the 10 products generating the highest revenue.

select p.product_id, p.product_name, sum(oi.quantity*oi.unit_price) as total_revenue
from products p 
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name 
order by total_revenue desc
limit 10;

-- Q4. monthly revenue trend.
-- calculate revenue month by month.

select  year(o.order_date) as order_year, month(o.order_date) as order_month, sum(oi.quantity*oi.unit_price) as monthly_revenue
from orders as o 
join order_items as oi on o.order_id = oi.order_id
group by year(o.order_date), month(o.order_date)
order by order_year desc , order_month asc;

-- Q5. revenue by sales channel.
-- identify which sales channels generte the highest revenue.

select o.channel as sales_channel, sum(oi.quantity*oi.unit_price) as total_revenue
from orders as o 
join order_items oi on o.order_id = oi.order_id
group by o.channel
order by total_revenue desc;

-- Q6. total quantity sold by product category.
-- calculate the total quantity of product sold in each category.

select p.category, sum(oi.quantity) as total_quantity_sold
from products as p 
join order_items as oi on p.product_id = oi.product_id
group by p.category 
order by total_quantity_sold desc;

-- Q7. payment method analysis.
-- count how many payments were made using each payment method.

select payment_method, count(*) as total_payments
from payments
group by payment_method
order by total_payments desc;

-- Q8. payment status analysis.
-- count payments by their status.

select payment_status, Count(*) as total_payments
from payments
group by payment_status
order by total_payments desc;

-- Q9. average payment amount.
-- calculate the average recoreded payment amount.

select avg(amount) as average_payment_amount
from payments;

-- Q10.payment amount by payment method.
-- calculate the total recoreded payment amount for each payment method.

select payment_method, sum(amount) as total_payment_amount
from payments
group by payment_method
order by total_payment_amount desc;


