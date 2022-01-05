#!/bin/bash

curl -sk https://datadoghq.dev/katacodalabtools/r?raw=true|bash

statusupdate "tools"
statuscheck "environment"

cd /root/lab

wget -q -O - https://github.com/buger/goreplay/releases/download/v1.1.0/gor_1.1.0_x64.tar.gz | tar -xz -C /usr/local/bin
mv /usr/local/bin/gor /root/lab/gor
mv /ecommworkshop/traffic-replay/requests_0.gor /root/lab/requests_0.gor

docker-compose deploy/docker-compose/docker-compose-broken-no-apm-instrumentation.yml up -d

statusupdate "workspace"

./gor --input-file-loop --input-file "./requests_0.gor|350%" --output-http "http://localhost:3000" >> /dev/null 2>&1