Now that you are starting to see some of the data that is made available through RUM, you can start looking at some user session data.

1. Navigate to **UX Monitoring > Session**.

2. Along the top of the **Session count** graph, you can click to explore the types of data that RUM makes accessible to you:

  * **Sessions** groups interactions by user session and includes information about session duration, pages visited, interactions, resources loaded, errors, and more. By clicking on a row, you can also look at the **Attributes** tab to determine the user's browser and other information.
  
  * **Views** shows you what pages users are visiting. Clicking on a row provides more detail on the view, including page load speeds and resources used.
  
  * **Actions** lists actions taken by a user such as clicks and any custom actions you've defined with the [`addUserAction` API](https://docs.datadoghq.com/real_user_monitoring/browser/advanced_configuration/?tab=npm#custom-user-actions).
  
  * **Errors** provides a list of errors experienced on the user side.
  
  * **Resources** provides a list of all resources served to users.
  
  * **Long Tasks** provides a listing of any task in a browser that blocks the main thread for more than 50ms.

  Further information on the data that RUM collects is available [here](https://docs.datadoghq.com/real_user_monitoring/browser/data_collected/).

3. Along the left-hand side, you'll see a list of **Facets**. These allow you to filter your data by a number of different criteria.

  Some may be familiar if you've used Datadog for logs and APM, but this list has a lot more options that are client-side oriented.

Click the **Continue** button below to move on, where you'll explore an individual user session.
