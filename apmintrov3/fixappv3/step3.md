Now let's use APM to see how the store-frontend service is performing. 

1. Navigate to <a href="https://app.datadoghq.com/apm/services" target="_datadog">**APM** > **Services**</a>. 

    If there is a menu next to the **Search services** field, make sure that `env:intro-apm` is selected. A menu is available if you've monitored more than one application environment in this Datadog organization.

2. Select the **store-frontend** service and browse its details. You may notice that there is error data in the **Errors by Version** graph. 

3. Click the **Errors by Version** dropdown and change it to **Errors**. There are a large amount of 500's coming in. *Looks like the store-frontend is not working correctly!*

    **Note:** To learn more about versioning your services and how that enables deeper insight into your applications performance across deployments, head over to our course on using [Datadog Deployment Tracking](https://labs.datadoghq.com/snippets/tracking-canary-deployments-with-datadog)

4. Click a red bar in the **Errors** graph. Select the **View related traces** option. 

    ![View Related Traces](fixappv3/assets/view-traces.png) 
    
    You will be redirected to the Traces page. The search field is populated with the related facets. 

5. Click into any of the related traces to view its details. 

    Looking at the flame graph for one of the 500 error traces will show the top level `rack.request` failing, but it seems the error begins from a downstream method called `rails.action_controller`.

6. Below the Flame Graph, click the **Errors (#)** tab. 

    1. Browse the details for the errors titled `ActionView::Template::Error: undefined method [] for nil:NilClass`.
    
    2. The first line in the details indicates `/spree/store-frontend/app/views/spree/layouts/spree_application.html.erb:##`. The error is originating from the indicated line of the `spree_applications.html.erb` file for the store-frontend service. 
    
    Using this information, we can now easily go fix this error.

7. Click IDE tab, and then click `spree_application.html.erb`{{open}} to open the file. Locate the line indicated in the error in step 5, `line 39`.

8. Copy and delete (or cut) the text `<br /><center><a href="<%= @ads['url'] %>"><img src="data:image/png;base64,<%= @ads['base64'] %>" /></a></center>` from `line 39`. 

    This line for the banner ads should be in two other files for the store-frontend, not this one!

9. Click `show.html.erb`{{open}} to open this file. 

10. Scroll to the bottom of the file (**Line 48**). Paste the line from step 8. 
```<br /><center><a href="<%= @ads['url'] %>"><img src="data:image/png;base64,<%= @ads['base64'] %>" /></a></center>```{{copy}}

11. Click `index.html.erb`{{open}} to open this file. 

12. Create a new line under **Line 11** and paste the line from step 8. 
```  <br /><center><a href="<%= @ads['url'] %>"><img src="data:image/png;base64,<%= @ads['base64'] %>" /></a></center>```{{copy}} Make sure to match the indent of the new line (**Line 12**) to that of the next line (**Line 13**).

These changes should fix the errors you are seeing in the store-frontend service. It will take about 3-4 minutes for new data to be displayed into Datadog. 

In the meantime, if you scroll to the trace statistics graphs on the service page, you'll notice that the latency is high (> 1s). Let's explore what may be causing this high latency.