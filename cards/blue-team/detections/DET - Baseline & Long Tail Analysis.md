---
dg-publish: true
date-created: 2026-03-22
---
~ [[Active Directory Security Monitoring]]
### DET - Baseline & Long Tail Analysis
---
The goal is to **know what is normal to detect abnormal.**

But how?

A user with 500 environment making TGS requests approximately creates 50,000 + 100,000 + events a day.

**Computer Accounts:**

One of the large part of that traffic is computer accounts, these are accounts that have names that ends with `$` character such as `IIS-SERVER$`. These accounts authenticate constantly for machine-to-machine communication, system updates, and automated process.

**See the total difference of authentication between user and computer accounts:**

```C
index=* EventCode IN (4624, 4768, 4769)
| eval AccountType=if(like(Account_Name, "%$%"), "Computer Account", "User Account")
| stats count by AccountType, EventCode
| sort AccountType, -count
```

**Common Service Name Patterns:**

The `Service_Name` field tells you what resources was accessed when looking at **4769** events.

- krbtgt
- cifs/marvel-dc
- ldap/marvel-dc

Look for unusual service name that does not fit your pattern, these service account patterns follows usually:

- Same sources
- Same destinations
- Same times
- Or any variables that shows a pattern.

### Long Tail Analysis
---
It is a technique that counts how many times each value appears, sorting the results by frequency, and then focusing your attention on the rare events.

```C
index=* EventCode=4769 NOT Account_Name="*$*"
| stats count by Account_Name
| sort -count
```

- Of course this should not be only applied to accounts. Such as:
- Stack count by `Account_Name` to find unusual user accounts
- Stack count by `Client_Address` to find unusual source IPs
- Stack count by `Service_Name` to find unusual services being accessed
- Stack count by `Ticket_Encryption_Type` to find unusual encryption methods

If 90% of our service ticket requests come from known, authorized accounts in our environment, that's normal. But if we see an account at the bottom that only requested one or two service tickets, that stands out precisely because it's rare and deserves investigation.

Next is **Time-based patterns:**

- User logins usually at business hours
- Batch jobs accounts at scheduled Windows 
- Admin account usage during maintenance Windows and more.