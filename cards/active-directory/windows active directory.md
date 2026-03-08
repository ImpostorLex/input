---
tags:
  - map
dg-publish: true
date-created:
aliases:
  - Active Directory
---
~ [[map]]

**A map can exist inside a map.**

**Note:** only use tags if the list is overwhelming.
```dataview
table dg-publish
from "cards/active-directory" OR #windows/ad 
where !contains(file.tags, "red-team/ad") 
      and !contains(file.tags, "windows/red-team") and !contains(file.tags, "map")
```

> [!bug]+ Pentest Active Directory or Windows AD only
> ```dataview
> table dg-publish
> from #red-team/ad or #windows/red-team 
> ```

