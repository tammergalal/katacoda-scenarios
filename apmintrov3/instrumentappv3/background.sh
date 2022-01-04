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

mv /root/docker-compose.yml /root/lab
wget -q -O - https://github.com/buger/goreplay/releases/download/v1.1.0/gor_1.1.0_x64.tar.gz | tar -xz -C /usr/local/bin
mv /usr/local/bin/gor /root/lab/gor
mv /ecommworkshop/traffic-replay/requests_0.gor /root/lab/requests_0.gor

docker-compose up -d

./gor --input-file-loop --input-file "./requests_0.gor|350%" --output-http "http://localhost:3000" >> /dev/null 2>&1