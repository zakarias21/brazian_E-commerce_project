---PHASE 4 — Linking Delivery to Customer Reviews
-------------------------------------------------------------
CREATE VIEW show_delivery_review_analysis AS
SELECT 
    d.order_id,
    d.delay_bucket,
    r.review_score,
    CASE
        WHEN review_score IN (1,2) THEN 'Negative (1-2)'
        WHEN review_score = 3 THEN 'Neutral (3)'
        WHEN review_score IN (4,5) THEN 'Positive (4-5)'
    END AS review_sentiment
FROM vw_delivery_delay_buckets d
LEFT JOIN olist_order_reviews_dataset r
    ON d.order_id = r.order_id
WHERE review_score IS NOT NULL;
GO
SELECT delay_bucket,
       review_sentiment,
       COUNT(*) AS count_reviews,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY delay_bucket), 2) AS percentage
FROM vw_delivery_review_analysis
GROUP BY delay_bucket, review_sentiment
ORDER BY delay_bucket, review_sentiment;