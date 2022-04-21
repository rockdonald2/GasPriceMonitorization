# README

Dockerized project for Kaufland monitorization.

## Steps to setup dockerized environment

**Note**: this won't contain the created dashboard, only periodically will pull data from an external server and put into an InfluxDB bucket.

1. Pull GH repo to local FS,
2. Run `bash index.sh`,
3. Wait for it to complete,
4. You have a dockerized dashboard application with 3 services: Jupyter, Grafana and InfluxDB at ports `8888` & `3000` & `8086` respectively.
