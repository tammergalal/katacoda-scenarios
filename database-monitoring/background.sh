#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

touch /root/status.txt
cd /ecommworkshop/deploy/docker-compose

docker-compose --env-file ./docker.env up --no-start && docker-compose start agent && docker-compose start db && wait-for-it -t 0 0.0.0.0:5432 && docker-compose start discounts && docker-compose start advertisements && docker-compose start frontend 


./ecommworkshop/gor --input-file-loop --input-file "./ecommworkshop/traffic-replay/requests_0.gor|300%" --output-http "http://localhost:30001" >> /dev/null 2>&1
