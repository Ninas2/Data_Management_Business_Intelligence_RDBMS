use e_properties;

Select EstCode
FROM estimation
WHERE EstPropertyCode IN 
(SELECT PropertyCode
FROM location, real_estate
WHERE AVG_Income > 25000 
AND real_estate.LocCode = location.LocCode);
