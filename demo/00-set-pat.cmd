@ECHO OFF

IF "%1"=="" (
    ECHO Please specify your PAT (Personal Access Token^)
    ECHO https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops^&tabs=preview-page#create-personal-access-tokens-to-authenticate-access
    PAUSE
) ELSE (
    SET TOKEN=%1
    SETX VSTS_TOKEN %TOKEN%
    SETX AZP_TOKEN %TOKEN%
)
