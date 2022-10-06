$resourceGroup = "RiojaDotNet2022"
$environment = "aca-demo1"
$logWorkspace = "aca-demo-workspace"
$storageAccount="jramgar"
$queue="riojadotnet-queue"
$fnBackgroundImageName = "jramgar.azurecr.io/riojadotnet/fnbackground:v1"

az acr login --name jramgar
docker build -f .\src\FnBackground\Dockerfile .\src\FnBackground\. -t $fnBackgroundImageName
docker push $fnBackgroundImageName


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

# https://keda.sh/docs/2.8/scalers/azure-storage-queue/

az deployment group create --resource-group $resourceGroup `
                                        --template-file 'demo5-template.json' `
                                        --parameters loganalyticsKey=$logAnalyticsKey `
                                                     loganalyticsId=$logAnalyticsId `
                                                     environment=$environment `
                                                     backgroundAppRev='rev01' `
                                                     backgroundAppName='background-app' `
                                                     backgroundAppImage=$fnBackgroundImageName `
                                                     queueName=$queue `
                                                     storageConnectionString=$storageConnectionString `
                                                     acr_username=$acr_userName `
                                                     acr_password=$acr_password


$message = "event payload..."
$bytes = [System.Text.Encoding]::Unicode.GetBytes($message)
$encodedMessage = [Convert]::ToBase64String($bytes)

1..200 | ForEach-Object -Parallel {
    Write-Host "Send message..."

    $storageConnectionString  = $($using:storageConnectionString)
    $storageAccount  = $($using:storageAccount)
    $queue  = $($using:queue)
    $encodedMessage  = $($using:encodedMessage)

    az storage message put `
                --connection-string $storageConnectionString `
                --account-name $storageAccount `
                --queue-name $queue `
                --content $encodedMessage `

} -ThrottleLimit 10
