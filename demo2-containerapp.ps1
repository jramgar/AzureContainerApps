$resourceGroup = "RiojaDotNet2022"
$logWorkspace = "aca-demo-workspace"
$location = "northeurope"
$frontEndImageName = "jramgar.azurecr.io/riojadotnet/frontend:v1"


#create the resource group
az group create --name $resourceGroup --location $location

# retrieve workspace ID and secret
$logAnalyticsId = az monitor log-analytics workspace show --query customerId `
    --resource-group $resourceGroup `
    --workspace-name $logWorkspace `
    --output tsv 

$logAnalyticsKey = az monitor log-analytics workspace get-shared-keys `
    --query primarySharedKey  `
    --resource-group $resourceGroup `
    --workspace-name $logWorkspace `
    --output tsv 

# OPC1: create with az commands
#
# az containerapp create  --name $nginxDemoAppName `
#                         --resource-group $resourceGroup `
#                         --environment $environment `
#                         --image $nginxDemoAppImage `
#                         --target-port 80 `
#                         --ingress 'external' `
#                         --min-replicas 0 `
#                         --max-replicas 5   

# OPC2: create with a deployment using an ARM template
az deployment group create --resource-group $resourceGroup `
    --template-file 'demo2-template.json' `
    --parameters loganalyticsKey=$logAnalyticsKey `
    loganalyticsId=$logAnalyticsId `
    environment="aca-demo" `
    demoAppRev='rev01' `
    demoAppName='frontend-app' `
    demoAppImage=$frontEndImageName `
    acr_username=$acr_userName `
    acr_password=$acr_password

                                        