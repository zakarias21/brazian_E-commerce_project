---PHASE 2 — Create Clean Delivered Orders Table
--------------------------------------------
CREATE VIEW view_delivered_orders AS
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    DATEDIFF(day, order_purchase_timestamp, order_delivered_customer_date) AS actual_delivery_days,
    DATEDIFF(day, order_purchase_timestamp, order_estimated_delivery_date) AS estimated_delivery_days,
    DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) AS delay_days,
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 0
        ELSE 1
    END AS is_late
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;
GO
SELECT 
    COUNT(*) AS total_delivered_orders,
    SUM(is_late) AS late_orders,
    ROUND(100.0 * SUM(is_late) / COUNT(*), 2) AS late_rate_percent
FROM vw_delivered_orders;