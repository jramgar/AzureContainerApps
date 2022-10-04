az login
az account set -s 44faf07a-6afd-461b-a664-3461a150f26e

#install powershell extensions
az extension add --name containerapp --upgrade

#register namespaces
az provider register --namespace Microsoft.App
az provider register --namespace Microsoft.OperationalInsights

az acr login --name jramgar

$acr_password="HUAYrAX5UbLwAn6p=eHRNWmQ48wswY8m"
$acr_username="jramgar"
