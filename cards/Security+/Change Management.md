---
tags:
  - sec
---
[[Sec+]]

- Should have a process such as frequency, duration, installation process, and rollback procedures in case something goes wrong.
- Common risks in the enterprise as change is not always good.

**Typical approval process**
- Fill out the request form.
- Why should it change?
- Identify the scope of the change.
- Schedule the date
	- Time of the year when company expects little to no users.
	- Overnights.
	- **Any non production hours**.
	- What about 24/7 production environment? switch back to secondary systems, upgrade the primary, then switch back.
- Determine affected systems and the impact.
	- Create a backup plan.
- Analyze risk associated with the change.
	- Consider both of NOT and making the change.
	- Recommend to use sandbox environment.
- Does end-user likes change?

### Technical Change Management
---
- Execute the plan.
- Implemented usually by the technician focuses on the 'how' to change.
- Change management focuses on the 'what' to change
- Send emails tell the users.
- Document everything.
	- Best use Version Control System.