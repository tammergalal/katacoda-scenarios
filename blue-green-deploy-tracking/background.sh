#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
touch status.txt
echo "">/root/status.txt

# apt-get install wait-for-it
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
# helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add datadog https://helm.datadoghq.com
helm repo update
# echo "Waiting for kubernetes to start" >>/root/status.txt
statusupdate "Waiting for kubernetes to start"
while [ "$( kubectl get nodes --no-headers 2>/dev/null | wc -l )" != "2" ]; do
  sleep 1
done
statusupdate "Waiting for all nodes to be ready"
# echo "Waiting for all nodes to be ready" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null| awk '{print $2}'|xargs )" !=  "Ready Ready" ]; do
  sleep 1
done
# echo "Kubernetes ready.">>/root/status.txt
statusupdate "Kubernetes ready."

git clone https://github.com/DataDog/ecommerce-workshop.git 

kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml

statusupdate complete

./ecommerce-workshop/gor --input-file-loop --input-file "./ecommerce-workshop/traffic-replay/requests_0.gor" --output-http "http://localhost:30001"
# echo "complete">>/root/status.txt