---
date-created: 2026-01-16
dg-publish: true
tags:
aliases:
type:
---
~ [[input]]

A **much more** better way to navigate.
## Initial Access

> [!note]+ TA0001 - Initial Access
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "initial-access")
> ```

## Execution

> [!note]+ TA0002 - Execution
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "execution")
> ```

## Persistence

> [!note]+ TA0003 - Persistence
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "persistence")
> ```

## Privilege Escalation

> [!note]+ TA0004 - Privilege Escalation
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "privilege-escalation")
> ```

## Defense Evasion

> [!note]+ TA0005 - Defense Evasion
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "defense-evasion")
> ```

## Credential Access

> [!note]+ TA0006 - Credential Access
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "credential-access")
> ```

## Discovery

> [!note]+ TA0007 - Discovery
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "discovery")
> ```

## Lateral Movement

> [!note]+ TA0008 - Lateral Movement
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "lateral-movement")
> ```

## Collection

> [!note]+ TA0009 - Collection
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "collection")
> ```

## Command and Control

> [!note]+ TA0011 - Command and Control
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "command-and-control")
> ```

## Exfiltration

> [!note]+ TA0010 - Exfiltration
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "exfiltration")
> ```

## Impact

> [!note]+ TA0040 - Impact
> ```dataview
> LIST choice(length(aliases) > 0, link(file.path, aliases[0]), file.link)
> FROM ""
> WHERE type = "PARENT"
> AND contains(mitre_tactic, "impact")
> ```
