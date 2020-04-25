@ECHO OFF

SET AZURE_SUBSCRIPTION=%AZURE_SUBSCRIPTION%

REM Create docker build machine with docker-machine command line (Installed with Docker Desktop)
docker-machine create --driver azure --azure-subscription-id %AZURE_SUBSCRIPTION% --azure-resource-group rg-gav2020 --azure-location westeurope --azure-ssh-user vivien --azure-size "Standard_D4s_v3" vm-build-001

REM Show environment variables to set to connect to the Docker service installed in the docker-machine
docker-machine env vm-build-001