---
aliases:
  - TECH | T0003.001 Scripting
date-created:
dg-publish:
tags:
  - template
mitre_tactic: TA0008
mitre_technique: T1021
type: TECH
---
~ [[parent]]
## Summary
---
**What it is:** One-line definition of the technique, tool, or concept.

**Scope:** What this note covers (and optionally what it does *not*).

**Prerequisites:**

**Risks & Limitations:**

**Key Topics:** Links to prerequisite notes, related concepts, or parent techniques.

**Status:** 🟡 Draft | 🟢 Validated | 🔵 Needs Review

> [!bugs]- DETECTIONs available
> ```dataview
> LIST file.link
> FROM ""
> WHERE type = "DET"
> AND mitre_technique = this.mitre_technique
> AND file.name != this.file.name
> AND (!file.tags OR !contains(file.tags, "template"))
> ```

---
## How it works (2–4 lines)

Concise description of the mechanism (protocol/architecture), plus the legitimate administrative use case that attackers abuse.
## Steps (Hands-on)
---
### Step 1 — Short Action

Command / Action

```text
{PLACEHOLDER}
```

#### Expected Observables
- Windows Event:
- Sysmon:
- Wazuh:
- Network:
- Process:

#### Observed in Lab
- ✅
- ❌

#### Evidence Collected
- Screenshot
- Security.evtx
- Sysmon Log
- Wazuh Alert
- PCAP
- Process Tree

#### Confidence
- 🟢 Verified in Lab
- 🟡 Expected (Documentation)
- 🔴 Unknown / Needs Testing

### Step 2

(repeat)

> [!tip]
> Keep every step independent. If one step fails, document **why** before moving on.

## Additional Concepts (Optional)
---

Use only when this technique naturally branches into multiple concepts.

Otherwise, create a separate TECH note.
## Detection Summary
---
### Top Indicators
- Event IDs
- Processes
- Registry
- Network
- File Artifacts

### Detection Ideas
- High-level detection logic.
- Related Sigma ideas.
- Wazuh rule references.
- Correlation opportunities.

### Related Investigation

> [!question]
> Review the corresponding **DET** (if any) note after completing this technique.
>
> Answer the investigation questions once the lab has been completed.
## Lessons Learned
---
-
-
-
