{{ config(materialized='table'
) }}

WITH product AS (
    SELECT
        product_id,
        CONCAT("product" ,"-",product_id) AS product_name
    FROM {{ ref('stg_product') }} 
       
)

SELECT * FROM product
