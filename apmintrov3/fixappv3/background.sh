# #!/bin/bash

# curl -sk https://datadoghq.dev/katacodalabtools/r?raw=true|bash

# statusupdate "tools"
# statuscheck "environment"

# # Wait for required assets to appear in the filesystem
# until  [ -f /root/docker-compose.yml ]
# do
#   echo "DOCKER-COMPOSE!!!!!"
#   sleep 2
# done

# cd /root/lab

# # ln -s /ecommworkshop/discounts-service/discounts.py
# # ln -s /ecommworkshop/ads-service/ads.py

# # ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/layouts/spree_application.html.erb
# # ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/home/index.html.erb
# # ln -s /ecommworkshop/store-frontend-broken-instrumented/app/views/spree/products/show.html.erb

# mv /root/docker-compose.yml /root/lab
# wget -q -O - https://github.com/buger/goreplay/releases/download/v1.1.0/gor_1.1.0_x64.tar.gz | tar -xz -C /usr/local/bin
# mv /usr/local/bin/gor /root/lab/gor
# mv /ecommworkshop/traffic-replay/requests_0.gor /root/lab/requests_0.gor

# docker-compose up -d

# statusupdate "workspace"

# ./gor --input-file-loop --input-file "./requests_0.gor|350%" --output-http "http://localhost:3000" >> /dev/null 2>&1