{{ config(
    materialized='table'
) }}

WITH cleaned AS (
    SELECT 
        -- General Fields
        TRIM(time_stamp) AS time_stamp,
        TRIM(ip) AS ip,
        FARM_FINGERPRINT(ip) AS location_id,
        TRIM(user_agent) AS user_agent,
        TRIM(resolution) AS resolution,
        TRIM(user_id_db) AS user_id_db,
        TRIM(device_id) AS device_id,
        TRIM(api_version) AS api_version,
        TRIM(store_id) AS store_id,
        TRIM(local_time) AS local_time,

        -- Boolean Fields (Fixed)
        SAFE_CAST(show_recommendation AS BOOLEAN) AS show_recommendation,
        SAFE_CAST(recommendation AS BOOLEAN) AS recommendation,
        SAFE_CAST(is_paypal AS BOOLEAN) AS is_paypal,

        -- URLs & Identifiers
        TRIM(current_url) AS current_url,
        TRIM(referrer_url) AS referrer_url,
        TRIM(email_address) AS email_address,
        TRIM(utm_source) AS utm_source,
        TRIM(utm_medium) AS utm_medium,
        TRIM(collection) AS collection,
        TRIM(product_id) AS product_id,
        TRIM(viewing_product_id) AS viewing_product_id,
        TRIM(cat_id) AS cat_id,
        TRIM(collect_id) AS collect_id,
        order_id,
        TRIM(recommendation_product_id) AS recommendation_product_id,
        TRIM(recommendation_clicked_position) AS recommendation_clicked_position,
        TRIM(key_search) AS key_search,
       
        -- Cleaning Price and Currency
        SAFE_CAST(
            REPLACE(
                TRIM(REGEXP_REPLACE(price, r'[^\d.,]', '')),  -- Remove non-numeric characters
                ',', ''  -- Convert European format
            ) AS FLOAT64
        ) AS price,

        TRIM(currency) AS currency,

        -- Integer Fields
        SAFE_CAST(recommendation_product_position AS INT64) AS recommendation_product_position,

        -- Cleaning Nested Options
        ARRAY(
            SELECT AS STRUCT 
                TRIM(option_label) AS option_label,
                TRIM(option_id) AS option_id,
                TRIM(value_label) AS value_label,
                TRIM(value_id) AS value_id,
                TRIM(quality) AS quality,
                TRIM(quality_label) AS quality_label,
                TRIM(alloy) AS alloy,
                TRIM(diamond) AS diamond,
                TRIM(shapediamond) AS shapediamond,
                TRIM(stone) AS stone,
                TRIM(pearlcolor) AS pearlcolor,
                TRIM(finish) AS finish,
                SAFE_CAST(
                    REPLACE(
                        TRIM(REGEXP_REPLACE(price, r'[^\d.,]', '')), ',', ''
                    ) AS FLOAT64
                ) AS price,
                TRIM(category_id) AS category_id,
                TRIM(kollektion) AS kollektion,
                TRIM(kollektion_id) AS kollektion_id
            FROM UNNEST(option)
        ) AS option,

        -- Cleaning Nested Cart Products
        ARRAY(
            SELECT AS STRUCT 
                TRIM(product_id) AS product_id,
                SAFE_CAST(
                    REPLACE(
                        TRIM(REGEXP_REPLACE(price, r'[^\d.,]', '')), ',', ''
                    ) AS FLOAT64
                ) AS price,
                TRIM(currency) AS currency,
                SAFE_CAST(amount AS INT64) AS amount,
                ARRAY(
                    SELECT AS STRUCT 
                        TRIM(option_id) AS option_id,
                        TRIM(option_label) AS option_label,
                        TRIM(value_id) AS value_id,
                        TRIM(value_label) AS value_label
                    FROM UNNEST(option)
                ) AS option
            FROM UNNEST(cart_products)
        ) AS cart_products

    FROM `glamira-project-2.glamira_warehouse.summary2`
)

SELECT * FROM cleaned

