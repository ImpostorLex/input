---
aliases:
  - BloodHound AD Enumeration
date-created: 2026-03-09
dg-publish: true
tags:
mitre_tactic:
  - discovery
mitre_technique: T1021
type: TECH
note_category: active-directory
---
~ [[Enumerating Active Directory (Authenticated Enumeration)]]
## Summary
---
**What it is:** Using BloodHound and SharpHound data collection tools to automatically enumerate Active Directory relationships, permissions, group memberships, and session data, then visualizing attack paths through graph analysis to identify privilege escalation routes and security misconfigurations.

**Scope:** This note covers executing SharpHound collectors (PowerShell and executable versions) with various collection methods, understanding CollectionMethods parameters (Default, All, Session), transferring and ingesting collected data into BloodHound, analyzing AD structure through graph visualization, identifying attack paths between nodes, and performing session-only collection runs for updated active session data.

**Prerequisites:**

- [[Active Directory]]
- [[Enumerating Active Directory (Authenticated Enumeration)]]
- [[Graph Theory Basics]]
- [[SharpHound Collector]]
- Valid AD credentials
- SharpHound.exe or SharpHound.ps1
- BloodHound application installed
- Network access to Domain Controller
- Non-domain-joined machine can use SharpHound with domain specification

**Risks & Limitations:**

- SharpHound detected as malware by most AV/EDR solutions
- Generates significant LDAP traffic to Domain Controllers
- Collection creates spike in Event ID 4662 (AD object access)
- Large environments produce multi-GB ZIP files
- Session collection requires NetSessionEnum (may be restricted)
- All collection method takes significant time (hours in large domains)
- Detection likelihood high during collection phase
- Requires exfiltration of ZIP file for analysis

## How It Works (2-4 lines)
---
BloodHound is an Active Directory relationship mapping and attack path analysis tool consisting of SharpHound data collectors that enumerate AD objects, permissions, group memberships, sessions, and trust relationships, and a graph-based visualization interface for analyzing collected data. Security teams and administrators use BloodHound for security assessments, identifying misconfigurations, understanding privilege escalation paths, and validating tiering models in complex AD environments. Attackers leverage BloodHound because SharpHound automates comprehensive AD enumeration that would take days manually, visualizes hidden attack paths through nested groups and permissions, identifies shortest paths to Domain Admin, reveals session-based lateral movement opportunities, and provides actionable intelligence for privilege escalation and domain compromise. Defenders detect BloodHound by identifying SharpHound process execution (high AV detection rate), LDAP query spikes to Domain Controllers, NetSessionEnum calls for session enumeration, large data exfiltration of ZIP files, and specific LDAP query patterns characteristic of SharpHound collection methodology.

## BloodHound Components
---
**BloodHound:**

- Graph-based visualization tool
- Displays actual AD relationships and attack paths
- Runs on attacker machine (not on target)
- Ingests data collected by SharpHound

**SharpHound (Collection Tool):**

Multiple versions available:

**SharpHound.ps1:**
- PowerShell script version
- Good for use with RATs (can be loaded directly into memory)
- Older version (latest releases stopped PowerShell script version)

**SharpHound.exe:**
- Compiled executable
- Most common version currently
- Standalone binary

**AzureHound.ps1:**
- For Azure/Microsoft 365 instances
- BloodHound can ingest Azure data

**Detection Warning:**

When using collector scripts on assessment, **high likelihood these files detected as malware** and raise alert to blue team. This is where non-domain-joined Windows machine assists - use runas command to inject credentials and point SharpHound to Domain Controller.

## Steps (Hands-On)
---

**Legend:**

- `{DOMAIN}` = za.tryhackme.com
- `{DC_IP}` = Domain Controller IP
- `{COLLECTION_METHOD}` = Default, All, Session
- `{ZIP_FILE}` = Output ZIP file from SharpHound
- `{AD_USERNAME}` = Domain username for collection
- `{ATTACKER_MACHINE}` = Kali or analysis workstation
- `{TARGET_USER}` = T0_TINUS.GREEN
- `{START_NODE}` = Source user for attack path
- `{END_NODE}` = Target node (e.g., Domain Admin)

**Context:** You have AD credentials and want to comprehensively map Active Directory relationships and identify attack paths using automated collection and graph analysis.

---

### 1. Execute SharpHound Collection

**Action:**

- Run SharpHound with specified collection method:
```C
Sharphound.exe --CollectionMethods All --Domain za.tryhackme.com --ExcludeDCs
```

**Parameters:**

- **--CollectionMethods** - Determines what data SharpHound collects
  - **Default** - Standard collection (users, groups, computers, sessions)
  - **All** - Comprehensive collection (everything including ACLs, containers, GPOs)
  - **Session** - Only session data (for quick updates)
- **--Domain** - Specify domain to enumerate (useful for parent/child domains or trusts)
- **--ExcludeDCs** - Instructs SharpHound not to touch Domain Controllers (reduces alert likelihood)

**Observable:**

- `Sharphound.exe` process execution
- Event ID 4688 (Process creation) - Sharphound.exe
- **High AV/EDR detection likelihood** - process flagged as malware
- Massive spike in LDAP queries to Domain Controller on port 389/636
- Event ID 4662 (Operation performed on AD object) on DC:
  - Rapid succession (hundreds to thousands per minute)
  - Accessing user objects, group objects, computer objects, GPO objects
  - Subject: `{AD_USERNAME}` running SharpHound
- NetSessionEnum API calls to enumerate active sessions on computers
- Event ID 5145 (Network share accessed) if session enumeration successful
- SMB connections to workstations/servers for session data
- Console output showing collection progress:
```
  [+] Building cache for domain za.tryhackme.com
  [+] Enumerating users
  [+] Enumerating groups
  [+] Enumerating computers
  [+] Enumerating containers
  [+] Enumerating GPOs
  [+] Enumerating sessions
  [+] Compressing output
```
- ZIP file created in current directory with timestamp

---

### 2. Verify SharpHound Output

**Action:**

- Check for generated ZIP file in current directory
- Typical filename format: `20230315143022_BloodHound.zip`

**Observable:**

- File creation in current working directory
- Sysmon Event ID 11 (FileCreate):
  - TargetFilename: `C:\Users\{USERNAME}\Documents\{TIMESTAMP}_BloodHound.zip`
  - Image: `Sharphound.exe`
- ZIP file size varies:
  - Small domains: 1-10 MB
  - Medium domains: 10-100 MB  
  - Large enterprises: 100+ MB to several GB
- File contains JSON data files:
  - computers.json
  - users.json
  - groups.json
  - sessions.json
  - containers.json
  - gpos.json
  - ous.json

---

### 3. Transfer ZIP File to Attacker Machine

**Action:**

- Exfiltrate SharpHound ZIP to analysis machine:
```PowerShell
scp {AD_USERNAME}@THMJMP1.za.tryhackme.com:C:/Users/{AD_USERNAME}/Documents/{TIMESTAMP}_BloodHound.zip .
```

**Observable:**

- `scp.exe` or SSH client process execution
- Network connection to target on port 22 (SSH)
- Sysmon Event ID 3 (Network connection):
  - DestinationIp: `{ATTACKER_MACHINE}`
  - DestinationPort: 22
- File read operations on SharpHound ZIP
- Large outbound file transfer (MB to GB range)
- Event ID 5140 (Network share accessed) if using SMB instead
- Sustained network traffic during transfer

---

### 4. Ingest Data into BloodHound

**Action:**

- Launch BloodHound application on attacker machine
- Drag and drop ZIP file into BloodHound interface
- Or use Upload Data button

**Observable:**

- BloodHound application processing on attacker machine (no target observables)
- ZIP extracted and JSON parsed
- Neo4j graph database populated with:
  - User nodes
  - Group nodes
  - Computer nodes
  - GPO nodes
  - OU nodes
  - Relationship edges (MemberOf, AdminTo, HasSession, etc.)
- Database size increases based on domain size
- Processing time: seconds to minutes depending on data volume

---

### 5. Analyze Domain Structure in BloodHound

**Action:**

- Explore BloodHound interface components:
  - Search bar for finding specific nodes
  - Analysis tab with pre-built queries
  - Graph view showing relationships
  - Node information panels

**Node Types (Icons):**

- **Person icon** - User accounts
- **Purple/black stacked lines** - GPO (Group Policy Object)
- **Orange network/org chart** - OU (Organizational Unit)
- **Computer icon** - Machine accounts

**Example Analysis:**

Search for specific user (e.g., `T0_TINUS.GREEN`):

![[Enumerating Active Directory-16.png]]

Click numbers beside user information to expand:

![[Enumerating Active Directory-17.png|500]]

**Observable Information:**

- Group memberships
- Direct admin rights
- Sessions on computers
- Outbound object control
- Reachable high-value targets

---

### 6. Use Pre-Built Analysis Queries

**Action:**

- Navigate to **Analysis** tab in BloodHound
- Explore pre-built queries created by BloodHound developers

![[Enumerating Active Directory-19.png]]

**Common Queries:**

- Find all Domain Admins
- Find Shortest Paths to Domain Admins
- Find Principals with DCSync Rights
- Find Workstations where Domain Users can RDP
- Find Servers where Domain Users can RDP
- Find Computers where Domain Users are Local Admin
- Find All Paths from Domain Users to High Value Targets
- Shortest Paths to High Value Targets
- Find Kerberoastable Users

**Example Query Result:**

User `T0_TINUS.GREEN` is member of `Tier 0 ADMINS` group, which is nested into `DOMAIN ADMINS` group. This means all users in Tier 0 ADMINS are effectively Domain Admins through nested group membership.

**Why This Matters:**

- Nested groups provide indirect privilege escalation
- Security teams may monitor Domain Admins direct membership
- Miss nested group memberships in manual reviews
- BloodHound reveals hidden privilege paths

**Target Selection:**

Since `ADMINISTRATOR` is built-in account, likely heavily monitored. Focus on `T0_TINUS.GREEN` as alternative path to Domain Admin privileges.

---

### 7. Find Attack Paths Between Nodes

**Action:**

- Use pathfinding feature to identify routes between Start Node and Target Node
- Select **Start Node** (e.g., compromised low-privilege user)
- Select **Target Node** (e.g., Domain Admin or high-value system)
- BloodHound calculates shortest attack path

![[Enumerating Active Directory-20.png]]

**Example Attack Path:**

![[Enumerating Active Directory-21.png]]

**Attack Path Analysis:**

- One of **T1 ADMINS** accounts broke tiering model
- Used credentials to authenticate to **THMJMP1** (workstation)
- Any user in **DOMAIN USERS** group has RDP access to THMJMP1
- **Exploitation Steps:**
  1. Use AD credentials to RDP into THMJMP1
  2. Look for privilege escalation vector for Administrative access
  3. Use Administrative access for credential harvesting (Mimikatz)
  4. T1 Admin has active session on THMJMP1
  5. Credential harvesting provides NTLM hash of T1 Admin account
  6. Use hash for privilege escalation or lateral movement

**Why Attack Paths Matter:**

- Visualizes multi-hop privilege escalation
- Identifies weakest links in security
- Shows practical exploitation routes
- Reveals tiering model violations
- Guides penetration testing efforts

---

### 8. Session-Only Collection for Updated Data

**Action:**

- Rerun SharpHound with Session collection method:
```C
Sharphound.exe --CollectionMethods Session --Domain za.tryhackme.com
```

**Why Session-Only Collection:**

- AD structure changes infrequently (users, groups, OUs relatively static)
- Active sessions change constantly (users log on/off throughout day)
- Good approach:
  - Execute SharpHound with "All" collection at start of assessment
  - Execute SharpHound with "Session" collection 2+ times daily
- Session collection much faster (minutes vs hours)
- Provides updated session data without re-enumerating entire AD

**Observable:**

- `Sharphound.exe` process execution
- Event ID 4688 (Process creation)
- NetSessionEnum API calls to enumerate sessions
- SMB connections to computers for session data
- Event ID 5145 (Network share accessed) on target computers
- Fewer LDAP queries compared to All collection
- ZIP file created with only session data (much smaller)

**Use Case:**

- Active sessions show where privileged users currently logged in
- Identify lateral movement opportunities
- Target systems with high-value sessions
- Update attack paths based on current session data
## Blue - Detection & Response
---

**Indicators of Compromise:**

- Event ID 4688 (Process creation) - Sharphound.exe or powershell.exe loading Sharphound.ps1
- AV/EDR alerts - SharpHound flagged as malware or hacking tool
- Massive spike in Event ID 4662 (Operation performed on AD object) on Domain Controllers
  - Hundreds to thousands per minute from single source account
  - Rapid enumeration of users, groups, computers, GPOs, OUs
- LDAP query volume spike from single workstation to DC
- NetSessionEnum API calls across multiple computers
- Event ID 5145 (Network share accessed) - session enumeration attempts on workstations/servers
- SMB connections from single source to many computers in short timeframe
- Sysmon Event ID 1 (Process creation) - Sharphound.exe with characteristic command-line arguments (--CollectionMethods, --Domain, --ExcludeDCs)
- Sysmon Event ID 11 (FileCreate) - ZIP file creation with timestamp naming pattern
- Large outbound file transfer (ZIP file exfiltration)
- Event ID 5140 (Network share accessed) or SSH connections for file transfer
- Sysmon Event ID 3 (Network connection) - connections to external IPs with large data transfer
- Characteristic LDAP query patterns matching SharpHound methodology
- Session enumeration during non-business hours
- SharpHound execution from recently compromised accounts
- Multiple SharpHound runs with different CollectionMethods (All followed by Session)
## Related Detection
---

- [[Credential Injection Detection|DET - T1078.002 - Active Directory Credential Injection Detection]]
- [[Net Commands Enumeration Detection|DET - T1087.002 - Active Directory Net Commands Detection]]
- [[PowerShell AD Enumeration Detection|DET - T1087.002 - Active Directory PowerShell Enumeration Detection]]