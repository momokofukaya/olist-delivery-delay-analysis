-- Order counts and status distribution
SELECT
    COUNT(*) AS total_orders
FROM orders;
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Order ID uniqueness and NULL check
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_ids
FROM orders;

-- Missing delivery dates among delivered orders
SELECT
    COUNT(*) AS orders_with_missing_dates
FROM orders
WHERE order_status = 'delivered'
    AND (
        order_delivered_customer_date IS NULL
        OR order_estimated_delivery_date IS NULL
    );

-- Eligible orders for delivery delay analysis
SELECT
    COUNT(*) AS eligible_orders
FROM orders
WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
    AND order_estimated_delivery_date IS NOT NULL;
