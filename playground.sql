USE superstore;

SELECT 
	o.order_id,
	ROUND(o.profit,2) as profit,
    CASE
		WHEN r.returned = 'Yes' THEN 'Yes'
        ELSE 'No'
	END AS returned_status
FROM 
	orders o 
LEFT JOIN 
	returns r 
ON  o.order_id = r.order_id
Order BY o.profit DESC;


/*
Practice Problem — Identify High-Risk Customers
The business wants to identify customers who may be hurting profitability.

query below groups customer information and key metrics for orders, displaying their 
orders and return rate/frequency
*/

SELECT 
	o.customer_id,
    o.customer_name,
    round(SUM(o.sales),2) as total_sales,
    round(SUM(o.profit),2) as total_profit,
    Count(o.order_id) as total_orders,
    SUM(
		CASE 
			WHEN r.returned = 'YES' THEN 1
            ELSE 0
		END) AS count_returned_orders,
     ROUND(
		SUM(
			CASE 
				WHEN r.returned = 'YES' THEN 1
				ELSE 0
			END)/COUNT(o.order_id) *100, 2) AS return_rate
    FROM orders o
    LEFT JOIN returns r ON
    o.order_id = r.order_id
    GROUP BY 
    o.customer_id,
    o.customer_name
    HAVING 
    return_rate > 30
    AND total_orders > 5
    ORDER BY return_rate DESC;
    
/*
 Query below is similar to the one on top but focuses more so on readability through
 the use of CTE'S. 
 
 I built a multi-step CTE pipeline to analyze customer profitability 
 and return behavior, calculating key metrics such as return rate and
 profit per order, and identifying high-risk low-profit customer segments
*/

WITH customer_base AS (
	SELECT
		o.customer_id,
        o.customer_name,
        o.order_id,
        o.sales,
        o.profit,
        r.returned
	FROM orders o
    LEFT JOIN returns r ON 
    o.order_id = r.order_id
), customer_metrics AS (
	SELECT 
		customer_id,
        customer_name,
        count(order_id) as total_orders,
        Round(SUM(sales),2) as total_sales,
        Round(SUM(profit),2) as total_profit,
        SUM(CASE 
			WHEN returned = "YES" THEN 1
            ELSE 0 END) as return_count
	FROM customer_base
    GROUP BY
    customer_id, customer_name
),
customer_insights AS(
	SELECT 
		customer_id,
        customer_name,
        total_orders,
        total_sales,
        total_profit,
        return_count, 
        100 * (return_count/total_orderS) AS return_rate
	FROM customer_metrics
)

SELECT 
	customer_id,
    customer_name,
    total_sales,
    total_profit,
    total_orders,
    total_sales,
    return_count,
    return_rate
FROM 
	customer_insights
WHERE 
	return_rate > 30 AND total_orders > 5
ORDER BY return_rate DESC;



    



