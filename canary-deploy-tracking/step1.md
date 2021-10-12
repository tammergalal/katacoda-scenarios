In the terminal on the right, the environment is set up with Kubernetes and a deployment of Storedog. Storedog is an e-commerce application that you can interact with via the StoredogV1 tab located to your right at the top of the terminal.

In the terminal on the right, you should see credentials for a newly provisioned Datadog trial account. Open a new window/tab and use the provided credentials to log into the [Datadog](https://app.datadoghq.com/account/login) platform.

**Note**: You can access these login credentials whenever you need by typing `creds` in the terminal.

Run `kubectl get all`{{execute}} in the terminal to the right by clicking the code snippet, this will show you all the kubernetes resources that comprise our application.

![Up and Running](./assets/up_and_running.png)

Click the StoredogV1 tab at the top of your terminal to the right. Take a look around and generate some traffic.

Since you started this lab, a background process has been automatically making requests to the Storedog app. Between this traffic and the traffic you created while clicking around Storedog, you should have a good amount of activity to look at in the Datadog Platform. Next, you need to get the Datadog agent running in your cluster to collect data from Storedog. You can use our simple one line Helm install command.

1. With all the kubernetes resources running and ready, execute the helm install command for the datadog agent and cluster-agent: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog --version 2.13.0`{{execute}}

1. Running `kubectl get deploy datadogagent-cluster-agent datadogagent-kube-state-metrics && kubectl get daemonset datadogagent && kubectl get pod -l app=datadogagent && kubectl get pod -l app=datadogagent-cluster-agent && kubectl get pod -l app.kubernetes.io/instance=datadogagent`{{execute}} should show you that the datadog agent, cluster agent, and kube-state metrics are now running in addition to your deployment.

**Note**: You may need to wait up to a minute or two for the agents to be fully up and running. Try executing the above command again after a minute to see if everything is ready. 

With the application receiving traffic and having used helm to install the datadog agent, the next step is to begin looking into some data about the app on the Datadog platform. 