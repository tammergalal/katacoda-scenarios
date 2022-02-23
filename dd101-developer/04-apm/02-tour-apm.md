With the Agent collecting traces from all of the Storedog services, you can now look at those traces in the Datadog app.

1. Navigate to <a href="https://app.datadoghq.com/apm/services?env=dd101-dev" target="_datadog">**APM > Services**</a>. You'll see the a list of all the services that are enabled. You'll also see `postgres`, which doesn't communicate with the Datadog Agent directly.

    `postgres` shows up because `discounts-service` and `advertisements-service` traces capture it. You configured the PostgreSQL integration in the previous lab, but it doesn't send traces to the Datadog Agent. Applications that *connect* to the database do.

    Similarly, you'll see some new services that don't correspond to Docker containers: `active_record`, `store-frontend-cache`, and `store-frontend-sqlite`. The `store-frontend` service is instrumented to tag these subsidiary areas of the application as services. You can see how by opening `store-frontend/config/initializers/datadog.rb`{{open}} in the IDE.

2. You'll notice the `discounts-service` has an alert in the **Monitors** column on the page: 

    ![Discounts service monitor alert in services view](./assets/discounts_monitor_alert.png)

    A site reliability engineer (SRE) at Storedog created a monitor to check the latency of this service, and it seems to be a bit higher than expected.

    You'll come back to this in a few minutes, but for now, continue exploring APM.

3. Select the <a href="https://app.datadoghq.com/apm/map?env=dd101-dev" target="_datadog">**APM > Service Map**</a> tab and you'll see a map of how each service communicates with one another:

    ![APM Service Map in flow layout](./assets/apm_service_map_flow.png)

    > **Note:** This map can take a long time to appear after Datadog receives new traces. Come back later if you don't see it right now.

4. Notice the **Map layout** buttons in the upper-right corner. Select **Cluster** and **Flow** to see the differences. The **Flow** layout is more suited for larger service maps.

    Also notice that the service monitor status is indicated in red for the `discount-service` in these maps.

5. Click on **discounts-service** and then **View service overview**. If you don't have a service map yet, you can click on **discounts-service** in the service list instead.

    On the resulting page, scroll down to **Endpoints**. Here you will see all of the service's application endpoints that APM traced. This service has one endpoint: `GET /discount`.

    ![Discounts service endpoints](./assets/discounts_apm_services_endpoints.png)

6. Navigate to <a href="https://app.datadoghq.com/apm/traces?query=env%3Add101-dev" target="_datadog"> **APM > Traces**</a>. Here, you'll see a live stream of the traces APM has captured over the past 15 minutes. Try and locate one for the `discounts-service` service.

    > **Note:** You may have to filter the traces by service name. Use the facets menu on the left to filter by the `discounts-service` service.

    Scroll down and click on an older `discounts-service` trace. This flame graph displays the time spent in each service for this trace. 

    ![Discounts APM trace flame graph](./assets/apm_traces_flamegraph.png)

7. Click the **Logs** tab at the bottom of the trace details panel. You can resize the logs display area by dragging the horizontal divider at the top.

    These are the related log lines captured during the trace's timeframe. You may notice that it's taking a long time to complete this request.

    ![Discounts APM trace detail log tab](./assets/apm_traces_logs.png)

    Mouse over each line and look at the flame graph. You'll see a vertical line marking the exact point in the trace that the log line was emitted. This is enabled by the `DD_LOGS_INJECTION` configuration.

8. Click on a log line from `discounts.py`. This takes you to a detailed view on the line in the Logs Explorer.

    ![Discounts trace to log line](./assets/discounts_logs.png)

9. Close the log detail and notice that the search field is filtering logs by the specific ID of the trace. 

    Clear the search field and change the timeframe to `Past 15 Minutes` to view all logs.

    Click on the `discounts-service` facet on the left to see only those from the `discounts-service`.

10. Click on a `discounts-service` log line for `discounts.py`.

    Click on the **Trace** tab.

    ![Traces in logs](./assets/discounts_logs_trace.png)

    Here is the trace for this log line right in the log details view!

11. Click on **View Trace Details** to view the trace in the APM trace details page. 

You can now travel back and forth between between APM traces and logs for the discounts service.  

Click the **Continue** button to move onto the next step, where you'll address the monitor from earlier.
