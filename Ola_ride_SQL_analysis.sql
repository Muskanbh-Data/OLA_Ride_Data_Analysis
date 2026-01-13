/*
Project: Ola Ride Data Analysis
Tool: SQL Server
Author: Muskan Bhardwaj
*/


--1: Data Understanding~


-- Structure of table

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ola_data';

-- Dataset

SELECT TOP 10 *
FROM ola_data;

--2: Data Quality Checks (EDA/Cleaning)~


-- Missing Values check

SELECT
    COUNT(*) AS total_rows,
    COUNT(Driver_Ratings) AS driver_rating_present,
    COUNT(Customer_Rating) AS customer_rating_present,
    COUNT(V_TAT) AS vtat_present,
    COUNT(C_TAT) AS ctat_present
FROM ola_data;


-- Distinct Booking Status

SELECT DISTINCT Booking_Status
FROM ola_data;


--3: Business SQL Queries~


-- 1. Retrieve all successful bookings:

SELECT *
FROM ola_data
WHERE Booking_Status = 'Completed';

--2. Find the average ride distance for each vehicle type:

SELECT Vehicle_Type,
       AVG(Ride_Distance) AS avg_ride_distance
FROM ola_data
GROUP BY Vehicle_Type;

--3. Get the total number of cancelled rides by customers:

SELECT COUNT(*) AS total_cancelled_by_customers
FROM ola_data
WHERE Booking_Status = 'Canceled by Customer';

--4. List the top 5 customers who booked the highest number of rides:

SELECT TOP 5 Customer_ID,
       COUNT(*) AS total_rides
FROM ola_data
GROUP BY Customer_ID
ORDER BY total_rides DESC;

--5. Get the number of rides cancelled by drivers due to personal and car-related issues:

SELECT COUNT(*) AS cancelled_by_driver
FROM ola_data
WHERE Booking_Status = 'Canceled by Driver'
  AND Canceled_Rides_by_Driver LIKE '%Personal%';

 --6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT 
    MAX(Driver_Ratings) AS max_rating,
    MIN(Driver_Ratings) AS min_rating
FROM ola_data
WHERE Vehicle_Type = 'Prime Sedan';

--7. Retrieve all rides where payment was made using UPI:

SELECT *
FROM ola_data
WHERE Payment_Method = 'UPI';

--8. Find the average customer rating per vehicle type:

SELECT Vehicle_Type,
       AVG(Customer_Rating) AS avg_customer_rating
FROM ola_data
GROUP BY Vehicle_Type;

--9. Calculate the total booking value of rides completed successfully:

SELECT 
  FORMAT(SUM(Booking_Value), 'N0') AS total_revenue
FROM ola_data
WHERE Booking_Status = 'Success';

--10. List all incomplete rides along with the reason

SELECT *
FROM ola_data
WHERE Incomplete_Rides = 1;

