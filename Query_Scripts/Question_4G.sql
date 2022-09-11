use e_properties;

SELECT DISTINCT T0.ID_Code 
,IFNULL(T1.Office_Count,0) AS 'Office_Count'
,IFNULL(T1.Residence_Count,0) AS 'Residence_Count'
#We use ifnull to show in the results estimators with 0 estimations
FROM estimation T0 
LEFT JOIN 
(SELECT T0.IDCode AS 'Estimator_ID'
, COUNT(T1.TAX_ID) AS 'Office_Count' 
, COUNT(T2.SSN) AS 'Residence_Count' 
FROM Estimator AS T0 
INNER JOIN estimation T3 ON T3.ID_Code = T0.IDCode 
LEFT JOIN Office T1 ON T1.OfficeCode = T3.EstPropertyCode 
LEFT JOIN Residence T2 ON T2.ResidenceCode = T3.EstPropertyCode 
WHERE (T3.Date >= '20200101' AND T3.Date <= '20201231') #Nested query that finds the estimators that have more than 0 calculations
GROUP BY T0.IDCode) T1 ON T0.ID_Code = T1.Estimator_ID;
