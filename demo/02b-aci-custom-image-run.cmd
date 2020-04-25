@ECHO OFF

SET AZP_TOKEN=%AZP_TOKEN%
SET AZP_URL=https://dev.azure.com/vivien
SET ACR_PASSWORD=%ACR_PASSWORD%

CALL az container create -g rg-gav2020 -n aci-agent-007 --image acrgav2020.azurecr.io/dockeragent --cpu 1 --memory 2 --registry-username acrgav2020 --registry-password %ACR_PASSWORD% --environment-variables AZP_URL=https://dev.azure.com/vivien AZP_TOKEN=%AZP_TOKEN% AZP_AGENT_NAME=aci-agent-007 AZP_POOL=pool-GlobalAzureVirtual
