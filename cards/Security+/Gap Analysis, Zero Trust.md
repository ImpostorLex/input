---
tags:
  - sec
---
- The analysis of where we currently are to where we want to be.
- Choosing a framework such as known baseline with NIST or ISO.
- Requires ALOT of resources.

![[Gap Analysis sec+.png]]

- The end of the gap analysis report, should include the above wherein colors represent danger level.
- It should also include solutions.

## Zero Trust

- A concept that everything even humans needs to be verified or authenticated.
	- A lot of organizations security is once you get past the firewall no security controls are implemented.
- Security zones - where did you come from and where are you going?
	- Untrusted zone to trusted zone might be enough to deny access.
	- **Policy Enforcement Point** (PEP) - can or consist of multiple systems that works together to enforce policies implemented by an organization.
		- Policy engine evaluates each access based on policy and other information, may grant, deny or revoke access.
		- Policy administrator then takes the decision made by the policy engine and decide to tell PEP if it is allowed to access using generated tokens or credentials or not.
		