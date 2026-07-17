---
dg-publish: true
date-created: 2026-03-22
mitre_technique:
  - T1558
---
~ [[Active Directory Security Monitoring]]
### DET - Kerberos Authentication Events

> [!warning] MITRE Mapping Note
> Mapped to _T1558_ (Steal or Forge Kerberos Tickets) as the closest technique. This detection covers general Kerberos authentication monitoring and is broader than ticket theft alone. Use as a starting point, not a strict mapping.

A user want to authenticate to file server:

1. User requests a TGT producing **Event ID 4768** - DC issues a TGT to client.
2. User requests a TGS producing **Event ID 4769** - DC issues a TGS to client.
3. User creates a session on to the target file server producing **Event ID 4624**
	- In the logs of 4624  - it is worth noting the `Logon ID` usually looks like `0xXXXXX` - this indicates a session of that time. See [[DET BRUTE FORCE TO EXECUTION]]

4. (WHAT IF?) User enters the wrong password during pre-authentication or fails for any other reason. It produces **Event ID 4771**
	
	- Why not Event ID 4625? Event ID 4771 relates to Kerberos pre-authentication wherein 4625 is for broader range of logon failures, such as local and network logons. Interactive, Remote Desktop, and Network  (Accessing shared folders) Logon.

**Encryption types:**

In the event 4768/4769 tab, more specifically in the **Ticket Encryption Type**, it has two encryption types depending on whether the system is modern or legacy:

- **0x12:** uses AES-256 encryption - Windows 2008+ domain functional level.
- **0x17:** RC4-HMAC - older system, cross-forest trusts.
	- **cross-forest trusts** where one domain or forest is using older versions that don't support AES, so the system falls back to RC4 for compatibility.

**Show TGT requests:**

```C
index=* EventCode=4768
| table _time, Account_Name, Client_Address, Ticket_Encryption_Type
```

This shows us:

- Who tried to authenticate ( `Account_Name`),
- When ( `_time`),
- From which machine ( `Client_Address`),
- And the encryption type for the ticket requested ( `Ticket_Encryption_Type`).

[[Questions for Monitoring Active Directory]]
