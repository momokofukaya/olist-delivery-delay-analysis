SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS order_month,
    COUNT(*) AS delivered_orders,
    COUNT(*) FILTER (
        WHERE CAST(order_delivered_customer_date AS DATE)
            > CAST(order_estimated_delivery_date AS DATE)
    ) AS late_orders,
    ROUND(100.0 * late_orders / delivered_orders, 2) AS late_pct
FROM orders
WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
    AND order_estimated_delivery_date IS NOT NULL
GROUP BY order_month
ORDER BY order_month;
