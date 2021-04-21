In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. Now run the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

1. Open <a href="https://app.datadoghq.com/event/stream" target="_datadog">Datadog</a> and look in the event stream for the agents to show up. Next move over to the Integrations page and enable the Kubernetes integration. 

1. You should see some Kubernetes metrics show up on the Metrics Summary. 

1. We need to add a new node to our cluster! First run `kubeadm token create --print-join-command`{{execute}}.

This command will output a new `join` command for you to enter into the terminal to add a new Node into our cluster.

Next run `openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'`{{execute}}
