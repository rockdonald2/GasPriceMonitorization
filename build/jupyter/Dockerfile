FROM jupyter/base-notebook
USER root

ARG ROOT='/home/jovyan/work/workspace'

ADD notebooks/.env ${ROOT}/.env
ADD scripts/createdb.sh ${ROOT}/createdb.sh
RUN chmod a+x ${ROOT}/createdb.sh
# create influxdb databases
RUN ${ROOT}/createdb.sh

# add notebooks to container
ADD notebooks/* ${ROOT}/
ADD notebooks/.env ${ROOT}/.env

# add scripts to container
ADD scripts/scrape.sh ${ROOT}/scrape.sh
RUN chmod a+x ${ROOT}/scrape.sh

# add data for Romanian counties
ADD data/counties.json ${ROOT}/counties.json