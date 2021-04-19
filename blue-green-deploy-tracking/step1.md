1. Wait until the environment has finished preparing before interacting with the terminal or clicking the IDE, Storedog, or Datadog tabs.

1. We can verify our application is up and running by executing a simple `kubectl` command:
First lets check on our pods, services, deployments, and replicasets using `kubectl get all`{{execute}}
You should see a list of the pods, services, deployments, and replicasets and their current state. (i.e., ContainerCreating or Ready in the Status columns.) If you don't see this output, wait a minute or so and run it again. Once you run `kubectl get all` and see all pods, services, deployments, and replicasets are running feel free to move on.

You'll notice now that all of the pods and services are running....there is no Datadog Agent!

`echo -n '<32_CHARACTER_LONG_STRING>' | base64`{{execute}}

`kubectl create secret generic datadog-auth-token --from-literal=token=<TOKEN_FROM_PREVIOUS_STEP>`{{copy}}

`kubectl apply -f cluster-agent.yaml`{{execute}}

`kubectl get pods -l app=datadog-cluster-agent`{{execute}}

`kubectl create -f datadog-agent.yaml`{{execute}}

`kubectl get daemonset datadog-agent`{{execute}}

Replace release name with whatever you would like the name to be, we will use storedog-app.




