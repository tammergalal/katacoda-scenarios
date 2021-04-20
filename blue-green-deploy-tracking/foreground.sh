#!/bin/bash
launch.sh

kubectl completion bash >/etc/bash_completion.d/kubectl
complete -F __start_kubectl k
clear
prepenvironment