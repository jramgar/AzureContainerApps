$resourceGroup = "RiojaDotNet-vnet"
$logWorkspace = "aca-demo-workspace"
$environment = "aca-demo"
$nginxDemoAppName = "demoapp"
$nginxDemoAppImage = "mcr.microsoft.com/azuredocs/aca-helloworld"
$location = "northeurope"

$vnetInfraSubnetId = "/subscriptions/44faf07a-6afd-461b-a664-3461a150f26e/resourceGroups/RiojaDotNet-vnet/providers/Microsoft.Network/virtualNetworks/vnet-demos/subnets/infrastructure"

#create the resource group
az group create --name $resourceGroup --location $location

#create log analytics
az monitor log-analytics workspace create --resource-group $resourceGroup `
                                          --workspace-name $logWorkspace  `
                                          --location $location

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
 
#create the demo environment
az containerapp env create --name $environment `
                           --resource-group $resourceGroup `
                           --logs-workspace-id $logAnalyticsId `
                           --logs-workspace-key $logAnalyticsKey `
                           --internal-only true `
                           --infrastructure-subnet-resource-id $vnetInfraSubnetId `
                           --location $location

az containerapp create  --name $nginxDemoAppName `
                        --resource-group $resourceGroup `
                        --environment $environment `
                        --image $nginxDemoAppImage `
                        --target-port 80 `
                        --ingress 'external' `
                        --min-replicas 0 `
                        --max-replicas 5                                        

#az group delete --resource-group $resourceGroup

## crear ProvateDNS con el dominio del Env
## enlazar dns con la sbnet - link
## crear registro A con * e ip stática