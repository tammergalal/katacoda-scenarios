Now that we've set up our main Ruby on Rails application and viewed traces coming into the platform, we can now instrument our downstream Python services.

Looking at the [documentation](https://ddtrace.readthedocs.io/en/stable/integrations.html#flask) for the Python tracer, we have a utility called `ddtrace-run`. 

Wrapping our Python executable in a `ddtrace-run` allows us to run an instance of our application fully instrumented with our trace library, so long as our Python libraries are supported by `ddtrace`.

For supported applications like Flask, `ddtrace-run` dramatically simplifies the process of instrumentation.
Let's start by instrumenting the Discounts service.

#### Discounts Service

1. Navigate to your IDE tab and click `requirements.txt`{{open}} to view the list of required libraries that are installed for the service. The `ddtrace` library (**Line 4**) has already been included.

1. Click `docker-compose.yml`{{open}}. Under **services**, view the details for **discounts**. <p> Let's add the code for enabling trace and log collection for the `discounts` service.

1. Click **Copy to Editor** below or manually copy and paste the text where indicated to add the following to the list of environment variables for the service.

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add discounts env variables">
         - DD_ENV=ruby-shop
         - DD_VERSION=1.0
         - DD_LOGS_INJECTION=true
         - DD_TRACE_SAMPLE_RATE=1
         - DD_PROFILING_ENABLED=true
         - DD_AGENT_HOST=agent</pre>

1. Click **Copy to Editor** below or manually copy and paste the text where indicated to add the `ddtrace-run` wrapper to the command that brings up the Flask server. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="command: flask run --port=5001 --host=0.0.0.0">
command: ddtrace-run flask run --port=5001 --host=0.0.0.0</pre>  

    `ddtrace-run` automates instrumentation of the service for Datadog APM. You can view more details for automatic and manual instrumentation using `ddtrace` in the <a href="https://ddtrace.readthedocs.io/en/stable/integrations.html#flask" target="_blank">Datadog Python Trace and Profile Client</a> documentation.


1. Click **Copy to Editor** below or manually copy and paste the text where indicated to add labels to enable logs. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add discounts log labels">
       labels:
         com.datadoghq.ad.logs: '[{"source": "python", "service": "discounts-service"}]'</pre>

1. Going back to your terminal tab, click `docker-compose down && docker-compose up -d`{{execute}} to restart the docker deployment to apply these changes. <p> The **discounts** section of the docker-compose file should now look like the screenshot below. <p> ![instrumented-discounts](instrumentapp2/assets/instrumented-discounts.png)

1. Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM > Traces** </a> in Datadog and within a few minutes you should see traces from the `discount-service` coming into the platform.

1. Click a trace for the `discounts` service to view the Flame Graph, Span List, Tags, related Hosts, and related Logs.

The next and final service that needs instrumentation is the Python based advertisements service.