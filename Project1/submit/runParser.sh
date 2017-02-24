rm ./sorted*
rm ./table*
rm ./import*
rm ./myData.db

python myParser.py /usr/class/cs145/project/ebay_data/items-*.json
#python myParser.py ./items-*.json

sort -u tableBid.dat > sortedTableBid.dat
sed '1d' sortedTableBid.dat > importBid.dat

sort -u tableCategory.dat > sortedTableCategory.dat
sed '1d' sortedTableCategory.dat > importCategory.dat

sort -u tableCatItem.dat > sortedTableCatItem.dat
sed '1d' sortedTableCatItem.dat > importCatItem.dat

sort -u tableItem.dat > sortedTableItem.dat # uniq has a length limitation, it truncates strings
sed '1d' sortedTableItem.dat > importItem.dat

sort -u tableSell.dat > sortedTableSell.dat
sed '1d' sortedTableSell.dat > importSell.dat

sort -u tableUser.dat > sortedTableUser.dat
sed '1d' sortedTableUser.dat > importUser.dat

sqlite3 myData.db < create.sql
sqlite3 myData.db < load.txt

rm ./sorted*
rm ./table*
rm ./import*

sqlite3 myData.db < query1.sql
sqlite3 myData.db < query2.sql
sqlite3 myData.db < query3.sql
sqlite3 myData.db < query4.sql
sqlite3 myData.db < query5.sql
sqlite3 myData.db < query6.sql
sqlite3 myData.db < query7.sql

rm ./myData.db


