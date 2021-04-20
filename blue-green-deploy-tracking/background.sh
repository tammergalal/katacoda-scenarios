#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY

statusupdate "Secrets created, starting services..."

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml


statusupdate complete
