With all the necessary tooling set up and the application up and running, you can take a look at the application with Datadog's distributed tracing and APM.

Navigate to <a href="https://app.datadoghq.com/apm/traces"> APM > Traces</a>, where you may need to wait a minute or so for data to show up in Datadog. Now, navigate to the <a href="https://app.datadoghq.com/apm/services"> APM > Services</a> page and you should see a list of the services that comprise Storedog. In the top right of the page change the timeline to `Past 15 Minutes`, and now click the `advertisements` service. This will bring up a page showing many different aspects of your `advertisements` service including `Total Requests`, `Total Errors`, `Latency` and more. 

Looking at the latency for this service shows a staggering 2.5 second response time! For our customers that is an unacceptable lag. Looking down just below the `Latency Distribution` graph you should see the `Deployments` section. 

![Deployment 1.0](./assets/deployment_tab.png)

Version `1.0` of the `advertisements` service is running and to the far right you will see its very high P95 latency. `P95` refers to the 95th percentile of latency. This means that 95% of your users are experiencing a latency equal to the P95 latency or lower. 

Since we currently only have one version deployed, there is no way to get any kind of deployment comparison data. The latency issue will need to be fixed to see if an improvement cna be made over the `1.0` deployment. Thankfully, the engineers have gone ahead and built a new advertisements image for us and even provided us with a manifest which should *hopefully* fix our latency issues. 

Let's make sure we have updated the version tag to `1.1` and given the deployment and service a name to help delineate it from the previous version.

1. First, copy the new manifest into the `k8s-yaml-files` directory. `cp /root/new-manifests/advertisements_1_1.yaml /root/k8s-yaml-files/advertisements.yaml`{{execute}}

1. Click the `IDE` tab on the right above the terminal and open `/root/k8s-yaml-files/advertisements.yaml`{{open}}

1. On lines 10 and 29 you'll see the engineering team didn't update the version number, so it's `1.0`. We need to update this to `1.1` so that Datadog will recognize this as a new versioned deployment and give us data specific to this deployment. `Version` is one of three Unified Service Tags reserved by Datadog, you can read more about these tags <a href="https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging/?tab=kubernetes">here</a>.

1. On lines 12 and 84 you should see the name of our deployment and service respectfully. Let's update both of these names to be `advertisementsv11`.

1. With our new kubernetes manifest ready, we can now deploy version `1.1` of the `advertisements` service by running the command: `kubectl apply -f k8s-yaml-files/advertisements`{{execute}}. You should see a new Deployment and Service were created in the terminal output.

1. Next, let's be sure our new deployment and service are running using `kubectl get all`{{execute}}. It may take anywhere from thirty seconds to one minute for the new deployment/service to show as 'running'. In the end you will see two separate `advertisements` pods, deployments, and services.

Great! Version 1.1 of the `advertisements` service has been deployed. With the service running, open the <a href=https://app.datadoghq.com/apm/traces>APM > Traces</a> page and on the left-hand menu under `Service` choose `advertisements`. Below that click the `Version` drop down and click `1.1`. Once traces start flowing in, that means you are getting traffic to your newer deployment. Head back over to the <a href=https://app.datadoghq.com/apm/service/advertisements>APM > Services > advertisements</a> page and after a few minutes you should be able to observe a `1.0` and `1.1` Deployment Version.

**Note**: It may take a few minutes for the new version of the application to show up in the Deployment section of APM > Services.

![Deployment 1.0 and 1.1](./assets/deployments_old_new.png)

Looking at you Deployment panel, you'll see that while the latency is way down, the error rate is quickly rising to a very high percentage of attempted requests! This is not a good result for an attempted fix.

**Note**: If you do not see a version `1.1` deployment, it may take a minute or so to have new traffic hit the `1.1` service and show up in the platform.
