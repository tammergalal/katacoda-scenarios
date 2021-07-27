#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

touch /root/status.txt
sleep 1
STATUS=$(cat /root/status.txt)

if [ "$STATUS" != "complete" ]; then
  echo ""> /root/status.txt

  git clone https://github.com/DataDog/ecommerce-workshop.git
  sudo sed -i '38i \ \ \ \ volumes:\n \ \ \ \ \ - "../../discounts-service-fixed:/app"' /root/ecommerce-workshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
  sudo sed -i '84i \ \ \ \ volumes:\n \ \ \ \ \ - "../../ads-service-fixed:/app"' /root/ecommerce-workshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
  echo "complete"> /root/status.txt
fi

/ecommerce-workshop/gor --input-file-loop --input-file /ecommworkshop/requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1