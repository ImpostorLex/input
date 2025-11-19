---
dg-publish: true
dg-home: true
---
~  [[input]] 

**A map can exist inside a map.**

> [!map]+ My maps
> ```dataview
> TABLE WITHOUT ID
> choice(length(file.aliases) > 0, link(file.path, file.aliases[0]), file.link) AS "Map"
> FROM #map
> WHERE file.name != "Map Template"
> AND !contains(file.tags, "closed")
> ```

> [!warning]+ Dont forget about this
> ```dataview
> TABLE WITHOUT ID file.link AS "Note", todo AS "Todo"
> FROM ""
> WHERE todo
> ```


https://www.reddit.com/r/crystalofatlan/comments/1n6fv8r/new_endgame_player_need_help_on_what_to_do_now/




