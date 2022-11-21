# Data-Guard

B1: Primary

primary_setup1.sh
primary_setup2.sh


B2: Standby

1. standby_setup_dataguard.sh  (create file tnsnames.ora, listener.ora, duplicate.sql
2. cp orapw $ORACLE_HOME/dbs
. startup nomount pfile='/home/oracle/pfile_primary.ora'
. create spfile from pfile='/home/oracle/pfile_primary.ora'
. shut immediate ( startup with spfile to config parameter)
. startup nomount
. nohupRman.sh
. alter database open;

3.a Configuration manual
          ### Primary
       1. alter system set log_archive_config='dg_config=(uprimary,ustandby)';
       2. alter system set log_archive_dest_2='service=standbytns valid_for=(online_logfile,all_roles) db_unique_name=ustandby';
       3. alter system set log_archive_dest_state_2=enable;

         ### Standby
       1. alter system set log_archive_config='dg_config=(uprimary,ustandby)';
       2. alter system set log_archive_dest_2=’service=primarytns valid_for=(online_logfiles,primary_roles) db_unique_name=uprimary’;
       3. altter database recover managed standby database using current logfile disconnect from session;
       4. Done
       
3.b Configuration data broker 
       oracle@primary : ./primary_setup3_broker.sh
       Done
        
##########################################################################33

  Option standby : 
      alter database recover managed standby database cancel;
      alter database recover managed standby database using current logfile disconnect from session;
      
