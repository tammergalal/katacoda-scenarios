With all the necessary tooling and deployments running, let's take a look at our application with Datadog's APM (Application Performance Monitoring). 

Head over to the <a href="https://app.datadoghq.com/apm/services"> APM > Services</a> page and you should see a list of the services that comprise Storedog. Click the `discounts` service. This will bring up a page showing many different aspects of the `discounts` service.

The first thing that stands out is our `Latency Distribution`. The distribution and latency are very high, almost 600-700ms at the highest! Looking down just below the `Latency Distribution` graph you should see the `Deployments` section. Version 1.0 of our `discounts` service is running, to the far right you will see its very high P95 latency. Since we currently only have one version deployed, we cannot get any kind of comparison, so lets get our latency fixed and see if we can make an improvement over our `1.0` deployment. 

Thankfully the high latency of our `discounts` service was on the radar of our software engineers and they have a fix ready for us to deploy. So let's go ahead and send out a version `2.0` of our `discounts` service and get this latency fixed! We are going to do this with a very basic canary deployment in which only a small subset of requests are actually going to make it to our newly deployed `discounts` service. This will decrease the blast radius should anything be wrong with our code, but the engineers in this little shop are the best so there should be ZERO issues!

1. We can deploy our version `2.0` of the `discounts` service by running the command: `kubectl apply -f k8s-yaml-files/discounts2.yaml`{{execute}}.

1. Next, let's be sure our new deployment and service are running using `kubectl get all`{{execute}}
