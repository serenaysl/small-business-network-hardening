Write-Host "========================================="
Write-Host " Security Configuration Verification"
Write-Host "========================================="
Write-Host ""

function Show-Result {
    param (
        [string]$Check,
        [string]$Status,
        [string]$Details
    )

    Write-Host "Check   : $Check"
    Write-Host "Status  : $Status"
    Write-Host "Details : $Details"
    Write-Host "-----------------------------------------"
}

# 1. Windows Firewall
try {
    $profiles = Get-NetFirewallProfile
    $disabledProfiles = $profiles | Where-Object { $_.Enabled -eq $false }

    if ($disabledProfiles.Count -eq 0) {
        Show-Result `
            "Windows Firewall" `
            "PASS" `
            "All available firewall profiles are enabled."
    }
    else {
        Show-Result `
            "Windows Firewall" `
            "REVIEW" `
            "One or more firewall profiles are disabled."
    }
}
catch {
    Show-Result `
        "Windows Firewall" `
        "UNKNOWN" `
        "Firewall status could not be checked."
}


# 2. Microsoft Defender
try {
    $defender = Get-MpComputerStatus

    if ($defender.RealTimeProtectionEnabled -eq $true) {
        Show-Result `
            "Microsoft Defender" `
            "PASS" `
            "Real-time protection is enabled."
    }
    else {
        Show-Result `
            "Microsoft Defender" `
            "REVIEW" `
            "Real-time protection is not enabled."
    }
}
catch {
    Show-Result `
        "Microsoft Defender" `
        "UNKNOWN" `
        "Defender status could not be checked."
}


# 3. Remote Desktop
try {
    $rdp = Get-ItemProperty `
        "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
        -Name fDenyTSConnections `
        -ErrorAction Stop

    if ($rdp.fDenyTSConnections -eq 1) {
        Show-Result `
            "Remote Desktop" `
            "PASS" `
            "Remote Desktop is disabled."
    }
    else {
        Show-Result `
            "Remote Desktop" `
            "REVIEW" `
            "Remote Desktop is enabled."
    }
}
catch {
    Show-Result `
        "Remote Desktop" `
        "UNKNOWN" `
        "Remote Desktop status could not be checked."
}


# 4. SMBv1
try {
    $smb = Get-WindowsOptionalFeature `
        -Online `
        -FeatureName SMB1Protocol `
        -ErrorAction Stop

    if ($smb.State -eq "Disabled") {
        Show-Result `
            "SMBv1" `
            "PASS" `
            "SMBv1 is disabled."
    }
    else {
        Show-Result `
            "SMBv1" `
            "REVIEW" `
            "SMBv1 may be enabled."
    }
}
catch {
    Show-Result `
        "SMBv1" `
        "UNKNOWN" `
        "SMBv1 status could not be verified with current permissions."
}


# 5. Listening Ports
try {
    $ports = Get-NetTCPConnection `
        -State Listen `
        -ErrorAction Stop |
        Select-Object -ExpandProperty LocalPort |
        Sort-Object -Unique

    Show-Result `
        "Listening TCP Ports" `
        "INFO" `
        ("Detected ports: " + ($ports -join ", "))
}
catch {
    Show-Result `
        "Listening TCP Ports" `
        "UNKNOWN" `
        "Listening ports could not be checked."
}


# 6. Recent Security Updates
try {
    $updates = Get-HotFix |
        Sort-Object InstalledOn -Descending |
        Select-Object -First 3

    if ($updates) {
        $updateList = ($updates.HotFixID -join ", ")

        Show-Result `
            "Recent Windows Updates" `
            "INFO" `
            "Recent updates detected: $updateList"
    }
    else {
        Show-Result `
            "Recent Windows Updates" `
            "REVIEW" `
            "No recent update information was returned."
    }
}
catch {
    Show-Result `
        "Recent Windows Updates" `
        "UNKNOWN" `
        "Update information could not be checked."
}


Write-Host ""
Write-Host "========================================="
Write-Host " Verification Completed"
Write-Host "========================================="