#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

cd /ecommworkshop/

sudo sed -i '38i \ \ \ \ volumes:\n \ \ \ \ \ - "../../discounts-service-fixed:/app"' /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
sudo sed -i '84i \ \ \ \ volumes:\n \ \ \ \ \ - "../../ads-service-fixed:/app"' /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
sudo sed -i '50i \ \ \ \ \ \ - DD_PROFILING_ENABLED=true' /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
sudo sed -i '50i \ \ \ \ \ \ - DD_ENV=development' /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
sudo sed -i '50i \ \ \ \ \ \ - DD_VERSION=1.0' /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
sudo sed -i "24i gem 'google-protobuf', ~> '3.0'" /ecommworkshop/storedog/Gemfile



