#!/bin/bash
launch.sh
while [ ! `ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l ` -eq 10 ]; do
  sleep 0.3
done
while [ ! `k get nodes 2>/dev/null | wc -l ` -eq 2 ]; do
  sleep 0.3
done

kubectl completion bash >/etc/bash_completion.d/kubectl
complete -F __start_kubectl k
clear
prepenvironment