FROM jupyter/base-notebook
USER root

ARG ROOT='/home/jovyan/work/workspace'

# add notebooks to container
ADD --chown=jovyan:jovyan notebooks/* ${ROOT}/
ADD --chown=jovyan:jovyan notebooks/.env ${ROOT}/.env

# add scripts to container
ADD --chown=jovyan:jovyan scripts/scrape.sh ${ROOT}/scrape.sh
RUN chmod a+x ${ROOT}/scrape.sh

ADD --chown=jovyan:jovyan scripts/createdb.sh ${ROOT}/createdb.sh
RUN chmod a+x ${ROOT}/createdb.sh

# add data for Romanian counties
ADD --chown=jovyan:jovyan data/counties.json ${ROOT}/counties.json

# create influxdb databases
RUN ${ROOT}/createdb.sh