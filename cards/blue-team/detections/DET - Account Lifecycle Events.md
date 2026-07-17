---
dg-publish: true
date-created: 2026-03-22
aliases:
mitre_tactic:
mitre_technique:
  - T1136.001
---
~ [[Active Directory Security Monitoring]]
### DET - Account Lifecycle Events

Every user account in Active Directory goes through a lifecycle:

- Account creation, (4720, 4722 when account enabled, 4725 account disabled)
- Password resets, (4724)
- Occasional lockouts, (4740)
- And eventually, deactivation when someone leaves. (4725)

**Accounts created:**

```C
index=* EventCode=4720
| table _time, SAM_Account_Name, Subject_Account_Name
```

- `SAM_Account_Name` account created
- `Subject_Account_Name` the admin account who created it.
- Context is very important here: 

	- Created by unexpected admin account?
	- Suspicious admin/user account.
	- Unusual creation time.
