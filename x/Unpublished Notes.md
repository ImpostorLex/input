[[input]]
```dataview
table
from "cards"
where !contains(file.path, "cards/trend-micro-vision-one") 
  and (dg-publish = false or !dg-publish)
```
