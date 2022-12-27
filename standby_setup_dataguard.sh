#!/bin/bash

##############################################################
cat > /u01/app/oracle/product/19.0.0/dbhome_1/network/admin/tnsnames.ora << EOFTNS
LISTENER =
  (ADDRESS = (PROTOCOL = TCP)(HOST = standby)(PORT = 1521))

standbytns  =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = standbyos)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SID = db1)
    )
  )


primarytns =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = primaryos)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = db1)
    )
  )
EOFTNS

################################################################
cat > /u01/app/oracle/product/19.0.0/dbhome_1/network/admin/listener.ora << EOFLIS
LISTENER =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = standbyos)(PORT = 1521))
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
    )
  )

SID_LIST_LISTENER =
  (SID_LIST =
    (SID_DESC =
      (ORACLE_HOME = /u01/app/oracle/product/19.0.0/dbhome_1)
      (SID_NAME = db1)
      (ENVS="TNS_ADMIN=/u01/app/oracle/product/19.0.0/dbhome_1/network/admin")
    )
  )

ADR_BASE_LISTENER = /u01/app/oracle
EOFLIS


################################################################
cat > /home/oracle/scripts1/duplicate.sql << EOFDUP
run {
duplicate target database for standby from active database dorecover nofilenamecheck;
}
EOFDUP
