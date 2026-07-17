---
dg-publish: true
date-created: 2026-03-22
mitre_technique:
  - T1078
---
~ [[Active Directory Security Monitoring]]
### DET - Logon Events
---
> [!warning] MITRE Mapping Note
> Mapped to T1078 (Valid Accounts) as the closest technique. Logon events are the detection surface for dozens of techniques across multiple tactics. This mapping reflects the most common abuse pattern but should not be treated as exhaustive.

Captures interactive logins at a workstation, network connections to file shares, RDP sessions, and service accounts starting background processes.

**Understanding Logon Types**

The The `LogonType` field tells us what kind of activity generated the logon event. For example:

- A Type 2 means someone sat down at a keyboard.
- A Type 3 means they accessed a file share remotely.
- A Type 4 Scheduled tasks running under a user account
- A Type 5 Windows services starting under a service account
- A Type 7 User unlocking a previously locked workstation
- A Type 10 RDP session

**View logon types in your environment:**

```C
index=* EventCode=4624
| stats count by Logon_Type
| sort -count
```

In most environments, Type 3 (network) will dominate because file share access and remote administration generate large volumes. Type 2 and Type 10 represent actual user sessions and should be of lower volume.
