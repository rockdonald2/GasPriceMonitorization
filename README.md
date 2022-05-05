# README

Dockerized project for Romanian gas prices monitorization.

## Steps to setup dockerized environment

1. Pull GH repo to local FS,
2. Create .env file in `notebooks` dir [as schema below](#env-schema),
3. Run `bash index.sh` in project's root directory,
4. Wait for it to complete,
5. You have a dockerized dashboard application with 3 services: Jupyter, Grafana and InfluxDB at ports `8888` & `3000` & `8086` respectively.

**Note**: this won't contain the created dashboard's model, only periodically pulls data from an external server and puts into an InfluxDB bucket. _Data source is [peco-online](https://www.peco-online.ro/)_.

`index.sh` shell script will create Docker containers, start them and initiate the scraping mechanism, which periodically (currently every day) resets itself.  
To recreate dashboard the `model.json` should be imported into a Grafana dashboard from the `dashboard` directory and an InfluxDB datasource should be added using database name `GasPriceMonitorization`.  
To reupload all data from archived data run `bash scripts/upload_all.sh` on host machine from the root directory.

## Short description

Dockerized dashboard about Romanian gas and Brent crude oil prices with daily scraped new data where researchers can examine the current trends in the oil industry.

Daily data is scraped with `scrape.sh` and `scrape.ipynb` with BeautifulSoup4 from [peco-online](peco-online.ro), then uploaded into an InfluxDB database named `GasPriceMonitorization` and visualized in a Grafana dashboard, ensuring a consistent flow of information, providing great insights into a ever-changing industry.

Later augmented with Brent crude oil prices to analyze connections between the two.

---

### Other remarks

- Execute `bash scripts/backup_data.sh` in root directory, on local machine to backup data from Jupyter container; **Note**: backups and removes all raw data from container!
- Execute `bash scripts/archive_data.sh` in root directory, on local machine to archive in `year_month` format all dangling data in `data` directory on local FS.
- Execute `bash run.sh` in project's root directory to restart containers after `docker compose stop`.
- For dashboard import `echarts` plugin has to be installed on Grafana container: `grafana-cli plugins install bilibala-echarts-panel`.
- For dashboard import `clock` plugin has to be installed on Grafana container: `grafana-cli plugins install grafana-clock-panel`.
- Start containers with `docker compose start` to not initiate a scrape session.

### .env schema

```plain
DB_USER=root
DB_PWD=root
DB_ADDR=influxdb
DB_PORT=8086
```
