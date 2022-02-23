# Synthetic Browser Tests

Synthetic browser tests are automated, simulated tests that are run against web app UIs or APIs to ensure optimal user experience. They help you observe how your systems and applications are performing with simulated requests and actions from data centers around the globe. 

When using browser tests, Datadog will make HTTP requests to your application, using Chrome, Firefox, or Edge browsers to test any web application similar to a real user. If you happen to run the Datadog Agent on your application infrastructure, test results will seamlessly integrate with APM to associate system metrics and logs with the test results.

The tests send their data to Datadog so you can track the performance of your webpages and APIs from the backend to the frontend and at various network levels. It’s a controlled and stable way to do automated testing and alerting. With browser tests, you can identify issues like:

- Regressions
- Broken features
- High response times 
- Unexpected status codes

Browser tests help you ensure that no defective code makes it to production; if it does, a browser test will allow you to catch an issue sooner before too many customers are impacted. This helps provide a consistent customer experience and ensures swift identification of errors that could be felt by end users.

You can also compute service level objectives (SLOs) on your key endpoints and user journeys, making it easier to stick to your performance targets.

In this lab, you'll be introduced to synthetic browser tests, where you'll use Datadog to test a web application's UI to ensure data populated by an API service displays correctly for the user.
