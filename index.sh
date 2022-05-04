#!/bin/bash

echo 'Starting setup.'

mkdir logs 2>>/dev/null

echo '' > logs/log.log
echo '' > logs/error.log

if ! docker compose up -d 1>logs/log.log 2>logs/error.log
then
    echo "Failed to create containers."
    exit 1
fi

# sleep for a specific amount of time to finalize setup, actually depends on the machine
echo "Sleep for 5m to finalize setup." && sleep 5m

JUPYTER_CONTAINER=jupyter
ROOT_J='/etc/share/ref/jupyter'

# create influxdb database to hold our data
if ! docker exec -d "$JUPYTER_CONTAINER" $ROOT_J/createdb.sh
then
    echo "Failed to execute createdb script."
    exit 1
fi

echo "Sleep for 2m to create database." && sleep 2m

# blocking script, should be run in detached, initiates scraping session
if ! docker exec -d "$JUPYTER_CONTAINER" $ROOT_J/scrape.sh
then
    echo "Failed to execute auto-pull scrape script."
    exit 1
fi