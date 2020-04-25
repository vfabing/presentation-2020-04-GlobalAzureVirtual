#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Microsoft.Azure.Management.Fluent;
using Microsoft.Azure.Management.ResourceManager.Fluent;
using Microsoft.Azure.Management.ResourceManager.Fluent.Authentication;
using System;
using System.Collections.Generic;
using System.Threading;

public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string action = req.Query["action"];

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic data = JsonConvert.DeserializeObject(requestBody);
    action = action ?? data?.action;

    var tenantId = "TENANT_ID";
    var clientId = "CLIENT_ID";
    var clientSecret = "CLIENT_SECRET";
    var subscriptionId = "SUBSCRIPTION_ID";
    var resourceGroup = "rg-gav2020";
    var agentName = "aci-agent-k";

    var imageName = "vfabing/azure-pipelines-agent-dotnet-core-sdk:latest";
    var envConfig = new Dictionary<string, string> {
        { "AZP_URL", "https://dev.azure.com/vivien" },
        { "AZP_TOKEN", "AZP_TOKEN" },
        { "AZP_AGENT_NAME", agentName },
        { "AZP_POOL", "pool-GlobalAzureVirtual" },
    };

    var sp = new ServicePrincipalLoginInformation { ClientId = clientId, ClientSecret = clientSecret };
    var azure = Azure.Authenticate(new AzureCredentials(sp, tenantId, AzureEnvironment.AzureGlobalCloud)).WithSubscription(subscriptionId);
    var rg = azure.ResourceGroups.GetByName(resourceGroup);

    
    switch(action) 
    {
        case "start":
            // Azure Container Instance Creation
            new Thread(() => azure.ContainerGroups.Define(agentName)
                .WithRegion(rg.RegionName)
                .WithExistingResourceGroup(rg)
                .WithLinux()
                .WithPublicImageRegistryOnly()
                .WithoutVolume()
                .DefineContainerInstance(agentName)
                    .WithImage(imageName)
                    .WithoutPorts()
                    .WithEnvironmentVariables(envConfig)
                    .Attach()
                .Create()).Start();
                break;
        case "stop":
            // Azure Container Instance Deletion
            new Thread(() => azure.ContainerGroups.DeleteByResourceGroup(resourceGroup, agentName)).Start();
            break;
        default:
            action = null;
            break;
    }

    return action != null
        ? (ActionResult)new OkObjectResult($"Hello, {action}")
        : new BadRequestObjectResult("Please pass an action (`start` or `stop`) on the query string or in the request body");
}
