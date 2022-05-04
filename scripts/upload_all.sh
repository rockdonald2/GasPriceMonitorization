#!/bin/bash

ROOT='/etc/share/ref/jupyter'

if ! jupyter nbconvert --execute $ROOT/upload_all.ipynb --to notebook --ExecutePreprocessor.timeout=-1
then
    echo "Failed to execute upload all notebook at $(date)." >> $ROOT/error
    exit 1
fi

rm $ROOT/upload_all.nbconvert.ipynb

echo "Successfully created InfluxDB db at $(date)." >> $ROOT/log