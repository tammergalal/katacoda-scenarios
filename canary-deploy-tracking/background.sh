#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

export FRONTEND_HOST=http://localhost:3000
touch /root/status.txt
sleep 1
STATUS=$(cat /root/status.txt)

if [ "$STATUS" != "complete" ]; then
  echo ""> /root/status.txt

  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  helm repo add datadog https://helm.datadoghq.com
  helm repo update

  git clone https://github.com/DataDog/ecommerce-workshop.git

  NNODES=$(kubectl get nodes | grep Ready | wc -l)

  while [ "$NNODES" != "2" ]; do
    sleep 0.3
    NNODES=$(kubectl get nodes | grep Ready | wc -l)
  done

  kubectl apply -f k8s-yaml-files/db.yaml
  kubectl apply -f k8s-yaml-files/advertisements.yaml
  kubectl apply -f k8s-yaml-files/advertisements-service.yaml
  kubectl apply -f k8s-yaml-files/discounts.yaml
  kubectl apply -f k8s-yaml-files/frontend.yaml

  while [ "$NPODS" != "4" ]; do
    sleep 0.3
    NPODS=$(kubectl get pods --field-selector=status.phase=Running | grep -v NAME | wc -l)
  done

  cd ecommerce-workshop/deploy/docker-compose
  docker-compose -f docker-compose-traffic-replay.yml up

  echo "complete">>/root/status.txt
fi


