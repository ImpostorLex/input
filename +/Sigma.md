---
date-created: 2025-04-26
dg-publish: 
tags:
  - sunday
  - template
aliases:
---
[[Parent]]
### Introduction 
---
Detection engineering is developing processes that will guide the analyst to identify threats before they cause harm to an environment through rules.

The problem is sharing Indicators of Compromise as different system takes different format, _sigma_ bridges that gap: "Sigma is for log files as Snort is for network traffic, and Yara is for files."

Sigma makes content matching easy to perform against log files.
## Syntax
---
The syntax:

![[Sigma.png|300]]

Each Sigma rule is a **YAML file** that follows a common structure, which includes:

- **Title**:  
    A short name describing what the rule detects (e.g., "WMI Event Subscription Persistence").
    
- **ID**:  
    A unique identifier for the rule (in UUID format).  
    (e.g., `0f06a3a5-6a09-413f-8743-e6cf35561297`)
    
- **Status**:  
    Describes the rule's maturity:
    
    - **Stable**: Good for production.
        
    - **Test**: Needs tuning, still being validated.
        
    - **Experimental**: Very early, likely noisy.
        
    - **Deprecated**: Outdated, replaced by better rules.
        
    - **Unsupported**: Not usable due to limitations.
        
- **Description**:  
    Extra context about what the rule is detecting and why it matters.
    
- **Logsource**:  
    Defines where the logs are coming from:
    
    - **Product**: (e.g., Windows, Apache)
        
    - **Category**: (e.g., firewall logs, security logs)
        
    - **Service** (optional): (e.g., sshd on Linux, Security on Windows)
        
- **Detection**:  
    The **heart of the rule** — defines **what to search for** and **how**:
    
    - **Search Identifiers**:  
        What fields and values to match (like `EventID: 19, 20, 21`).
        
    - **Condition**:  
        How to combine or filter those matches (using AND, OR, NOT, etc.).
        
- **FalsePositives**:  
    Lists examples of harmless activities that might trigger the rule (to help with tuning later).
    
- **Level**:  
    Severity of the detection:
    
    - Informational → Low → Medium → High → Critical
        
- **Tags**:  
    Adds extra info like MITRE ATT&CK tactics or CVE references.  
    (e.g., `attack.persistence`, `attack.t1546.003`)
### Search Identifiers and Conditions
---
The **Detection** section describes **what to match** inside the logs and **how to handle it**:

- **Search Identifiers** (selections):
    
    - **Lists** (OR logic): Match any value.  
        Example: `EventID: [19, 20, 21]`
        
    - **Maps** (AND logic): Multiple conditions must be true.  
        Example: `Image ends with "/shred"` **AND** `CommandLine contains "/var/log"`
        
- **Modifiers** (special search tweaks):
    
    - `|contains`: Value appears anywhere inside the field.
        
    - `|endswith`: Field must end with the given value.
        
    - `|startswith`: Field must start with the given value.
        
    - `|base64`: Decode base64 values.
        
    - `|re`: Treat the value as a regular expression (regex).
        
- **Conditions** (how results are combined):
    
    - Basic logical operators: **AND**, **OR**, **NOT**
        
    - Special terms:
        
        - `1 of selection_*` → at least one matches.
            
        - `all of selection_*` → all must match.







### Questions and Problems
---
## Conclusion


