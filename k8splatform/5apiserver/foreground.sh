until [ -f /usr/local/bin/statuscheck ]
do
     sleep 0.3
done
while [ ! `ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l ` -eq 6 ]; do
  sleep 0.3
done
clear
# while ! grep -q "helm installed" /root/status.txt; do
#   sleep 1
#   echo "Waiting for Helm"
# done
statuscheck helm
helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f /root/k8s-yaml-files/values.yaml datadog/datadog

# while ! grep -q "krew installed" /root/status.txt; do 
#   echo "Waiting for kubectl plugins"
#   sleep 1
# done
statuscheck krew

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kubectl completion bash >/etc/bash_completion.d/kubectl
complete -F __start_kubectl k
cd k8s-yaml-files

clear
prepenvironment