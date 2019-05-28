# OraTOPQ - Oracle TOP executions of queries

**OraTOPQ** ( Oracle TOP Queries ) is a free tool that adds many views for bad queries in your Oracle Database.

Usage examples of OraTOPQ:

* TOP queries consuming CPU.
./oratopq.sh cpu
* TOP queries with SQL id and SQL
./oratopq.sh sql
* TOP queries with SQL PLAN for top sql
./oratopq.sh sqlid
* TOP queries with LOCK issues
./oratopq.sh lock
* TOP queries with LOCK with kill option
./oratopq.sh lockkill

* TOP queries with many details about your sqlid
./oratopq.sh sqlid 12jxx1234x

* You need set/configure your ORACLE_SID before use it. There is no use of any performance
view/tunning pack options.

Tested on all Oracle Database versions (SE and EE) from **10gR2 until latest 12c**.

More information at: http://www.soudba.com/en/oratotp

## 1. How it Works ##

This is a shell script with plsql can be used to check sql in database. Can open other session to check different views - like one with Top sql with plans and other session with IDs of session with process id of operation system.

OraTOTQ tool is intended to be very easy to setup and use, not requiring any major skills for anyone to enable it.

## 2. Features ##

* Execute each 10 sec a screenshot of queries running on database.
* If execute without parameters will run with default mode - TOP sqls .
* Can customise scripts in scripts folder
* Can be used with sqlcl
* Collors can be enabled and disable


## 3. Instructions ##

1. Download the script in:

2. Install OraTOPQ tool in your database. In your prefered folder like /stage/scripts

3. Execute the commando: chmod +x oratopq.sh


## 4. Versions ##

* v1.00 - Initial Release
* v1.01 -  
* v1.02 -  

## 5. Other Information ##

Check http://www.soudba.com.br/oratopq for installation instructions, usage examples and objects documentation.