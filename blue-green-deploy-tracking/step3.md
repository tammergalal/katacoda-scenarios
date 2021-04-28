Great! Our latency is way down, but we are seeing an increased error rate in our new `1.1` deplyoment! That is not going to fly for our end user, so lets revert this deployment quickly and send some tickets over to our engineers.

First we need to take down our deployment of the `1.1` service.

In the terminal to the right, execute the following command: `kubectl delete deployments.apps <name of advertisementsv11 deployment> && kubectl delete service <name of advertisemensv11>`. Be sure to replace the <> with the specific names of your delployments and service. You can find this with a `kubectl get deployments & kubectl get svcs`

