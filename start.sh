#!/bin/bash -eu

# check cluster is enabled
if [ "$1" == "cluster" ]; then

    # use random number as server_id
    echo -n $RANDOM > /data/server_id

    # server id
    export NEO4J_ha_server__id=${NEO4J_ha_server__id:-$(cat /data/server_id)}

    # store server id
    echo ${NEO4J_ha_server__id} > /data/server_id

    # current node IP address
    IP=$(ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

    # advertise all connectors on IP address
    export NEO4J_dbms_connectors_default__advertised__address="${IP}"

    # causal cluster advertise addresses
    export NEO4J_causal__clustering_discovery__advertised__address="${IP}:5000"
    export NEO4J_causal__clustering_transaction__advertised__address="${IP}:6000"
    export NEO4J_causal__clustering_raft__advertised__address="${IP}:7000"

    # initial hosts in cluster
    export NEO4J_causal__clustering_initial__discovery__members=$(java -jar /tools/neo4j-cluster-ecs-tools-jar-with-dependencies.jar ${ECS_CLUSTER_NAME})

    # execute entrypoint script
    /docker-entrypoint.sh "neo4j"
else
    # execute entrypoint script
    /docker-entrypoint.sh $1
fi
