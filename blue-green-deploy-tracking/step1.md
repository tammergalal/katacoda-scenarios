Let's dive right into it. This environment has been setup running Kubernetes and already has a full deployment of an application called Storedog. Storedog is a multilanguage eCommerce application that you can interact with via the StoredogV1 tab located to your right at the top of the terminal(don't click that just yet.)

Once the environment is setup and you see your newly created login credentials and are able to access the `$controlpane` in the terminal, lets check on the status of our deployment. Run `kubectl get all`{{execute}} in the terminal to check on the status of our deployment. Once you see everything up and running, go ahead and click the StoredogV1 tab at the top of your terminal to the right.

So, as you can see we have a fully functioning ecommerce application, and thankfully in the background artifical traffic is being sent to our application so that we can just stick to exploring the Datadog platform. Speaking of the platform....we are going to need our agents running to collect data from our application. Let's do install the agents now.

1. With our deployment up and running, execute the helm install command for the datadog agent and cluster-agent: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

**Note** Your `$DD_API_KEY` and `$DD_APP_KEY` are being grabbed from the environment, so no need to manually edit the above command.

1. Running `kubectl get all`{{execute}} again should show you that the datadog agent, cluster agent, and kube state metrics are now running in addition to our deployment. Great!

Now that our deployment is up and running, traffic is being generated and sent to our app, and we have used helm to install the datadog agent, we can now move onto looking into some information about our deployment in the next step. See you there!


