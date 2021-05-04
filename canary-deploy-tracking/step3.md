With our `1.0` and `1.1` versions up and running and showing in the `Deployment` pane, click on the `1.0` deployment. Deployment Tracking for Datadog APM tracks all versions deployed over the last 30 days, giving you a wide window for continuous deployment analysis. Datadog automatically provides out-of-the-box graphs that visualize RED (requests, errors, and duration) metrics across versions, making it easy to spot problems in your services and endpoints before they turn into serious issues. Speaking of issues....we are starting to see a large error percentage in our new `1.1` deployment

Uh-oh! Our latency is way down, but we are seeing an increased error rate in our new `1.1` deplyoment! That is not going to fly for our end user, so lets revert this deployment quickly and send some tickets over to our engineers.

First we need to take down our deployment of the `1.1` advertisements service.

In the terminal to the right, execute the following command: `kubectl delete deployments.apps advertisementsv11 && kubectl delete service advertisementsv11 && kubectl delete pod <name of advertisements v11 pod>`. Be sure to replace the `<>` with the specific names of your pod. You can easily find the name of your pods with `kubectl get pods`{{execute}}.

Heading back over to the <a href=https://app.datadoghq.com/apm/service/advertisements>APM > Services > advertisements</a> page, looking down at our deployments we should shortly see that only the version `1.0` is `Active`. Now that we have taken down the bad deployment and ensured no users will encounter any errors, we can get a new image from our dev team.

With version `1.1` being error ridden, we have quickly received word of a new useable and tested image from our engineering team. We didn't receive a manifest from them, so let's quickly create a new one and update the image, version tag and name.

`cp /root/k8s-yaml-files/advertisements.yaml /root/k8s-yaml-files/advertisements_1_2.yaml`{{execute}}

1. In the IDE on the right, open our newly copied `/root/k8s-yaml-files/advertisements_1_2.yaml`{{open}}.

1. On lines 9 and 26, update the version numbers from `1.0` to `1.2`. 

1. On line 29, update the image from

```yaml
- image: ddtraining/advertisements:1.0.0
```
 
to

```yaml
- image: ddtraining/advertisements-fixed:1.0.0
```

1. Finally, on lines 10 and 80 go ahead and update the name of our deployment and service to `advertisementsv12`.

Great! Now we can deploy what is hopefully going to be a minor update that gives our end user the latency they deserve! Apply the `1.2` manifest using `kubectl apply -f k8s-yaml-files/advertisements_1_2.yaml`{{execute}}. Just like earlier, we can use our `kubectl get all`{{execute}} to ensure that our new `advertisementsv12` is fully up and running. Once it is, open the <a href=https://app.datadoghq.com/apm/service/advertisements>APM > Services > advertisements</a> page and wait for the `1.2` deployment to show up in the `Deployments` pane on the advertisements service page.


