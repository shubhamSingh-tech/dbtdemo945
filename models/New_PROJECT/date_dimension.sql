WITH CTE AS (
    SELECT
        TO_TIMESTAMP(started_at) AS started_at_ts,
        DATE(TO_TIMESTAMP(started_at)) AS date_started_at,
        HOUR(TO_TIMESTAMP(started_at)) AS hour_started_at,

        -- Day type (weekend vs business day)
        CASE 
            WHEN DAYNAME(TO_TIMESTAMP(started_at)) IN ('Sat', 'Sun') 
                THEN 'WEEKEND'
            ELSE 'BUSINESSDAY'
        END AS day_type,

        -- Season of year
        CASE 
            WHEN MONTH(TO_TIMESTAMP(started_at)) IN (12, 1, 2) THEN 'WINTER'
            WHEN MONTH(TO_TIMESTAMP(started_at)) IN (3, 4, 5) THEN 'SPRING'
            WHEN MONTH(TO_TIMESTAMP(started_at)) IN (6, 7, 8) THEN 'SUMMER'
            ELSE 'AUTUMN'
        END AS season_of_year
    FROM {{ source('demo', 'bike') }}
    WHERE started_at IS NOT NULL
)
SELECT *
FROM CTE;