#!/bin/bash -eu

# database mode
export NEO4J_dbms_mode=HA

# check id has been generated
if [ -f /data/server_id ]; then
    # server id
    export NEO4J_ha_serverId=$(cat /data/server_id)
else
    # generate server id
    export NEO4J_ha_serverId=$RANDOM
    # store it
    echo ${NEO4J_ha_serverId} > /data/server_id
fi

# host coordination
export NEO4J_ha_host_coordination=":5001"

# listen for transactions from the master node
export NEO4J_ha_host_data=":6001"

# initial hosts
export NEO4J_ha_initialHosts="127.0.0.1:5001"

# execute entrypoint script
/docker-entrypoint.sh $1