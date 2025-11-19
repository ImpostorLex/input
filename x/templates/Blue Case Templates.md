---
title: INC | 20251101 – Volt Typhoon – Blue IR Challenge
audience: blue
tags:
created: 2025-11-01
date-created:
dg-publish:
aliases:
---
~ [[]] % link to mitre % (If possible)
## Summary  
- **What happened / Goal:** Brief summary of what the scenario was and what you aimed to do.  
- **What we found:** Key artifacts, behaviors, or anomalies discovered during the investigation.

## Timeline & Findings  
Record what you did step-by-step, include tools / commands, and note what you observed / artifact for each:  

1. Ran `wmic process list` on target  
   - **Artifact:** saw `wmiprvse.exe` as a running process  
   - **Technique observed:** [[TECH – T1047 / WMI Lateral Movement]]  
2. Queried Event Logs for Process Create (Sysmon)  
   - **Artifact:** EventID 1 showing `wmiprvse.exe` → `cmd.exe`  
   - **Technique observed:** [[TECH – T1047 / WMI Lateral Movement]]  
3. Dumped memory with `procdump`  
   - **Artifact:** extracted command-line strings, parent PID  
4. Checked WinRM / CIM session info  
   - **Artifact:** session user `DOMAIN\ADMIN`, remote host `Host01`

## Detection / Mitigation Insights  
- Detection logic that caught or could catch these behaviors  
- Preventative measures or policies to reduce risk  
- Ideas to tune alerts or monitoring to reduce noise or false positives  

## Technique Mapping  
- **T1047 – WMI Lateral Movement** → observed in process creation via WMI.  
- *(Add other techniques you observed here)*  
