---
dg-publish: true
date-created: 2026-03-18
tags:
aliases:
---
~ [[MITRE map]]

> [!bug]+ Detections
> ```dataview
> LIST WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link)
> FROM ""
> WHERE type = "DET"
> AND (!file.tags OR !contains(file.tags, "template"))
> ```