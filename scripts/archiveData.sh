#!/bin/bash

# TODO: archive data in a year_month date format

folder_name=$(date +%Y_%m)
root_path="../data"

mkdir "$root_path"/"$folder_name" 1>/dev/null 2>/dev/null

for d in $(find $root_path -maxdepth 1 -name "gas_tmp-*.json" -type f)
do
    name=$(echo "$d" | cut -d/ -f3)
    mv "$d" "$root_path"/"$folder_name"/"$name"
done