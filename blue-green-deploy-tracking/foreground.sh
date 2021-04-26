#!/bin/bash
while [ ! `kubectl get nodes 2>/dev/null | wc -l ` -eq 2 ]; do
  sleep 0.3
done

kubectl completion bash >/etc/bash_completion.d/kubectl

clear

prepenvironment