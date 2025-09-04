### Enabling XDR Sensors On Endpoint Computers
---
Endpoint computers require the appropriate XDR sensor to submit telemetry to the Trend Micro Vision One data lake.

1. Installing Trend Micro Endpoint Basecamp Services - the required services is automatically installed if Trend Micro Apex One as a Service is used - if not the Endpoint Basecamp Installer needs to be installed.
2. Enabling the XDR Sensor should be automatic.

Navigate to **Trend Vision One console:**

> [!tip]- Windows Installation at Trend Micro's Vision One
> 1. Expand **Endpoint Security Operations***.
> 2. Click the **Endpoint Inventory** app.
> 3. Click the **Agent Installer** tab.
> 4. Click to download the **Windows (32-bit, 64-bit)** package and save the resulting installer to a location accessible by the required endpoints.
> 
> An installer called EndpointBasecamp.exe is downloaded.
> 
> ![[Pasted image 20250416102458.png]]
> 
> Run the Installer and go to **services** and check for the following three services:
> - TM Clound Endpoint Telemetry Service
> - TM Endpoint Basecamp
> - TM Web Service Communicator
> To ensure communication happens properly, **configure** appropriate **Allow** rules in your firewall.

> [!tip]- MacOS Installation
> 1. Expand **Endpoint Security Operations.** 
> 2. Click the **Endpoint Inventory** app.
> 3. Click the **Agent Installer** tab.
> 4. Click to download the **macOS (64-bit)** package and save the resulting installer to a location accessible by the required endpoints.  
> 
> An installer endpoint_basecamp_mac.zip is downloaded and **run** the installer.
> 

#### Enabling the XDR Sensor on an Endpoint
---
In the Trend Micro Vision One console, click the **Endpoint Inventory** app. On the **Endpoint List** tab, click **All** to display a list of endpoints running the Trend Micro Endpoint Basecamp services.

![[Vision One for Administrators.png]]
- **XDR Sensor** under the **Features Enabled** column indicates it's already enabled.
- Check the checkbox of each endpoint to enable or disable.
- Can also use **View Recommendation Endpoints**.
- There will be a **confirmation dialog** alongside with the credits required.