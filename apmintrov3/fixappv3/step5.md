Let's analyze how the changes you made affected that services performance.

1. Navigate to <a href="https://app.datadoghq.com/apm/services?env=ruby-shop" target="_datadog">**APM** > **Services**</a>. 

2. Click on the `advertisements-service`.

3. Scroll down and click the `GET /ads` endpoint.

You can see by looking at the `Latency` graph for this service there has been a sharp decline in latency down to an acceptable range. The fix worked! <p> ![Fixed Latency](fixappv3/assets/fixed-ads-latency.png)

It would also be a good idea to confirm that the upstream services are now running properly after the fix.

1. Navigate back to the <a href="https://app.datadoghq.com/apm/services?env=ruby-shop" target="_datadog">**APM** > **Services**</a> page and enter the `store-frontend` service. 

1. Looking at the provided `Latency` graph, you will also see a reduction in overall latency for this service. To get better view, you can click and drag over the area of interest on the graph to zoom in. <p> ![Latency Fix](fixappv3/assets/fixed-latency-zoom.gif).

Another quick place to check the overall health of our application is by using the <a href="https://app.datadoghq.com/apm/map" target="_datadog">**APM** > **Service Map**</a>. At a glance, the markers on the store-frontend and advertisements-service nodes are now green with discounts remaining green, meaning the monitor for each service is in the `OK` status.

7. Click the store-frontend service node and select **View service overview**. <p> Notice that the **Total Requests** and **Total Errors** graphs have no new error data since you fixed the store-frontend.

Let's explore the store-frontend service more to see if the app has any other undesired behavior.