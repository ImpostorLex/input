---
tags: 
date-created: 2025-02-01
dg-publish: true
---
[[Common Attack Signatures]]

- Injecting malicious code into javascript
	- Steal cookies.
	- Hijack user sessions.

**Look for**
- `<script>` tags sometimes url encoded and have bad letter casing.
- event handlers such as: `onload`, `onclick`, and `onmouseover`.

#### References
---
- [https://github.com/payloadbox/xss-payload-list](https://github.com/payloadbox/xss-payload-list)
- [https://www.w3schools.com/tags/ref_urlencode.ASP](https://www.w3schools.com/tags/ref_urlencode.ASP)