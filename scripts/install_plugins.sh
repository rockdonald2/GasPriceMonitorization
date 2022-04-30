#!/bin/bash

CONTAINER_NAME=grafana

if ! docker exec $CONTAINER_NAME grafana-cli plugins install bilibala-echarts-panel
then
    echo 'Failed to install echarts plugin in Grafana.'
    exit 1
fi

if ! docker exec $CONTAINER_NAME grafana-cli plugins install grafana-clock-panel
then
    echo 'Failed to install clock plugin in Grafana.'
    exit 1
fi

docker restart $CONTAINER_NAME