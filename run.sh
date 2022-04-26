#!/bin/bash

# starts all services
if ! docker compose start 1>/dev/null
then
    echo "Failed to start services."
    exit 1
fi

# copies all necessary notebooks and scripts to containers
if ! bash "./scripts/setup.sh"
then
    echo "Failed to execute setup script."
    exit 1
fi

# starts scrape on Jupyter container, initiates a scrape at the beginning
JUPYTER_CONTAINER=jupyter
if ! docker exec -d "$JUPYTER_CONTAINER" bash /home/jovyan/work/workspace/scrape.sh
then
    echo "Failed to start auto-pull scrape script."
    exit 1
fi

echo "Successfully started and setup all services."