#!/bin/bash -eu

# check cluster is enabled
if [ "$1" == "cluster" ]; then

    # use random number as server_id
    echo -n $RANDOM > /data/server_id

    # server id
    export NEO4J_ha_server__id=${NEO4J_ha_server__id:-$(cat /data/server_id)}

    # store server id
    echo ${NEO4J_ha_server__id} > /data/server_id

    # initial hosts in cluster
    export NEO4J_causal__clustering_initial__discovery__members=$(java -jar /tools/neo4j-cluster-ecs-tools-0.0.1-jar-with-dependencies.jar)

    # execute entrypoint script
    /docker-entrypoint.sh "neo4j"
else
    # execute entrypoint script
    /docker-entrypoint.sh $1
fi
