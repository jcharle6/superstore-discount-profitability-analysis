USE superstore;

SELECT 
	ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(discount), 2) AS avg_discount
FROM orders;

SELECT 
	region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

SELECT 
	category, 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC;


/*
Superstore SQL Practice — Regional Performance
CTE edition below
*/

With regional_orders AS (
	SELECT 
		region,
		COUNT(order_id) as order_count, 
        Sum(sales) as total_sales, 
        SUM(profit) as total_profit,
        ROUND(AVG(profit),2) as avg_profit
	FROM 
		orders
	GROUP BY region
	),
    regional_metrics AS (
		SELECT 
			order_count,
            region,
            total_sales,
            total_profit,
            avg_profit,
            Round(100*(total_profit)/total_sales , 2) as profit_margin
		FROM regional_orders
    )
		SELECT
			order_count,
            region,
            total_sales,
            total_profit,
            avg_profit,
            profit_margin,
            RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
		FROM regional_metrics
        ORDER BY profit_rank DESC
	;



    