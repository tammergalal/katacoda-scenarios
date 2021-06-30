#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

touch /root/status.txt
sleep 1
STATUS=$(cat /root/status.txt)

if [ "$STATUS" != "complete" ]; then
  echo ""> /root/status.txt
  
  wall -n "Cloning necessary materials"

  git clone https://github.com/DataDog/ecommerce-workshop.git
  cd /ecommworkshop/docker-compose-files
  sudo sed -i '38i \ \ \ \ volumes:\n \ \ \ \ \ - "../../discounts-service-fixed:/app"' /root/ecommerce-workshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml
  sudo sed -i '85i \ \ \ \ volumes:\n \ \ \ \ \ - "../../ads-service-fixed:/app"' /root/ecommerce-workshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml

  echo "complete"> /root/status.txt
fi


/ecommworkshop/gor --input-file-loop --input-file /ecommworkshop/requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1