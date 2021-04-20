#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

kubeloopstart=`date +%s`
until kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY
do
  kubeloopend=`date +%s`
  kubeloopruntime=$((kubeloopend-kubeloopstart))
  echo "kubectl isn't ready yet."
  echo "It has been $kubeloopruntime seconds"
  echo "If this doesn't resolve after 60 seconds, contact support."
  sleep 2
done

statusupdate "Kubernetes setup complete and secrets created, starting services..."

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml


statusupdate complete
