import mysql.connector

MyDB = mysql.connector.connect(user="root", passwd="Z1a2q3w4s5x6!", host="127.0.0.1",  database ="sakila" ,auth_plugin = 'mysql_native_password')

mycursor = MyDB.cursor()
mycursor.execute('SELECT T2.Population FROM location T2')
Pop_sum = mycursor.fetchall()
Population_sum = 0
for i in range(0,len(Pop_sum)):
    Population_sum += Pop_sum[i][0]

#print(Population_sum)

mycursor.execute('SELECT DISTINCT T0.LocCode ,T0.Population From location T0')
Population_per_Loc = mycursor.fetchall()
pop_perc = {}
for i in range(0,len(Population_per_Loc)):
    pop_perc[Population_per_Loc[i][0]] = int(Population_per_Loc[i][1])/Population_sum

#print(pop_perc)

mycursor.execute('SELECT T0.LocCode FROM real_estate T0, estimation T1 WHERE T0.PropertyCode = T1.EstPropertyCode  AND (T1.Date >= "20200101" AND T1.Date <= "20201231")')
Location_Estimated_2020 = mycursor.fetchall()
Total_locations_2020 = len(Location_Estimated_2020)
Estim_per_location = {}
for i in range(0, len(Location_Estimated_2020)):
    if Location_Estimated_2020[i][0] in Estim_per_location.keys():
        Estim_per_location[Location_Estimated_2020[i][0]] += 1
    else:
        Estim_per_location[Location_Estimated_2020[i][0]] = 1

for i in range(0, len(Population_per_Loc)):
    if Population_per_Loc[i][0] not in Estim_per_location.keys():
        Estim_per_location[Population_per_Loc[i][0]] = 0
        Perc_per_location = Estim_per_location
        for i in Perc_per_location.keys():
             Perc_per_location[i] = Perc_per_location[i] / int(Total_locations_2020)

print(Perc_per_location)

