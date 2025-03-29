---
tags:
  - sunday
  - github
  - template
aliases: 
date-created: 
dg-publish:
---
[[Placeholder]]
**Reminder to upload the said analysis on github with their respective files, you may delete this if you want to.**
### Summary
---
### Initials
---
- **Atomic Red Team ID**: T1059.003 - User Execution
- **Description**: 
- **Challenges Encountered & Solution*:
	- It requires installing some dependencies.
	- Requires Windows 8 to work.
## Analysis
---
- Screenshots or code snippets
- Wazuh alerts generated with default configurations.
- False positive/negative analysis

### WAZUH. rule creation
---
- **Rule ID and description**: 
- **Rule logic (conditions, actions)**
- **Effectiveness of detection**
- Make sure to put appropriate severity level for the next optional step.

### Example Wazuh Rule Documentation

```
Rule ID: suspicious_process_creation
Description: Detects process creation with suspicious command-line arguments
Logic: Checks for process creation with specific keywords in command-line (e.g., powerhell, cmd, wscript)
Expected Detections: Malicious script execution, command-line tools abuse
```

## Incident Response
---
- **Incident identification criteria**
- **Investigation steps** 
- **Containment actions**
- **Eradication procedures**
- **Recovery steps**

