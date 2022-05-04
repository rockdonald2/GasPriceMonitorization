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

DELAY=15m

# sleep for a specific amount of time to finalize setup, actually depends on the machine
echo "Sleep for $DELAY to finalize setup." && sleep "$DELAY"

if ! "./scripts/setup.sh"
then
    echo "Failed to execute setup script."
    exit 1
fi

if ! "./scripts/install_plugins.sh"
then
    echo "Failed to execute install plugins script."
    exit 1
fi

JUPYTER_CONTAINER=jupyter

# create influxdb database to hold our data
if ! docker exec "$JUPYTER_CONTAINER" /home/jovyan/work/workspace/createdb.sh
then
    echo "Failed to execute createdb script."
    exit 1
fi

# blocking script, should be run in detached, initiates scraping session
if ! docker exec -d "$JUPYTER_CONTAINER" /home/jovyan/work/workspace/scrape.sh
then
    echo "Failed to execute auto-pull scrape script."
    exit 1
fi