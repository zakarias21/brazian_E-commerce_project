SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM olist_customers_dataset
UNION ALL SELECT 'geolocation', COUNT(*) FROM olist_geolocation_dataset
UNION ALL SELECT 'order_items', COUNT(*) FROM olist_order_items_dataset
UNION ALL SELECT 'order_payments', COUNT(*) FROM olist_order_payments_dataset
UNION ALL SELECT 'order_reviews', COUNT(*) FROM olist_order_reviews_dataset
UNION ALL SELECT 'orders', COUNT(*) FROM olist_orders_dataset
UNION ALL SELECT 'products', COUNT(*) FROM olist_products_dataset
UNION ALL SELECT 'sellers', COUNT(*) FROM olist_sellers_dataset
UNION ALL SELECT 'category_translation', COUNT(*) FROM product_category_name_translation;
--* see which tables are large/small.
--* Helps anticipate performance considerations.
----------------------------------------------------------------------------------------------------------------
-- Check missing order dates
SELECT 
    SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS missing_purchase_dates,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS missing_delivery_dates,
    COUNT(*) AS total_orders
FROM olist_orders_dataset;
--* Delivery analysis relies on these timestamps
----------------------------------------------------------------------------------------------------------------
-- uniqueness checking codes
SELECT order_id, COUNT(*) AS cnt
FROM olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*) > 1; 

SELECT customer_id, COUNT(*) AS cnt
FROM olist_customers_dataset
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT seller_id, COUNT(*) AS cnt
FROM olist_sellers_dataset
GROUP BY seller_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS cnt
FROM olist_products_dataset
GROUP BY product_id
HAVING COUNT(*) > 1;