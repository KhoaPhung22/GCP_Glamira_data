{{ config(materialized='view') }}

SELECT 
    source_collection,
    ip,
    country_short,
    country_long,
    city,
    region,
    latitude,
    longitude
FROM `glamira-project-2.glamira_warehouse.add_to_cart_action`
WHERE ip is NOT NULL 
AND country_long is NOT NULL 
AND city is NOT NULL 
AND region is NOT NULL
