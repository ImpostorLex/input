## Analyzing and Responding to Threats Through XDR
---
The Trend Micro Vision One platform includes **Extended Detection and Response (XDR)** capabilities that collect and correlate activity data across multiple vectors – email, endpoints, servers, cloud workloads, and networks.


- XDR uses native sensors to collect deep activity data, not just detections, across email, endpoints, servers, cloud workloads, and networks and stores the telemetry in a data lake. 
- Detection models scan the data lake regularly to stitch together threat activity across layers providing an unmatched understanding of the activity data in the environment.

The detection models, which generate the alert triggers, combine multiple rules and filters using a variety of analysis techniques including data stacking and machine learning

Each detection model uses one or more filters to detect suspicious behaviors or events based on associated [MITRE](https://attack.mitre.org/) techniques and reported threat indicators

![[Vision One for Administrators-8.png|450]]
### Workbenches (Alert View)
---
The **Alert View** tab displays alerts triggered by detection models and allows you to further investigate each alert.

![[Vision One for Administrators-9.png|450]]

Alert in detail (In order):

![[Vision One for Administrators-10.png]]
- Status: new, in progress, closed, closed - false positive.
- Score of the **overall severity**.
- Unique Identifier for the alert.
- What detection model triggered the alert.
- Severity assigned to that model.
- What are the affected (including potential) entities.

**Clicking one** of the workbench ID, allows to edit settings, analyze the even, and objects and include notes:

![[Vision One for Administrators-11.png]]

- The **Highlights** pane lists the specific detection filters that triggered the alert and the objects affected.

---

View a demonstration of navigating in the Workbench and using Incident views:
https://cdn5.dcbstatic.com/files/t/r/trendmicroeducation_docebosaas_com/1744801200/NRm4_aixAcg455GrviYn4A/scorm/f24c3fb82e1b479120e9826826d83cf7adcdbbee/course/en/assets/61e1a26b6c70eb0bc48460b1/video.mp4
