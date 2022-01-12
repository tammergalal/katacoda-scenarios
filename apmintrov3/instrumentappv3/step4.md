First, you'll restart the docker deployment to apply the changes for monitoring the `store-frontend` service. Then, you'll view the trace and log data being collected by Datadog from the app.

1. First, navigate back to the Terminal tab. Click `docker-compose down && docker-compose up -d`{{execute}} to redeploy Storedog with the updated yml changes.

![restarted-agent-frontend](instrumentapp2/assets/restarted-agent-frontend.png)

1. With our new deployment up, we can take a look at the Datadog platform and check to see if traces are coming in.

1. First, enter `creds`{{execute}} in the terminal. In a new window/tab, log in to the <a href="https://app.datadoghq.com/account/login" target="_datadog">Datadog account/organization</a> that was created for you by learn.datadoghq.com.

1. Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM > Traces** </a> in Datadog to view the list of traces that are being ingested. 

1. In the search field, type `env:ruby-shop` if it is not listed so that the traces list displays traces for the storedog app only.

1. In the **Facets** list, expand **Service** to view the services from the app that are injecting traces into Datadog. <p>![trace-frontendservices](instrumentapp2/assets/trace-frontendservices.png)

1. Click a trace for the `store-frontend` service to view the Flame Graph and Span List. The color of each span is based on the associated service, listed on the right of the Flame Graph. To zoom in and out of the Flame Graph, hover the cursor over the Flame Graph and scroll up and down. 

1. Below the Flame Graph, click each tab to see the Tags, related Hosts, and related Logs. Under **Logs(#)**, you can see the `trace_id:###` tag assigned by Datadog to the trace and the list of logs that are correlated to the trace via the `trace_id:###` tag. Correlating traces with related logs allows you to see all details related to each trace so that you can quickly troubleshoot any issues. To learn more, view the <a href="https://docs.datadoghq.com/tracing/connect_logs_and_traces/" target="_blank">Connect Logs and Traces</a> documentation. 
 
1. Click any of the logs. A new browser tab will open for the **Log Explorer** and the details for the log. Notice the tag selected in the search field above the lists of logs is the `trace_id:###` for the specific trace.

As you can see, the agent and store-frontend service were successfully instrumented for APM and log collection in Datadog. 

Now, let's instrument the Python-Flask services of the app.