#!/bin/bash

# TODO: copy important static data into container, e.g. counties.json, romania.json, .env file
# TODO: copy notebooks into container

ROOT_J='/etc/share/ref/jupyter'

JUPYTER=jupyter
GRAFANA=grafana

for i in notebooks/*
do
    name=$(echo "$i" | cut -d/ -f3) 
    docker cp "$i" jupyter:$ROOT_J/"$name"
done

docker cp notebooks/.env jupyter:$ROOT_J/.env

docker cp data/counties.json "$JUPYTER":$ROOT_J/counties.json
docker cp data/romania.json "$GRAFANA":/usr/share/grafana/public/maps/romania.geojson

docker cp scripts/scrape.sh "$JUPYTER":$ROOT_J/scrape.sh
docker cp scripts/createdb.sh "$JUPYTER":$ROOT_J/createdb.sh

echo "Successfully completed setup at $(date)."