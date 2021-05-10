In the terminal on the right, the environment is set up with Kubernetes and a deployment of Storedog. Storedog is an e-commerce application that you can interact with via the StoredogV1 tab located to your right at the top of the terminal.

Now open a new window/tab and log into the [Datadog account](https://app.datadoghq.com/account/login) that was created for you by learn.datadoghq.com. 

**Note**: You can access these login credentials whenever you need by typing `creds` in the terminal.

Click the StoredogV1 tab at the top of your terminal to the right. Take a look around and generate some traffic.

Since you started this lab, a background process has been automatically making requests to the Storedog app. Between this traffic and the traffic you created while clicking around Storedog, you should have a good amount of activity to look at in the Datadog Platform. Next, you need to get the Datadog agent running in your cluster to collect data from Storedog. You can use our simple one line Helm install command.

1. With all the kubernetes resources running and ready, execute the helm install command for the datadog agent and cluster-agent: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

**Note**: Your `$DD_API_KEY` and `$DD_APP_KEY` are being grabbed from the environment, there is no need to manually edit the environment variables in this command.

1. Running `kubectl get service, pod, deployment -n datadog`{{execute}} should show you that the datadog agent, cluster agent, and kube-state metrics are now running in addition to your deployment.

**Note**: You may need to wait up to a minute or two for the agents to be fully up and running. Try executing `kubectl get service, pod, deployment -n datadog`{{execute}} after a minute to see if everything is ready. 

With the application receiving traffic and having used helm to install the datadog agent, the next step is to begin looking into some data about the app on the Datadog platform. 