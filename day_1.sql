create database sql7challenge;
use sql7challenge;

-- customers 

create table customers
(customer_id int primary key,
full_name varchar(100) not null,
email varchar(100) not null,
city varchar(50) not null,
signup_date date not null,
segment varchar(20) not null);

-- products

create table products (
product_id int primary key,
product_name varchar(100) not null,
category varchar(50),
price decimal(10,2),
cost decimal(10,2));

-- orders 

create table orders 
(order_id int primary key,
customer_id int not null,
order_date date not null,
status varchar(20),
channel varchar(20),

foreign key (customer_id) references customers(customer_id));

-- orders_itmes

create table order_items 
(order_item_id int primary key,
order_id int not null,
product_id int not null,
quantity int not null,
unit_price decimal(10,2),

foreign key (order_id) references orders(order_id),
foreign key (product_id) references products(product_id));

-- payments 

create table payments 
(payment_id int primary key,
order_id int not null unique,
payment_method varchar(50) not null,
payment_status varchar(50) not null,
amount decimal(10,2),
foreign key (order_id) references orders(order_id));

-- deliveries

create table deliveries 
(delivery_id int primary key,
order_id int not null unique,
dispatch_date date,
delivery_date date null,
delivery_status varchar(50),

foreign key (order_id) references orders(order_id));


