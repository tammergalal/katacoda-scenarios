#!/bin/bash

while [ "$( kubectl get nodes --no-headers 2>/dev/null | wc -l )" != "2" ]; do
  sleep 1
done

kubectl completion bash >/etc/bash_completion.d/kubectl

clear

prepenvironment