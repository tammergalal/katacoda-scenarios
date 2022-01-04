#!/bin/bash
while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done

while [ ! $(ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l) -eq 5 ]; do
  sleep 0.3
done

clear


statuscheck helm
helm install datadogagent --set datadog.apiKey="$DD_API_KEY" --set datadog.appKey="$DD_APP_KEY" -f /root/k8s-yaml-files/values.yaml datadog/datadog


statuscheck krew

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kubectl completion bash >/etc/bash_completion.d/kubectl
complete -F __start_kubectl k

cd k8s-yaml-files || exit

clear
prepenvironment