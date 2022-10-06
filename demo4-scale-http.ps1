$resourceGroup = "RiojaDotNet2022"
$frontendAppName = 'frontend-app'

# HTTP Rule, create new revision with scale
az containerapp update  --name $frontendAppName `
    --resource-group $resourceGroup `
    --scale-rule-name http-rule `
    --scale-rule-http-concurrency 5


$url = az containerapp show --name $frontendAppName `
    --resource-group $resourceGroup `
    --query properties.configuration.ingress.fqdn `
    --output tsv

# Load Test: 500 virtual users, 100 request/user

artillery quick --count 500 --num 100 https://$url


echo 'Tested fqdn: '$url
az containerapp show --name $frontendAppName `
    --resource-group $resourceGroup `
    --query properties.latestRevisionName

# deploy fn 

# run powershell

#az listar número de réplicas