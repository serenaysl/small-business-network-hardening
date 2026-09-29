Write-Host "========================================="
Write-Host " Small Business Security Audit"
Write-Host "========================================="
Write-Host ""

Write-Host "[1] System Information"
Write-Host "----------------------"
Get-ComputerInfo | Select-Object `
    WindowsProductName,
    WindowsVersion,
    OsArchitecture,
    CsName

Write-Host ""
Write-Host "[2] Windows Firewall Status"
Write-Host "---------------------------"
Get-NetFirewallProfile | Select-Object `
    Name,
    Enabled,
    DefaultInboundAction,
    DefaultOutboundAction

Write-Host ""
Write-Host "[3] Microsoft Defender Status"
Write-Host "-----------------------------"

try {
    Get-MpComputerStatus | Select-Object `
        AntivirusEnabled,
        AntispywareEnabled,
        RealTimeProtectionEnabled,
        BehaviorMonitorEnabled,
        IoavProtectionEnabled
}
catch {
    Write-Host "Microsoft Defender status could not be read."
}

Write-Host ""
Write-Host "[4] Active Network Connections"
Write-Host "------------------------------"
Get-NetTCPConnection |
    Where-Object { $_.State -eq "Established" } |
    Select-Object `
        LocalAddress,
        LocalPort,
        RemoteAddress,
        RemotePort,
        State

Write-Host ""
Write-Host "[5] Listening TCP Ports"
Write-Host "-----------------------"
Get-NetTCPConnection |
    Where-Object { $_.State -eq "Listen" } |
    Sort-Object LocalPort |
    Select-Object `
        LocalAddress,
        LocalPort,
        OwningProcess

Write-Host ""
Write-Host "[6] Remote Desktop Status"
Write-Host "-------------------------"

$rdpStatus = Get-ItemProperty `
    "HKLM:\System\CurrentControlSet\Control\Terminal Server" `
    -Name fDenyTSConnections `
    -ErrorAction SilentlyContinue

if ($rdpStatus.fDenyTSConnections -eq 0) {
    Write-Host "Remote Desktop: ENABLED"
}
else {
    Write-Host "Remote Desktop: DISABLED"
}

Write-Host ""
Write-Host "[7] SMBv1 Status"
Write-Host "----------------"

try {
    Get-WindowsOptionalFeature `
        -Online `
        -FeatureName SMB1Protocol |
        Select-Object FeatureName, State
}
catch {
    Write-Host "SMBv1 status could not be read."
}

Write-Host ""
Write-Host "[8] Local Users"
Write-Host "---------------"

try {
    Get-LocalUser |
        Select-Object `
            Name,
            Enabled,
            LastLogon
}
catch {
    Write-Host "Local user information could not be read."
}

Write-Host ""
Write-Host "[9] Local Administrators"
Write-Host "------------------------"

try {
    Get-LocalGroupMember `
        -Group "Administrators" |
        Select-Object Name, ObjectClass
}
catch {
    Write-Host "Administrator group information could not be read."
}

Write-Host ""
Write-Host "[10] Recent Windows Updates"
Write-Host "---------------------------"

Get-HotFix |
    Sort-Object InstalledOn -Descending |
    Select-Object -First 10 `
        HotFixID,
        Description,
        InstalledOn

Write-Host ""
Write-Host "========================================="
Write-Host " Audit Completed"
Write-Host "========================================="