#!/bin/bash

# TODO: copy important static data into container, e.g. counties.json, romania.json, .env file
# TODO: copy notebooks into container

CONTAINER_NAME=jupyter

for i in ../notebooks/*
do
    name=$(echo "$i" | cut -d/ -f3) 
    docker cp "$i" jupyter:/home/jovyan/work/workspace/"$name"
done

docker cp ../notebooks/.env jupyter:/home/jovyan/work/workspace/.env

docker cp ../data/counties.json "$CONTAINER_NAME":/home/jovyan/work/workspace/counties.json
docker cp ../data/romania.json "$CONTAINER_NAME":/home/jovyan/work/workspace/romania.json
docker cp scrape.sh "$CONTAINER_NAME":/home/jovyan/work/workspace/scrape.sh
docker cp createdb.sh "$CONTAINER_NAME":/home/jovyan/work/workspace/createdb.sh