rm ./sorted*
rm ./table*
rm ./import*
rm ./myData.db

python myParser.py /usr/class/cs145/project/ebay_data/items-*.json
#python myParser.py ./items-*.json

sort -u tableBids.dat > sortedTableBids.dat
sed '1d' sortedTableBids.dat > importBids.dat

sort -u tableCategories.dat > sortedTableCategories.dat
sed '1d' sortedTableCategories.dat > importCategories.dat

sort -u tableItems.dat > sortedTableItems.dat # uniq has a length limitation, it truncates strings
sed '1d' sortedTableItems.dat > importItems.dat

sort -u tableUsers.dat > sortedTableUsers.dat
sed '1d' sortedTableUsers.dat > importUsers.dat

#sqlite3 myData.db < create.sql
#sqlite3 myData.db < load.txt
#
#rm ./sorted*
#rm ./table*
#rm ./import*
#
#sqlite3 myData.db < query1.sql
#sqlite3 myData.db < query2.sql
#sqlite3 myData.db < query3.sql
#sqlite3 myData.db < query4.sql
#sqlite3 myData.db < query5.sql
#sqlite3 myData.db < query6.sql
#sqlite3 myData.db < query7.sql
#
#rm ./myData.db


