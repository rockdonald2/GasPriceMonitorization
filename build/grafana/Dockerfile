FROM grafana/grafana
USER ROOT

ENV GF_INSTALL_PLUGINS=grafana-clock-panel,bilibala-echarts-panel

# copy Romania map to grafana
ADD data/romania.json /usr/share/grafana/public/maps/romania.geojson