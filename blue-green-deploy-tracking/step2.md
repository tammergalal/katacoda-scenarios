With all the necessary tooling setup and our deployment up and running, let's take a look at our application with Datadog's APM (Application Performance Monitoring). 

Head over to the <a href="https://app.datadoghq.com/apm/services"> APM > Services</a> page and you should see a list of the services that comprise Storedog. Change the timeline to `Past 15 Minutes` and now click `advertisements`. This will bring up a page showing many different aspects of our `advertisements` service including `Total Requests`, `Total Errors`, `Latency` and more. Let's take a look at our Latency graph...

Wow, looking at the latency for this service shows a staggering 1-3 second response time. For our customers that is an unacceptable lag. Looking down just below the `Latency Distribution` graph you should see the `Deployments` section. Version 1.0 of our `advertisements` service is running, to the far right you will see its very high P95 latency. Since we currently only have one version deployed, we cannot get any kind of deployment comparison data, so lets get our latency fixed and see if we can make an improvement over our `1.0` deployment. 

1. Lets copy over our new `ads.py` file to our root project directory. `cp /root/ads_1_1.py /root/ads.py`{{execute}}.

1. Now that we have our new `ads.py`, lets go into our second `advertisements_1_1.yaml` manifest and make sure we have an updated version of `1.1`

1. Click the `IDE` tab on the right above the terminal and open `/root/k8s-yaml-files/advertisements_1_1.yaml`{{open}}

1. On lines 9 and 26 you should see a version of `1.1`. `Version` is one of three Unified Service Tags reserved by Datadog, you can read more about these tags <a href="https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging/?tab=kubernetes">here</a>

1. With our new `discounts.py` file we can now deploy version `1.1` of the `discounts` service by running the command: `kubectl apply -f k8s-yaml-files/advertisements_1_1.yaml`{{execute}}.

1. Next, let's be sure our new deployment and service are running using `kubectl get all`{{execute}}. It may take anywhere from thirty seconds to one minute for the new deployment/service to show as 'running'

Great! Version 1.1 of our `discounts` service has been deployed. With the service running, lets go back over to the <a href=https://app.datadoghq.com/apm/service/discounts>APM > Services > discounts</a> and we should be able to observe a `1.0` and `1.1` Deployment Version.

This is a Canary deployment in which only a subset of our users will ingest the updated `1.1` service, while the rest of the traffic would continue to ingest the original `1.0` service. Using a Canary deployment gives us some time to evaluate the health of this new deployment, and if things go wrong we can quickly take revert the deployment, and if things go well we can shift all of our traffic to our Canary.

**Note**: If you do not see a version `1.1` deployment, it may take a minute or so to have new traffic hit the `1.1` service and show up in the platform.

But wait.....something seems off here......
