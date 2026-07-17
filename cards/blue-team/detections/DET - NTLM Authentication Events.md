---
tags:
date-created: 2026-03-22
note_category: active-directory
type: DET
mitre_technique:
  - T1550.002
mitre_tactic:
dg-publish: true
---
~ [[Active Directory Security Monitoring]]
### DET - NTLM Authentication Events
---
> [!warning] MITRE Mapping Note
> Mapped to T1550.002 (Pass the Hash) as the closest technique. This detection covers general NTLM authentication monitoring and applies broadly across NTLM abuse scenarios including lateral movement and credential reuse. Use as a starting point, not a strict mapping.


It is used when Kerberos authentication is not available. This happens when accessing resources by IP address, when the target system cannot be found in DNS, or during authentication to non-domain systems.


1. User authenticates to a file server.
2. Server asks DC to validate NTLM credentials producing **Event ID 4776**
3. DC sends validation result to server whether to allow or not.
4. Assuming correct, session is created on **TARGET server** producing **Event ID 4624** logged at the target server.

Event 4776 appears on the Domain Controller when NTLM credentials are validated. Common scenarios include:

- Accessing file shares by IP address ( `\\10.0.1.50\Shared`)
- Legacy applications that don't support Kerberos
- Authentication across untrusted domains

**View authentication attempts in DC:**

```C
index=* EventCode=4776
| table _time, Logon_Account, Source_Workstation
```

This shows us:

- Which account was authenticated ( `Logon_Account`),
- From which machine ( `Source_Workstation`).

**View logs on the target server:**

```C
index=* EventCode=4624 Account_Name=michelle.smith Authentication_Package=NTLM
| table _time host user Workstation_Name Source_Network_Address Authentication_Package
```

- This query of course assumes we have a target user.
- **HIGH volume of NTLM authentication or Event 4776:** indicates misconfigured systems, legacy applications, or server accessing resources by IP instead of hostname.
	- Some of this requires immediate attention while some are 'risk accepted' type of shit.

