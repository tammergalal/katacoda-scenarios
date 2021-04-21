In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. Now run the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

1. Open <a href="https://app.datadoghq.com/event/stream" target="_datadog">Datadog</a> and look in the event stream for the agents to show up. Next move over to the Integrations page and enable the Kubernetes integration. 

1. You should see some Kubernetes metrics show up on the Metrics Summary. 

1. We need to add a new node to our cluster! First run `kubeadm token create --print-join-command`{{execute}}.

This command will output a new `join` command for you to enter into the terminal to add a new Node into our cluster.

Next run `kubectl apply -f k8s-yaml-files/frontend2.yaml -f k8s-yaml-files/advertisements2.yaml -f k8s-yaml-files/discounts2.yaml -f k8s-yaml-files/db2.yaml`{{execute}} to create our second deployment.

Use `kubectl get all`{{execute}} to ensure all deployments and pods are running correctly.

`gor-files/gor1 --input-file-loop --input-file "gor-files/requests_1.gor|300%" --output-http "http://localhost:3000" >> /dev/null 2>&1`{{execute}}

Next, run `gor-files/gor1 --input-file-loop --input-file "/gor-files/requests_2.gor|300%" --output-http "http://localhost:3001" >> /dev/null 2>&1`{{execute}} to simulate some traffic to the Storedog V1.1 application.