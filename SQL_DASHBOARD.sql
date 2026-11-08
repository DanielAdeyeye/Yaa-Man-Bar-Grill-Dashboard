
-- Yaa Man Bar & Grill — SQL behind the Tableau BI dashboard
-- Run against the star schema: fact_sales_line, dim_date, dim_item,
-- dim_server, dim_payment_method (see schema.sql / README.md)
-- ===================================================================


-- 1. TOTAL ORDERS (card: 636)
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM fact_sales_line;


-- 2. TOTAL REVENUE (card: 5,968)
SELECT ROUND(SUM(sales_amount), 2) AS total_revenue
FROM fact_sales_line;


-- 3. AVERAGE ORDER VALUE (card: 9.384)
-- Revenue divided by distinct orders, not by line count —
-- an order with 3 lines should count once on the denominator.
SELECT ROUND(
    SUM(sales_amount) / COUNT(DISTINCT order_id), 3
) AS average_order_value
FROM fact_sales_line;


-- 4. TOP SALES EMPLOYEES % (Damien 24.84%, T.Brown 13.84%, Priya 12.89%,
--    Toni-Ann 12.11%, Josh 12.42%, Kayla 11.01% — dashboard shows top 4)
-- Share of DISTINCT orders per server, not line count.
SELECT
    s.server,
    COUNT(DISTINCT f.order_id) AS orders_handled,
    ROUND(
        100.0 * COUNT(DISTINCT f.order_id)
        / SUM(COUNT(DISTINCT f.order_id)) OVER (), 2
    ) AS pct_of_total_orders
FROM fact_sales_line f
JOIN dim_server s ON f.server_key = s.server_key
GROUP BY s.server
ORDER BY orders_handled DESC;


-- 5. SALES BY TOP 6 MONTHS (order counts: Jan 103, Feb 97, Mar 95,
--    Apr 102, May 111, Jun 108)
SELECT top (6)
    d.month_name,
    d.month_number,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM fact_sales_line f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.month_name, d.month_number
ORDER BY total_orders DESC;

-- 6. TOTAL ORDERS BY TOP 4 PAYMENT METHODS (Card 272, Cash 183,
--    Online 95, Contactless 86)
SELECT
    p.payment_method,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM fact_sales_line f
JOIN dim_payment_method p ON f.payment_method_key = p.payment_method_key
GROUP BY p.payment_method
ORDER BY total_orders DESC;


-- 7. TOTAL ORDERS BY TOP 6 TABLE NUMBERS (Table 1 dominates at 163;
--    tables 2,3,5,11,13 each in the low 30s)
-- table_number lives directly on the fact table — no dimension join
-- needed (this is the degenerate dimension decision from the schema).
SELECT top (6)
    table_number,
    COUNT(DISTINCT order_id) AS total_orders
FROM fact_sales_line
GROUP BY table_number
ORDER BY total_orders DESC


-- 8. TOTAL SALES BY CATEGORY (order counts: Main 195, Drink 159,
--    Starter 125, Side 101, Dessert 56)
-- Note: this is DISTINCT ORDERS per category, not order LINES —
-- an order with 2 items in the same category still counts once here.
SELECT
    i.category,
    COUNT(DISTINCT f.order_id) AS total_orders
FROM fact_sales_line f
JOIN dim_item i ON f.item_key = i.item_key
GROUP BY i.category
ORDER BY total_orders DESC;