#!/bin/bash

curl -sk https://datadoghq.dev/katacodalabtools/r?raw=true|bash

statusupdate "tools"
statuscheck "environment"

# Wait for required assets to appear in the filesystem
until  [ -f /root/puppeteer.sh ]
do
  sleep 2
done

cd /root/lab

ln -s /ecommworkshop/discounts-service/discounts.py
ln -s /ecommworkshop/ads-service/ads.py
ln -s /root/lab/requirements.txt
ln -s /root/lab/datadog.rb
ln -s /root/lab/Gemfile

mv /root/docker-compose.yml /root/lab

docker-compose up -d

statusupdate "workspace"

