---
aliases:
  - "TECH - T1087.002 - Account Discovery: Domain Account"
date-created: 2026-03-09
dg-publish: true
tags:
mitre_tactic:
  - discovery
mitre_technique: T1087.002
type: TECH
---
~ [[Enumerating Active Directory (Authenticated Enumeration)]]
## Summary
---
**What it is:** Using Windows built-in net.exe commands to enumerate Active Directory users, groups, and password policies from domain-joined machines, leveraging native Windows networking tools that require no additional software and are often not monitored by security teams.

**Scope:** This note covers enumerating AD users with net user, enumerating AD groups with net group, discovering group memberships, extracting domain password policies with net accounts, and understanding the benefits and limitations of net commands for post-breach enumeration.

**Prerequisites:**

- [[Active Directory]]
- [[Enumerating Active Directory (Authenticated Enumeration)]]
- [[Domain Password Policies]]
- Domain-joined Windows machine OR
- Injected domain credentials via runas (see [[Credential Injection via Runas|TECH - T1078.002 - Active Directory Credential Injection via Runas]])
- Command prompt access

**Risks & Limitations:**

- Net commands must be executed from domain-joined machine
- If machine is not domain-joined, commands default to WORKGROUP domain
- Net commands may not show all information (e.g., > 10 group memberships)
- User enumeration can be slow on large domains
- Group membership limited to direct memberships (no nested group visibility)
- Requires valid domain credentials
- Commands generate Event ID 4688 (process creation) if auditing enabled

## How It Works (2-4 lines)
---
The net.exe command is a Windows built-in networking utility that provides functionality for managing local systems and Active Directory domains through simple command-line operations. Administrators rely on net commands for quick user and group lookups, password policy verification, and basic AD management tasks during troubleshooting and system administration. Attackers leverage net commands for post-breach enumeration because they require no additional tools, generate minimal suspicion as legitimate admin utilities, are supported natively in VBScript and macro languages used in phishing payloads, and can enumerate users, groups, group memberships, and password policies to identify targets for privilege escalation, lateral movement, and password spraying attacks. Defenders often overlook net command usage since it blends with normal administrative activity, though process creation logs (Event ID 4688) can reveal enumeration patterns when correlated.

## Steps (Hands-On)
---

**Legend:**

- `{DOMAIN}` = za.tryhackme.com
- `{USERNAME}` = zoe.marshall
- `{GROUP_NAME}` = Tier 1 Admins
- `{DOMAIN_JOINED}` = Yes/No (affects command behavior)

**Context:** You have obtained AD credentials and need to enumerate domain structure, users, groups, and password policies using built-in Windows commands. You may be on a domain-joined machine or using injected credentials via runas.
### 1. Enumerate All Domain Users
---
**Action:**

- List all users in the AD domain:
```C
net user /domain
```

**Observable:**

- `cmd.exe` process execution
- `net.exe` child process spawned
- Event ID 4688 (Process creation):
  - Process: `net.exe`
  - CommandLine: `net user /domain`
- LDAP query to Domain Controller on port 389/636
- Event ID 4662 (Operation performed on AD object) on DC if detailed auditing enabled
- Output displays list of all domain user accounts
- Output format:
```
  User accounts for \\DC-NAME
  
  -------------------------------------------------------------------------------
  Administrator            Guest                    user1
  user2                    user3                    zoe.marshall
  [...]
  The command completed successfully.
```

![[Enumerating Active Directory-2.jpg|500]]

**Why This Is Useful:**

- Determine size of domain (user count)
- Identify naming conventions
- Discover service accounts
- Find potential targets for attacks

---

### 2. Enumerate Specific User Account Details

**Action:**

- Query detailed information about specific user:
```C
net user zoe.marshall /domain
```

**Observable:**

- `net.exe` process execution
- LDAP query to DC for specific user object
- Event ID 4688 (Process creation)
- Event ID 4662 (Operation performed on AD object) on DC
- Output displays user account details:
  - User name
  - Full Name
  - Comment
  - Account active status
  - Account expires
  - Password last set
  - Password expires
  - Password changeable
  - **Group memberships (limited to ~10 groups)**
  - Logon script
  - Profile path
  - Home directory
  - Last logon

![[Enumerating Active Directory-1.jpg|450]]

**Note:** If user is part of more than ten AD groups, command will fail to list them all. Use PowerShell or other tools for complete group membership enumeration.

**Validation:**

- Identify privileged users
- Check password change dates
- Verify account status (active/disabled)
- Review group memberships for privilege assessment

---
### 3. Enumerate All Domain Groups

**Action:**

- List all groups in the AD domain:
```C
net group /domain
```

**Observable:**

- `net.exe` process execution
- LDAP query to DC for group objects
- Event ID 4688 (Process creation)
- Event ID 4662 (Operation performed on AD object) on DC
- Output displays list of all domain groups:
```C
  Group Accounts for \\DC-NAME
  
  -------------------------------------------------------------------------------
  *Cloneable Domain Controllers
  *DnsUpdateProxy
  *Domain Admins
  *Domain Computers
  *Domain Controllers
  *Domain Guests
  *Domain Users
  *Enterprise Admins
  *Group Policy Creator Owners
  *Protected Users
  *Read-only Domain Controllers
  *Schema Admins
  *Tier 1 Admins
  *Tier 2 Admins
  [...]
  The command completed successfully.
```

![[Enumerating Active Directory.jpg|500]]

**Why This Is Useful:**

- Identify privileged groups (Domain Admins, Enterprise Admins)
- Discover custom administrative groups
- Understand organizational structure
- Map tiering model (Tier 0, Tier 1, Tier 2)

---
### 4. Enumerate Group Membership

**Action:**

- Query members of specific group:
```C
net group "Tier 1 Admins" /domain
```

**Observable:**

- `net.exe` process execution
- LDAP query to DC for group membership
- Event ID 4688 (Process creation)
- Event ID 4662 (Operation performed on AD object) on DC
- Output displays group details and members:
```C
  The request will be processed at a domain controller for domain za.tryhackme.com
  
  Group name     Tier 1 Admins
  Comment
  
  Members
  
  -------------------------------------------------------------------------------
  t1_arthur.tyler          t1_gary.moss             t1_henry.miller
  t1_jill.wallis           t1_joel.stephenson       t1_marian.yates
  t1_rosie.bryant
  The command completed successfully.
```

**Why This Is Useful:**

- Identify members of privileged groups
- Target accounts for credential theft
- Map user-to-privilege relationships
- Plan lateral movement paths

---
### 5. Enumerate Domain Password Policy

**Action:**

- Query domain password policy settings:
```C
net accounts /domain
```

**Observable:**

- `net.exe` process execution
- LDAP query to DC for domain policy
- Event ID 4688 (Process creation)
- Event ID 4662 (Operation performed on AD object) on DC
- Output displays password policy:
```C
  The request will be processed at a domain controller for domain za.tryhackme.com
  
  Force user logoff how long after time expires?:       Never
  Minimum password age (days):                          0
  Maximum password age (days):                          Unlimited
  Minimum password length:                              0
  Length of password history maintained:                None
  Lockout threshold:                                    Never
  Lockout duration (minutes):                           30
  Lockout observation window (minutes):                 30
  Computer role:                                        PRIMARY
  The command completed successfully.
```

**Why This Is Critical for Password Spraying:**

**Lockout threshold:**
- Shows how many failed attempts before account locks
- "Never" = no lockout (ideal for spraying)
- Number value = must stay below threshold

**Lockout observation window:**
- Time period for counting failed attempts
- 30 minutes = failed attempts reset after 30 min
- Plan spray timing to avoid lockout

**Minimum password length:**
- Informs password selection for spraying
- 0 = very weak policy, simple passwords possible
- Higher number = need more complex passwords

**Password complexity requirements:**
- Not shown in net accounts output
- Must verify separately
- Affects password spray wordlist selection

**Important Note:**

Blind password spraying can cause account lockouts since you don't know how many recent failed attempts the target already has. Use this information to tune attack timing and attempt limits.

## Blue - Detection & Response
---
**Indicators of Compromise:**

- Event ID 4688 (Process creation) - net.exe with `/domain` parameter
- Multiple sequential net.exe executions (net user, net group, net accounts)
- LDAP queries from workstations not typically performing AD enumeration
- Event ID 4662 (Operation performed on AD object) on DC - user and group object enumeration
- Net.exe executed from non-administrative user accounts
- Pattern of net user /domain followed by net group /domain followed by net accounts /domain
- Net.exe launched from recently compromised accounts
- Enumeration during non-business hours
- Net commands executed from command prompt spawned by suspicious parent processes (e.g., powershell.exe, wscript.exe, mshta.exe)
- High volume of net.exe process creations in short timeframe
- Net commands with /domain parameter from non-domain-joined machines (requires injected credentials)
- Correlation with runas.exe usage followed by net.exe commands

## Related Detection
---

- [[Credential Injection Detection|DET - T1078.002 - Active Directory Credential Injection Detection]]
- [[PowerShell AD Enumeration Detection|DET - T1087.002 - Active Directory PowerShell Enumeration Detection]]