!#/bin/bash

sqlplus / as sysdba << EOF

shutdown immediate;
startup mount;
alter system set db_recovery_file_dest_size=2G;
alter system set db_recovery_file_dest='/fra';
alter database archivelog;
alter database force logging;
alter system set standby_file_management=auto;
alter database open;
create pfile='/home/oracle/pfile_primary.ora' from spfile;
alter database add standby logfile thread 1 group 10 ('/u01/app/oracle/oradata/DB1/standby_redo10.log') size 200m;
alter database add standby logfile thread 1 group 11 ('/u01/app/oracle/oradata/DB1/standby_redo11.log') size 200m;
alter database add standby logfile thread 1 group 12 ('/u01/app/oracle/oradata/DB1/standby_redo12.log') size 200m;
alter database add standby logfile thread 1 group 13 ('/u01/app/oracle/oradata/DB1/standby_redo13.log') size 200m;
EOF


sqlplus / as sysdba << EOF
alter system set db_unique_name=uprimary scope=spfile;
shut immediate;
startup open;
EOF
