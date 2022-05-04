#!/bin/bash

ROOT='/etc/share/ref/jupyter'
JUPYTER_CONTAINER=jupyter

if ! docker exec -d "$JUPYTER_CONTAINER" jupyter nbconvert --execute $ROOT/upload_all.ipynb --to notebook --ExecutePreprocessor.timeout=-1
then
    echo "Failed to execute upload all notebook at $(date)." >> logs/error.log
    exit 1
fi

docker exec -d "$JUPYTER_CONTAINER" rm $ROOT/upload_all.nbconvert.ipynb

echo "Successfully uploaded all data to db at $(date)." >> logs/log.log