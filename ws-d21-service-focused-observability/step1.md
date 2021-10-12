Our legacy monolith shop uses Ruby on Rails and Spree. We've started to build out a first set of microservices, and these have been added to an initial set of containers.

While the lab was being provisioned, we started Storedog in the background to get it up and running. There's a prebuilt Rails Docker container image, along with the new Python / Flask microservice which will handle our Coupon codes and Ads which display in the store. 

Inside of the docker-compose file for our Storedog application, we also have attached a container which will generate and send production traffic to our application so we are not forced to click around the app to generate data.

In this workshop we are going to analyze Storedog with Datadog to identify and fix errors and performance issues, and once these fixes are made put measures in place to be alerted if this were to happen again.

We'll focus on thinking through what observability might make sense in a real application, and see how setting up observability works in practice.

## Log into the Datadog Trial Account

In the terminal on the right, you'll see credentials for a newly provisioned Datadog trial account. Open a new private/incognito window and use the provided credentials to log into [Datadog](https://app.datadoghq.com/account/login).

**Note:** You can access these login credentials whenever you need by typing `creds` in the terminal.

## Generating Traffic for Our Site

We've got a capture of "production" traffic using GoReplay. In our `/ecommworkshop/deploy/docker-compose` folder, you will see a container we created called `docker-compose-traffic-replay`. This container will send "production" traffic to our application on a consistent basis to help generate data for us on the platform.

Click the "+" sign next to the `storedog` tab. Next, click `Open New Terminal`.

`cd ../ecommworkshop/deploy/docker-compose`{{execute}}

`docker-compose -f docker-compose-traffic-replay.yml up`{{execute}}

Once the traffic replay begins, we can take a look at the issues we've seen since the team rolled out their first few microservices.

There have been reports that the new `advertisements-service` broke the website after the new deployment in the development environment. The `frontend` team has blamed the `ads-service` team, and the `advertisements-service` team has blamed the ops team.

We'll use the Datadog APM trace library to instrumented our code. Let's see what's *really* been breaking our application.
