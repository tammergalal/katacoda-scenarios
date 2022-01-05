The `store-frontend` service has a Rails framework. The first step for instrumentation is to install the required Ruby tracing and log libraries. Next, an initializer file is added to enable Rails instrumentation, followed by a configuration file to ship logs to Datadog in JSON format so that Datadog can filter the logs based on special parameters. Finally, the docker-compose file is updated for trace and log collection and App Analytics for the frontend service. 

The store-frontend service has been instrumented for you, but you will update the docker-compose.yml. Let's first go through the instrumentation.

## Installing the Ruby APM Language Library

The `store-frontend` service has a Rails framework. The first step for instrumentation is to install the required Ruby tracing and log libraries. Next, an initializer file is added to enable Rails instrumentation, followed by a configuration file to ship logs to Datadog in JSON format so that Datadog can filter the logs based on special parameters. Finally, the docker-compose file is updated for trace and log collection and App Analytics for the frontend service.

The store-frontend service has been instrumented for you. Let's review the instrumentation.

Open the IDE tab. Take a look at `Gemfile`{{open}} in the Katacoda file explorer.

1. **Line 46** installs the `ddtrace` Gem, which is [Datadog’s tracing client for Ruby](https://docs.datadoghq.com/tracing/setup/ruby/). The `ddtrace` library traces requests as they flow across web servers, databases, and microservices so that developers have high visibility into bottlenecks and troublesome requests.

2. **Line 49** installs the `rails_semantic_logger` Gem, which is a feature rich replacement for the Ruby and Rails loggers. To learn more, view the [rails_semantic_logger](https://logger.rocketjob.io/) documentation.

To enable the Rails instrumentation, an initializer file was created in the config/initializers folder. Open the file `datadog.rb`{{open}}.

There, we control a few settings:

```ruby
Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails, {'service_name': 'store-frontend', 'cache_service': 'store-frontend-cache', 'database_service': 'store-frontend-sqlite'}
  # Make sure requests are also instrumented
  c.use :http, {'service_name': 'store-frontend'}
end
```

With this, our Ruby application is instrumented. 

Before instrumenting the discounts and advertisements services, let's log in to Datadog to view the traces and logs being collected for the store-frontend service. 