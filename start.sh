#!/bin/bash -eu

# database mode
export NEO4J_dbms_mode=HA

# server id
export NEO4J_ha_serverId=1

# host coordination
export NEO4J_ha_host_coordination=":5001"

# listen for transactions from the master node
export NEO4J_ha_host_data=":6001"

# initial hosts
export NEO4J_ha_initialHosts="127.0.0.1:5001"

# execute entrypoint script
/docker-entrypoint.sh $1