#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

cd /ecommworkshop/

sudo sed -i '38i \ \ \ \ volumes:\n \ \ \ \ \ - "../../discounts-service-fixed:/app"' /ecommworkshop/deploy/docker-compose-fixed-instrumented.yml
sudo sed -i '84i \ \ \ \ volumes:\n \ \ \ \ \ - "../../ads-service-fixed:/app"' /ecommworkshop/deploy/docker-compose-fixed-instrumented.yml


