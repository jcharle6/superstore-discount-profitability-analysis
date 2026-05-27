USE superstore;

SELECT 
	category, 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC;

SELECT 
	sub_category, 
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY sub_category, category
ORDER BY category,total_sales DESC;

/* 
Lets check the correlation between discounts and profit, the below code simulates
the formula for correlation
*/

SELECT 
    (COUNT(*)*SUM(discount*profit) - SUM(discount)*SUM(profit)) /
    SQRT(
        (COUNT(*)*SUM(discount*discount) - POWER(SUM(discount),2)) *
        (COUNT(*)*SUM(profit*profit) - POWER(SUM(profit),2))
    ) AS discount_profit_corr
FROM orders;
/*
Correlation = -0.32 represents a moderate negative relationship, this confirms that there
is some connection between higher discounts generally reducing profit.
*/

SELECT 
	sub_category,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
WHERE sub_category = 'Tables'
GROUP BY sub_category;

SELECT 
	discount,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
WHERE sub_category = 'Tables'
GROUP BY discount
ORDER BY discount;

/* 
tables are being over discounted, we notice a sharp decline in profits for discounts > 20%.
Average discount was calculated at 29%. 
*/

/*
Are other catergories affected by discounts as well?
Table below answers this, furniture shows slightly higher average discounting, but
further analysis of sub categories such as tables show they are heavily dicounted 
which significantly impacts profitability
*/
SELECT
	category,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY category
ORDER BY avg_discount DESC;

SELECT 
	sub_category,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
WHERE category = 'Furniture'
GROUP BY sub_category
ORDER BY avg_discount DESC;

-- Below table is for discount vs profit by region

SELECT 
	region,
    ROUND(AVG(discount),2) AS avg_discount,
    ROUND(AVG(profit), 2) AS  avg_profit,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(*) AS num_orders
FROM orders
GROUP BY region
ORDER BY total_profit DESC;
-- ORDER BY avg_discount DESC;

/*
Table results show that the regions with the 
highest avg discount also have the lowest toal profit. There is the possibility that 
the need for heavy discounting was to clear inventory space. Our weak performers are 
western africa, central asia, and western asia. Lets push this further to see what catergory
subcatergory is the issue
*/





SELECT 
	region,
    sub_category,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(AVG(profit), 2) AS avg_profit,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY region, sub_category
HAVING avg_profit < 0 and avg_discount > 0.2
ORDER BY region, avg_discount DESC;

/*
Insight: “Tables consistently generate negative profit across multiple regions,
 especially Eastern US (-$11k), South America (-$13k), 
 and Southeastern Asia (-$18k). This correlates with high average discounts (22–53%),
 suggesting over-discounting is driving substantial losses. 
 Machines also show regional losses, but less consistently.”
*/
    
-- Lets look into returns
-- Negative profit + returns analysis

SELECT
	o.region,
    o.sub_category,
    o.product_name,
    ROUND(SUM(o.profit),2) AS total_profit,
    COUNT(r.order_id) AS num_returns,
    ROUND(AVG(o.discount),2) AS avg_discount
FROM orders o
JOIN returns r
	ON o.order_id = r.order_id
GROUP BY o.region, o.sub_category, o.product_name
HAVING total_profit < 0
ORDER BY region, sub_category, total_profit, avg_discount;

/*
“Analyzed returned orders to identify unprofitable products. 
Found that frequently returned items often had high average discounts, 
reinforcing the negative relationship between discounting and profitability.”
*/

SELECT 
	p.person AS region_owner,
    o.region,
    ROUND(SUM(o.profit),2) AS total_profit,
    ROUND(AVG(o.discount),2) AS avg_discount,
    COUNT(r.order_id) AS num_returns
FROM orders o
LEFT JOIN returns r
	ON o.order_id = r.order_id
JOIN people p
	ON TRIM(REPLACE(o.region, '\r', '')) = TRIM(REPLACE(p.region, '\r', ''))
GROUP BY region_owner, o.region
ORDER BY total_profit;

-- =====================================================
-- NOTE ON JOINING REGION FIELDS
-- =====================================================
-- The join between 'orders' and 'people' uses the region field.
-- During development, this join initially returned no results due to
-- hidden formatting inconsistencies in the data (e.g., trailing spaces
-- or non-standard whitespace characters from CSV imports).
--
-- Since SQL joins require exact string matches, even small differences
-- (such as extra spaces) can prevent rows from matching.
--
-- To resolve this, TRIM() is applied to both fields in the join condition
-- to remove leading/trailing whitespace and ensure proper matching.
--
-- This highlights the importance of data cleaning when working with
-- imported datasets.
-- =====================================================

/*
Regional performance analysis shows that profitability is strongly influenced 
by discounting strategies. Regions such as Western Asia and Western Africa, 
which apply high average discounts (35–43%), generate significant losses exceeding $50,000. 
In contrast, top-performing regions like Western Europe and Eastern Asia maintain lower 
discount levels (5–10%) while achieving the highest profits. This suggests that 
excessive discounting is a key driver of financial underperformance.
*/









    
