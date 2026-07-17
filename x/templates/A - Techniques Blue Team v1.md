---
aliases:
  - DETECT | Endpoint -  Windows Suspicious PowerShell Parent
date-created:
dg-publish:
tags:
  - template
mitre_tactic: TA0008
mitre_technique: T1021
type: DET
---
~ [[map]]
## Summary
---
**What it is:** One-line definition of the detection or defensive concept.  
**Scope:** What this note covers (and optionally what it does *not*).  
**Key Topics:** Links to prerequisite concepts, detection fundamentals, or related techniques.  
**Status:** 🟡 Draft | 🟢 Validated | 🔵 Needs Review

> [!warning]- TECHNIQUEs available
> ```dataview
> LIST file.link
FROM ""
WHERE type = "TECH"
AND mitre_technique = this.mitre_technique
AND file.name != this.file.name
AND (!file.tags OR !contains(file.tags, "template"))
> ```
## How it works (2–4 lines)
---
Explain what happens technically (protocol/process), why it’s used legitimately, and how attackers repurpose it. Keep short and neutral — this sets context for your detection logic.
## Investigation Workflow
---
### Initial Alert

- What triggered the alert?
- What telemetry generated it?
- What ATT&CK technique does it map to?

### Investigation Questions

> Follow the SOC Investigation Framework.

My follow thingy needs to be linked add this as todo. It's important to **link** these only as the prize possesion is the "Technique-specific questions".
#### Technique-Specific Questions
- Add attack-specific investigation questions here.
### Evidence Collection
- Windows Event Logs
- Sysmon
- Wazuh Alerts
- Process Tree
- Network Connections
- Registry
- File System
### Detection Validation
- Did the expected telemetry appear?
- Did the detection fire?
- False positives?
- False negatives?
### Detection Improvements
- Rule tuning ideas
- Additional telemetry
- Correlation opportunities
## Investigation Artifacts
---
## Investigation Artifacts
---
### Expected Telemetry
### Observed in Lab
### Evidence Collected
### Confidence

🟢 Verified in Lab

🟡 Expected (Documentation)

🔴 Unknown / Needs Testing
## Response & Containment
---

- **Immediate:** isolate affected host, collect volatile data, preserve logs.  
- **Analysis:** verify scope, identify user accounts or lateral movement path.  
- **Remediation:** credential resets, patching, policy update.  
- **Recovery:** confirm no persistence mechanisms remain.

## Investigation Outcome
---
### Root Cause

### Detection Verdict

- ☐ True Positive
- ☐ False Positive
- ☐ Benign Activity
- ☐ Needs More Investigation
### Detection Gap
### Recommended Improvements

## Detection Tuning
---
- Known False Positives
- Known False Negatives 
- Required Data Sources 
- Rule Improvements 
- Testing Notes 

## Lessons Learned
---


