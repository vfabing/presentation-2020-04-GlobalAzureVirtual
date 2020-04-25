@ECHO OFF

CD 02-aci-custom-image

REM https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#linux
CALL az acr build --registry acrgav2020 --image dockeragent .

CD ..
