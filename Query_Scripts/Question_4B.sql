use e_properties;

Select T0.IDCode
, T0.First_Name
, T0.Last_Name
, ifnull(T1.EstCode,0) AS 'Estimation_Count'
#We use ifnull to show the estimators with 0 estimations
FROM estimator AS T0
LEFT JOIN 
(SELECT COUNT(EstCode) AS 'EstCode'
, T1.ID_Code 
FROM estimation AS T1
WHERE (T1.Date >= '20200101' AND T1.Date <= '20201231') #We find all estimators that have at least one estimations
GROUP BY T1.ID_Code) AS T1 ON T0.IDCode = T1.ID_Code;
