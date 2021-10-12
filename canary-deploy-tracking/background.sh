#!/bin/bash

curl -sk https://datadoghq.dev/katacodalabtools/r?raw=true|bash

touch /root/status.txt
sleep 1
STATUS=$(cat /root/status.txt)

if [ "$STATUS" != "complete" ]; then
  echo ""> /root/status.txt

  NNODES=$(kubectl get nodes | grep Ready | wc -l)

  while [ "$NNODES" != "2" ]; do
    sleep 0.3
    NNODES=$(kubectl get nodes | grep Ready | wc -l)
  done

  NPODS=$(kubectl get pods -n kube-system -l component=kube-apiserver --field-selector=status.phase=Running | grep -v NAME | wc -l)
  while [ "$NPODS" != "1" ]; do
    sleep 0.3
    NPODS=$(kubectl get pods -n kube-system -l component=kube-apiserver --field-selector=status.phase=Running | grep -v NAME | wc -l)
  done

  # wall -n "Installing Helm and cloning necessary materials"
  statusupdate installingHelm

  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  helm repo add datadog https://helm.datadoghq.com
  helm repo update
  wget -q -O - https://github.com/buger/goreplay/releases/download/v1.1.0/gor_1.1.0_x64.tar.gz | tar -xz -C /usr/local/bin
  mv /usr/local/bin/gor /root/gor
  mv /ecommworkshop/traffic-replay/requests_0.gor /root/requests_0.gor

  statusupdate deployment
  # wall -n "Creating ecommerce deployment"
  kubectl apply -f k8s-yaml-files/advertisements.yaml
  kubectl apply -f k8s-yaml-files/db.yaml
  kubectl apply -f k8s-yaml-files/advertisements-service.yaml
  kubectl apply -f k8s-yaml-files/discounts.yaml
  kubectl apply -f k8s-yaml-files/frontend.yaml

  statusupdate checkPods
  sleep 1
  NPODS=$(kubectl get pods --field-selector=status.phase=Running | grep -v NAME | wc -l)
  while [ "$NPODS" != "4" ]; do
    sleep 0.3
    NPODS=$(kubectl get pods --field-selector=status.phase=Running | grep -v NAME | wc -l)
  done


  statusupdate complete

fi


./gor --input-file-loop --input-file "./requests_0.gor|300%" --output-http "http://localhost:30001" >> /dev/null 2>&1
