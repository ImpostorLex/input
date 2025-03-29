---
tags:
  - map
dg-publish: true
date-created: 2024-11-28
---
[[input]]

**A map can exist inside a map.**


> [!map]- Digital Forensics
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/digital-forensics"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/digital-forensics/chall") sort file.ctime
> ```

> [!map]- Endpoint Security & Analysis
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/endpoint-security"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/endpoint-security/chall") sort file.ctime
> ```

> [!map]- Network Analysis
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/network-security"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/network-security/chall") sort file.ctime
> ```

> [!map]- Phishing Analysis
>
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/phishing"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/phishing/chall") sort file.ctime
> ```

> [!map]- Security Information & Event Management
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/siem"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/siem/chall") sort file.ctime
> ```

> [!map]- Threat Intelligence
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/threat-intelligence"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/threat-intelligence/chall") sort file.ctime
> ```
