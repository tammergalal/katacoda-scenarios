<a href="https://docs.datadoghq.com/tracing/deployment_tracking/">Deployment Tracking</a> uses Datadog’s reserved `version` tag, a unified tag that lets Datadog automatically aggregate performance data based on the code version’s infrastructure assets, traces, trace metrics, profiles, and logs. This makes it easy for developers to compare the performance of code deployments against their existing live code to verify that new code is performing properly and that no new errors have surfaced in between versions.

In this scenario you are going to take an existing deployment and examine it on the Datadog Deployment Tracking. You will then create another deployment with a pseudo Canary strategy, monitor the change, and make any necessary fixes to get the new deployment stable and out to the masses!

Let’s move on to see this in action.

**Notes:** *The hands-on environments have a lifetime of one hour from the time you first visit. After one hour you will need to refresh the browser to restart them. Each hands-on exercise is a different environment.*