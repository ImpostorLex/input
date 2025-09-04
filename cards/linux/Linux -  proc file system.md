---
dg-publish: true
---
[[Linux Process Analysis]]

- location: `/proc`
- It is a virtual file system that does not correspond to any physical storage, all of it is in memory.
- It provides an interface for the kernel to provide information on various running processes on the system.

![[Linux -  proc file system.png]]
- directories in blue with numbers are the processes itself.

Viewing the process of the reverse shell:

![[Linux -  proc file system-1.png]]
- **cmdline** refers to the argument given - we can `cat` this out
- cwd or `exe`
- `environ` - such as special settings

```bash
cat environ | tr '\0' '\n'
```

