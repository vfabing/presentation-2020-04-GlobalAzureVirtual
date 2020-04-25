@ECHO OFF

SET AZP_TOKEN=%AZP_TOKEN%
SET AZP_URL=https://dev.azure.com/vivien

docker run -d --name machine-agent-double --restart=always -e AZP_URL=%AZP_URL% -e AZP_TOKEN=%AZP_TOKEN% -e AZP_POOL=pool-GlobalAzureVirtual -e AZP_AGENT_NAME=machine-agent-double -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker vfabing/dockeragent
