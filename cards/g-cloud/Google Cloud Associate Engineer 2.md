[[Google Cloud Associate Engineer]]

### Storage in the cloud
---
Google has many ways to store data:
#### Cloud Storage
---
- It offers a highly available _object storage_ unlike traditional storage that organizes data in files and folders or as blocks data is split into **blocks** each have it's own address and reassembled when needed.
- **Object Storage** stores **primarly large/temporary data** as individual objects, each object includes:
	- The actual content.
	- **Metadata**: date-creation, file type, author and permissions.
	- **Unique identifier** that is in a form of a URL which makes the object accessible over the web.
	- Objects are immutable, a new version of object is created instead after editing.
		- Versioning can be configured (similar to git)
		- As well as overwriting the old version.
- Wide variety of uses: serving website content, file archiving, and disaster recovery or directly downloading via Direct Download.
##### Buckets
---
- Cloud Storage files are organized through _buckets_, it requires a globally-unique name and a specific geographic location preferrably near customers.
- **IAM roles** are sufficient for most since Roles are inherited from project > bucket > object.
- **Finer control** Access Control List has two pieces of information: scope which defines who can access and perform action and second is permission which defines what actions  such as read or write
- **Mountable** buckets can be mounted and be used as typical linux and macos directory.
- File retention policies/ file lifecylce management.


- **Hot data** frequent access.
- **Nearline storage** infrequently accessed data (once per month or less).
- **Coldline** 90 days. (Below is low-cost options)
- **Archive** 365 days. 
- **Autoclass** automate stores files or objects to appropriate storage classes

- **Storage Transfer Service** great for transferring large files from one cloud to Google cloud, from http(s) endpoint, or another g-cloud region.

#### CloudSQL
---
- MySQL, PostgreSQL, SQL server, focus on building the app.
	- Google apply patches, updates , backups and configuration replication.
- Encrypts customer data when on Google’s internal networks and when storedin database tables, temporary files, and backups and firewall.
- Accessible by other cloud services and some exteranl services.

#### Spanner
---
- Combines the power of **relational database** with scalability of non-relational databases.
- Fast, high availability, and global consistency.
- **Horizontal scalable** - adding more machines to handle an increased workload

#### Firestore
---
- NoSQL database for mobile, web and server deployment
- **Stores data as documents** then organizes as collections can contained nested objects.
	- Each document uses a key-value pair
- Data caching so apps can manipulate data when offline and synch once online
- Horizontal Scalable

#### BigTable
---
- NoSQL big data database service.
- Designed to handle massive workloads including time sensitive, asynchronous and synchronous.
- Can be interacted using **APIs**.
- Can be streamed thorugh dataflow, spark streaming, and storm.
- Batch processing.


![[Google Cloud Associate Engineer 2.png]]

### Containers in the Cloud
---
- Groups your code and dependencies into one container. (Have a look at vault: containerisation in notes)
- Best of both worlds PaaS and IaaS.
- Ideally application should be created using microservices architecture where one container perform their own function and connect them.

#### Kubernetes
---
Is an open-source platform for managing containerized workloads and services such as deployment, scaling and updates across multiple devices.
- At the core it is a set of APIs
- Group of machines are called **clusters**, it has two parts.
	- **Control Plane** 'brain' of kubernetes which manages the containers and scheduling.
	- **Nodes** virtual machines orm achines that runs the containers
- Makes management of lifecycle of containers easy including when stop/start and how many needed.
- **Pods** is a smallest unit that can be deployed or created.
	- Acts as a 'wrapper' around one or more running containers, representing a running part of your application such as single process.
	- Generally one container = one pod but one pod = many container is possible allowing ease of communication and network sharing.
	- Each pod gets a **uniqe IP address** and set of ports that the container uses to communicate with each other and outside.
- A **Deployment** represents a group of replicas of the same Pod and keeps your Pods running even when the **nodes** they run on fail. A Deployment could represent a component of an application or even an entire app.
	- Instead of running commands such as `kubectl` provide a deployment config file.
- Rolling out updates with `kubectl rollout` or using deployment configuration file and apply changes with `kubectl apply`.

#### Google Kubernetes Engine
---
- **GKE** is a **managed Kubernetes service** provided by Google Cloud. It simplifies the use of Kubernetes by handling much of the heavy lifting for you.
- Manages **control plane** for user.
- **Autopilot Mode** (Recommended): GKE handles almost everything for you. It takes care of **node configuration**, **autoscaling**, **upgrades**, **networking**, and **security**, so you can focus on your applications rather than the infrastructure.
- **Standard Mode**: You manage the **nodes** (the servers running containers) yourself, giving you more control over configuration but requiring more management including optimization.

### Applications in the Cloud
---


https://github.com/Ditectrev/Google-Cloud-Platform-GCP-Associate-Cloud-Engineer-Practice-Tests-Exams-Questions-Answers






