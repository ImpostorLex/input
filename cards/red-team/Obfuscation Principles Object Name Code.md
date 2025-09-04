---
date-created: 2025-07-10
dg-publish: true
aliases:
  - Obfuscation Principles code blocks
tags:
  - red-team/resource
---
~ [[Obfuscation Principles#Object Names|Obfuscation Princples]]

Code 1:

```c
// #include "windows.h"
#include <iostream>
#include <string>

int main() {
	unsigned char shellcode[] = "";
	int myNumber = 40;
    std::string leaked = "This was leaked in the strings";
    std::cout << "Some placeholder text\n";
    std::cout << leaked;
    return 0;
}
```

Compile with:

```C
g++ -g demo.ccp -o demo
```

After compiling check using `strings.exe`.

![[Obfuscation Principles Object Name Code.png]]
**Note:** `-g` switch is used meaning compile with debug info -- so this preserves the symbols that is why its showing the variable name without this flag the strings would only show.
#### obfuscated Code 2
---
Changing the strings into something obfuscated unidentifiable purpose:

![[Obfuscation Principles Object Name Code-1.png|500]]
