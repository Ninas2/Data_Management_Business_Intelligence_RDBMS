use e_properties;

SELECT T0.LocCode
, T0.Average_Value_per_sq_m
FROM
(Select T0.LocCode
,  ROUND(sum(T1.Value)/sum(T0.size),3)
 AS 'Average_Value_per_sq_m'
FROM real_estate T0, estimation T1
WHERE T0.PropertyCode = T1.EstPropertyCode
GROUP BY T0.LocCode) T0 #Nested query that calculates the average value per square for each location, we use a nested a query to order the results based on the calculated value
ORDER BY T0.Average_Value_per_sq_m; 
