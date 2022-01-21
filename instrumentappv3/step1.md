In this course you're going to work with Storedog, a fully functional e-commerce application running on a few Docker containers managed by Docker Compose. Live traffic to the app is also being simulated, so you will have data to work with once the application is instrumented. Once the environment has been fully provisioned, you will see the message `Provisioning Complete` in the terminal along with your Datadog login credentials.

**Note:** If at any time you need to see your training credentials again, type `creds`{{copy}} in the terminal.

With the environment provisioned, first click the IDE Tab to the right of the Terminal tab. Next, open the `docker-compose.yml`{{open}} by clicking to view the file in the editor on the right. 

This docker-compose file instruments the Datadog agent and app services for monitoring with Datadog. Browse the file to view the details of the deployment. As you can see, there are no specifications for APM or log collection, or much at all for that matter! 

After taking a look at the `docker-compose.yml` file, click the **Storedog** tab to the right of the IDE tab to view the Storedog app. The app may error on first load, as the database needs some time to spin up. A refresh of the tab, by clicking the small circle on the right of the tab should resolve this.

Clicking around inside the app, you can see it includes a home page, product pages, advertisements, discounts, and a shopping cart. 

In this activity, you will first complete the agent instrumentation for trace and log collection. Next, you will go through instrumenting the `store-frontend`, `discounts-service`, and `advertisements-service` of Storedog for use with Datadog APM. You will also create Monitors to keep track of these services without having to stare at their trace data. 

Continue to the next session to get started.