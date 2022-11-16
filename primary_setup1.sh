#!/bin/bash

cat > /u01/app/oracle/product/19.0.0/dbhome_1/network/admin/tnsnames.ora << EOFTNSNAMES 
LISTENER =
  (ADDRESS = (PROTOCOL = TCP)(HOST = primary)(PORT = 1521))

standbytns  =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = standbyos)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = db1)
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
EOFTNSNAMES

cat > /u01/app/oracle/product/19.0.0/dbhome_1/network/admin/listener.ora << EOFLISTENER
LISTENER =
  (DESCRIPTION_LIST =
    (DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = primaryos)(PORT = 1521))
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
    )
  )


SID_LIST_LISTENER =
  (SID_LIST =
    (SID_DESC =
      (ORACLE_HOME = /u01/app/oracle/product/19.0.0/dbhome_1)
      (SID_NAME = db1)
      (ENVS = "TNS_ADMIN=/u01/app/oracle/product/19.0.0/dbhome_1/network/admin")
    )
  )
EOFLISTENER
