#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

cd /ecommworkshop/

sudo sed -i '38i \ \ \ \ volumes:\n \ \ \ \ \ - "../../discounts-service-fixed:/app"' /ecommworkshop/deploy/docker-composedocker-compose-fixed-instrumented.yml
sudo sed -i '84i \ \ \ \ volumes:\n \ \ \ \ \ - "../../ads-service-fixed:/app"' /ecommworkshop/deploy/docker-composedocker-compose-fixed-instrumented.yml

/ecommworkshop/gor --input-file-loop --input-file /ecommworkshop/requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1



