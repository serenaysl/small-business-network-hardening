# Network Security Configuration and Hardening Plan

## 1. Introduction

This project is about creating a basic network security hardening plan for a hypothetical small business.

I wanted to understand how a small business network can be protected using simple but important security controls such as firewall rules, endpoint protection, network segmentation, patching and access control.

I also used PowerShell scripts on my own Windows system to check some real security settings and listening ports. I used these results as a small practical part of the project.

The main goal is to reduce unnecessary access, reduce the attack surface and make the network more difficult to compromise.



## 2. Hypothetical Company

The fictional company used in this project is called Northbridge Digital Services.

The company has around 30 employees.

The network includes:

- employee desktop computers
- company laptops
- Wi-Fi
- a small file server
- network printers
- cloud storage
- Microsoft 365
- a company website
- remote workers
- business applications

The company does not have a large IT team, so the security plan needs to be practical and not too complicated.


## 3. Basic Network Structure

A simple version of the network could look like this:

INTERNET  
↓  
FIREWALL  
↓  
Employee VLAN / Server VLAN / Guest VLAN  
↓  
PCs, laptops / File server / Guest Wi-Fi  
↓  
Printer and IoT VLAN

There would also be a separate Management VLAN for the firewall, switches and access points.

In a real small business network, these parts should not all be placed on the same flat network.



## 4. Main Security Risks

I identified some common risks that could affect this type of company.

### 4.1 Phishing

Employees may receive fake emails that try to steal passwords.

If an attacker gets a real employee password, they may access email, cloud storage or company files.

Risk level: High

Possible impact:

- stolen accounts
- data leaks
- unauthorized access
- fake payment requests

### 4.2 Ransomware

A malicious attachment, compromised website or infected file could introduce ransomware.

If all devices are connected to the same unrestricted network, ransomware could spread to other computers or shared storage.

Risk level: High

Possible impact:

- encrypted files
- downtime
- data loss
- business interruption

### 4.3 Unnecessary Open Services

Open ports and services increase the attack surface.

Some ports are normal for Windows, but services that are not needed should be reviewed.

Risk level: Medium

### 4.4 Weak Remote Access

Remote access can become a security risk if it is exposed directly to the internet.

Examples include:

- RDP
- SMB
- administrative interfaces

Risk level: High

### 4.5 Unpatched Systems

Old operating systems or applications may contain known vulnerabilities.

Attackers often try to use vulnerabilities that already have public information or exploits available.

Risk level: High

### 4.6 Weak Network Separation

If every device is on the same network, one compromised computer may be able to communicate with many other systems.

Risk level: High

### 4.7 Lost or Stolen Laptops

A stolen laptop may expose business files or login information.

Risk level: Medium

Disk encryption can help protect the data.

### 4.8 Weak Backup Protection

If backups are always connected and writable, ransomware could also encrypt the backups.

Risk level: High

### 4.9 Unnecessary Applications

Extra applications on business computers may increase the attack surface.

For example, applications that are not needed for work may open ports, run background services or contain vulnerabilities.

Risk level: Medium



## 5. Practical Security Checks

I created PowerShell scripts to check some security settings on my Windows system.

The checks included:

- Windows Firewall
- Microsoft Defender
- Remote Desktop
- SMBv1
- listening TCP ports
- processes using open ports
- recent Windows updates
- basic risk review

The purpose was not to fully audit a real company network.

I used my own computer as a small lab system so I could practice security checks and understand the results.



## 6. Scripts Used

The following PowerShell scripts were created during the project.

### 6.1 security_audit.ps1

This script collects basic system and security information.

It checks things such as:

- system information
- firewall status
- Defender status
- active network connections
- listening ports
- RDP
- SMBv1
- local users
- local administrators
- recent updates

### 6.2 verify_security.ps1

This script checks some important settings and gives simple results such as:

- PASS
- INFO
- REVIEW
- UNKNOWN

This made the results easier for me to understand.

### 6.3 port_analysis.ps1

This script checks listening TCP ports and tries to find the process using each port.

For example, it showed ports being used by:

- svchost
- System
- Spotify
- VS Code
- OneDrive
- Print Spooler

### 6.4 hardening_recommendations.ps1

This script gives basic security recommendations based on common small business hardening practices.

It includes suggestions about:

- firewall
- Defender
- Remote Desktop
- SMB
- network segmentation
- patching
- backups
- logging
- account security

### 6.5 risk_summary.ps1

This script creates a simple risk summary based on the checks I performed.

It shows:

- the finding
- the risk level
- a short explanation
- my suggestion



## 7. Results From My Tests

### 7.1 Windows Firewall

Status: PASS

All firewall profiles were enabled.

This is a good security setting because the firewall helps control unwanted network connections.

My recommendation is to keep the firewall enabled and review firewall rules from time to time.

### 7.2 Microsoft Defender

Status: PASS

Real-time protection was enabled.

This provides basic protection against malware and suspicious files.

My recommendation is to keep Defender updated and perform regular scans.

### 7.3 Remote Desktop

Status: PASS

Remote Desktop was disabled.

For a small business system that does not need remote desktop access, keeping it disabled reduces the attack surface.

If remote access is needed later, I would prefer using VPN and MFA instead of exposing RDP directly to the internet.

### 7.4 SMBv1

Status: UNKNOWN

I could not verify SMBv1 because I did not have administrator permission.

Because of this, I did not assume that it was enabled or disabled.

In a real company system, SMBv1 should be checked by an administrator.

If it is not required for a legacy device or application, it should be disabled.

### 7.5 Recent Windows Updates

Status: INFO

Recent Windows updates were detected.

This is a positive result because patching helps reduce vulnerabilities that are already known.

Updates should also include browsers and third-party applications.



## 8. Listening Port Analysis

I checked which TCP ports were listening on the computer.

Some of the ports I found were:

- 135
- 139
- 445
- 1757
- 5040
- 7680
- 7768
- 28623
- 42050
- several dynamic Windows ports

I also identified some of the processes connected to these ports.

Examples included:

- svchost
- System
- Superhuman.WebUI
- Spotify
- VS Code
- OneDrive
- lsass
- wininit
- spoolsv
- Windows services

Not every open port automatically means that there is a vulnerability.

The important point is to understand which process uses the port, whether the service is required, whether it is reachable from outside and whether firewall rules are protecting it.



## 9. Important Port Findings

### 9.1 Port 445

Port 445 is related to SMB file sharing.

This port can be useful inside a business network, but it should not be directly exposed to the public internet.

Risk: High Attention

My recommendation:

- restrict access with firewall rules
- only allow trusted internal devices
- avoid exposing SMB directly to the internet
- review file sharing permissions

### 9.2 Port 139

Port 139 is also related to Windows file sharing.

Risk: Needs Review

My recommendation:

- only allow it if file sharing is required
- block unnecessary access
- review old file sharing configurations

### 9.3 Port 135

Port 135 is used by Windows RPC services.

Risk: Needs Review

My recommendation:

- keep external access restricted
- use firewall rules
- do not expose it directly to the public internet



## 10. Print Spooler

The spoolsv process was listening on the system.

The Print Spooler service is used for printing.

If a computer does not use printers, this service can be reviewed.

Disabling unused services can reduce the attack surface.

Risk: Needs Review



## 11. Extra Applications

I found some non-system applications using network ports.

Examples included:

- Spotify
- VS Code
- OneDrive
- Superhuman

Some of these are normal applications and some ports were only listening on localhost.

In a normal personal computer this may not be a big problem.

However, in a business environment, unnecessary software should be removed when possible.

Every additional application can create extra attack surface.

Risk: Needs Review



## 12. Firewall Hardening

A small business firewall should use a default-deny approach for incoming connections.

Basic idea:

Internet to Internal Network = DENY by default

Only services that are actually required should be allowed.

Administrative interfaces should not be directly available from the internet.

Firewall rules should also be reviewed regularly.

Example rules:

- Employee VLAN to Internet = ALLOW
- Guest VLAN to Internet = ALLOW
- Guest VLAN to Internal Network = DENY
- Internet to SMB = DENY
- Internet to RDP = DENY
- Management VLAN to Network Devices = ALLOW



## 13. Network Segmentation

A flat network is easier for malware to move through.

A better design would separate systems into different VLANs.

| VLAN | Purpose |
|---|---|
| VLAN 10 | Employees |
| VLAN 20 | Management |
| VLAN 30 | Servers |
| VLAN 40 | Guest Wi-Fi |
| VLAN 50 | Printers / IoT |
| VLAN 60 | Network Management |

Guest Wi-Fi should only have internet access.

It should not be able to reach internal company computers or servers.

This can reduce lateral movement if one device becomes compromised.



## 14. Wireless Security

The business Wi-Fi should use modern wireless security.

Recommended settings:

- WPA3 when supported
- WPA2-AES as fallback
- strong passwords
- WPS disabled
- separate guest Wi-Fi
- firmware updates
- guest client isolation

The guest network should not communicate directly with the employee network.



## 15. Endpoint Security

Company computers should have:

- Microsoft Defender or another endpoint security product
- Windows Firewall
- automatic security updates
- disk encryption
- screen lock
- restricted administrator permissions
- secure browser settings

Employees should normally use standard user accounts.

Administrator accounts should only be used when administrative work is required.



## 16. Authentication Security

Important accounts should use multi-factor authentication.

This includes:

- email
- Microsoft 365
- cloud storage
- VPN
- administrator accounts

Passwords should be unique and should not be reused between services.

A password manager can also help employees use stronger and unique passwords.



## 17. Administrator Accounts

Employees should not use administrator accounts for normal daily activities.

A better setup would be:

Normal user account  
plus  
Separate administrator account

The administrator account should only be used when changing system settings or installing software.

This reduces the possible damage if a normal user session becomes infected.



## 18. Remote Access

Remote Desktop should not be directly exposed to the internet.

If remote access is required, a VPN should be used.

Remote User  
↓  
Encrypted VPN  
↓  
Firewall  
↓  
Internal Resources

MFA should also be enabled for VPN access.

Remote access activity should be logged.



## 19. Patch Management

Windows and other applications should be updated regularly.

My test system showed recent Windows updates, which is a positive result.

In a small business, updates should include:

- Windows
- browsers
- Office
- security software
- firewall firmware
- wireless access points
- network switches
- third-party applications

Old and unsupported software should be removed.

Critical security updates should be installed as soon as possible after basic testing.



## 20. Backup Security

Backups are very important against ransomware.

A good approach is the 3-2-1 backup rule:

- 3 copies of important data
- 2 different storage types
- 1 copy offline or off-site

Backups should not always be writable by normal employee accounts.

Backup restoration should also be tested.

A backup is not very useful if it cannot be restored when needed.



## 21. Logging and Monitoring

Security logs should be reviewed regularly.

Important logs include:

- firewall logs
- login attempts
- antivirus alerts
- VPN activity
- administrator activity
- account permission changes

Logs can help during an incident investigation.

For a larger setup, logs could be collected in a central logging system.



## 22. IDS and IPS

A small business can also use IDS or IPS technology.

Examples of things an IDS may detect:

- port scanning
- suspicious connections
- known exploit attempts
- malware communication
- unusual network traffic

An IDS or IPS should not replace a firewall.

Different security controls should work together.

For example:

Firewall + IDS/IPS + Endpoint Protection + Logging



## 23. DNS Security

The company should use trusted DNS servers.

Unapproved DNS traffic can be blocked by the firewall.

DNS filtering can also be used to help block:

- known malicious domains
- phishing websites
- malware command-and-control domains



## 24. Email Security

Email is one of the most common attack methods.

Recommended controls include:

- spam filtering
- phishing filtering
- malicious attachment scanning
- MFA
- security awareness training
- SPF
- DKIM
- DMARC

Employees should be trained to recognize:

- fake login pages
- suspicious attachments
- urgent payment requests
- fake password reset messages



## 25. File Server Security

The file server should be placed in a separate server VLAN.

Access should depend on the user's role.

Example:

Finance Folder

Finance Department = Read / Write  
Management = Read  
Sales = No Access

Users should not automatically have access to every shared folder.

File server access should also be logged.



## 26. Physical Security

Network security also depends on physical security.

The following devices should not be freely accessible:

- firewall
- switches
- servers
- backup devices
- wireless controllers

Network equipment should be placed in a locked or restricted area.



## 27. Incident Response

The company should have a simple incident response process.

A basic process could be:

1. Identify
2. Contain
3. Investigate
4. Remove
5. Recover
6. Review

For example, during a ransomware incident:

Disconnect affected device  
↓  
Disable compromised account  
↓  
Check other systems  
↓  
Preserve logs  
↓  
Remove malware  
↓  
Restore clean backup  
↓  
Change credentials



## 28. Basic Risk Mitigation Table

| Finding | Risk | Mitigation |
|---|---|---|
| Firewall enabled | Low | Keep enabled and review rules |
| Defender enabled | Low | Keep updated |
| RDP disabled | Low | Keep disabled if not needed |
| SMBv1 unknown | Needs Review | Verify with admin permissions |
| Port 445 listening | High Attention | Restrict with firewall |
| Port 139 listening | Needs Review | Allow only if needed |
| Port 135 listening | Needs Review | Restrict external access |
| Print Spooler | Needs Review | Disable if printing is not needed |
| Extra applications | Needs Review | Remove unnecessary software |
| Recent updates installed | Low | Continue patching |
| Flat network | High | Use VLAN segmentation |
| Weak authentication | High | Use MFA |
| Weak backup protection | High | Use offline or off-site backup |



## 29. Security Improvement Priorities

### 29.1 First Priority

- keep firewall enabled
- keep Defender enabled
- apply security updates
- review SMB access
- do not expose ports 135, 139 or 445 to the internet
- enable MFA
- verify backups

### 29.2 Second Priority

- create VLANs
- separate guest Wi-Fi
- remove unnecessary applications
- use standard user accounts
- enable disk encryption
- secure remote access

### 29.3 Third Priority

- improve logging
- deploy IDS or IPS
- perform vulnerability scans
- test backup recovery
- perform regular security reviews



## 30. Risk Mitigation Approach

The main idea of the hardening plan is to use more than one security control.

### 30.1 Phishing

- MFA
- Email Filtering
- User Training

### 30.2 Ransomware

- Endpoint Protection
- Network Segmentation
- Patching
- Protected Backups

### 30.3 Network Attacks

- Firewall
- IDS / IPS
- Closed Unnecessary Ports
- Logging

This means that if one control fails, another control may still reduce the damage.



## 31. What I Learned

This project helped me understand that network hardening is not only about installing one security product.

Different controls work together.

For example, a firewall can block unwanted traffic, but endpoint protection is still needed.

Network segmentation can reduce how far malware can spread.

Backups are also important because prevention is not always enough.

I also learned that an open port does not always mean there is a vulnerability.

It is important to check:

- which service is using the port
- whether the service is required
- whether it is exposed externally
- whether a firewall is protecting it

The PowerShell scripts helped me understand this better because I could see real listening ports and processes on my own Windows system.

I also saw that some checks require administrator permissions.

For example, I could not verify the SMBv1 configuration with my current permissions.

Instead of guessing the result, I marked it as unknown and included it as something that should be checked later.



## 32. Conclusion

The main goal of this hardening plan is to reduce unnecessary access and reduce the possible damage if a system is compromised.

For a small business, some of the most important controls are:

- firewall protection
- endpoint security
- patching
- MFA
- network segmentation
- secure remote access
- backups
- logging
- reducing unnecessary services

These controls are not very complicated by themselves, but using them together can improve the overall security of the network.

The practical PowerShell checks also helped me connect the theoretical security recommendations with real system settings.



## 33. Project Files

The project contains the following scripts:

- security_audit.ps1
- verify_security.ps1
- port_analysis.ps1
- hardening_recommendations.ps1
- risk_summary.ps1

The generated result files include:

- audit-results.txt
- verification-results.txt
- port-analysis.txt
- hardening-results.txt
- risk-summary.txt

These files show the checks I performed and the results used in this report.



## 34. AI Usage Note

I used AI tools for some brainstorming, code suggestions and wording ideas, and also some grammar help while preparing this project.

I reviewed the scripts myself, ran them on my own Windows system and used the actual output from my tests in the final project.

I also changed some of the explanations based on what I understood from the results instead of using the suggestions directly.
