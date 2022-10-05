$storageAccount="jramgar"
$queue="riojadotnet-queue"


$message = "event payload..."
$bytes = [System.Text.Encoding]::Unicode.GetBytes($message)
$encodedMessage = [Convert]::ToBase64String($bytes)

1..20 | ForEach-Object -Parallel {
    Write-Host "Send message..."

   

} -ThrottleLimit 10
