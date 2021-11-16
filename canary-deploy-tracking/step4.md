1. First, copy the new manifest into the `k8s-yaml-files` directory. `cp /root/new-manifests/advertisements_1_1.yaml /root/k8s-yaml-files/advertisements.yaml`{{execute}}

1. Click the `IDE` tab on the right above the terminal and open `/root/k8s-yaml-files/advertisements.yaml`{{open}}

1. On lines 9 and 26 you'll see the engineering team didn't update the version number, so it's `1.0`. We need to update this to `1.1` so that Datadog will recognize this as a new versioned deployment and give us data specific to this deployment. `Version` is one of three Unified Service Tags reserved by Datadog, you can read more about these tags [here](https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging/?tab=kubernetes).

1. With our new kubernetes manifest ready, we can now deploy version `1.1` of the `advertisements` service by running the command: `kubectl apply -f k8s-yaml-files/advertisements.yaml`{{execute}}. You should see a new Deployment was created in the terminal output.

1. Next, let's be sure our new deployment is ready using `kubectl get deployment advertisements-canary`{{execute}}. It may take anywhere from 10 seconds to one minute for the new deployment to show as 'Ready'. In the end you will see your deployment with the name `advertisements-canary`.

Great! Version `1.1` of `advertisements` has been deployed. With the deployment running, open the [APM > Traces](https://app.datadoghq.com/apm/traces?env=ruby-shop) page and on the left-hand menu under `Service` choose `advertisements`. Below that click the `Version` drop down and click `1.1`. Once traces start flowing in, that means you are getting traffic to your newer deployment. Head back over to the [APM > Services > advertisements](https://app.datadoghq.com/apm/service/advertisements?env=ruby-shop) page and after a few minutes you should be able to observe a `1.0` and `1.1` Deployment Version.

**Note**: It may take a few minutes for the new version of the application to show up in the Deployment section of APM > Services.

![Deployment 1.0 and 1.1](./assets/deployments_old_new.png)

Looking at your Deployment panel, you'll see that while the latency is way down, the error rate is quickly rising to a very high percentage of attempted requests! This is not a good result for an attempted fix.

**Note**: If you do not see a version `1.1` deployment, it may take a minute or so to have new traffic hit the `1.1` service and show up in the platform.
