With all the necessary tooling setup and our deployment up and running, let's take a look at our application with Datadog's APM (Application Performance Monitoring). 

Head over to the <a href="https://app.datadoghq.com/apm/services"> APM > Services</a> page and you should see a list of the services that comprise Storedog. Click the `discounts` service. This will bring up a page showing many different aspects of the `discounts` service.

The first thing that stands out is our `Latency Distribution`. The distribution and latency are very high, almost 600-700ms at the highest! Looking down just below the `Latency Distribution` graph you should see the `Deployments` section. Version 1.0 of our `discounts` service is running, to the far right you will see its very high P95 latency. Since we currently only have one version deployed, we cannot get any kind of deployment comparison data, so lets get our latency fixed and see if we can make an improvement over our `1.0` deployment. 

Thankfully the high latency of our `discounts` service was on the radar of our software engineers and they have a fix ready for us to deploy. So let's go ahead and send out a version `1.1` of our `discounts` service and get this latency fixed! We are going to do this with a very basic blue/green deployment in which only a small subset of requests are actually going to make it to our newly deployed `discounts` service. Once everything is stable we will make our

Our engineering team has sent down a new `discounts.py` file for us, with the proper minor version tag of `1.1`. Let's take this file and copy it over to our root where it will be picked up by our next deployment.

1. `cp /root/discounts_1_1.py /root/discounts.py`{{execute}}

1. Now that we have our new `discounts.py`, lets go into our second `discounts` manifest and make sure we update our version.

1. Click the `IDE` tab on the right above the terminal and open `/root/k8s-yaml-files/discounts2.yaml`{{open}}

1. On lines 9 and 26 we need to update the version from `1.0` to `1.1`. Let's also name our new service `discounts1_1` on lines 10 and 86.

1. With our new `discounts.py` file we can now deploy version `1.1` of the `discounts` service by running the command: `kubectl apply -f k8s-yaml-files/discounts2.yaml`{{execute}}.

1. Next, let's be sure our new deployment and service are running using `kubectl get all`{{execute}}

Great! Version 1.1 of our `discounts` service has been renamed and is applied in our manifest as the new file to use. With the service running, lets go back over to the <a href=https://app.datadoghq.com/apm/service/discounts>APM > Services > discounts</a> and we should be able to observe a `1.0` and `1.1` Deployment Version. 

**Note**: If you do not see a version `1.1` deployment, just wait a few moments. It may take a minute or so to have new traffic hit the `1.1` service

