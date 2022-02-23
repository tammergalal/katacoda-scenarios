#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

statuscheck "environment"

until  [ -f /root/docker-compose.yml ]
do
  sleep 2
done

mv /root/docker-compose.yml /root/lab/docker-compose.yml
ln -s /ecommworkshop/store-frontend-instrumented-fixed /root/lab/store-frontend
ln -s /ecommworkshop/discounts-service /root/lab/discounts-service
ln -s /ecommworkshop/ads-service /root/lab/ads-service

docker-compose -f /root/lab/docker-compose.yml pull

statusupdate "workspace"

