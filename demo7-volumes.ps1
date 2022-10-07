$resourceGroup = "RiojaDotNet2022"
$environment = "aca-demo"
$storageAccountName = "jramgar"
$storageFileShare = "ficheros-demo"
$frontendImageName = "jramgar.azurecr.io/riojadotnet/frontend:v2"
$backendImageName = "jramgar.azurecr.io/riojadotnet/backend:v2"

az containerapp env storage set `
            --name $environment `
            --resource-group $resourceGroup `
            --storage-name mystorage `
            --azure-file-account-name $storageAccountName `
            --azure-file-account-key $storageAccountKey `
            --azure-file-share-name $storageFileShare `
            --access-mode ReadWrite

az containerapp env storage list `
            --name $environment `
            --resource-group $resourceGroup


az deployment group create --resource-group $resourceGroup `
            --template-file 'demo7-template.json' `
            --parameters loganalyticsKey=$logAnalyticsKey `
                         loganalyticsId=$logAnalyticsId `
                         environment="aca-demo" `
                         frontendAppName='frontend-app' `
                         frontendAppImage=$frontendImageName `
                         frontendAppRev='rev03-5' `
                         backendAppName='backend-app' `
                         backendAppImage=$backendImageName `
                         backendAppRev='rev03-5' `
                         acr_username=$acr_userName `
                         acr_password=$acr_password