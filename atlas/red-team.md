---
tags:
  - map
dg-publish: true
date-created: 2024-11-28
---
~ [[map]]

**A map can exist inside a map.**

**Note:** only use tags if the list is overwhelming.

> [!info]- TAGLESS RED TEAM NOTES
> ```dataview
> TABLE WITHOUT ID
> link(file.path, choice(length(file.aliases) > 0, file.aliases[0], file.name)) AS "Title",
> file.mtime AS "Last Modified"
> FROM "cards/red-team"
> WHERE length(file.tags) = 0
> AND is_concept != true
> SORT file.ctime DESC
> ```


> [!warning]- HOST EVASION
> ```dataview
> TABLE WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link) AS "Title",
> file.mtime AS "Last Modified"
> FROM #red-team/host-evasion 
> SORT file.ctime ASC
> ```

> [!warning]- THREAT EMULATION
> ```dataview
> TABLE WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link) AS "Title",
> file.mtime AS "Last Modified"
> FROM #red-team/threat-emulation 
> SORT file.ctime ASC
> ```

 > [!warning]- INITIAL ACCESS
> ```dataview
> TABLE WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link) AS "Title",
> file.mtime AS "Last Modified"
> FROM #red-team/initial-access 
> SORT file.ctime ASC
> ```

 > [!warning]- POST COMPROMISE
> ```dataview
> TABLE WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link) AS "Title",
> file.mtime AS "Last Modified"
> FROM #red-team/post-c 
> SORT file.ctime ASC
> ```

> [!warning]- RED TEAM FUNDAMENTALS
> ```dataview
> TABLE WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link) AS "Title",
> file.mtime AS "Last Modified"
> FROM ""
> WHERE contains(file.tags, "#red-team") and
>    !any(file.tags, (t) => startswith(t, "#red-team/"))
> SORT file.ctime ASC
> ```

#### Others
---

> [!NOTE]+ red teaming related concepts/terminologies
> ```dataview
> table is_concept
> where is_concept = true and contains(file.tags, "#red-team/concept")
> ```

> [!bug]- red team related resources e.g codeblocks and more mentioned in notes.
> ```dataview
> TABLE WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link) AS "Title",
> file.mtime AS "Last Modified"
> FROM #red-team/resource
> SORT file.mtime DESC
> ```



See also [[windows]] and [[linux]]