{{ config(materialized='table') }}

WITH locations AS (
    SELECT DISTINCT
        FARM_FINGERPRINT(ip) AS location_id,
        ip,
        country_short,
        country_long,
        city,
        region,
        latitude,
        longitude,
    FROM {{ref("stg_user_journey")}}
)
SELECT * FROM locations
