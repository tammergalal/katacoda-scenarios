#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

touch /root/status.txt
sleep 1
STATUS=$(cat /root/status.txt)

if [ "$STATUS" != "complete" ]; then
  echo ""> /root/status.txt

  wall -n "Cloning necessary materials"

  mkdir /ecommerce-observability
  git clone https://github.com/DataDog/ecommerce-workshop /ecommerce-observability
  cd ../ecommerce-observability

  echo "complete">>/root/status.txt
fi

# locked to specific commit on 2020-10-02
git checkout 9ce34516d9a65d6f09a6fffd5c4911a409d31e3f
git reset --hard

statusupdate complete
