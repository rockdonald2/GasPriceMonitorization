#!/bin/bash

while true
do
    echo "Scraping GasPrice data at $(date)..."

    jupyter nbconvert --execute /home/jovyan/work/workspace/scrape.ipynb --to notebook --ExecutePreprocessor.timeout=-1

    if [[ $? -ne 0 ]]
    then
        echo 'Failed to execute scrape notebook.'
        exit 1
    fi

    jupyter nbconvert --execute /home/jovyan/work/workspace/upload.ipynb --to notebook --ExecutePreprocessor.timeout=-1

    if [[ $? -ne 0 ]]
    then
        echo 'Failed to execute upload notebook.'
        exit 1
    fi

    rm /home/jovyan/work/workspace/scrape.nbconvert.ipynb /home/jovyan/work/workspace/upload.nbconvert.ipynb

    echo "Finished scraping GasPrice data at $(date)."

    echo "Next scrape for GasPrice in a day."
    sleep 1d
done