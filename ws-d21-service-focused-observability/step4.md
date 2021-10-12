Now that we've set up our main Ruby on Rails application, we can now instrument our downstream Python services.

Looking at the [documentation](https://ddtrace.readthedocs.io/en/stable/integrations.html#flask) for the Python tracer, we have a utility called `ddtrace-run`. 

Wrapping our Python executable in a `ddtrace-run` allows us to run an instance of our application fully instrumented with our trace library, so long as our Python libraries are supported by `ddtrace`.

For supported applications like Flask, `ddtrace-run` dramatically simplifies the process of instrumentation.

## Instrumenting the Advertisements Service

In our `docker-compose.yml`{{open}} there's a command to bring up our Flask server. If we look at line 91, we'll see:

```
ddtrace-run flask run --port=5002 --host=0.0.0.0
```

The `ddtrace` Python library includes an executable that allows us to automatically instrument our Python application. We simply call the `ddtrace-run` application, followed by our normal deployment, and magically, everything is instrumented.

With this, we're now ready to *configure* our application's instrumentation.

Automatic instrumentation is done via environment variables in our `docker-compose.yml`{{open}} starting on line 82:

```
      - DD_SERVICE=advertisements-service
      - DD_ENV=sfo101
      - DD_LOGS_INJECTION=true
      - DD_TRACE_SAMPLE_RATE=1
      - DD_PROFILING_ENABLED=true
      - DD_AGENT_HOST=agent 
      - DD_VERSION=1.0
```

With this, we've connected and instrumented all of our services to APM.

The last thing we need to add is a *label* to our container, so our logs are sent with the label of the service, and with the proper language pipeline processor on line 106:


```
    labels:
      com.datadoghq.ad.logs: '[{"source": "python", "service": "ads-service"}]'
```

We can repeat the process, and fill out the settings for the `discounts-service` starting on line 18:

```
  discounts:
    environment:
      - FLASK_APP=discounts.py
      - FLASK_DEBUG=1
      - POSTGRES_PASSWORD
      - POSTGRES_USER
      - POSTGRES_HOST=db
      - DD_SERVICE=discounts-service
      - DD_ENV=sfo101
      - DD_LOGS_INJECTION=true
      - DD_TRACE_SAMPLE_RATE=1
      - DD_PROFILING_ENABLED=true
      - DD_AGENT_HOST=datadog 
    image: 'ddtraining/discounts:2.0.0'
    command:
      [
        sh,
        -c,
        'ddtrace-run flask run --port=5001 --host=0.0.0.0',
      ]
    ports:
      - '5001:5001'
    depends_on:
      - datadog
      - db
    labels:
      com.datadoghq.tags.env: 'sfo101'
      com.datadoghq.tags.service: 'discounts-service'
      com.datadoghq.tags.version: '2.0'
      my.custom.label.team: 'discounts'
      com.datadoghq.ad.logs: '[{"source": "python", "service": "discounts-service"}]'
```

To verify for yourself, take a look at the `discounts.py`{{open}} file. You'll see there's no reference to Datadog at all.

Now that we've fully instrumented our application, let's hop back in to Datadog to take a closer look at *why* and *where* our application may be failing.