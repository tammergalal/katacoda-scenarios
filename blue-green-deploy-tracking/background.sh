#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

helm repo add datadog https://helm.datadoghq.com

helm repo update

while [ "$( kubectl get nodes --no-headers 2>/dev/null | wc -l )" != "2" ]; do
  sleep 1
done

mkdir k8s-yaml-files

git clone https://github.com/DataDog/ecommerce-workshop.git 

cp /root/ecommerce-workshop/deploy/generic-k8s/ecommerce-app/advertisements.yaml /root/k8s-yaml-files
cp /root/ecommerce-workshop/deploy/generic-k8s/ecommerce-app/discounts.yaml /root/k8s-yaml-files
cp /root/ecommerce-workshop/deploy/generic-k8s/ecommerce-app/discounts.yaml /root/k8s-yaml-files/discounts2.yaml
cp /root/ecommerce-workshop/deploy/generic-k8s/ecommerce-app/frontend.yaml /root/k8s-yaml-files
cp /root/ecommerce-workshop/deploy/generic-k8s/ecommerce-app/db.yaml /root/k8s-yaml-files
cp /root/ecommerce-workshop/discounts-service-fixed/discounts.py /root/discounts_1_1.py

sudo sed -ie '8i  \ \ \ \ tags.datadoghq.com/service: '\''advertisements'\''\n \ \ \ tags.datadoghq.com/version: '\''1.0'\''' /root/k8s-yaml-files/advertisements.yaml
sudo sed -ie '49i \ \ \ \ \ \ \ \ \ \ - name: DD_SERVICE\n  \ \ \ \ \ \ \ \ \ \ valueFrom:\n \ \ \ \ \ \ \ \ \ \ \ \ \ fieldRef:\n \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ fieldPath: metadata.labels['\''tags.datadoghq.com/service'\'']\n \ \ \ \ \ \ \ \ \ - name: DD_VERSION\n  \ \ \ \ \ \ \ \ \ \ valueFrom:\n \ \ \ \ \ \ \ \ \ \ \ \ \ fieldRef:\n \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ fieldPath: metadata.labels['\''tags.datadoghq.com/version'\'']' /root/k8s-yaml-files/advertisements.yaml
sudo sed -ie '8i  \ \ \ \ tags.datadoghq.com/service: '\''discounts'\''\n \ \ \ tags.datadoghq.com/version: '\''1.0'\''' /root/k8s-yaml-files/discounts.yaml
sudo sed -ie '49i \ \ \ \ \ \ \ \ \ \ - name: DD_SERVICE\n  \ \ \ \ \ \ \ \ \ \ valueFrom:\n \ \ \ \ \ \ \ \ \ \ \ \ \ fieldRef:\n \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ fieldPath: metadata.labels['\''tags.datadoghq.com/service'\'']\n \ \ \ \ \ \ \ \ \ - name: DD_VERSION\n  \ \ \ \ \ \ \ \ \ \ valueFrom:\n \ \ \ \ \ \ \ \ \ \ \ \ \ fieldRef:\n \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ fieldPath: metadata.labels['\''tags.datadoghq.com/version'\'']' /root/k8s-yaml-files/discounts.yaml
sudo sed -ie '29d' /root/discounts_1_1.py
sudo sed -ie '42d' /root/discounts_1_1.py

kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml

statusupdate complete

./ecommerce-workshop/gor --input-file-loop --input-file "./ecommerce-workshop/traffic-replay/requests_0.gor|500%" --output-http "http://localhost:30001" >> /dev/null 2>&1

# echo "complete">>/root/status.txt