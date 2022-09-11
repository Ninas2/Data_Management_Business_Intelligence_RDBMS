use e_properties;

Select EstPropertyCode
, COUNT(*)
FROM estimation
WHERE (date >= '20200101' AND date <= '20201231')
GROUP BY EstPropertyCode
HAVING COUNT(*) > 2 ;
