# **<span style="color:green">Maven Tomcat Integration</span>**

---

## **<span style="color:green">Contact Information</span>**

For further assistance or inquiries, click the buttons below:

- [![Name](https://img.shields.io/badge/Name-Nditafon%20Hyson%20Nuigho-brightgreen)](mailto:nditafonhysonn@gmail.com)
- [![Phone](https://img.shields.io/badge/Phone-%2B237679638540-brightgreen)](tel:+237679638540)
- [![Email](https://img.shields.io/badge/Email-nditafonhysonn%40gmail.com-blue)](mailto:nditafonhysonn@gmail.com)
- [![GitHub](https://img.shields.io/badge/GitHub-Hyson--Wayne-lightgrey?logo=github)](https://github.com/Hyson-Wayne)
- [![LinkedIn](https://img.shields.io/badge/LinkedIn-nditafon--hyson-blue?logo=linkedin)](https://www.linkedin.com/in/nditafon-hyson-762a6623b/)

---

## **<span style="color:green">Deploying Maven Web Application in Tomcat</span>**

### **<span style="color:blue">Deployment Methods</span>**
1. **Manual Deployment**: Upload the `.war` file to Tomcat using the **Manager App GUI**.
2. **Automatic Deployment**: Transfer the `.war` file from the **Maven server** to Tomcat directly.

---

## **<span style="color:green">Manual Deployment</span>**

1. **Access the Tomcat Manager App:**
    ```bash
    http://<tomcat-public-ip>:<port>/manager
    ```
    - Login with the credentials configured in the `tomcat-users.xml` file.

2. **Deploy the `.war` file:**
   - Navigate to the **Deploy** section and upload the `.war` file.

---

## **<span style="color:green">Automatic Deployment from Maven Server</span>**

### **<span style="color:blue">Step 1: Prepare the Key Pair</span>**

1. **Create a private key file (`key.pem`)** on the Maven server:
    ```bash
    vi key.pem
    ```
    - Paste the **keypair** associated with your Tomcat server.

2. **Verify and secure the key file:**
    ```bash
    ls -l key.pem  # Verify the key file exists
    chmod 400 key.pem  # Restrict permissions to read-only for the user
    ls -l key.pem  # Confirm the updated permissions
    ```

---

### **<span style="color:blue">Step 2: Transfer the `.war` File</span>**

1. **Deploy the `.war` file to the Tomcat server using `scp`:**
    ```bash
    scp -i key.pem target/<your-artifact>.war ec2-user@<tomcat-public-ip>:/opt/tomcat10/webapps/
    ```
    **Example:**
    ```bash
    scp -i key.pem maven-app.war ec2-user@44.204.71.5:/opt/tomcat10/webapps/
    ```

---

### **<span style="color:blue">Step 3: Verify Deployment</span>**

1. **Access the Tomcat Manager App:**
    ```bash
    http://<tomcat-public-ip>:<port>/manager
    ```
    - Check that the `.war` file is listed under the **Applications** section.

2. **Click on the deployed application** to verify it is running.

---

## **<span style="color:green">Configuration Changes</span>**

### **Ensure Automatic Deployment**
1. **Edit the `server.xml` file:**
    ```bash
    sudo vi /opt/tomcat10/conf/server.xml
    ```
    - Verify the following attributes:
    ```xml
    unpackWARs="true"
    autoDeploy="true"
    ```

2. **Restart Tomcat:**
    ```bash
    stoptomcat
    starttomcat
    ```

---

### **Perform a Hotfix**
1. **Modify a JSP file for quick changes:**
    ```bash
    sudo vi /opt/tomcat10/webapps/<app-name>/jsps/home.jsp
    ```
    - Update the content (e.g., text changes) and save.

2. **Refresh the application** in the browser to see the changes.

---

This concludes the Maven-Tomcat integration process, enabling both manual and automatic deployment of web applications.
