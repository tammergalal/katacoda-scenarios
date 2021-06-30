#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

git clone https://github.com/DataDog/ecommerce-workshop.git
cd /ecommworkshop/docker-compose-files

sudo sed -i '37i \ \ \ \ volumes:\n \ \ \ \ \ - "../../discounts-service-fixed:/app"' /root/ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
sudo sed -i '84i \ \ \ \ volumes:\n \ \ \ \ \ - "../../ads-service-fixed:/app"' /root/ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml

/ecommworkshop/gor --input-file-loop --input-file /ecommworkshop/requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1