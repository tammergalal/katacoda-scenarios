1. With all the kubernetes resources running and ready, execute the helm install command for the datadog agent and cluster-agent: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog --version=2.16.6`{{execute}}

1. Running `kubectl get deploy datadogagent-cluster-agent datadogagent-kube-state-metrics && kubectl get daemonset datadogagent && kubectl get pod -l app=datadogagent && kubectl get pod -l app=datadogagent-cluster-agent && kubectl get pod -l app.kubernetes.io/instance=datadogagent`{{execute}} should show you that the datadog agent, cluster agent, and kube-state metrics are now running in addition to your deployment.

**Note**: You may need to wait up to a minute or two for the agents to be fully up and running. Try executing the above command again after a minute to see if everything is ready. 

With the application receiving traffic and having used helm to install the datadog agent, the next step is to begin looking into some data about the app on the Datadog platform. 