Write-Host "========================================="
Write-Host " Listening Port Analysis"
Write-Host "========================================="
Write-Host ""

$connections = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
    Sort-Object LocalPort

foreach ($connection in $connections) {

    $processName = "Unknown"

    try {
        $process = Get-Process -Id $connection.OwningProcess -ErrorAction Stop
        $processName = $process.ProcessName
    }
    catch {
        $processName = "Could not read process"
    }

    Write-Host "Port       : $($connection.LocalPort)"
    Write-Host "Address    : $($connection.LocalAddress)"
    Write-Host "Process ID : $($connection.OwningProcess)"
    Write-Host "Process    : $processName"
    Write-Host "-----------------------------------------"
}

Write-Host ""
Write-Host "========================================="
Write-Host " Port Analysis Completed"
Write-Host "========================================="