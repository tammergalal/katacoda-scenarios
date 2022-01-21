#!/bin/bash

curl -sk https://datadoghq.dev/katacodalabtools/r?raw=true|bash

statusupdate "tools"
statuscheck "environment"

# Wait for required assets to appear in the filesystem
until  [ -f /root/puppeteer.sh ]
do
  sleep 2
done

cd /root/lab

ln -s /ecommworkshop/discounts-service/discounts.py
ln -s /ecommworkshop/ads-service/ads.py
ln -s /root/lab/index.html.erb
ln -s /root/lab/show.html.erb
ln -s /root/lab/spree_application.html.erb

mv /root/docker-compose.yml /root/lab
mv /root/index.html.erb /root/lab
mv /root/show.html.erb /root/lab
mv /root/spree_application.html.erb /root/lab

docker-compose up -d

statusupdate "workspace"