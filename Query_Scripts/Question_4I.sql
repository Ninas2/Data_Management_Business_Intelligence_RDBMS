use e_properties;

SELECT T0.LocCode
,T0.Count_per_Loc/ T1.All_estimations as 'Estimation Percentage'
,T0.Population / T2.Total_Population as 'Population Percentage'
FROM 
(SELECT T0.LocCode
,IFNULL(T1.Count_per_Loc,0) AS 'Count_per_Loc'
,T0.Population
FROM location T0
LEFT JOIN (SELECT COUNT(*) AS 'Count_per_Loc'
,T0.LocCode
,T2.Population
FROM real_estate T0
INNER JOIN estimation T1 ON T0.PropertyCode = T1.EstPropertyCode
INNER JOIN location T2 ON T0.LocCode = T2.LocCode
WHERE (T1.Date >= '20200101' AND T1.Date <= '20201231') 
GROUP BY T0.LocCode,T2.Population) T1 ON T0.LocCode = T1.LocCode) T0
#Nested Query that finds calculations per location
, (SELECT COUNT(*) AS 'All_estimations'
FROM estimation T1
WHERE (T1.Date >= '20200101' AND T1.Date <= '20201231')) T1
,(SELECT SUM(Population) AS 'Total_Population'
FROM Location T0) T2;
