---
mitre_technique: T1087.002
mitre_tactic:
  - discovery
note_category: active-directory
dg-publish: true
date-created: 2026-03-09
aliases:
  - PowerShell AD-RSAT Enumeration
tags:
type: TECH
---
~ [[Enumerating Active Directory (Authenticated Enumeration)]]
## Summary
---
**What it is:** Using PowerShell Active Directory Remote Server Administration Tools (AD-RSAT) cmdlets to perform advanced AD enumeration including user queries with filtering, group membership discovery, AD object searches, domain information retrieval, and object modification, providing over 50 specialized cmdlets for comprehensive domain reconnaissance.

**Scope:** This note covers installing AD-RSAT PowerShell module, enumerating users with Get-ADUser and filtering capabilities, discovering groups with Get-ADGroup, querying group memberships with Get-ADGroupMember, searching AD objects with Get-ADObject for modified objects and bad password counts, retrieving domain details with Get-ADDomain, and understanding alteration capabilities like Set-ADAccountPassword.

**Prerequisites:**

- [[Active Directory]]
- [[Enumerating Active Directory (Authenticated Enumeration)]]
- [[PowerShell]]
- [[Active Directory Remote Server Administration Tools]]
- Windows machine with PowerShell
- AD-RSAT PowerShell module installed
- Valid AD credentials
- Non-domain-joined machines require `-Server` parameter pointing to DC

**Risks & Limitations:**

- Requires AD-RSAT module installation (may need admin privileges)
- More visibility than net commands (PowerShell script block logging)
- Generates detailed Event IDs if PowerShell logging enabled
- Non-domain-joined machines must specify `-Server` parameter for every cmdlet
- Object modification cmdlets require appropriate AD permissions
- PowerShell execution policy may restrict script execution
- Generates more comprehensive audit trails than basic net commands

## How It Works (2-4 lines)
---

PowerShell is Microsoft's task automation and configuration management framework with all standard Command Prompt functionality plus powerful cmdlets (pronounced "command-lets") that are .NET classes performing specific functions, allowing administrators to write custom cmdlets for specialized tasks. Installing AD-RSAT provides over 50 Active Directory-specific cmdlets enabling administrators to query users, groups, organizational units, domain policies, and AD objects with advanced filtering, sorting, and property selection capabilities. Attackers leverage PowerShell AD cmdlets for deep enumeration because they provide granular control over queries through filtering (Name, Description, Properties), can retrieve all object properties with `-Properties *`, support complex searches like finding recently modified objects or accounts with bad password attempts, and enable targeted enumeration for privilege escalation and attack planning. Defenders detect PowerShell AD enumeration through Event ID 4104 (PowerShell script block logging) capturing full cmdlet syntax, Event ID 4688 showing powershell.exe execution, LDAP query patterns to Domain Controllers, and correlation of multiple AD cmdlet executions indicating reconnaissance activity.

## Steps (Hands-On)
---

**Legend:**

- `{DOMAIN}` = za.tryhackme.com
- `{DC_IP}` = Domain Controller IP address
- `{USERNAME}` = gordon.stevens
- `{FILTER_PATTERN}` = *stevens (wildcard search)
- `{GROUP_NAME}` = Administrators
- `{CHANGE_DATE}` = 2022-02-28 12:00:00
- `{OLD_PASSWORD}` = old
- `{NEW_PASSWORD}` = new

**Context:** You have AD credentials and need to perform advanced enumeration using PowerShell AD-RSAT cmdlets. You may be on domain-joined or non-domain-joined machine.

---

### 1. Enumerate Specific AD User

**Action:**

- Query specific user account with all properties:
```PowerShell
Get-ADUser -Identity gordon.stevens -Server za.tryhackme.com -Properties *
```

**Parameters:**

- **-Identity** - Account name being enumerated
- **-Properties** - Which properties to display (`*` shows all properties)
- **-Server** - Domain controller to query (required for non-domain-joined machines)

**Observable:**

- `powershell.exe` process execution
- Event ID 4688 (Process creation) - powershell.exe
- Event ID 4104 (PowerShell script block logging) if enabled:
  - ScriptBlock text: `Get-ADUser -Identity gordon.stevens -Server za.tryhackme.com -Properties *`
- LDAP query to DC on port 389/636
- Event ID 4662 (Operation performed on AD object) on DC
- Comprehensive user object properties returned:
  - AccountExpirationDate
  - BadLogonCount
  - BadPwdCount
  - Created
  - Description
  - DisplayName
  - DistinguishedName
  - EmailAddress
  - Enabled
  - LastBadPasswordAttempt
  - LastLogonDate
  - LockedOut
  - MemberOf (all group memberships)
  - PasswordExpired
  - PasswordLastSet
  - PasswordNeverExpires
  - SamAccountName
  - ServicePrincipalNames
  - UserPrincipalName
  - And 100+ additional attributes

**Why `-Properties *` Matters:**

- Default query returns limited properties
- `-Properties *` reveals ALL user attributes
- Exposes sensitive information not visible in basic queries
- Shows complete group memberships (no 10-group limit like net user)

---

### 2. Filter Users with Wildcard Search

**Action:**

- Use `-Filter` parameter for flexible user searches:
```PowerShell
Get-ADUser -Filter 'Name -like "*stevens"' -Server za.tryhackme.com | Format-Table Name,SamAccountName -A
```

**Parameters:**

- **-Filter** - Query filter using PowerShell syntax
- **-like** - Wildcard matching operator
- **Format-Table** - Display results in table format
- **-A** - AutoSize parameter for table formatting

**Observable:**

- `powershell.exe` process execution
- Event ID 4104 (PowerShell script block logging)
- LDAP query with filter to DC
- Event ID 4662 (Operation performed on AD object)
- Output displays matching users:
```
  Name             SamAccountName
  ----             --------------
  chloe.stevens    chloe.stevens
  samantha.stevens samantha.stevens
```

**Why Filtering Is Powerful:**

- Find users matching patterns without knowing exact names
- Search by partial names, descriptions, departments
- Combine multiple filter conditions
- More control than `net user` enumeration

---

### 3. Enumerate AD Group

**Action:**

- Query specific AD group:
```PowerShell
Get-ADGroup -Identity Administrators -Server za.tryhackme.com
```

**Observable:**

- `powershell.exe` process execution
- Event ID 4104 (PowerShell script block logging)
- LDAP query to DC for group object
- Event ID 4662 (Operation performed on AD object) on DC
- Output displays group properties:
  - DistinguishedName
  - GroupCategory (Security or Distribution)
  - GroupScope (DomainLocal, Global, Universal)
  - Name
  - ObjectClass
  - ObjectGUID
  - SamAccountName
  - SID

**Note:** Add `-Properties *` to see all group attributes including Description, ManagedBy, Members count, etc.

---

### 4. Enumerate Group Membership

**Action:**

- Query members of specific group:
```PowerShell
Get-ADGroupMember -Identity Administrators -Server za.tryhackme.com
```

**Observable:**

- `powershell.exe` process execution
- Event ID 4104 (PowerShell script block logging)
- LDAP query to DC for group membership
- Event ID 4662 (Operation performed on AD object) on DC
- Output displays group members:
  - distinguishedName
  - name
  - objectClass (user, group, computer)
  - objectGUID
  - SamAccountName
  - SID

**Why This Is Critical:**

- Returns ALL group members (no limit like net group)
- Shows nested group memberships
- Identifies user, computer, and group objects in group
- Reveals complete membership hierarchy

---

### 5. Search for Recently Modified AD Objects

**Action:**

- Find AD objects modified after specific date:
```PowerShell
$ChangeDate = New-Object DateTime(2022, 02, 28, 12, 00, 00)
```
```PowerShell
Get-ADObject -Filter 'whenChanged -gt $ChangeDate' -includeDeletedObjects -Server za.tryhackme.com
```

**Parameters:**

- **$ChangeDate** - Variable holding DateTime object
- **-Filter** - Query for objects where `whenChanged` attribute greater than date
- **-includeDeletedObjects** - Include objects in AD recycle bin
- **-gt** - Greater than operator

**Observable:**

- `powershell.exe` process execution
- Event ID 4104 (PowerShell script block logging) - full cmdlet syntax
- Variable creation (`$ChangeDate`)
- LDAP query with whenChanged filter to DC
- Event ID 4662 (Operation performed on AD object) on DC
- Output shows recently modified objects:
  - New user accounts
  - Modified group memberships
  - Changed permissions
  - Updated computer objects
  - Deleted objects (if -includeDeletedObjects used)

**Why This Is Useful:**

- Identify recent AD changes
- Discover newly created accounts
- Track administrative activity
- Find persistence mechanisms
- Detect recent privilege escalations

---

### 6. Find Accounts with Bad Password Attempts

**Action:**

- Query accounts with failed logon attempts:
```PowerShell
Get-ADObject -Filter 'badPwdCount -gt 0' -Server za.tryhackme.com
```

**Parameters:**

- **badPwdCount** - Attribute tracking failed password attempts
- **-gt 0** - Greater than zero (any failed attempts)

**Observable:**

- `powershell.exe` process execution
- Event ID 4104 (PowerShell script block logging)
- LDAP query filtering by badPwdCount attribute
- Event ID 4662 (Operation performed on AD object) on DC
- Output shows accounts with failed logon attempts:
  - Account names
  - badPwdCount value (number of failed attempts)
  - Distinguished names

**Why This Is Critical for Password Spraying:**

- Identify accounts close to lockout threshold
- Avoid spraying accounts with existing bad attempts
- Target accounts with zero failed attempts
- Reduce risk of account lockouts during attack
- Plan password spray timing based on current state

**Attack Planning:**

If domain policy shows lockout threshold of 5 attempts:
- Accounts with badPwdCount = 0 → Safe to attempt
- Accounts with badPwdCount = 3-4 → High risk, avoid
- Accounts with badPwdCount = 5+ → Already locked, skip

---

### 7. Retrieve Domain Information

**Action:**

- Query comprehensive domain details:
```PowerShell
Get-ADDomain -Server za.tryhackme.com
```

**Observable:**

- `powershell.exe` process execution
- Event ID 4104 (PowerShell script block logging)
- LDAP query to DC for domain object
- Event ID 4662 (Operation performed on AD object) on DC
- Output displays domain information:
  - DNSRoot (FQDN)
  - DomainMode (functional level)
  - DomainSID
  - Forest
  - InfrastructureMaster
  - Name (NetBIOS)
  - PDCEmulator (primary DC)
  - RIDMaster
  - DomainControllersContainer

**Why This Is Useful:**

- Understand domain structure
- Identify domain functional level
- Locate PDC Emulator (primary target)
- Map domain controllers
- Understand forest relationships

---

### 8. Force User Password Change (If Permissions Allow)

**Action:**

- Change user password using Set-ADAccountPassword:
```PowerShell
Set-ADAccountPassword -Identity gordon.stevens -Server za.tryhackme.com -OldPassword (ConvertTo-SecureString -AsPlaintext "old" -force) -NewPassword (ConvertTo-SecureString -AsPlainText "new" -Force)
```

**Parameters:**

- **-Identity** - User account to modify
- **-OldPassword** - Current password (converted to SecureString)
- **-NewPassword** - New password (converted to SecureString)
- **ConvertTo-SecureString** - Converts plaintext to encrypted SecureString
- **-AsPlaintext** - Indicates input is plaintext
- **-force** - Bypass confirmation prompts

**Observable:**

- `powershell.exe` process execution
- Event ID 4104 (PowerShell script block logging):
  - **Warning:** May log passwords in plaintext if script block logging enabled
- LDAP modify operation to DC
- Event ID 5136 (Directory Service object modified) on DC:
  - Object: User distinguished name
  - AttributeLDAPDisplayName: unicodePwd or pwdLastSet
  - Subject: Account performing password change
- Event ID 4724 (Attempt to reset account password) on DC
- Event ID 4723 (Attempt to change account password) if user changing own password
- Password change successful if permissions allow

**Why This Matters:**

- Demonstrates alteration capabilities beyond enumeration
- Requires appropriate AD permissions
- Useful for persistence (password change to known value)
- Locks legitimate user out of account
- Highly visible in AD audit logs

**Note:** The focus for this engagement is enumeration. Creating new objects or altering existing ones would be considered AD exploitation, not enumeration.

---

## Blue - Detection & Response
---

**Indicators of Compromise:**

- Event ID 4104 (PowerShell script block logging) - AD-RSAT cmdlets (Get-ADUser, Get-ADGroup, Get-ADGroupMember, Get-ADObject, Get-ADDomain)
- Event ID 4688 (Process creation) - powershell.exe execution
- Multiple sequential PowerShell AD cmdlet executions in short timeframe
- Event ID 4662 (Operation performed on AD object) on DC - user, group, and object enumeration
- LDAP queries from workstations not typically performing AD management
- PowerShell cmdlets with `-Properties *` parameter (comprehensive property enumeration)
- Get-ADObject queries with filters for `whenChanged`, `badPwdCount`, or other reconnaissance-related attributes
- PowerShell executed from recently compromised user accounts
- AD cmdlets with `-Server` parameter from non-domain-joined machines (indicates credential injection)
- Set-ADAccountPassword cmdlet usage by non-administrative accounts
- Event ID 5136 (Directory Service object modified) - unauthorized password changes
- Event ID 4724 or 4723 (Password reset/change attempts)
- PowerShell AD enumeration during non-business hours
- High volume of Get-ADUser or Get-ADGroup queries in rapid succession
- Correlation with runas.exe usage followed by PowerShell AD cmdlets
- PowerShell launched from suspicious parent processes (wscript.exe, mshta.exe, macros)

---

## Related Detection
---

- [[Credential Injection Detection|DET - T1078.002 - Active Directory Credential Injection Detection]]
- [[Net Commands Enumeration Detection|DET - T1087.002 - Active Directory Net Commands Detection]]
- [[BloodHound Enumeration Detection|DET - T1087.002 - Active Directory BloodHound Detection]]