[[]]

**Cloud Computing** has these important traits:

- Customers get computing resources on-demand and self-service through a web interface using the Internet.
- Resources are flexible, if customers wants more resource they can get it quickly same goes for reducing resources.
- Customers only pays for what they use.
- Allows company to focus more on their business goals and spend less time on maintaining technical infrastructure.

**Colocation** - Renting physical space rather than data center real estates.
**Virtualized Data Center** - similar to private data centers and colococation but servers, cpus, disks, and load balancers is now virtualized instead. - enterprises still maintained the infrastructure

Types of cloud offerings:

- **Infrastructure as a Service (Iaas)** - raw computing, storage, and network capabilities - customers still need to configure resources (OS, Applications, Middleware). pay for the resource allocated (Compute Engine for Google Cloud)
- **Platform as a Service** - provides the infrastructure to application logic such as pre-configured OS, databases and other development tools. pay for what customer uses. (App Engine for Google Cloud)
- **Software as a Service** - provides full functional software over the Internet.

Google Cloud’s infrastructure is based in five major geographic locations: North
America, South America, Europe, Asia, and Australia.

- ISO 140001 certified for environment | resource efficiency and reducing waste
- Uses 2% of world electricity.
- Aims by 2030 to operate carbon free.

![[Google Cloud Associate Engineer.png|450]]

- **Regions** represents a independent geographic area such as **london** and it is composed of _zones_.
	- **Zones** is an area where google cloud resources get deployed
- Resources can run on different regions for bringing apps closer to users around the world.

##### Security
---

- **Hardware Infrastructure**
	- Hardware are custom made
	- Secure boot stack - google make sure that the servers are booting to correct software stacks.
	- On premise security.
- **Service Deployment**
	- Google services communicate with each other by encrypting Remote Procedure Call.
- **User Identity level**
	- Smart authentication that intelligently ask additional information such as strange log in from different locations.
- **Storage services**
	- Data at rest is encrypted as well as for hardware encryption.
- **Internet Communication Level**
	- Google Front End - a service that all google services that is publicly available must have TLS connection enabled.
- **Operational Level**
	- Intrusion Detection
	- Monitors and limits the activites of employees
	- Best software dev practices

# Resources and Access in the Cloud

**Resources are hierarchical**

![[Google Cloud Associate Engineer-1.png|]]

Starting from bottom up:
- **Resources** - virtual machines, cloud storage anything in Google Cloud.
- resources are organized into **projects**
- projects can be organized into **folders** or sub folders.
	- Folders let's you apply policies at a level of granularity you choose. specific or not.
	- Allows you to group resources per department basis.
- The **organization node** is the top view of resources.
	
- Policies can be defined at the project, folder, and organization node levels. Some Google Cloud services allow policies to be applied to individual resources, 
	- Polices are inherited downward. put policy to folder then it will apply to all projects in that folder.

#### Diving more into Projects
---
- Projects are the basis for enabling and using Google Cloud services and APIs.
- Each resource belongs to one exactly project.
- Projects can have different owners and users.
- Project Attribute:
	- **Project ID** similar to SQL, immutable, automatic assign.
	- **Project Name** user created and not need to be unique.
	- **Project number** used by Google to track resources internally.
- It is managed by **resource manager** tool - it is an API. access by RPC API or REST API.

#### Organization Node
---
- Any projects, folders, and other resources are attached here.
- Can create a policy administrator
- Can create a project creater role.

Focus on core services like compute, networking, storage, and security. Supplement your practical experience with the official Google Cloud Certified Professional Cloud Architect exam guide and sample questions. Prioritize areas where you're less familiar.

### Identity and Access Management (IAM)
---
- Have a look at Google Cloud IAM and try and follow along.

**Three players**
- 'who' - a google account, group, and a service account also known as 'principal'.
- 'can do what' - IAM role is a collection of permission or a group of permission
	- It is important to remember **roles** applied to any element from resource is also applied to sub-elements.
	- A deny policy overrides any existing **allow** policy granted by the IAM role.

#### Basics IAM roles
---

**Basic roles**:
- Project viewers can examine resources, but can make no changes.
- Project editors can examine and make changes to a resource.
- And project owners can also examine and make changes to a resource. In addition, project owners can manage the associate roles and permissions, as well as set up billing.
- Often companies want someone to be able to control the billing for a project,but not have permissions to change the resources in the project. This is possible through a billing administrator role.

**Predefined roles**
- Specific Google Cloud services offer sets of predefined roles, and they even define where those roles can be applied.

**Custom Role**
- Apply least privilege concept.
- Can create a custom role at the project or organization level

**Service Account** are used by program to access other cloud services without the need of human intervention, it also allows specific permission.
- Are named with email address and uses cryptographic keys to access resources.
- Managed by IAM.


**Cloud Identity** organizations can define policies and manage their users and groups using the Google Admin console.
-  Can use username and pass from AD or LDAP
- Easily disable user accounts 

Four ways to interact with google cloud:

- Web console.
- Cloud SDK tools a set of command line tools for google cloud.
	- Cloud Shell provides command-line access to cloud resources directly from a browser. Cloud Shell is a Debian-based virtual machine with a persistent 5-GB home directoy
- APIs
- Google cloud app

## Virtual Machines and Networks in the Cloud

**Virtual Private Cloud (VPC)** 
- a cloud inside a cloud
- customers can run code, store data, host websites, and do anything else
- segment networks and restrict access to instances using firewall

Google VPC networks are global and can have subnets in any Google cloud region worldwide.

![[Google Cloud Associate Engineer-2.png]]

- Same subnet but different zones
- Have built-in router no need to manage a router and have routing tables to other instances regardless of the logical/physical location.
- VPCs provide a global distributed firewall, which can be controlled to restrict access to instances through both incoming and outgoing traffic

#### Compute Engine
---
- Create and run virtual machines. pay for what you need only.
- Run linux, windows server or any customized images.
- Google Marketplace have pre-configured software, vm instancse, or network settings.
- Autoscaling allows VM to be created or added depending on load metrics using _load balancing_.

#### Cloud Load Balancing
---
Distribute user traffic across multiple instances of an application, reduces the risk of one VM experiencing performance issues.

- No need to manage 
- Can put load balancing in front of all traffic:
	- HTTP(S)
	- TCP/UDP
	- SSL traffic
- Cross-region load balancing, including automatic multi-region failover - basically redirects traffic to nearest region or use another region to process user request.

**Cloud DNS**
- The famous free DNS server 8.8.8.8
- Google Cloud offers Cloud DNS to help the world find applications built in google cloud.
- fast.

**Cloud Content Delivery Network**

- Google has a global system of edge caches. Edge caching refers to the use of caching servers to store content closer to end users

**Connecting VPC networks to other networks**

- **Cloud VPN** to create a 'tunnel' connection enabling site to site connections.
	- **Cloud Router** lets other networks and Google VPC exchange route information over the VPN using the Border Gateway Protocol. Using this method, if you add a new subnet to your Google VPC, your on-premises network will automatically get routes to it.
- **Direct Peering** Instead of using the public internet, Direct Peering allows companies to connect their networks to Google by physically placing a router in the same data center as one of Google’s nearby locations (called "points of presence" or PoPs).
- **What It Is**: If your network isn’t near one of Google’s points of presence (PoPs), you can still connect directly to Google’s network through a partner in Google’s **Carrier Peering** program.
	- Third party provider connects your on-premises network to Googles allowing stable access.
- **Dedicated Internconnect** Dedicated Interconnect provides private, physical connections directly between your network and Google’s. This option is for businesses that need the highest uptime and reliability.
	- Supports Service Level Agreeement
- **Partner Interconnect** Partner Interconnect connects your on-premises network to a Google VPC (Virtual Private Cloud) through a third-party service provider. It’s helpful if your data center isn’t near a Google facility for Dedicated Interconnect, or if you don’t need a full 10 Gbps connection.

- The per-hour price of preemptible and spot VMs incorporates a substantial discount.


[[Google Cloud Associate Engineer 2]]