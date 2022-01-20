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
ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/layouts/spree_application.html.erb
ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/home/index.html.erb
ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/products/show.html.erb

mv /root/docker-compose.yml /root/lab

docker-compose up -d

statusupdate "workspace"