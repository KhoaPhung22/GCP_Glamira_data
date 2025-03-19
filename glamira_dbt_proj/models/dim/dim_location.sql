{{ config(materialized='table') }}

WITH locations AS (
    SELECT DISTINCT
        ip,
        country_short,
        country_long,
        city,
        region,
        latitude,
        longitude
    FROM {{ref("stg_user_journey")}}
)
SELECT * FROM locations
