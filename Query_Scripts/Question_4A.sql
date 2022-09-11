use e_properties;

Select DISTINCT
T0.PropertyCode AS 'Property Code'
, T0.Street
, T0.Number
, T0.Zip_Code
, T0.City
FROM real_estate T0, location T1, estimation T2
WHERE T1.LocCode = T0.LocCode AND T0.PropertyCode = T2.EstPropertyCode
AND T1.AVG_Income > 40000 AND (T2.Date >= '20201224'
AND T2.Date <= '20201231');
