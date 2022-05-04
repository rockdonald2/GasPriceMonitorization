FROM jupyter/base-notebook
USER root

ARG ROOT='/home/jovyan/work/workspace'

COPY notebooks/createdb.ipynb ${ROOT}/
COPY notebooks/.env ${ROOT}/.env
COPY scripts/createdb.sh ${ROOT}/createdb.sh
RUN chmod a+x ${ROOT}/createdb.sh
# create influxdb databases
RUN ${ROOT}/createdb.sh

# add notebooks to container
COPY notebooks/* ${ROOT}/
COPY notebooks/.env ${ROOT}/.env

# add scripts to container
COPY scripts/scrape.sh ${ROOT}/scrape.sh
RUN chmod a+x ${ROOT}/scrape.sh

# add data for Romanian counties
COPY data/counties.json ${ROOT}/counties.json