#!/bin/bash

# TODO: backup data from Jupyter container volume
# I wrote the data pull script, it will always be saved in /home/jovyan/work/workspace/ as
# gas_tmp-xx.json
# data should be backed up in the ../data dir

CONTAINER_NAME=jupyter
ROOT='/etc/share/ref/jupyter'

root_path='./data'

for d in $(docker exec "$CONTAINER_NAME" find $ROOT -maxdepth 1 -name "gas_tmp-*.json" -type f)
do
    name=$(echo "$d" | cut -d/ -f6)
    
    if ! docker cp "$CONTAINER_NAME":"$d" "$root_path/$name"
    then
        echo "Failed to copy data from container: $d; exiting."
        exit 1
    fi

    if ! docker exec "$CONTAINER_NAME" rm "$d"
    then
        echo "Failed to delete backed up data: $d; exiting."
        exit 1
    fi
done

for d in $(docker exec "$CONTAINER_NAME" find $ROOT -maxdepth 1 -name "crude_tmp-*.json" -type f)
do
    name=$(echo "$d" | cut -d/ -f6)
    
    if ! docker cp "$CONTAINER_NAME":"$d" "$root_path/$name"
    then
        echo "Failed to copy data from container: $d; exiting."
        exit 1
    fi

    if ! docker exec "$CONTAINER_NAME" rm "$d"
    then
        echo "Failed to delete backed up data: $d; exiting."
        exit 1
    fi
done