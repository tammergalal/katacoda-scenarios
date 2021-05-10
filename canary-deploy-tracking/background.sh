#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

helm repo add datadog https://helm.datadoghq.com

helm repo update

git clone https://github.com/DataDog/ecommerce-workshop.git

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml

statusupdate complete

./ecommerce-workshop/gor --input-file-loop --input-file "./ecommerce-workshop/traffic-replay/requests_0.gor|300%" --output-http "http://localhost:30001" >> /dev/null 2>&1

# echo "complete">>/root/status.txt