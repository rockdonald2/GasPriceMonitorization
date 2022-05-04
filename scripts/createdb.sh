#!/bin/bash

ROOT='/etc/share/ref/jupyter'

if ! jupyter nbconvert --execute $ROOT/createdb.ipynb --to notebook --ExecutePreprocessor.timeout=-1
then
    echo "Failed to execute createdb notebook at $(date)." >> $ROOT/error
    exit 1
fi

rm $ROOT/createdb.nbconvert.ipynb

echo "Successfully created InfluxDB db at $(date)." >> $ROOT/log