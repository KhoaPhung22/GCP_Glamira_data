{{ config(materialized='table') }}

WITH options AS (
    SELECT DISTINCT
        option_id,
        option_label,
        value_label,
    FROM {{ref("stg_product")}}
)
SELECT * FROM options
