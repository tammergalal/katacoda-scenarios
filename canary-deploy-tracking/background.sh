#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

touch /root/status.txt
sleep 1
STATUS=$(cat /root/status.txt)

if [ "$STATUS" != "complete" ]; then
  echo ""> /root/status.txt

  wall -n "Installing Helm and cloning necessary materials"

  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  helm repo add datadog https://helm.datadoghq.com
  helm repo update

  NNODES=$(kubectl get nodes | grep Ready | wc -l)

  while [ "$NNODES" != "2" ]; do
    sleep 0.3
    NNODES=$(kubectl get nodes | grep Ready | wc -l)
  done

  wall -n "Creating ecommerce deployment"
  kubectl apply -f k8s-yaml-files/db.yaml
  kubectl apply -f k8s-yaml-files/advertisements.yaml
  kubectl apply -f k8s-yaml-files/advertisements-service.yaml
  kubectl apply -f k8s-yaml-files/discounts.yaml
  kubectl apply -f k8s-yaml-files/frontend.yaml

  while [ "$NPODS" != "4" ]; do
    sleep 0.3
    NPODS=$(kubectl get pods --field-selector=status.phase=Running | grep -v NAME | wc -l)
  done

  echo "complete">>/root/status.txt
fi

./ecommworkshop/gor --input-file-loop --input-file "./ecommerce-workshop/traffic-replay/requests_0.gor|300%" --output-http "http://localhost:30001" >> /dev/null 2>&1
