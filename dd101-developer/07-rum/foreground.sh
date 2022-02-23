#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export DD_DISCOUNTS_URL=https://[[HOST_SUBDOMAIN]]-5001-[[KATACODA_HOST]].environments.katacoda.com/discount
export DD_ADS_URL=https://[[HOST_SUBDOMAIN]]-5002-[[KATACODA_HOST]].environments.katacoda.com
export STOREDOG_URL=https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com

clear

statuscheck environment
cd /root/lab 

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
DD_APPLICATION_ID=$DD_APPLICATION_ID\n\
DD_CLIENT_TOKEN=$DD_CLIENT_TOKEN\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres\n\
DD_ADS_URL=$DD_ADS_URL\n\
DD_DISCOUNTS_URL=$DD_DISCOUNTS_URL\n\
STOREDOG_URL=$STOREDOG_URL" > .env 

statusupdate complete
start
prepenvironment