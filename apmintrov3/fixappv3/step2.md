In Datadog, you can create a variety of <a href="https://docs.datadoghq.com/monitors/" target="_datadog">**Monitors**</a> to track the health of your applications and to alert you if action is needed. 

Let's create monitors to track the latency of specific store-frontend, discounts, and advertisements service resources. You will use these monitors later in the activity.

#### Store-frontend Service

1. In the <a href="https://app.datadoghq.com/apm/services?env=ruby-shop" target="_datadog">**Service List**</a>, click on **store-frontend** to see a more detailed overview of the service. <p> ![Store Frontend Flow](fixappv3/assets/store-frontend-list.png)

2. Scroll to the **Endpoints** list and click **Spree::HomeController#index**.

3. Click the **No Monitors or Synthetics Tests** banner near the top and click **New Resource Monitor**. You will be redirected to a new APM monitor page.

4. Based on the Service and Endpoint from which we began creating a Resource Monitor, the **Select monitor scope** section is already filled out with the relevant information.

5. Expand **Set alert conditions**, select **Threshold Alert**. <p>Set the alert as follows: **Alert when `Avg latency` is above the threshold over the last `1 minute`**. To change it to `1 minute`, click the `5 minute` dropdown and set it to `custom`.

6. Set the **Alert Threshold** to `1`. Leave the setting of **Never** auto resolving from an alerted state.

7. Under **Notify your team**, delete `@yourloginemail` from the dropdown. You will notice that `@yourloginemail` is automatically deleted from the message in step 4. You can easily add or remove team members from the notifications and messages this way. In this case, you do not want to send any notifications.

8. Expand **Say what's happening**, leave the message as is. 

9. Click **Create** on the bottom right. <p> You will be redirected to the new monitor page. Browse the details. <p> Notice that **Tags** for the resource, service, and environment were automatically assigned to the monitor. These tags will correlate the monitor to the respective Service Page and Resource Page.

#### Discounts Service

Next, let's setup a monitor for the Discounts service. 

1. Head back to the <a href="https://app.datadoghq.com/apm/services?env=ruby-shop" target="_datadog">**Service List**</a>, and hover over the `discounts-service`. To the right, click `View Suggested` in the monitor column. <p> ![Discounts Suggest Monitors](fixappv3/assets/discounts-monitors.png)

4. Under **Select monitor scope**, select `get_/discount` as the **Resource**.

5. Repeat steps 5 - 8 from the store-frontend monitor above.

#### Advertisements Service

1. Repeat the steps you completed for the discounts service monitor. <p>In step 3, select `advertisements-service` for the **Service** and `get_/ads` for the **Resource**.

When you view the monitors in <a href="https://app.datadoghq.com/monitors/manage" target="_datadog">**Monitor** > **Manage Monitors**</a>, you'll notice that their status is `No Data`. Because the monitors are new, it may take a few minutes for the status of the monitors to update. After waiting, you may begin to see some monitor data populating the Monitor list.

![Monitor Data on Service List](fixappv3/assets/monitor-data-list.png)

