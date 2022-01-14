#!/bin/bash

curl -sk https://datadoghq.dev/katacodalabtools/r?raw=true|bash

statusupdate "tools"
statuscheck "environment"

# Wait for required assets to appear in the filesystem
until  [ -f /root/dd_agent.sql ]
do
  sleep 2
done

cd /root/lab

ln -s /ecommworkshop/discounts-service/discounts.py
ln -s /ecommworkshop/ads-service/ads.py
ln -s /ecommworkshop/discounts-service/requirements.txt
ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/layouts/spree_application.html.erb
ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/home/index.html.erb
ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/products/show.html.erb
ln -s /ecommworkshop/store-frontend-broken-instrumented/config/initializers/datadog.rb
ln -s /ecommworkshop/store-frontend-broken-instrumented/Gemfile

mv /root/docker-compose.yml /root/lab

docker-compose up -d

statusupdate "workspace"

./gor --input-file-loop --input-file "./requests_0.gor|350%" --output-http "http://localhost:3000" >> /dev/null 2>&1