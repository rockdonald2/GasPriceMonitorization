FROM jupyter/base-notebook
USER root

ARG ROOT='/etc/share/ref/jupyter'

# make working directory
RUN mkdir -p ${ROOT} 2>/dev/null

# add notebooks to container
COPY notebooks/* ${ROOT}/
COPY notebooks/.env ${ROOT}/.env

# add scripts to container
COPY scripts/scrape.sh ${ROOT}/scrape.sh
RUN chmod a+x ${ROOT}/scrape.sh

# add data for Romanian counties
COPY data/counties.json ${ROOT}/counties.json

RUN mkdir -p ${ROOT}/archived_data 2>/dev/null
# copy archived data to contaienr
COPY data/* ${ROOT}/archived_data/

# add script to container that creates InfluxDB bucket
COPY scripts/createdb.sh ${ROOT}/createdb.sh
RUN chmod a+x ${ROOT}/createdb.sh