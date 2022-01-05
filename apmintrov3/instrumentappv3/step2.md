For APM in Datadog, you need to enable trace collection by the Datadog agent. The Datadog Agent is software that runs on your hosts. It collects events and metrics from hosts and sends them to Datadog.

To use the added feature of correlating trace and log data, you will also need to enable log collection. 

1. Open the IDE tab, and then open the `docker-compose.yml`{{open}} file.

2. Beginning on line 3, you can view the details for **agent**. 

3. Click **Copy to Editor** in the block below or manually copy and paste the text where indicated to add the following to the list of environment variables for the agent.

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add agent env variables">
         - DD_LOGS_ENABLED=true
         - DD_PROCESS_AGENT_ENABLED=true
         - DD_DOCKER_LABELS_AS_TAGS={"my.custom.label.team":"team"}
         - DD_TAGS='env:ruby-shop'
         - DD_APM_NON_LOCAL_TRAFFIC=true
      </pre> 

    `DD_APM_ENABLED=true` enables trace collection. (Note: This is enabled by default for Agent 6+.) 
    
    `DD_LOGS_ENABLED=true` enables log collection from the agent container. 
    
    `DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true` enables log collection from the all other containers that comprise the application.
    
    To learn more, view the <a href="https://docs.datadoghq.com/agent/docker/?tab=standard#optional-collection-agents" target="_blank">Tracing Docker Applications</a> and <a href="https://docs.datadoghq.com/agent/docker/log/?tab=dockercompose#one-step-install-to-collect-all-the-container-logs" target="_blank">Docker Log Collection</a> documentation.

4. Click **Copy to Editor** below or manually copy and paste the text where indicated to add the ports for tracing between the agent container and other containers. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add agent trace port">
       ports:
         - 127.0.0.1:8126:8126/tcp</pre> 
    
    Port `8126` is the default port for tracing. Prefixing `127.0.0.1:` will isolate the requests going to the agent to the local network. To learn more, view the <a href="https://docs.datadoghq.com/agent/docker/apm/?tab=java#tracing-from-the-host" target="_blank">Tracing Docker Applications</a> documentation. 

5. Click **Copy to Editor** below or manually copy and paste the text where indicated to add labels to the logs. 

    <pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# add agent log labels">
       labels:
         com.datadoghq.ad.logs: '[{"source": "datadog-agent", "service": "agent"}]'</pre>
    
    The labels allow Datadog to identify the log source for the container and to automatically install corresponding integrations, if available. This **Autodiscovery** feature speeds up the setup process for log collection. To learn more, view the <a href="https://docs.datadoghq.com/agent/docker/log/?tab=dockercompose#activate-log-integrations" target="_blank">Docker Log Collection</a> documentation. 

The **agent** section of the docker-compose file should now look like the screenshot below. <p> ![instrumented-agent](instrumentapp2/assets/instrumented-agent.png)

With trace and log collection enabled for the Datadog Agent, let's go through instrumenting of one of Storedog's services.
