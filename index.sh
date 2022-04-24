#!/bin/bash

if ! docker compose create 1>/dev/null 2>/dev/null
then
    echo "Failed to create containers."
    exit 1
fi

if ! docker compose start 1>/dev/null 2>/dev/null
then
    echo "Failed to start services."
    exit 1
fi

DELAY=10m

# sleep for a specific amount of time to finalize setup
echo "Sleep for $DELAY to finalize setup." && sleep "$DELAY"

if ! bash "./scripts/setup.sh"
then
    echo "Failed to execute setup script."
    exit 1
fi

JUPYTER_CONTAINER=jupyter

if ! docker exec -d "$JUPYTER_CONTAINER" bash /home/jovyan/work/workspace/createdb.sh
then
    echo "Failed to start createdb script."
    exit 1
fi

if ! docker exec -d "$JUPYTER_CONTAINER" bash /home/jovyan/work/workspace/scrape.sh
then
    echo "Failed to start auto-pull scrape script."
    exit 1
fi