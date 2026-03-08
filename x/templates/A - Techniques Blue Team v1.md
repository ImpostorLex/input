---
aliases:
  - DETECT | Endpoint -  Windows Suspicious PowerShell Parent
date-created:
dg-publish:
tags:
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

## How it works (2–4 lines)
---
Explain what happens technically (protocol/process), why it’s used legitimately, and how attackers repurpose it. Keep short and neutral — this sets context for your detection logic.
## Detection Workflow
---

1. **Identify telemetry sources:** event logs, Sysmon, EDR, network, etc.  
2. **Define key behaviors:** process names, parent relationships, command line patterns.  
3. **Write detection logic / pseudo-query:**  pseudo code or logic line, tool-agnostic
4. **Validate detection:** test against legitimate admin actions; adjust allowlists.

## Observables & Indicators
---
- **EventIDs / Artifacts:** list relevant ones (e.g., Sysmon 1, 4688, 7045).  
- **Processes / Parents:** `wmiprvse.exe`, `powershell.exe`, etc.  
- **Network:** ports, destination types, service names.  
- **Filesystem / Registry:** dropped binaries, service creation paths.

## Response & Containment
---

- **Immediate:** isolate affected host, collect volatile data, preserve logs.  
- **Analysis:** verify scope, identify user accounts or lateral movement path.  
- **Remediation:** credential resets, patching, policy update.  
- **Recovery:** confirm no persistence mechanisms remain.

## Notes / Tuning
---
- Legitimate management tools that may trigger false positives.  
- Data sources required for effective coverage.  
- Example filters to reduce noise.
