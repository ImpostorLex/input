---
aliases:
tags:
dg-publish: true
date: 2026-03-14
mitre_technique:
mitre_tactic:
  - defense-evasion
type: PARENT
---
~ [[MITRE map]] | [[Active Directory]]
### Summary
---
**What you will find:** A structured detection reference for Active Directory monitoring — covering authentication events, account lifecycle changes, group modifications, GPO tampering, logon analysis, and baseline techniques for identifying anomalous behavior in high-volume AD environments.

**Primary purpose:** Equip defenders with the event IDs, Splunk queries, and analytical patterns needed to distinguish legitimate AD activity from attacker behavior.

**Key Topics:**
- Kerberos and NTLM authentication event flow (4768, 4769, 4776, 4624)
- Account and group lifecycle monitoring (4720, 4728, 4732, 4740)
- Directory Service and GPO modification detection (5136)
- Logon type analysis and what each type signals
- Baseline building and long tail analysis techniques
- Audit policy gaps and critical logging requirements
#### Why AD?
---
Active Directory is the backbone of most enterprise networks, it generates thousands of legitimate events per hour, such as authentication requests, group changes, service tickets, and failed logins. It is very important to be able to identify legitimate traffic to false one.

## Authentication Events
---
Every time attackers attempts to access domain resources, they must authenticate, the events includes:

- Who requested access,
- When,
- From where,
- And whether they succeeded.

Key concepts:

- **Domain User:** Credential database stored in AD database called `NTDS.dit` every events appear in DC.
- **Local User:** Credential database stored on that specific machine called `SAM`.

**Note:** delete me right after - [retrieve the sample log images of the mentioned event here](https://tryhackme.com/room/monitoringactivedirectory?taskNo=3&sharerId=62c289c115190d00484e6ec6) and add to Kerberos note too.

- [[Kerberos]]

## Knowledge Base
---
### Core Techniques
---

- [[DET - Kerberos Authentication Events]]
- [[DET - NTLM Authentication Events]]
- [[DET - Account Lifecycle Events]]
- [[DET - Group Membership Events]]
- [[DET - Directory Service Events and GPO Modifications]]
- [[DET - Logon Events]]
- [[DET - Baseline & Long Tail Analysis]]

> One of the frustrating things about Windows logging is that many useful events aren't logged by default. Critical categories, such as **DS Access** and **detailed Kerberos logging**, are turned off by default. If our audit policies aren't configured correctly, we'll have gaps in our visibility, and some of the events we just covered simply won't appear.


Refer to steps shown to enable critical logging [here](https://tryhackme.com/room/monitoringactivedirectory?taskNo=6&sharerId=62c289c115190d00484e6ec6).

