# Small Business Network Hardening

This project is a small network security hardening exercise for a hypothetical small business.

I used PowerShell to check some basic security settings on my Windows system and then created recommendations based on the results.

The project includes:

- Windows Firewall verification
- Microsoft Defender status check
- Remote Desktop check
- SMBv1 check
- Listening port analysis
- Process identification
- Basic risk summary
- Hardening recommendations

## Files

### scripts/

`security_audit.ps1`  
Collects basic system and security information.

`verify_security.ps1`  
Checks important security settings and shows PASS, INFO, REVIEW or UNKNOWN results.

`port_analysis.ps1`  
Finds listening TCP ports and the processes using them.

`risk_summary.ps1`  
Creates a simple summary of the main risks I found.

`hardening_recommendations.ps1`  
Lists security improvements that could be applied in a small business environment.

## Main Findings

During my testing I found that:

- Windows Firewall was enabled
- Microsoft Defender real-time protection was enabled
- Remote Desktop was disabled
- SMBv1 could not be verified without administrator permission
- Ports 135, 139 and 445 were listening
- Some applications such as Spotify, VS Code and OneDrive were also using local ports
- Recent Windows updates were installed

Not every open port means there is a vulnerability. I used the results to identify which services should be reviewed and which ones are normal system services.

## Security Recommendations

Some of the main recommendations are:

- Keep Windows Firewall enabled
- Keep Microsoft Defender updated
- Disable unnecessary services
- Do not expose SMB directly to the internet
- Review listening ports regularly
- Use network segmentation in a real business network
- Enable MFA for important accounts
- Keep regular backups
- Use least privilege
- Monitor security logs

## Note

I used AI tools for some brainstorming and wording suggestions while working on this project. I reviewed the scripts myself, tested them on my own Windows system, and used the actual results from my security checks in the final project.