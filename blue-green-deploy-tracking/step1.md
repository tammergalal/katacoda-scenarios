1. Wait until the environment has finished preparing before interacting with the terminal or clicking the IDE, Storedog, or Datadog tabs.

1. We can verify our application is up and running by executing a simple `kubectl` command:
First lets check on our pods, services, deployments, and replicasets using `kubectl get all`{{execute}}
You should see a list of the pods, services, deployments, and replicasets and their current state. (i.e., ContainerCreating or Ready in the Status columns.) If you don't see this output, wait a minute or so and run it again. Once you run `kubectl get all` and see all pods, services, deployments, and replicasets are running feel free to move on.

You'll notice now that all of the pods and services are running....there is no Datadog Agent! Now run the helm install command: 

`helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml datadog/datadog`{{execute}}

`helm install datadogagent --set datadog.apiKey=$DD_API_KEY -f k8s-yaml-files/values.yaml datadog/datadog` {{execute}}

Replace release name with whatever you would like the name to be, we will use storedog-app.




