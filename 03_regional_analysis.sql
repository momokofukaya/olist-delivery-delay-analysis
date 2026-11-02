-- Confirm that each order still appears once after joining customers
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT orders.order_id) AS unique_orders,
    COUNT(*) FILTER (WHERE customers.customer_state IS NULL) AS missing_customer_state
FROM orders
LEFT JOIN customers
    ON orders.customer_id = customers.customer_id;


-- Delivery performance by customer state

SELECT
    customers.customer_state,
    COUNT(*) AS delivered_orders,
    COUNT(*) FILTER (
        WHERE CAST(orders.order_delivered_customer_date AS DATE)
            > CAST(orders.order_estimated_delivery_date AS DATE)
    ) AS late_orders,
    ROUND(100.0 * late_orders / delivered_orders, 2) AS late_rate_pct
FROM orders
LEFT JOIN customers
    ON orders.customer_id = customers.customer_id
WHERE orders.order_status = 'delivered'
    AND orders.order_delivered_customer_date IS NOT NULL
    AND orders.order_estimated_delivery_date IS NOT NULL
GROUP BY customers.customer_state
ORDER BY late_orders DESC;
