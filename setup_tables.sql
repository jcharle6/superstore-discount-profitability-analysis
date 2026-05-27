DROP DATABASE IF EXISTS superstore;
CREATE DATABASE superstore;
USE superstore;

DROP TABLE IF EXISTS orders, returns, people ;

CREATE TABLE orders(
	row_id INT, order_id VARCHAR(40), order_date DATE, ship_date DATE, ship_mode VARCHAR(50),
    customer_id VARCHAR(20), customer_name VARCHAR(100), segment VARCHAR(50), 
    postal_code VARCHAR(20), city VARCHAR(50), state VARCHAR(50), country VARCHAR(50),
    region VARCHAR(50), market VARCHAR(20), product_id VARCHAR(20), category VARCHAR(50), 
    sub_category VARCHAR(50), product_name VARCHAR(200), sales DECIMAL(10,2), quantity INT,
    discount DECIMAL(4,2), profit DECIMAL(10,2), shipping_cost DECIMAL(10,2), order_priority VARCHAR(20)
    );
    
Create TABLE returns (
	returned VARCHAR(10),
	order_id VARCHAR(40),
    region VARCHAR(30)
);

CREATE TABLE people (
	region VARCHAR(50),
    person VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@row_id, @order_id, @order_date, @ship_date, @ship_mode,@customer_id,
@customer_name,@segment,@postal_code,@city,@state,@country,@region,@market,@product_id,
@category, @sub_category, @product_name,@sales,@quantity,@discount,@profit,@shipping_cost,@order_priority)

SET
row_id = @row_id, order_id = @order_id, 
order_date = str_to_date(@order_date, '%m/%d/%Y'),
ship_date = str_to_date(@ship_date, '%m/%d/%Y'),
ship_mode = @ship_mode, customer_id = @customer_id, customer_name = @customer_name,
segment = @segment, postal_code = @postal_code, 
city = @city, state = @state, country = @country,
region = @region, market = @market,
product_id = @product_id, category = @category,
sub_category = @sub_category, product_name = @product_name,
sales = @sales, quantity = @quantity, discount = @discount, profit = @profit,
shipping_cost = @shipping_cost, order_priority = @order_priority;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/returns.csv'
INTO TABLE returns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@returned, @order_id,@region)
SET 
returned = @returned,
order_id = @order_id,
region = @region;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/people.csv'
INTO TABLE peopleorders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@person, @region)
SET
person = @person,
region = @region;


        

    
    