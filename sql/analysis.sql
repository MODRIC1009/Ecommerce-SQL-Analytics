-- Count Imports 
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;

-- SECTION 1: OVERALL SALES PERFORMANCE

-- 1. Total revenue
SELECT ROUND(SUM(payment_value), 2) AS total_revenue
FROM payments;

-- 2. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 3. Average order value
SELECT ROUND(AVG(payment_value), 2) AS avg_order_value
FROM payments;

-- 4. Total number of customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- SECTION 2: TIME-BASED ANALYSIS

-- 5. Monthly revenue
SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- 6. Monthly order volume
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- 7. Revenue by day of week
SELECT 
    DAYNAME(order_purchase_timestamp) AS day_of_week,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY day_of_week
ORDER BY revenue DESC;

-- SECTION 3: CUSTOMER ANALYSIS

-- 8. Top 10 customers by spending
SELECT 
    o.customer_id,
    ROUND(SUM(p.payment_value), 2) AS total_spent
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 9. Repeat vs new customers
SELECT
    CASE
        WHEN order_count = 1 THEN 'New Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) t
GROUP BY customer_type;

-- 10. Average customer lifetime value
SELECT 
    ROUND(AVG(total_spent), 2) AS avg_customer_ltv
FROM (
    SELECT 
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY o.customer_id
) t;

-- 11. Top 5 cities by revenue
SELECT 
    c.customer_city,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_city
ORDER BY revenue DESC
LIMIT 5;

-- SECTION 4: PRODUCT PERFORMANCE

-- 12. Top 10 products by revenue
SELECT 
    product_id,
    ROUND(SUM(price), 2) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

-- 13. Top categories by revenue
SELECT 
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10;

-- 14. Average product price by category
SELECT 
    p.product_category_name,
    ROUND(AVG(oi.price), 2) AS avg_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_price DESC;

-- 15. Top 5 most frequently ordered products
SELECT 
    product_id,
    COUNT(*) AS order_count
FROM order_items
GROUP BY product_id
ORDER BY order_count DESC
LIMIT 5;

-- SECTION 5: PAYMENT ANALYSIS

-- 16. Payment method distribution
SELECT 
    payment_type,
    COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- 17. Revenue by payment type
SELECT 
    payment_type,
    ROUND(SUM(payment_value), 2) AS revenue
FROM payments
GROUP BY payment_type
ORDER BY revenue DESC;

-- 18. Average installment count
SELECT 
    ROUND(AVG(payment_installments), 2) AS avg_installments
FROM payments;

-- SECTION 6: OPERATIONAL METRICS

-- 19. Average delivery time (days)
SELECT 
    ROUND(AVG(
        DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)
    ), 2) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 20. Orders by status
SELECT 
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- SECTION 7: ADVANCED ANALYSIS

-- 21. Top 10 customers using window function
SELECT *
FROM (
    SELECT 
        o.customer_id,
        SUM(p.payment_value) AS total_spent,
        RANK() OVER (ORDER BY SUM(p.payment_value) DESC) AS rank_position
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY o.customer_id
) ranked_customers
WHERE rank_position <= 10;

-- 22. Monthly revenue growth
SELECT 
    month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change
FROM (
    SELECT 
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
        SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY month
) t;

-- 23. Order value distribution
SELECT 
    CASE
        WHEN payment_value < 50 THEN 'Low Value'
        WHEN payment_value BETWEEN 50 AND 150 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_segment,
    COUNT(*) AS total_orders
FROM payments
GROUP BY order_value_segment;

-- 24. Customer order frequency
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- 25. Revenue contribution by top 10 customers
SELECT 
    ROUND(SUM(total_spent), 2) AS top10_revenue
FROM (
    SELECT 
        o.customer_id,
        SUM(p.payment_value) AS total_spent
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY o.customer_id
    ORDER BY total_spent DESC
    LIMIT 10
) t;