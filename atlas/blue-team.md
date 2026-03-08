---
tags:
  - map
dg-publish: true
date-created: 2024-11-28
aliases:
  - Blue Teaming
---
~ [[map]]

**A map can exist inside a map.**

> [!danger]+ [START HERE] - playbook/guide, scripts, one liners and more.
> - [[Email Analysis|Phishing Email Analysis]]
> - [[Endpoint Security|Endpoint Security & Analysis]]
> - [[Threat Intelligence]]
> - [[Threat Hunting]]
> - [[Living off the Land#File Operations|Living off the Land (red-team)]] - have a look here for some additional detection/threat hunting ideas
> - [[Digital Forensics]]

> [!map]- Endpoint Security & Analysis
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/endpoint-security"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/endpoint-security/chall") sort file.ctime
> ```
> [[Group Policy Objects#Sample Investigation]] has investigation how to investigate GPOs

> [!map]- Phishing Analysis
>
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/phishing"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/phishing/chall") sort file.ctime
> ```

> [!map]- Threat Intelligence
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/threat-intelligence"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/threat-intelligence/chall") sort file.ctime
> ```

> [!map]- Network Analysis
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/network-security"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/network-security/chall") sort file.ctime
> ```

> [!map]- Digital Forensics
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/digital-forensics"
> where !contains(file.path, "cards/blue-team/digital-forensics/chall")
> sort file.ctime desc
> ```
> [[Linux Logging for SOC]] -- have a look for some common logs that is not usually ingested in SIEM to data noise and hard to parse

> [!map]+ Incident Response
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/incident-response"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/incident-response/chall") sort file.ctime
> ```

> [!map]+ Threat Hunting
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/threat-hunting"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/threat-hunting/chall") sort file.ctime
> ```

> [!map]- Security Information & Event Management
> ```dataview
> TABLE WITHOUT ID
link(file.path, choice(length(file.aliases)>0, file.aliases[0], file.name)) AS "Title",
sTags AS "Topics"
> from "cards/blue-team/siem"
> sort file.mtime desc where !contains(file.path, "cards/blue-team/siem/chall") sort file.ctime
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

