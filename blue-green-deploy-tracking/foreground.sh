# sed -i 's|--DATADOG_API_KEY--|datadog/agent:6.11.1|' docker-compose.yml
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl completion bash >/etc/bash_completion.d/kubectl
complete -F __start_kubectl k
clear
prepenvironment