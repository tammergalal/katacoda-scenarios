Now that we've set up our main Ruby on Rails application, we can now instrument our downstream Python services.

Looking at the [documentation](https://ddtrace.readthedocs.io/en/stable/integrations.html#flask) for the Python tracer, we have a utility called `ddtrace-run`. 

Wrapping our Python executable in a `ddtrace-run` allows us to run an instance of our application fully instrumented with our trace library, so long as our Python libraries are supported by `ddtrace`.

For supported applications like Flask, `ddtrace-run` dramatically simplifies the process of instrumentation.

## Instrumenting the Advertisements Service

In our `docker-compose.yml`{{open}} there's a command to bring up our Flask server. If we look at **line 94**, we'll see:

```
ddtrace-run flask run --port=5002 --host=0.0.0.0
```

The `ddtrace` Python library includes an executable that allows us to automatically instrument our Python application. We simply call the `ddtrace-run` application, followed by our normal deployment, and magically, everything is instrumented.

With this, we're now ready to *configure* our application's instrumentation.

Automatic instrumentation is done via environment variables in our docker yml files starting on **line 82**:

1. Click `docker-compose.yml`{{open}}. 

2. Click **Copy to Editor** below or manually copy and paste the text where indicated to add the following to the list of environment variables for the service. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add ads env variables">
          - DATADOG_SERVICE=advertisements-service
          - DD_ENV=ruby-shop
          - DD_VERSION=2.0
          - DD_LOGS_INJECTION=true
          - DD_TRACE_SAMPLE_RATE=1
          - DD_PROFILING_ENABLED=true
          - DD_AGENT_HOST=agent</pre>

3. Click **Copy to Editor** below or manually copy and paste the text where indicated to add the `ddtrace-run` wrapper to the command that brings up the Flask server. Note that the port for this service is 5002. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="command: flask run --port=5002 --host=0.0.0.0">
command: ddtrace-run flask run --port=5002 --host=0.0.0.0</pre> 

4. Click **Copy to Editor** below or manually copy and paste the text where indicated to add labels to enable logs. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add ads log labels">
       labels:
         com.datadoghq.ad.logs: '[{"source": "python", "service": "advertisements-service"}]'</pre>

5. Click `rm /ecommworkshop/store-frontend-broken-instrumented/store-frontend/tmp/pids/*; docker-compose -f docker-compose.yml up -d`{{execute}} to restart the docker deployment to apply these changes. <p> The **advertisements** section of the docker-compose file should now look like the screenshot below. <p> ![instrumented-adverstisements](instrumentapp2/assets/instrumented-advertisements.png)

6. Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM > Traces** </a> in Datadog to view the list of traces that are coming in. <p> You should now see traces for the `advertisements` service in the list. This may take a couple of minutes.

7. Click a trace for the `advertisements` service to view the Flame Graph, Span List, Tags, related Hosts, and related Logs.

With these steps, the Python-based services are also instrumented for APM with Datadog. The final list for **Service** under **Facets** is shown below.

![trace-services](instrumentapp2/assets/trace-allservices.png)

The `postgres` service appears in the list because it is installed and automatically instrumented to support the discounts and advertisements services using **Line 12** in `discounts-service/requirements.txt`{{open}} and `ads-service/requirements.txt`{{open}}, respectively. You can view <a href="https://ddtrace.readthedocs.io/en/stable/integrations.html#module-ddtrace.contrib.psycopg" target="_blank"> Datadog's Python tracing client</a> for more details. 


### Assessment
Click `grademe`{{execute}} to receive a grade for this activity.
