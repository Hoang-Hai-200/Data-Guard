#!/bin/bash
#export ORACLE_UNQNAME=ustandby
#export ORACLE_BASE=/u01/app/oracle
#export ORACLE_HOME=$ORACLE_BASE/product/19.0.0/dbhome_1
#export ORACLE_SID=db1

export PATH=/usr/sbin:/usr/local/bin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH 

nohup rman target sys/admin@primarytns auxiliary sys/admin@standbytns cmdfile=/home/oracle/scripts/duplicate12.sql log=/home/oracle/scripts/duplicate.log &
