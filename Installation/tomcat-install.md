# **<span style="color:green">Apache Tomcat Installation and Setup on AWS EC2 Red Hat Instance</span>**

---

## **<span style="color:green">Contact Information</span>**

For further assistance or inquiries, click the buttons below:

- [![Name](https://img.shields.io/badge/Name-Nditafon%20Hyson%20Nuigho-brightgreen)](mailto:nditafonhysonn@gmail.com)
- [![Phone](https://img.shields.io/badge/Phone-%2B237679638540-brightgreen)](tel:+237679638540)
- [![Email](https://img.shields.io/badge/Email-nditafonhysonn%40gmail.com-blue)](mailto:nditafonhysonn@gmail.com)
- [![GitHub](https://img.shields.io/badge/GitHub-Hyson--Wayne-lightgrey?logo=github)](https://github.com/Hyson-Wayne)
- [![LinkedIn](https://img.shields.io/badge/LinkedIn-nditafon--hyson-blue?logo=linkedin)](https://www.linkedin.com/in/nditafon-hyson-762a6623b/)

---

### **<span style="color:green">Prerequisites</span>**
- An **active AWS account**
- A **Red Hat EC2 instance** (e.g., t2.micro)
- **Security Group** with required ports open (e.g., port 8080 & 8177 for Tomcat)
- **Java OpenJDK 17** installed

## **<span style="color:green">Step 1: Set Hostname and Install Java</span>**

**Set the hostname and install Java:**
```bash
    # Change the hostname to 'tomcat'
    sudo hostnamectl set-hostname tomcat

    # Change to the /opt directory
    cd /opt

    # Install Git and Wget
    sudo yum install git wget -y

    # Install Java JDK 17
    sudo yum install java-17-openjdk-devel -y

    # Install additional packages
    sudo yum install unzip -y
```

## **<span style="color:green">Step 2: Download and Extract Tomcat</span>**

**Download and extract Apache Tomcat:**
```bash
    # Download Apache Tomcat version 9.0.98
    sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.zip

    # Extract the Tomcat zip file
    sudo unzip apache-tomcat-9.0.98.zip

    # Clean up by removing the zip file
    sudo rm -rf apache-tomcat-9.0.98.zip

    # Rename the directory for simplicity
    sudo mv apache-tomcat-9.0.98 tomcat9
```

## **<span style="color:green">Step 3: Set Up Tomcat Directory and Permissions</span>**

**Assign permissions to the Tomcat directory:**
```bash
    # Set executable permissions for the Tomcat home directory
    sudo chmod 777 -R /opt/tomcat9

    # Change the ownership to 'ec2-user'
    sudo chown ec2-user -R /opt/tomcat9
```

## **<span style="color:green">Step 4: Start Tomcat and Create Soft Links</span>**

**Start the Tomcat server and create soft links:**
```bash
    # Start the Tomcat server
    sh /opt/tomcat9/bin/startup.sh

    # Create symbolic links for easier management
    sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
    sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat

    # Switch back to the ec2-user
    sudo su - ec2-user

    # Start Tomcat using the soft link
    starttomcat
```

## **<span style="color:green">Access Tomcat</span>**

- **Access the Tomcat server via** `http://<your-ec2-ip>:8080`.

## **<span style="color:green">Configuration Changes</span>**

### **Change Port Number**
**Edit the `server.xml` file to change the port:**
```bash
    sudo vi /opt/tomcat9/conf/server.xml
```
- Locate the `<Connector>` tag and change the port from `8080` to `8177`.

**Restart Tomcat to apply the changes:**
```bash
    stoptomcat
    starttomcat
```

### **Enable External Access to the Tomcat Manager**
**Edit the `context.xml` file to allow external access:**
```bash
    sudo vi /opt/tomcat9/webapps/manager/META-INF/context.xml
```
- Comment out the following line to enable access:
```xml
    <!--
      <Valve className="org.apache.catalina.valves.RemoteAddrValve"
            allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
    -->
```

### **Add Users to Tomcat**
**Edit `tomcat-users.xml` to add user credentials:**
```bash
    sudo vi /opt/tomcat9/conf/tomcat-users.xml
```
- Add the following user configuration:
```xml
    <user username="YourName" password="PassWord" roles="manager-gui,admin-gui"/>
    <user username="hyson" password="hyson123" roles="manager-gui,admin-gui,manager-script"/>
```

This completes the setup and configuration for Apache Tomcat on your AWS EC2 Red Hat instance.
