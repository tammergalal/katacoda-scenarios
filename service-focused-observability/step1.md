
# Storedog

Our legacy monolith shop uses Ruby on Rails and Spree. We've started to build out a first set of microservices, and these have been added to an initial set of containers.

We use `docker-compose` to get the application up and running. There's a prebuilt Rails Docker container image, along with the new Python / Flask microservice which handle our Coupon codes and Ads which display in the store.

In this workshop, we're going to start and instrument Storedog to see what things are broken, and next, find a few bottlenecks.

We'll focus on thinking through what observability might make sense in a real application, and see how setting up observability into a specific service works in practice.

Our application should be cloned from Github in this scenario, and if we change into the directory, we should be able to start the code with the following:


1. `cd /ecommerce-observability/docker-compose-files {{execute}}`{{execute}}

1 .`POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres  docker-compose -f docker-compose-broken-instrumented.yml up`{{execute}}


Once our images are pulled and the application is running we can view our ecommerce application, Storedog. You can either:

1. Click the `storedog` tab to the right, next to `Terminal`.

1. Navigate to https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/

Try browsing around and take a look at what the shop has to offer. Notice the homepage takes a very long time to load....

![storedog](https://github.com/burningion/katacoda-tracing-datadog/raw/master/assets/ecommerce/storedog.png)

## Spinning up Traffic for Our Site

In our `/ecommerce-observability` folder, we've got a copy of [GoReplay](https://goreplay.org).

We've also got a capture of "production" traffic using GoReplay. Let's spin up an infinite loop of that traffic. Click the "+" sign next to the `storedog` tab, and open a new terminal to spin it up:


1. `cd /ecommerce-observability`{{execute}}

1. `./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}


With simulated traffic being sent to Storedog, we can then take a look at the first few microservices that the team has rolled out and investigate some issues we

Before being instrumented with Datadog, there'd been reports that the new `advertisements-service` broke the website. With the new deployment on staging, the `frontend` team has blamed the `ads-service` team, and the `advertisements-service` team has blamed the ops team.

With Datadog and APM instrumented in our code, let's see what's really been breaking our application.
