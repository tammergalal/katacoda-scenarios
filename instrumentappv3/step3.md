The `store-frontend` service has a Rails framework. The first step for instrumentation is to install the required Ruby tracing and log libraries. Next, an initializer file is added to enable Rails instrumentation, followed by a configuration file to ship logs to Datadog in JSON format so that Datadog can filter the logs based on special parameters. Finally, the docker-compose file is updated for trace and log collection and Tracing Without Limits for the frontend service.

While the store-frontend service has been instrumented for you, you will still need to update the docker-compose.yml. First, it's time to go through the existing instrumentation.

## Installing the Ruby APM Language Library

Open the IDE tab. Take a look at `Gemfile`{{open}} in the Katacoda file explorer.

1. **Line 46** installs the `ddtrace` Gem, which is [Datadog’s tracing client for Ruby](https://docs.datadoghq.com/tracing/setup/ruby/). The `ddtrace` library traces requests as they flow across web servers, databases, and microservices so that developers have high visibility into bottlenecks and troublesome requests.

1. **Line 49** installs the `rails_semantic_logger` Gem, which is a feature rich replacement for the Ruby and Rails loggers. To learn more, view the [rails_semantic_logger](https://logger.rocketjob.io/) documentation.

To enable the Rails instrumentation, an initializer file was created in the `config/initializers` folder. Open the file `datadog.rb`{{open}}.

There, you control a few settings:

```ruby
Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails, {'service_name': 'store-frontend', 'cache_service': 'store-frontend-cache', 'database_service': 'store-frontend-sqlite'}
  # Make sure requests are also instrumented
  c.use :http, {'service_name': 'store-frontend'}
end
```

Next, instrument your `store-frontend` in the `yml` file.

1. Click `docker-compose.yml`{{open}}.

1. Under **services**, on **line 40**, view the details for **frontend**. Now, add the code for enabling trace and log collection.

1. To instrument the frontend service, only a few environment variables need to be added to the yml config. Click **Copy to Editor** below or manually copy and paste the text where indicated to add the following to the list of environment variables for the service.

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add frontend env variables">
         - DD_AGENT_HOST=agent 
         - DD_SERVICE=store-frontend
         - DD_ENV=intro-apm
         - DD_VERSION=1.0
         - DD_LOGS_INJECTION=true
         - DD_TRACE_SAMPLE_RATE=1
         - DD_CLIENT_TOKEN
         - DD_APPLICATION_ID</pre> 

    By default, the Datadog Ruby APM trace library will send traces to `localhost` over port 8126. Because we're running within Docker, you need to set an environment variable, `DD_AGENT_HOST`, for our Ruby trace library to know to ship to the `agent` container instead. You'll find this on **line 59**.
    
    `DD_LOGS_INJECTION=true` enables automatic injection of trace IDs into the logs from the supported logging libraries to correlate traces and logs. 

    `DD_TRACE_SAMPLE_RATE=1` enables [Tracing without Limits™](https://docs.datadoghq.com/tracing/trace_retention_and_ingestion/) for Trace Search and Analytics from within Datadog. You're also able to continue traces downstream, utilizing Distributed Traces.

1. Click **Copy to Editor** below or manually copy and paste the text where indicated to add labels so your logs are sent with the label of the service, and with the proper language pipeline processor. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add frontend log labels">
       labels:
         com.datadoghq.ad.logs: '[{"source": "ruby", "service": "store-frontend"}]'</pre> 

With these steps, the Rails `store-frontend` service is instrumented for APM and Log management with Datadog. The **frontend** section of the docker-compose file should now look like the screenshot below.

  ![instrumented-frontend](instrumentapp2/assets/instrumented-frontend.png)

Before instrumenting the discounts and advertisements services, log in to Datadog to view the traces and logs being collected for the store-frontend service. 