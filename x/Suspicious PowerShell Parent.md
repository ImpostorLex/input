---
aliases:
  - DETECT - Endpoint Windows Suspicious PowerShell Parent
---
~ [[A - Techniques Blue Team v1]]
## Summary
---
**What you will find:** Detection logic for PowerShell processes launched by unexpected parents — a key sign of fileless or lateral-movement activity.  
**Go next:** [[cards/blue/Execution Checklist]] · [[INC | 20251105 - Lab]]
## How it works
---
PowerShell is a trusted Windows management shell. Attackers abuse it by spawning scripts from non-interactive contexts (e.g., service executables or WMI) to execute malicious code without files.

## Detection Workflow
---
1. **Source:** Sysmon EventID 1 (Process Create) and Security 4688.  
2. **Behavior:** parent process not in known list (`explorer.exe`, `cmd.exe`).  
3. **Pseudo query:**  

```C
where process == "powershell.exe"
and parent_process not in ("explorer.exe","cmd.exe")
```

4. **Validation:** test against software deployment tools and legitimate scripts.

## Observables & Indicators
---

- **EventIDs:** Sysmon 1, Security 4688  
- **Parent process:** `svchost.exe`, `wmiprvse.exe`, `winword.exe` (unexpected)  
- **Command line:** Base64-encoded content or network I/O flags  
- **Network:** outbound HTTP(S) or SMB connections post execution  

## Response & Containment
---

- **Immediate:** isolate host, collect process tree, export relevant event logs.  
- **Analysis:** trace parent process, check command line & user context.  
- **Remediation:** review scripts executed, rotate credentials, assess persistence.  
- **Recovery:** update PowerShell execution policies or AMSI rules.

## Notes / Tuning
- Patch management systems often spawn PowerShell — whitelist known paths.  
- AMSI logs or Defender events complement Sysmon visibility.

