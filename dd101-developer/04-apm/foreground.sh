#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export STOREDOG_URL=https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com

clear
statusupdate "environment"
statuscheck "workspace"

cd /root/lab 

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=$POSTGRES_USER\n\
POSTGRES_PASSWORD=$POSTGRES_PASSWORD\n\
STOREDOG_URL=$STOREDOG_URL" > .env 

string="Resource get_/discount has a high average latency on env:dd101-dev"
if curl -X GET "https://api.datadoghq.com/api/v1/monitor" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}" | grep -q "$string"; then
    echo "Monitor exists"
else      
  curl -X POST "https://api.datadoghq.com/api/v1/monitor" \
  -H "Content-Type: application/json" \
  -H "DD-API-KEY: ${DD_API_KEY}" \
  -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
  -d @/root/discount_monitor.json
fi

clear

docker-compose up -d

statusupdate complete
start
prepenvironment