# README

Dockerized project for Kaufland monitorization.

## Steps to setup dockerized environment

**Note**: this won't contain the created dashboard, only periodically will pull data from an external server and put into an InfluxDB bucket. _Data source is [peco-online](https://www.peco-online.ro/)_.

1. Pull GH repo to local FS,
2. Run `bash index.sh`,
3. Wait for it to complete,
4. You have a dockerized dashboard application with 3 services: Jupyter, Grafana and InfluxDB at ports `8888` & `3000` & `8086` respectively.

### Other remarks

- Execute `bash backupData.sh` on local machine to backup data from Jupyter container; **Note**: backups and removes all data from container!
- Execute `bash archiveData.sh` on local machine to archive in `year_month` format all dangling data in `data` directory on local FS.
- For dashboard import `echarts` plugin has to be installed on Grafana container: `grafana-cli plugins install bilibala-echarts-panel`.
- For dashboard import `clock` plugin has to be installed on Grafana container: `grafana-cli plugins install grafana-clock-panel`.
- Execute `bash run.sh` to restart containers after `docker compose stop`.
