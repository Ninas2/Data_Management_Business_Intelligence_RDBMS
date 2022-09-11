use e_properties;

Select COUNT(EstCode)
FROM ESTIMATION T0 
INNER JOIN REAL_ESTATE T1 ON T0.EstPropertyCode = T1.PropertyCode
INNER JOIN Location T2 ON T1.LocCode = T2.LocCode
WHERE (T0.Date >= '20200101' AND T0.Date <= '20201231')
AND T2.Population > 50000;
