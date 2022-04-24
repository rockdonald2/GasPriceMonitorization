#!/bin/bash

# TODO: copy important static data into container, e.g. counties.json, romania.json, .env file
# TODO: copy notebooks into container

JUPYTER=jupyter
GRAFANA=grafana

for i in notebooks/*
do
    name=$(echo "$i" | cut -d/ -f3) 
    docker cp "$i" jupyter:/home/jovyan/work/workspace/"$name"
done

docker cp notebooks/.env jupyter:/home/jovyan/work/workspace/.env

docker cp data/counties.json "$JUPYTER":/home/jovyan/work/workspace/counties.json
docker cp data/romania.json "$GRAFANA":/usr/share/grafana/public/maps/romania.geojson

docker cp scripts/scrape.sh "$JUPYTER":/home/jovyan/work/workspace/scrape.sh
docker cp scripts/createdb.sh "$JUPYTER":/home/jovyan/work/workspace/createdb.sh

echo "Successfully completed setup at $(date)."