#!/bin/bash

echo "Starting services."

ROOT_J='/etc/share/ref/jupyter'

# starts all services
if ! docker compose start 1>/dev/null
then
    echo "Failed to start services."
    exit 1
fi

# starts scrape on Jupyter container, initiates a scrape at the beginning
JUPYTER_CONTAINER=jupyter
if ! docker exec -d "$JUPYTER_CONTAINER" $ROOT_J/scrape.sh
then
    echo "Failed to start auto-pull scrape script."
    exit 1
fi

echo "Successfully started and setup all services."