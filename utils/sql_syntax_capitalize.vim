arg *.sql
argdo %s/with /WITH /g
argdo %s/ as / AS /g
argdo %s/ integer)/ INTEGER)/g
argdo %s/ float)/ FLOAT)/g
argdo %s/ or / OR /g
argdo %s/ on / ON /g
argdo %s/ in / IN /g
argdo %s/ not / NOT /g
argdo %s/where /WHERE /g
argdo %s/ and / AND /g
argdo %s/group by /GROUP BY /g
argdo %s/order by /ORDER BY /g
argdo %s/limit /LIMIT /g

argdo %s/round(/ROUND(/g
argdo %s/sum(/SUM(/g
argdo %s/nvl2(/NVL2(/g
argdo %s/cast(/CAST(/g
argdo %s/max(/MAX(/g
argdo %s/greatest(/GREATEST(/g
argdo %s/min(/MIN(/g
argdo %s/count(/COUNT(/g
argdo %s/date_part(/DATE_PART(/g
argdo %s/datediff(/DATEDIFF(/g
argdo %s/getdate()/GETDATE()/g
argdo %s/coalesce(/COALESCE(/g
argdo %s/round(/ROUND(/g
