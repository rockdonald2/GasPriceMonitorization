#!/bin/bash

if ! docker compose up -d --force-recreate 1>/dev/null 2>/dev/null
then
    echo "Failed to create containers."
    exit 1
fi

DELAY=15m

# sleep for a specific amount of time to finalize setup, actually depends on the machine
echo "Sleep for $DELAY to finalize setup." && sleep "$DELAY"

JUPYTER_CONTAINER=jupyter

# blocking script, should be run in detached, initiates scraping session
if ! docker exec -d "$JUPYTER_CONTAINER" /home/jovyan/work/workspace/scrape.sh
then
    echo "Failed to execute auto-pull scrape script."
    exit 1
fi