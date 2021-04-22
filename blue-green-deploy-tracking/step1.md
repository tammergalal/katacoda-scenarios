Let's dive right into it. This environment has been setup running Kubernetes and already has a full deployment of an application called Storedog. Storedog is a multilanguage eCommerce application that you can interact with via the StoredogV1 tab located to your right at the top of the terminal.





Give the kubernetes services time to spin up. Then:

1. Now run the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

1. Open <a href="https://app.datadoghq.com/event/stream" target="_datadog">Datadog</a> and look in the event stream for the agents to show up. Next move over to the Integrations page and enable the Kubernetes integration. 

1. You should see some Kubernetes metrics show up on the Metrics Summary. 

Next run `kubectl apply -f k8s-yaml-files/discounts2.yaml`{{execute}} to create our second deployment.

Use `kubectl get all`{{execute}} to ensure all deployments and pods are running correctly.


