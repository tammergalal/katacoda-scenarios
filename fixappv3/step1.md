In the terminal on the right, the Storedog app is being instrumented with trace and log collection, and all the settings from the previous activity. Live traffic to the app is also being simulated. This may take up to 2 minutes. Once the app is running, you will see the message `Provisioning Complete` in the terminal along with your Datadog login credentials.

**Note:** If at any time you need to see your training credentials again, type `creds`{{copy}} in the terminal.

1. In a new window/tab, log in to the <a href="https://app.datadoghq.com/account/login" target="_datadog">Datadog account/organization</a> that was created for you by learn.datadoghq.com.

2. Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM** > **Traces**</a> in Datadog to view the list of traces that are being ingested for the storedog app. 

    If you are working in a new Datadog organization, the link will be redirected to the **APM** > **Introduction** page. You may need to wait about two minutes as Datadog's Autodiscovery feature picks up the traces that are coming in. In the main menu, when the option appears, click the **APM > Traces** to see the list of traces.

3. In the search field, enter `env:intro-apm` if it is not listed to make sure that you are only viewing traces for the Storedog app. 

4. Under **Facets**, expand **Services** to confirm that all the services shown below are reporting traces. 

    ![trace-services](./assets/trace-services.png)

5. Navigate to <a href="https://app.datadoghq.com/apm/map?env=intro-apm" target="_datadog">**APM** > **Service Map**</a> to visualize the services and their dependencies.

    1. In the `Scope to` dropdown, make sure that `env:intro-apm` is selected. 
    
    2. Hover over each service node to view the direction flow of information from service to service, and see what is dependent on what. 
    
    3. Click each node, then click **Inspect** to view the services more clearly. 
    
    4. Notice that users primarily interact with the `store-frontend` service, which is on the top when you **Inspect** any service node linked to it.

With Datadog collecting trace and log data from the Storedog app, you can now create monitors for some of its services.