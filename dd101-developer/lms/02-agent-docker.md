# The Datadog Agent

The Datadog Agent is open source software that runs on your hosts. It is the service that listens for and collects events, logs, and metrics from hosts and sends them to Datadog to be processed and displayed.

As a developer, it may not always be your responsibility to ensure the Agent is installed; that may be the job of a site reliability engineer. However, it's good to understand how it can be installed, and more importantly, how it's configured to capture data correctly.

The Agent can be installed in a number of different environments, all of which are well-documented within the Datadog application for you to refer to. In the following lab, you'll learn how to install the Agent in a Docker environment and use the right environment variables and Docker labels to ensure the Agent is collecting data properly.
