WITH route_stats AS (
    SELECT 
        origin,
        dest,
        COUNT(*) AS total_flights,
        COUNT(DISTINCT tail_number) AS unique_airplanes,
        COUNT(DISTINCT airline) AS unique_airlines,
        AVG(actual_elapsed_time) AS avg_actual_elapsed_time,
        AVG(arr_delay) AS avg_arrival_delay,
        MAX(arr_delay) AS max_arrival_delay,
        MIN(arr_delay) AS min_arrival_delay,
        SUM(cancelled) AS total_cancelled,
        SUM(diverted) AS total_diverted
    FROM prep_flights
    GROUP BY origin, dest
),
origin_airport AS (
    SELECT 
        faa AS origin_faa, 
        city AS origin_city, 
        country AS origin_country, 
        name AS origin_name
    FROM prep_airports
),
destination_airport AS (
    SELECT 
        faa AS dest_faa, 
        city AS dest_city, 
        country AS dest_country, 
        name AS dest_name
    FROM prep_airports
)
SELECT 
    origin_faa AS origin_airport_code, 
    dest_faa AS destination_airport_code,
    rs.total_flights,
    rs.unique_airplanes,
    rs.unique_airlines,
    rs.avg_actual_elapsed_time,
    rs.avg_arrival_delay,
    rs.max_arrival_delay,
    rs.min_arrival_delay,
    rs.total_cancelled,
    rs.total_diverted,
    o.origin_city, 
    o.origin_country, 
    o.origin_name,
    d.dest_city, 
    d.dest_country, 
    d.dest_name
FROM route_stats rs
LEFT JOIN origin_airport o ON rs.origin = o.origin_faa
LEFT JOIN destination_airport d ON rs.dest = d.dest_faa