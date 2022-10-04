$resourceGroup = "RiojaDotNet2022"
$logWorkspace = "aca-demo-workspace"
$location = "northeurope"
$frontendImageName = "jramgar.azurecr.io/riojadotnet/frontend:v2"
$backendImageName = "jramgar.azurecr.io/riojadotnet/backend:v2"

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

# git checkout demo3
# git pull

# docker build -f .\src\frontend\Dockerfile .\src\frontend\. -t $frontendImageName
# docker push $frontendImageName

# docker build -f .\src\backend\Dockerfile .\src\backend\. -t $backendImageName
# docker push $backendImageName

#docker run -d -p 8080:80 --name frontend jramgar.azurecr.io/riojadotnet/frontend:v1

#create with a deployment using an ARM template
az deployment group create --resource-group $resourceGroup `
                           --template-file 'demo3-template.json' `
                           --parameters loganalyticsKey=$logAnalyticsKey `
                                        loganalyticsId=$logAnalyticsId `
                                        environment="aca-demo1" `
                                        frontendAppName='frontend-app' `
                                        frontendAppImage=$frontendImageName `
                                        frontendAppRev='rev02' `
                                        backendAppName='backend-app' `
                                        backendAppImage=$backendImageName `
                                        backendAppRev='rev02' `
                                        acr_username=$acr_userName `
                                        acr_password=$acr_password

                                        