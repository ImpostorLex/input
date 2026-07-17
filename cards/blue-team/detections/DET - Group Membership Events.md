---
dg-publish: true
date-created: 2026-03-22
mitre_technique:
  - T1098
---
~ [[Active Directory Security Monitoring]]
### DET - Group Membership Events

Adding user into privilege groups:

- 4728 - Member added to the global security group -  domain wide scope
- 4732 - Member added to local security group - machine-level (domain local on DCs)
- 4756 - Member added to universal security group - entire forest scope.

```C
index=* (EventCode=4728 OR EventCode=4732 OR EventCode=4756)
| table _time, Member_Account_Name, Group_Name, Subject_Account_Name
```

This shows us:

- Who was added ( `Member_Account_Name`),
- Which group they were added to ( `Group_Name`),
- And who made the change ( `Subject_Account_Name`).

