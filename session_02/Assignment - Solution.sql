/*
#######################################################################
#
#   Assignment #1 Solution
#
#   This SQL has been tested within Google Cloud BigQuery
#
#######################################################################
*/

/*
# Question 1: Which bike station in Austin is the most popular when starting a trip?
#
# Answer:
# 1     21st & Speedway @PCL        72799
# 2     Riverside @ S. Lamar        40635
# 3     City Hall / Lavaca & 2nd    36520
# 4     2nd & Congress              35307
# 5     Rainey St @ Cummings        34758
*/

SELECT
    start_station_name,
    count(*) as counts
FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips`
GROUP BY
    start_station_name
ORDER BY
    counts desc


/*
# Question #2: Which routes (start to end point) are the most popular? List the top 5.
#
# Answer:
# 1	21st & Speedway @PCL    21st & Speedway @PCL    13109
# 2	Riverside @ S. Lamar    Riverside @ S. Lamar    12302
# 3	21st & Speedway @PCL    Dean Keeton & Speedway  10173
# 4	Dean Keeton & Speedway  21st & Speedway @PCL    9523
# 5	Rainey St @ Cummings    Rainey St @ Cummings    8676
*/

SELECT
    start_station_name,
    end_station_name,
    count(*) as counts
FROM `bigquery-public-data.austin_bikeshare.bikeshare_trips`
GROUP BY
    start_station_name,
    end_station_name
ORDER BY counts desc


/*
# Question 3: Which stations are the furthest distance apart?
# Hint: I'd calculated the distance in meters based on the longitue and latitute of the start and end points.
# https://towardsdatascience.com/using-bigquerys-new-geospatial-functions-to-interpolate-temperatures-d9363ff19446
# https://cloud.google.com/bigquery/docs/reference/standard-sql/geography_functions
#
# Answer:
# Lake Austin & Enfield     Capital Metro HQ - East 5th at Broadway     8246.260917924477
# Lake Austin & Enfield     East 6th & Pedernales St.                   7709.260055350502
# Lake Austin & Enfield     East 6th at Robert Martinez                 7281.816803608255
*/

SELECT
    c.*,
    ST_Distance(ST_GeogPoint(d.longitude, d.latitude), ST_GeogPoint(start_longitude, start_latitude)) AS dist_meters
FROM
    (
    SELECT
        a.*,
        b.latitude as start_latitude,
        b.longitude as start_longitude
    FROM
        `bigquery-public-data.austin_bikeshare.bikeshare_trips` a
    LEFT JOIN
        `bigquery-public-data.austin_bikeshare.bikeshare_stations` b ON a.start_station_id = b.station_id
    ) c
LEFT JOIN
    `bigquery-public-data.austin_bikeshare.bikeshare_stations` d ON safe_cast(c.end_station_id as STRING) = safe_cast(d.station_id as STRING)
ORDER BY dist_meters DESC




#ZEND
