In the terminal on the right, the Storedog app is being deployed using Docker. Live traffic to the app is also being simulated. This may take up to 2 minutes. Once the app is running, you will see the message `Provisioning Complete` in the terminal along with your Datadog login credentials.

With the environment provisioned, first click the IDE Tab to the right of the Terminal tab. Next, open the `docker-compose.yml`{{open}} by clicking to view the file in the editor on the right. 

This docker-compose file instruments the Datadog agent and app services for monitoring with Datadog. Browse the file to view the details of the deployment. As you can see, there are no specifications for apm or log collection. 

After taking a look at the `docker-compose.yml` file, click the **Storedog** tab to the right of the IDE tab to view the Storedog app. Clicking around inside the app, you can see it includes a home page, product pages, advertisements, discounts, and a shopping cart. 

In this activity, you will go through instrumenting the store-frontend (home page), discounts, and advertisements services of Storedog for use with Datadog APM. But first, let's enable trace and log collection for the Datadog Agent.