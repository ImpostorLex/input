---
tags:
  - map
dg-publish: true
date-created: 2024-11-28
aliases:
---
[[input]]

**A map can exist inside a map.**

See challenges [[#chall|here]].

> [!danger]+ quick start
> - [[Email Analysis]]
> - [[Endpoint Security]]
> - [[Digital Forensics]]
> - [[Incident Response]]
> - [[Threat Intelligence]]
> - [[Threat Hunting]]
> - [[Living off the Land#File Operations|Living off the Land (red-team)]] - have a look here for some additional detection/threat hunting ideas

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

> [!map]+ Threat Hunting
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/threat-hunting"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/threat-hunting/chall") sort file.ctime
> ```

> [!map]+ Incident Response
> ```dataview
> table file.mtime as "Last Modified"
> from "cards/blue-team/incident-response"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/incident-response/chall") sort file.ctime
> ```

### Challenges
---

> [!danger]- Challenges I did for exam
> ```dataview
> TABLE WITHOUT ID
> file.link AS "Challenge",
> file.mtime AS "Last Modified"
> FROM "cards/blue-team"
> WHERE regexmatch("^cards/blue-team/[^/]+/challenges/.*", file.path)
> SORT file.ctime DESC
> ```

