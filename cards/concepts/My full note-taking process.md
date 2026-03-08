
This guide explains **how I structure, write, and maintain my cybersecurity notes**—whether learning Red Teaming, Blue Teaming, DFIR, Windows internals, or general concepts.

My system has three layers:

1. **Parent Notes** → concepts & theory
    
2. **TECH Notes** → red‑team techniques
    
3. **DET Notes** → blue‑team detection
    
Each layer has a clear purpose and strict boundaries.  
This keeps my vault clean, scalable, and easy to navigate.

As for folder organization:

I use the AC (modified from ACE) framework YouTube: "Ace Framework by Nick Milo":

1. `atlas` folder will contain my **map** notes, these "map" notes contain a list of notes relating to one subject, for example: blue-team folder will contain well blue-team related stuff.

2. `cards` contains every subject or domain in cybersecurity to non-cybersec organized in their respective folder, for example: `cards/blue-team`,

	- Images are the same if the images belong to blue-team notes, I placed them here 'cards/blue-team/images' so each 'cards' (card = topic/subject) is self-contain meaning if I move the entire card to another folder it will contain all of it's images.

3. `x` contains some utilities such as templates for the notes I am using and some other stuff not worth mentioning.

# ⚙️ **1. Parent Notes (Concept Library)**

### _“What is it? Why does it matter?”_

Parent Notes define the _big picture_.  
They explain concepts such as **Kerberos**, **Lateral Movement**, **Credential Abuse**, **Windows Authentication**, and more.

### **Purpose**

Parent Notes exist to:

- Give conceptual context
    
- Explain the theory behind techniques
    
- Define prerequisites (privileges, accounts, services)
    
- Describe legitimate system behavior
    
- Link to TECH and DET notes without duplicating content
    

They intentionally **avoid** anything tactical.

### **What They Contain**

- Concept definition
    
- High‑level workflow (conceptual only)
    
- Prerequisites & terminology
    
- Key sub‑techniques
    
- Links to TECH & DET notes
    
- Optional diagrams or architecture notes
    

### **What They NEVER Contain**

🚫 No offensive/defensive commands  (errr in some notes yeah but not the 'main' point type of commands)
🚫 No detection logic  
🚫 No labs  
🚫 No step‑by‑step procedures

Parent Notes are _pure knowledge_ — the stable foundation.

---

# 🔴 **2. TECH Notes (Red Team Technique Notes)**

### _“How attackers use it.”_

TECH Notes describe **offensive technique mechanics**.  
They are environment‑agnostic (If possible but most of time it's not), methodical, and reusable.

Every TECH note answers:

- What the attack is
    
- How it works at OS/protocol level
    
- How attackers execute it
    
- What defenders would observe
    

### **Purpose**

To document _how to perform_ a technique without mixing theory or detection.

TECH notes give the **offensive workflow**, **placeholders for commands**, and **expected observables**.

### **Sections**

#### **Summary**

- One-line description
    
- Scope of the technique
    
- Key Topics (required prerequisites, protocols, behaviors)
    
- Optional constraints or environment assumptions
    

#### **How It Works (2–4 lines)**

High-level mechanism:

- OS/protocol components involved
    
- Legitimate admin purposes
    
- How attackers repurpose it
    

No commands. No detection logic.

#### **Steps (Hands‑On)**

Each step contains:

1. **Action** (generic placeholders)
    
2. **Observable** (what the host shows)
    
3. **Collect** (evidence for later)

**Note 1:**
It was not noted by ChatGPT but in my case, the resource when I am learning red teaming, the resource literally contain (sometimes) how to exploit "X" but no **"Observable" and "Collect"** so what I do is ask ChatGPT to provide these for me BUT STRICTLY base the obersvable and collection purely on my NOTES, this results into two important things:

- ChatGPT does not invent something or include something that you did not talk about or did not include in your learning material, avoiding "where this X comes from?"
- By "NOTES" this include the PROVEN FACTs based on your conversation window: such as "ChatGPT explain this technique X for me the resource material is not enough" in this way ChatGPT will add info that YOU already know about, this avoids pasting it into your note and asking "Where did this come from"

Example:

- Action: Authenticate to {TARGET} using {USER} credentials
    
- Observable: Network connection on port 135 (RPC)
    
- Collect: Packet capture metadata, timestamp
    

#### **Blue — Detection & Response (Concise)**

Short defensive awareness:

- Key logs
    
- Parent-child process patterns
    
- High-value indicators
    
- Quick response checklist
    
This section is minimal but helps connect red ↔ blue learning.

**Note 1:** ..... (the concept of note 1 applies here too never let chatgpt invent)

### **Why TECH Notes Exist**

To keep **offense isolated** from concept theory and defensive analysis.

This allows:

- Fast review
    
- Clean reusability
    
- No duplicated theory
    
- Easy mapping to DET notes
    

---

# 🔵 **3. DET Notes (Blue Team Detection Notes)**

### _“How defenders detect and respond to it.”_

DET Notes describe how to detect, triage, and respond to a technique.

### **Purpose**

To provide a **clean, accurate, and reproducible detection workflow**.

DET notes focus strictly on:

- Observables
    
- Telemetry
    
- Detection logic
    
- Triage essentials
    
- Tuning guidance
    

They avoid offensive steps entirely.

### **Sections**

#### **Summary**

- One-line detection definition
    
- What is covered (scope)
    
- Required log sources
    

#### **How It Works (2–4 lines)**

High-level behavior:

- What the OS normally does
    
- What attackers change
    
- What logs are created
    
- What behavior is suspicious
    

#### **Detection Workflow**

- Required telemetry (e.g., Sysmon, EDR, Windows Security)
    
- Behavior patterns
    
- Pseudo detection logic
    
- Decision points
    
- Validation steps
    

This is **tool-agnostic** and focuses on behavior, not syntax.

**Note 1:** same.
#### **Observables & Indicators**

- Event IDs
    
- File paths
    
- Registry changes
    
- Process trees
    
- Network patterns
    
- User behavior anomalies
    
**Note 1:** same..
#### **Notes / Tuning**

- Known false positives
    
- Allowlists
    
- Data quality considerations
    
- SOC caveats
    

### **Why DET Notes Exist**

To make detection **repeatable**, **clean**, and **evidence-based**.

---

# 🎯 **How All Three Work Together**

**Parent Note:**  
What is Kerberos? How does the ticket system work?

➡ Links to TECH & DET

**TECH Note:**  
How does an attacker Kerberoast in practice?

➡ Links back to parent  
➡ Shows observables  
➡ Shows execution model

**DET Note:**  
How do we detect AS‑REP Roasting or TGS abuse?

➡ Links back to parent  
➡ Describes logs, process patterns, tuning

This separation keeps notes:

- Clean
    
- Modular
    
- Easy to maintain
    
- Fast to review
    
- Scalable as your vault grows
    

---

# 📦 **Case Notes (Blue or Red)**

Case Notes (labs, THM, HTB, forensic challenges) follow a separate template:

**Summary** → what happened  
**Timeline & Actions** → what I did  
**Observations & Artifacts** → what I found  
**Detection / Mitigation** → blue focus  
**Technique Mapping** → link to existing TECH notes

These are **not** concept notes and should never muddle theory or templates.

---

# 🧠 **Core Principles of My Note‑Taking Philosophy**

### **1. Concept and Technique Are Separate**

- Parent explains “why and how at theory level”
    
- TECH explains “how attackers do it”
    
- DET explains “how defenders detect it”
    

### **2. Notes Must Answer: “Is this relevant right now?”**

That’s why every note begins with a **meaningful Summary**.

### **3. Templates protect clarity**

Every note follows a strict template to prevent:

- Bloat
    
- Mixing blue/red content
    
- Repeated theory
    
- Research messiness
    

### **4. All cross‑references are explicit**

TECH ↔ DET ↔ Parent but never duplicated.

### **5. Commands and logs MUST stay in technique or case notes**

Never in parent notes.

Sometimes yeah because some learning resources explain in that way but the main techniques is seperated.

### **6. TTP Mapping is always based on your TECH notes**

Example:  
Timeline step → observed WMI process →  
Link to: **[[TECH – T1047 WMI Exec]]**

Yep, if the note does not exist say **TECH - T12345** does not exist yet but I am learning blue-teaming and the **TECH - T12345** does not exist yet, I don't force to learn it immediately or create a note I leave it as a placeholder. 

If note structure and process must be earn, so does note taking


