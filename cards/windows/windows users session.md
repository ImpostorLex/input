~ [[lateral movement and pivoting]] | ~ [[windows]]

_Windows user session_ is the runtime environment created when a user logs on. It includes the user’s security token, session ID, window station/desktop, environment (variables, registry HKCU), and the processes started in that session. Crucially: **credentials used purely for network authentication (`/netonly`) are _not_ converted into a local interactive logon token**, so they won’t let you create a visible interactive process in that other user’s session.

