---
tags:
  - map
dg-publish: true
date-created:
---
~ [[map]]

**A map can exist inside a map.**

**Note:** only use tags if the list is overwhelming.

```dataview
table dg-publish
from "cards/active-directory"
where !contains(tags, "ad/red-team")
```

> [!bug]+ Pentest Active Directory or Windows AD only
> ```dataview
> table dg-publish
> from #red-team/windows/ad or #windows/red-team 
> ```

