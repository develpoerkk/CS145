# createDatabase.sh
# created by Rao on Nov 12, 2016

sqlite3 myData.db < create.sql
sqlite3 myData.db < load.txt

rm ./sorted*
rm ./table*
rm ./import*

sqlite3 myData.db < constraints_verify.sql
sqlite3 myData.db < trigger08_add.sql
sqlite3 myData.db < trigger09_add.sql
sqlite3 myData.db < trigger11_add.sql
# sqlite3 myData.db < trigger12_add.sql
sqlite3 myData.db < trigger13_add.sql
sqlite3 myData.db < trigger14_add.sql
sqlite3 myData.db < trigger15_add.sql
sqlite3 myData.db < trigger16_add.sql

#rm ./myData.db

