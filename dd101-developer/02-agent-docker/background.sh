#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

# Wait for required assets to appear in the filesystem
until  [ -f /root/puppeteer.sh ]
do
  sleep 2
done

mkdir /root/lab
mv /root/docker-compose.yml /root/lab

cd /root/lab
ln -s /ecommworkshop/store-frontend-instrumented-fixed /root/lab/store-frontend
ln -s /ecommworkshop/discounts-service
ln -s /ecommworkshop/ads-service

docker-compose pull

statusupdate "workspace"