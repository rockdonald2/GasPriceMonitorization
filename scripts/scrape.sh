#!/bin/bash

while true
do
    jupyter nbconvert --execute /home/jovyan/work/workspace/scrape.ipynb --to notebook --ExecutePreprocessor.timeout=-1
    jupyter nbconvert --execute /home/jovyan/work/workspace/upload.ipynb --to notebook --ExecutePreprocessor.timeout=-1

    rm /home/jovyan/work/workspace/scrape.nbconvert.ipynb /home/jovyan/work/workspace/upload.nbconvert.ipynb

    sleep 1d
done