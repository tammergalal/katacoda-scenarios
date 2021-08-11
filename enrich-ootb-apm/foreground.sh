#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
cd /ecommworkshop/deploy/docker-compose
docker-compose -f docker-compose-broken-instrumented up -d
docker-compose -f docker-compose-traffic-replay.yml up -d
clear

envready
statusupdate complete
clear

prepenvironment