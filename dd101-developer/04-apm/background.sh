#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

statuscheck "environment"

until  [ -f /root/puppeteer.sh ]
do
  sleep 2
done

mkdir /root/lab
mv /root/docker-compose.yml /root/lab
mv /root/discounts.py /ecommworkshop/discounts-service/discounts.py
ln -s /ecommworkshop/store-frontend-instrumented-fixed /root/lab/store-frontend
ln -s /ecommworkshop/discounts-service /root/lab/discounts-service
ln -s /ecommworkshop/ads-service /root/lab/ads-service

docker-compose -f /root/lab/docker-compose.yml pull

statusupdate "workspace"