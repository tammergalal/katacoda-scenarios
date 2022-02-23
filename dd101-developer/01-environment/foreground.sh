#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export STOREDOG_URL=https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com
export DD_ENV=

clear

statuscheck "workspace"
cd /root/lab 

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
DD_APPLICATION_ID=$DD_APPLICATION_ID\n\
DD_ENV=\n\
DD_CLIENT_TOKEN=$DD_CLIENT_TOKEN\n\
POSTGRES_USER=$POSTGRES_USER\n\
POSTGRES_PASSWORD=$POSTGRES_PASSWORD\n\
STOREDOG_URL=$STOREDOG_URL" > .env 

docker-compose up -d

statusupdate complete
start
prepenvironment