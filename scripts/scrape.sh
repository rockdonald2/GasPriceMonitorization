#!/bin/bash

while true
do
    echo "Scraping GasPrice data at $(date)..." >> /home/jovyan/work/workspace/log

    if ! jupyter nbconvert --execute /home/jovyan/work/workspace/scrape.ipynb --to notebook --ExecutePreprocessor.timeout=-1
    then
        echo 'Failed to execute scrape notebook.' >> /home/jovyan/work/workspace/error
        exit 1
    fi

    if ! jupyter nbconvert --execute /home/jovyan/work/workspace/upload_gas.ipynb --to notebook --ExecutePreprocessor.timeout=-1
    then
        echo 'Failed to execute upload notebook.' >> /home/jovyan/work/workspace/error
        exit 1
    fi

    if ! jupyter nbconvert --execute /home/jovyan/work/workspace/upload_crude.ipynb --to notebook --ExecutePreprocessor.timeout=-1
    then
        echo 'Failed to execute upload notebook.' >> /home/jovyan/work/workspace/error
        exit 1
    fi

    rm /home/jovyan/work/workspace/scrape.nbconvert.ipynb /home/jovyan/work/workspace/upload_gas.nbconvert.ipynb /home/jovyan/work/workspace/upload_crude.nbconvert.ipynb

    echo "Finished scraping GasPrice data at $(date)." >> /home/jovyan/work/workspace/log

    echo "Next scrape for GasPrice in a day." >> /home/jovyan/work/workspace/log
    sleep 1d
done