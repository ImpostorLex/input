---
dg-publish: true
date-created: 2026-03-22
mitre_technique:
  - T1484.001
---
~ [[Active Directory Security Monitoring]]
### DET - Directory Service Events and GPO Modifications

**Event 5136** shows the specific LDAP attribute that changed and its new value:

- `userAccountControl` - Account status changes (disabled, password never expires, etc.)
- `servicePrincipalName` - SPN modifications refers to changes made for a service such as web server or database.
- `scriptPath` - Logon script path (scripts that run when users log in)
- `member` - Group membership modifications at the attribute level i.e adding or removing a user from groups affecting access and permission.
- `displayName`, `description`, `title` - User information fields

When filtering for this event:

- Subject is usually the user or admin performing the action.
- Object is the affected user.
- Attribute well try and guess it. (no, srsly.)

**Tracking GPO modifications:**

A group policy object allows administrator to manage configuration across the domain centrally. This is why attackers target them.

```C
index=* EventCode=5136 Class="groupPolicyContainer"
| table _time, Subject_Account_Name, DN, LDAP_Display_Name, Value
| sort - _time
```

- Who modified ( `Subject_Account_Name`),
- Which GPO was affected (`DN`),
- And what changed (`LDAP_Display_Name` and `Value`).
    - `gPCFileSysPath`, which shows the `SYSVOL` for the group policy being configured.
    - `versionNumber` attribute (indicates modification count)

The `displayName` and `DN` fields help us identify which GPO was touched, and `Subject_Account_Name` shows who made the change. But this event won't show you the **actual policy setting** (such as password length must be 14 from 10 characters) that has been modified instead it will show the GPO's version number updated or incremented.
