-- Overall delivery performance
SELECT
    COUNT(*) AS delivered_orders,
    COUNT(*) FILTER (
        WHERE CAST(order_delivered_customer_date AS DATE)
            > CAST(order_estimated_delivery_date AS DATE)
    ) AS delayed_orders,
    ROUND(
        100.0 * delayed_orders / delivered_orders, 2
    ) AS late_pct
FROM orders
WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
    AND order_estimated_delivery_date IS NOT NULL;


-- Create an order-level view of delayed deliveries
CREATE OR REPLACE VIEW delayed_orders AS
SELECT
    order_id,
    DATE_DIFF(
        'day',
        CAST(order_estimated_delivery_date AS DATE),
        CAST(order_delivered_customer_date AS DATE)
    ) AS delay_days
FROM orders
WHERE order_status = 'delivered'
    AND CAST(order_delivered_customer_date AS DATE)
        > CAST(order_estimated_delivery_date AS DATE);


-- Distribution of delay days
SELECT
    delay_days,
    COUNT(*) AS order_count
FROM delayed_orders
GROUP BY delay_days
ORDER BY delay_days;

-- Delay severity statistics
SELECT
    COUNT(*) AS delayed_orders,
    ROUND(AVG(delay_days), 2) AS avg_delay_days,
    MEDIAN(delay_days) AS median_delay_days,
    MAX(delay_days) AS max_delay_days,
    PERCENTILE_CONT(0.9) WITHIN GROUP (
        ORDER BY delay_days
    ) AS p90_delay_days
FROM delayed_orders;