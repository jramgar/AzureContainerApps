$resourceGroup = "RiojaDotNet2022"
$logWorkspace = "aca-demo-workspace"
$location = "northeurope"

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
# az containerapp env create --name $environment `
#                            --resource-group $resourceGroup `
#                            --logs-workspace-id $logAnalyticsId `
#                            --logs-workspace-key $logAnalyticsKey `
#                            --internal-only true `
#                            --infrastructure-subnet-resource-id $vnetInfraSubnetId `
#                            --location $location
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
                           --template-file 'demo3-template.json' `
                           --parameters loganalyticsKey=$logAnalyticsKey `
                                        loganalyticsId=$logAnalyticsId `
                                        environment="aca-demo1" `
                                        demoAppRev='rev01' `
                                        demoAppName='demo3app' `

                                        