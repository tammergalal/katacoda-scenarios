# Datadog Integrations

In the previous lab, you got the Datadog Agent up and running. You also were able to tag containers and services and see their system-level metrics, but you didn't get deep insight into what those services were doing. Additionally, you were capturing and tagging logs, but they were often poorly formatted and interpreted as errors. This is because different services such as Postgres, Python, or Ruby all produce different types of data and the Datadog app doesn't automatically know exactly which one is which without being told what to expect. This is where integrations come in.

Many integrations come out-of-the-box with the Datadog Agent, but they can also be used with your other services such as Slack, AWS, and Azure, or configured at the application-level when you aren't using the Agent. For this course, you'll focus on using out-of-the-box integrations with the Agent in a Docker environment.

Setting up an integration with the Agent in a Docker environment requires different configuration values for each service listed in a `docker-compose` file, all of which are provided and well-documented for you in the Datadog application. In the following lab, you'll set these values for different types of services so Datadog can make better sense of the data it receives.
