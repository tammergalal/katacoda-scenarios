Let's dive right into it. This environment has been setup running Kubernetes and already has a full deployment of an application called Storedog. Storedog is a multilanguage eCommerce application that you can interact with via the StoredogV1 tab located to your right at the top of the terminal(don't click that just yet.)

Once the environment is setup and you see your newly created login credentials and are able to access the `$controlpane` in the terminal, you can check on the status of our deployment. Run `kubectl get all`{{execute}} in the terminal to the right or use the execute command by clicking the code snippet. Once you see everything up and running, go ahead and click the StoredogV1 tab at the top of your terminal to the right.

So, as you can see we have a fully functioning ecommerce application, Click around the store and add some things to the cart and see what our store offers (sadly....this isn't a real store). So that we can stick to exploring the Datadog platform, we have setup artifical traffic to be sent to Storedog. Speaking of the platform....we are going to need our agents running to collect data from our application. Let's go ahead and use Helm to install the agents now!

1. With our deployment up and running, execute the helm install command for the datadog agent and cluster-agent: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

**Note**: Your `$DD_API_KEY` and `$DD_APP_KEY` are being grabbed from the environment, there is no need to manually edit the variables in this command.

1. Running `kubectl get all`{{execute}} should show you that the datadog agent, cluster agent, and kube state metrics are now running in addition to our deployment. Great!

**Note**: You may need to wait up to a minute or two for the agents to be fully up and running. Try running `kubectl get all` after a minute to see if everything is up and running. 

Now that our deployment is up and running, we have used helm to install the datadog agent, and traffic is being generated and sent to our app, in the next step we can now move onto looking into some data about our deployment in Datadog. See you there!!!!


