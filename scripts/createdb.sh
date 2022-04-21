#!/bin/bash

if ! jupyter nbconvert --execute /home/jovyan/work/workspace/createdb.ipynb --to notebook --ExecutePreprocessor.timeout=-1
then
    echo 'Failed to execute createdb notebook.'
    exit 1
fi

rm /home/jovyan/work/workspace/createdb.nbconvert.ipynb

echo "Successfully created InfluxDB db at $(date)."