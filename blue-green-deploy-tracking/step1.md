In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. Now run the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}
1. Open <a href="https://app.datadoghq.com/event/stream" target="_datadog">Datadog</a> and look in the event stream for the agents to show up. Next move over to the Integrations page and enable the Kubernetes integration. 
1. Then you should see some Kubernetes metrics show up on the Metrics Summary. But you probably aren't seeing them. Try looking at the **Kubernetes - Overview** dashboard. Most of the charts are probably empty.
1. Back in the console, run `k exec <pod name> agent status` replacing pod name with the full name of the agent on your cluster (In this lab environment, `k` is an alias for `kubectl` and kubectl autocomplete is enabled). You are looking for the block dealing with the kubelet. See the error? The environment you are running isn't exactly the same as what you are probably running in production. We need to tell the agent not to verify TLS. We do that by adding an environment variable.
1. Open values.yaml in the IDE. On line 190, uncomment env: and add
        - name: DD_KUBELET_TLS_VERIFY
          value: "false"
1. Run helm update to put your changes into effect. `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}
1. Return to the Metrics Summary page and you should see the kubernetes metrics start to appear. Take a look at the **Kubernetes - Overview** dashboard. Note that it can take a while for metrics to populate at first. You can also run the agent status command again, but note that your Datadog agent pod probably has a new name. 





