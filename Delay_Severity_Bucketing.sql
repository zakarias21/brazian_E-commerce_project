---PHASE 3 — Delay Severity Bucketing (Important Stage)
----------------------------------------------------------------------------------
CREATE VIEW show_delivery_delay_buckets AS
SELECT 
    order_id,
    customer_id,
    actual_delivery_days,
    estimated_delivery_days,
    delay_days,
    is_late,
    CASE
        WHEN is_late = 0 THEN 'On Time'
        WHEN delay_days BETWEEN 1 AND 3 THEN 'Late (1-3 Days)'
        WHEN delay_days BETWEEN 4 AND 7 THEN 'Late (4-7 Days)'
        WHEN delay_days BETWEEN 8 AND 14 THEN 'Late (8-14 Days)'
        WHEN delay_days > 14 THEN 'Severely Late (15+ Days)'
    END AS delay_bucket
FROM vw_delivered_orders;
GO
---Checks distribution of delay severity
SELECT delay_bucket,
       COUNT(*) AS order_count,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM vw_delivery_delay_buckets), 2) AS percentage
FROM vw_delivery_delay_buckets
GROUP BY delay_bucket
ORDER BY percentage DESC;