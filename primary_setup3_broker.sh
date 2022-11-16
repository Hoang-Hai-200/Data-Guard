#!/bin/bash
dgmgrl sys/admin@primarytns << EOFDG
alter system set dg_broker_start=true;
create configuration my_dg_config as primary database is uprimary connect identifier is primarytns;
add database ustandby as connect identifier is standbytns maintained as physical;
enable configuration;
EOFDG
