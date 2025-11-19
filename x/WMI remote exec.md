---
aliases:
  - TECH - T1047 - WMI - Remote Process Creation
dg-publish: false
date-created:
---
~ [[A - Techniques  Red Team v1]]
## Summary
---
**What / Who / Why:** WMI remote process creation — red team lab workflow and defender observables; open this to practice lateral movement or to validate detections.  
**Go next:** [[cards/red/LM - WMI Checklist]] · [[INC | 20251015 - THM Lab]]

## How it works (2–3 lines)
---
WMI/CIM exposes classes (e.g., `Win32_Process`) accessible via DCOM (RPC) or WinRM. Admin tooling uses these APIs for legitimate management; attackers reuse them to run commands without obvious file drops.

## Steps (red — hands on)
---

1. **Obtain creds / context:** `{CRED_PLACEHOLDER}`  
   **Observable:** auth events from source host (Kerberos/NTLM).  
   **Collect:** auth logs, client IP.

2. **Create remote session:** `{SESSION_PLACEHOLDER}`  
   **Observable:** network connect to 135 / ephemeral RPC ports or 5985/5986.  
   **Collect:** network flow, session origin host.

3. **Invoke Win32_Process.Create to run payload:** `{COMMAND_PLACEHOLDER}`  
   **Observable:** Sysmon EventID 1 on target; parent process may be `wmiprvse.exe`.  
   **Collect:** process tree, command line, timestamps.

## Blue — Detection & Response
---

- **Top indicators:** Sysmon EventID 1 with suspicious parents; service/task creation EventIDs; WinRM/DCOM connections from non-management hosts.  
- **Detection ideas:** correlate ProcessCreate events with initiating host and user; alert when `Win32_Product`/`Win32_Service` calls originate from endpoints not in management inventory.  
- **Immediate response:** isolate target, collect Sysmon/event logs and memory snapshot, identify account used and rotate credentials.

## Notes / Caveats
---

- Legit management platforms will generate similar telemetry — maintain allowlists for known management servers.