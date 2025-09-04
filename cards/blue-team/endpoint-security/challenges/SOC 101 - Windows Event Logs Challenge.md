---
tags:
date-created: 2025-01-27
dg-publish: true
---
[[Endpoint Security]] | ~ [[blue-team]]

> What is the **hostname** of the computer that generated the logs in the `challenge.evtx` file?

DESKTOP-1M5L0T9 

> What is the **Process ID (PID)** of the execution process that cleared the security event log?

![[SOC 101 - Windows Event Logs Challenge-2.png]]

> Which user account was added to the **Backup Operators** group?

note: There may be cases where the system can't resolve the **MemberName** field. However, you can still **correlate** a user account's unique Security Identifier (SID) from the user creation event.

sysadmin since in the account creation:

![[SOC 101 - Windows Event Logs Challenge.png]]
Then here:

![[SOC 101 - Windows Event Logs Challenge-1.png]]


