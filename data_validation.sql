USE superstore;


-- Check for Null values 
SELECT *
FROM orders
WHERE order_id IS NULL 
	OR sales IS NULL 
    OR profit IS NULL;
    
SELECT *
FROM people
WHERE person IS NULL 
	OR region IS NULL;

SELECT *
FROM returns
WHERE returned IS NULL
	OR order_id IS NULL
    OR region IS NULL;

-- Check for duplicate values
-- Since row_id will always be unique in this case, we check every other value
SELECT 
    order_id, order_date, ship_date, ship_mode, customer_id,
    customer_name, segment, country, city, state, postal_code,
    region, product_id, category, sub_category, product_name,
    sales, quantity,discount, profit, shipping_cost,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY 
    order_id, order_date, ship_date, ship_mode,
    customer_id, customer_name, segment, country,
    city, state, postal_code, region, product_id,
    category, sub_category, product_name, sales,
    quantity, discount, profit, shipping_cost
HAVING COUNT(*) > 1
ORDER BY order_id;

-- Check for negative sales(should not exist)
SELECT *
FROM orders
WHERE sales < 0  OR quantity < 0;





