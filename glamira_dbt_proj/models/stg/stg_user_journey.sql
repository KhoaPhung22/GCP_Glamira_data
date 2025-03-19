{{ config(materialized='view') }}

SELECT 
    source_collection,
    ip,
    country_short,
    country_long,
    city,
    region,
    latitude,
    longitude,
    'add_to_cart' AS action_type
FROM {{ ref('stg_add_to_cart_action') }}

UNION ALL

SELECT 
    source_collection,
    ip,
    country_short,
    country_long,
    city,
    region,
    latitude,
    longitude,
    'back_to_product' AS action_type
FROM {{ ref('stg_back_to_product_action') }}

UNION ALL

SELECT 
    source_collection,
    ip,
    country_short,
    country_long,
    city,
    region,
    latitude,
    longitude,
    'checkout' AS action_type
FROM {{ ref('stg_checkout') }}

UNION ALL

SELECT 
    source_collection,
    ip,
    country_short,
    country_long,
    city,
    region,
    latitude,
    longitude,
    'checkout_success' AS action_type
FROM {{ ref('stg_checkout_success') }}
