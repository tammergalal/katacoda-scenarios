# Application Performance Monitoring

As you know, modern software applications are composed of pieces of code that you update frequently, and are typically spread across a diverse infrastructure. This often makes it challenging to find the source of performance problems. Is a sudden change in performance caused by:

- An increase in error conditions? 
- A slow database query? 
- Overwhelmed hardware? 
- A cloud service outage? 

With end-to-end distributed tracing, APM, and the continuous profiler in Datadog, you have the ability to locate these issues by correlating traces with frontend and backend data. This gives you a more complete picture of how your services perform while interacting with one another and their dependencies, allowing you to reduce latency, identify processes using a high number of resources, and eliminate errors that negatively impact the user experience.

Datadog offers a number of solutions for implementing APM across any tech stack, allowing you to collect and correlate trace metrics from the application level all the way up to your hosts, containers, serverless functions, and many more. Having the ability to connect these metrics across your various services helps you gain a better sense of what can be done to enhance your application and where it should be done. Furthermore, you or members of your organization can create monitors based on APM traces to alert you when your services aren't optimally performing.

As a developer, you'll likely be responsible for ensuring traces are sent from your applications to the Datadog Agent for collection, which is what you'll do in the following lab. You'll gain an understanding for how APM is configured in a Docker environment, how to read APM traces in the Datadog application, how to correlate traces with logs, and how to use monitors to identify an issue in an application. Finally, you'll take a look at the APM profiling feature to gain insight into applications' system resource consumption beyond traces.
