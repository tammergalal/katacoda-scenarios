#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

./ecommworkshop/gor --input-file-loop --input-file "./ecommerce-workshop/traffic-replay/requests_0.gor|300%" --output-http "http://localhost:30001" >> /dev/null 2>&1



