#!/bin/bash
while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
sleep 0.3

clear
statuscheck installingHelm 
statusupdate checkPods
statuscheck deployment
prepenvironment