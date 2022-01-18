#!/bin/bash
statuscheck "tools"

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export STOREDOG_URL=https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com

clear
statusupdate "environment"
statuscheck "workspace"

[ ! -d "/root/lab" ] && mkdir /root/lab 

cd /root/lab

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=$POSTGRES_USER\n\
POSTGRES_PASSWORD=$POSTGRES_PASSWORD\n\
STOREDOG_URL=$STOREDOG_URL" > .env 

clear

statusupdate complete
start
prepenvironment