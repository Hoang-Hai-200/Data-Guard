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
EOF


sqlplus / as sysdba << EOF
alter system set db_unique_name=uprimary scope=spfile;
EOF
