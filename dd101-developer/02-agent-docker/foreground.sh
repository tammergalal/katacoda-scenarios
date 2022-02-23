#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export DD_ENV=
export STOREDOG_URL=https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com

clear

statuscheck "workspace"
cd /root/lab 

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
DD_APPLICATION_ID=$DD_APPLICATION_ID\n\
DD_CLIENT_TOKEN=$DD_CLIENT_TOKEN\n\
DD_ENV=\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres\n\
STOREDOG_URL=$STOREDOG_URL" > .env 

statusupdate "environment"

statusupdate complete
start
prepenvironment