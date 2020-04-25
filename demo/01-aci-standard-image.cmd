@ECHO OFF

SET VSTS_TOKEN=%VSTS_TOKEN%
SET VSTS_ACCOUNT=vivien

REM https://hub.docker.com/_/microsoft-azure-pipelines-vsts-agent
az container create -g rg-gav2020 -n aci-agent-smith --image mcr.microsoft.com/azure-pipelines/vsts-agent --cpu 1 --memory 2 --environment-variables VSTS_ACCOUNT=vivien VSTS_TOKEN=%VSTS_TOKEN% VSTS_AGENT=aci-agent-smith VSTS_POOL=pool-GlobalAzureVirtual
