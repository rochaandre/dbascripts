 
#!/bin/sh
# Andre Rocha
# Script create to check queries in database
# Check more updates in: www.soudba.com.br/scripts
# TOP queries consuming CPU. ./oratopq.sh cpu
# TOP queries with SQL id and SQL ./oratopq.sh sql
# TOP queries with SQL PLAN for top sql ./oratopq.sh sqlid
# TOP queries with LOCK issues ./oratopq.sh lock
# TOP queries with LOCK with kill option ./oratopq.sh lockkill
# TOP queries with many details about your sqlid ./oratopq.sh sqlid 12jxx1234x

case "$1" in
  "cpu")
    script="sql/topcpu.sql"
    ;;
  "sql")
    script="sql/topsql.sql"
    ;;
  "lock")
    script="sql/toplockkill.sql"
    ;;
  "lockkill")
    script="sql/toplockkill.sql"
    ;;
  "sqlid")
    if [ -n "$2" ]; then
       script="sql/topsqlid.sql"
       ;;
    else
       script="sql/topsqlidid.sql"
       ;;
    fi   
  *)
    echo "Assuming top sql."
    exit 1
    ;;
esac
 

if [ -n "$ORACLE_SID" ]; then
while [ 1 ]; do
clear
hsize=`stty size|cut -f2 -d" "`
vsize=`stty size|cut -f1 -d" "`
sqlplus -S "/ as sysdba" @$script
SQL
echo "Press CTRL-c to exit"
sleep 5
done
else
echo ORACLE_SID not set
fi


