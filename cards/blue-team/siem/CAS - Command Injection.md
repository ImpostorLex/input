---
tags: 
date-created: 2025-02-01
dg-publish: true
---
[[Common Attack Signatures]]

- Execution of OS commands through vulnerable applications such as web app, desktop application

**Look for:**
- `;`, `||`, `&&` - characters that seperate commands.
- **os** commands