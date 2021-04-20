#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
touch status.txt
echo ""> /root/status.txt
kubeloopstart=`date +%s`
do
  kubeloopend=`date +%s`
  kubeloopruntime=$((kubeloopend-kubeloopstart))
  echo "kubectl isn't ready yet."
  echo "It has been $kubeloopruntime seconds"
  echo "If this doesn't resolve after 60 seconds, contact support."
  sleep 2
done
statusupdate "Kubernetes ready!"

kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/cluster-agent/cluster-agent-rbac.yaml"
kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/cluster-agent/rbac.yaml"

statusupdate "RBACs complete"

kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY

statusupdate "Secrets created, starting services..."

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml


statusupdate complete
