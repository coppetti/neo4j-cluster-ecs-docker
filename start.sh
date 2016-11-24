#!/bin/bash -eu

# check cluster is enabled
if [ "$1" == "cluster" ]; then

    # database mode
    export NEO4J_dbms_mode=HA

    # server id, generate a new one if not set
    export NEO4J_ha_serverId=${NEO4J_ha_serverId:-$(cat /data/server_id)}

    # store server id
    echo ${NEO4J_ha_serverId} > /data/server_id

    # host coordination port
    export NEO4J_ha_host_coordination_port=${NEO4J_ha_host_coordination_port:-5001}

    # host coordination
    export NEO4J_ha_host_coordination=":${NEO4J_ha_host_coordination_port}"

    # master data port
    export NEO4J_ha_host_data_port=${NEO4J_ha_host_data_port:-6001}

    # listen for transactions from the master node
    export NEO4J_ha_host_data=":${NEO4J_ha_host_data_port}"

    # initial hosts
    export NEO4J_ha_initialHosts="127.0.0.1:${NEO4J_ha_host_coordination_port}"

    # execute entrypoint script
    /docker-entrypoint.sh "neo4j"
else
    # execute entrypoint script
    /docker-entrypoint.sh $1
fi