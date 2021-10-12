#!/bin/bash
while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
sleep 0.3

clear
statuscheck installingHelm 
statuscheck deployment
statusupdate checkPods
# prepenvironment