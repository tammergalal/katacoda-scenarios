In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. Now run the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

1. Open <a href="https://app.datadoghq.com/event/stream" target="_datadog">Datadog</a> and look in the event stream for the agents to show up. Next move over to the Integrations page and enable the Kubernetes integration. 

1. You should see some Kubernetes metrics show up on the Metrics Summary. 

1. Return to the Metrics Summary page and you should see the kubernetes metrics start to appear. Take a look at the **Kubernetes - Overview** dashboard. Note that it can take a while for metrics to populate at first. You can also run the agent status command again, but note that your Datadog agent pod probably has a new name. 
