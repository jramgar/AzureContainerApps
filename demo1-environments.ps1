$resourceGroup = "RiojaDotNet2022"
$logWorkspace = "aca-demo-workspace"
$environment = "aca-demo1"
$location = "northeurope"

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
                           --internal-only false `
                           --location $location

#create the demo environment (without log analytics workspace)
# az containerapp env create --name $environment `
#                            --resource-group $resourceGroup `
#                            --location $location

#az group delete --resource-group $resourceGroup