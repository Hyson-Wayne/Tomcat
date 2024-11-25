#!/bin/bash

# Apache Tomcat Installation and Setup on AWS EC2 Red Hat Instance

# Step 1: Set Hostname and Install Java
sudo hostnamectl set-hostname tomcat
cd /opt
sudo yum install git wget unzip java-17-openjdk-devel -y

# Step 2: Download and Extract Tomcat
sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.33/bin/apache-tomcat-10.1.33.zip
sudo unzip apache-tomcat-10.1.33.zip
sudo rm -rf apache-tomcat-10.1.33.zip
sudo mv apache-tomcat-10.1.33 tomcat10

# Step 3: Set Up Tomcat Directory and Permissions
sudo chmod 777 -R /opt/tomcat10
sudo chown ec2-user -R /opt/tomcat10

# Step 4: Start Tomcat and Create Soft Links
sh /opt/tomcat10/bin/startup.sh
sudo ln -s /opt/tomcat10/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat10/bin/shutdown.sh /usr/bin/stoptomcat

echo "Apache Tomcat installation and setup complete. Use 'starttomcat' to start Tomcat and 'stoptomcat' to stop it."
