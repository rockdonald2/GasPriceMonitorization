#!/bin/bash

ROOT='/etc/share/ref/jupyter'

while true
do
    echo "Scraping GasPrice data at $(date)..." >> $ROOT/log

    if ! jupyter nbconvert --execute $ROOT/scrape.ipynb --to notebook --ExecutePreprocessor.timeout=-1
    then
        echo "Failed to execute scrape notebook at $(date)." >> $ROOT/error
        exit 1
    fi

    if ! jupyter nbconvert --execute $ROOT/upload_gas.ipynb --to notebook --ExecutePreprocessor.timeout=-1
    then
        echo "Failed to execute upload gas notebook at $(date)." >> $ROOT/error
        exit 1
    fi

    if ! jupyter nbconvert --execute $ROOT/upload_crude.ipynb --to notebook --ExecutePreprocessor.timeout=-1
    then
        echo "Failed to execute upload gas notebook at $(date)." >> $ROOT/error
        exit 1
    fi

    rm $ROOT/scrape.nbconvert.ipynb $ROOT/upload_gas.nbconvert.ipynb $ROOT/upload_crude.nbconvert.ipynb

    echo "Finished scraping GasPrice data at $(date)." >> $ROOT/log

    echo "Next scrape for GasPrice in a day." >> $ROOT/log
    sleep 1d
done

