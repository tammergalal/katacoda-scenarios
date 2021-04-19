#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
touch status.txt
echo "">/root/status.txt

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
statusupdate "Kubernetes ready!"

kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/cluster-agent/cluster-agent-rbac.yaml"
kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/cluster-agent/rbac.yaml"

kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml

# if [ ! -f "/root/provisioned" ]; then
#   apt install datamash
# fi

statusupdate complete

# echo "complete">>/root/status.txt