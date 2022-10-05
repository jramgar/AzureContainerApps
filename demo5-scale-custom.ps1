$storageAccount="jramgar"
$queue="riojadotnet-queue"


$message = "event payload..."
$bytes = [System.Text.Encoding]::Unicode.GetBytes($message)
$encodedMessage = [Convert]::ToBase64String($bytes)

1..20 | ForEach-Object -Parallel {
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
