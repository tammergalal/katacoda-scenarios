1. Wait until the environment has finished preparing before interacting with the terminal or clicking the IDE, Storedog, or Datadog tabs.

1. We can verify our application is up and running by executing a simple `kubectl` commands:
First lets check on our pods, services, deployments, and replicasets using `kubectl get all`{{execute}}
You should see a list of the pods, services, deployments, and replicasets and their current state. (i.e., ContainerCreating or Ready in the Status columns.)

1. But wait, we have a cluster that is running on two servers, why aren’t there two agents running. Normally, only the nodes in the cluster will run the agent, but it’s also possible to run the agent on master if you add the tolerance to the pod. After line 15 in datadog-agent.yaml, add the following:
  <pre><code>tolerations:
  - key: node-role.kubernetes.io/master
     effect: NoSchedule
  </code></pre>

  *tolerations: should be at the same indent level as containers: below it*

1. Now apply the file again:
`kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}
1. Get the daemonset again and you should see two agents are running.
1. Open the datadog-agent.yaml file. Notice that many of the configuration options for the agent are defined with environment variables. 



