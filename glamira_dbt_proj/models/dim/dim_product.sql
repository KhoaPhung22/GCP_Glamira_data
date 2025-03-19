SELECT 
    s.order_id, 
    c.product_id,
    COALESCE(CAST(c.price AS STRING), 'N/A') AS price,
    COALESCE(c.currency, 'N/A') AS currency,
    c.amount,
    o.option_id,
    o.option_label,
    o.value_id,
    o.value_label
FROM `glamira-project-2.glamira_warehouse.summary2` AS s
LEFT JOIN UNNEST(s.cart_products) AS c  -- Unnest cart_products array
LEFT JOIN UNNEST(c.option) AS o         -- Unnest option array inside cart_products
WHERE c.product_id IS NOT NULL
