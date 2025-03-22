{{ config(
    materialized='table'
) }}

WITH stores AS (
    SELECT
        DISTINCT store_id,
        CONCAT("store", ' - ', store_id) AS store_name,
    FROM {{ ref('stg_summary') }} s
)

SELECT * FROM stores
