use e_properties;

SELECT T0.LocCode
,T1.Perc_Value_Change_2019_2020
FROM Location T0
LEFT JOIN #left join in order to also show the locations without a change in the below years
(SELECT T0.LocCode
, Round((T1.Average_Value_per_sq_m - T0.Average_Value_per_sq_m) /T0.Average_Value_per_sq_m,3)  AS 'Perc_Value_Change_2019_2020'
#Calculate the change of average value per sq m in years 2019-2020
FROM (Select T0.LocCode
,  ROUND(sum(T1.Value)/sum(T0.size),3) AS 'Average_Value_per_sq_m'
FROM real_estate T0
, estimation T1
WHERE T0.PropertyCode = T1.EstPropertyCode
AND (T1.Date >= '20190101' AND T1.Date <= '20191231')
GROUP BY T0.LocCode) T0 # Νested query to find average value per square meter for locations in 2019
,(Select T0.LocCode
,  ROUND(sum(T1.Value)/sum(T0.size),3) 
AS 'Average_Value_per_sq_m'
FROM real_estate T0
, estimation T1
WHERE T0.PropertyCode = T1.EstPropertyCode 
AND (T1.Date >= '20200101' AND T1.Date <= '20201231')
GROUP BY T0.LocCode) T1 # Nested query to find average value per square meter for locations in 2020
WHERE T0.LocCode = T1.LocCode) T1 ON T0.LocCode = T1.LocCode
ORDER BY T1.Perc_Value_Change_2019_2020;
