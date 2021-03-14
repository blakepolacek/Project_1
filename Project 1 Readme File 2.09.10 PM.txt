## Automated ELK Stack Deployment


The files in this repository were used to configure the network depicted below.


![TODO: Update the path with the name of your diagram](Images/diagram_filename.png) STILL NEED TO DO THIS!!!


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook (.yml) file may be used to install only certain pieces of it, such as Filebeat.


 -File path for playbooks: root@8b9d0e10e6a1:/etc/ansible/roles/filebeat-playbook.yml
 root@8b9d0e10e6a1:/etc/ansible/roles/metricbeat-playbook.yml
 root@8b9d0e10e6a1:/etc/ansible/elk.yml


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
 - Beats in Use
 - Machines Being Monitored
- How to Use the Ansible Build




### Description of the Topology


The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.


Load balancing ensures that the application will be highly responsive, in addition to restricting traffic to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?
Load balancers protect against DDoS attacks by shifting attack traffic to a separate cloud network.
Lets admins quickly access other points of the network with less restrictions. They can also be in a different security zone.


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- _TODO: What does Filebeat watch for?_ Log data
- _TODO: What does Metricbeat record?_ Metric data (system info for indexing)


The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.


| Name     | Function | Public IP     | Private IP | OS    |
|----------|----------|---------------|------------|-------|
| Jump Box | Gateway  | 104.211.24.35 | 10.0.0.4   | Linux |
| Elk VM   | Server   | 40.75.23.249  | 10.1.0.4   | Linux |
| Web-1    | Server   | 40.88.1.176   | 10.0.0.5   | Linux |
| Web-2    | Server   | 40.88.1.176   | 10.0.0.6   | Linux |


### Access Policies


The machines on the internal network are not exposed to the public Internet.


Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: 72.77.53.140
Public IP of my local machine


Machines within the network can only be accessed by Jump Box.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_
Jump Box Provisioner. 104.211.24.35


A summary of the access policies in place can be found in the table below.


| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 10.0.0.4:80          |
| Jump Box | Yes                 | 10.0.0.4:22          |
| Elk      | No                  | 10.1.0.4             |
| Web-1    | No                  | 10.0.0.5             |
| Web-2    | No                  | 10.0.0.6             |


### Elk Configuration


Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_
Allows for quick setup on the fly.


The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- Create Elk VM in Azure
- SSH to jump box
- Attach and start ansible container
- SSH to Elk VM


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
Screen Shot 2021-03-04 at 9.13.34 PM
![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)
  



### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_
| Web-1 | 40.88.1.176 |
| Web-2 | 40.88.1.176 |


We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_
Filebeat & Metricbeat


These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
Filebeat - Monitors log files, collects log events, and forwards it to elasticsearch.
ex) Most common internet protocols used in a geographic location. 
Metricbeat - Collects metric data such as system information. 
ex) Can pull the current OS version of a desired machine. 


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:


SSH into the control node and follow the steps below:
--Filebeat--
- Copy the filebeat-configuration.yml file to /etc/ansible/roles/files.
- Update the filebeat-configuration.yml file to include the elk private IP in lines 1106 and 1806.
- Run the playbook, and navigate to http://52.247.60.205:5601/app/kabana (elk vm public IP) to check that the installation worked as expected.
--Metricbeat--
- Copy the metricbeat-configuration.yml file to /etc/ansible/roles/files.
- Update the metricbeat-configuration.yml file to include the elk private IP in lines 62 and 96.
- Run the playbook, and navigate to http://52.247.60.205:5601/app/kabana (elk vm public IP) to check that the installation worked as expected.


_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
Playbook - filebeat-playbook.yml
Copy in ~/etc/ansible/roles
Playbook - metricbeat-playbook.yml
Copy in ~/etc/ansible/roles


- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
Update filebeat-config.yml and metricbeat-config.yml
This is decided by the groups [webservers] and [elk] in the config files respectively.


- _Which URL do you navigate to in order to check that the ELK server is running?
http://52.247.60.205:5601/app/kibana#/home
Elk server IP plus the port 5601. 


_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
ansible-playbook /etc/ansible/roles/filebeat-playbook.yml
ansible-playbook /etc/ansible/roles/metricbeat-playbook.yml


--Playbook data for filebeat-playbook.yml--
---
- name: installing and launching filebeat
  hosts: webservers
  become: yes
  tasks:


  - name: download filebeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb


  - name: install filebeat deb
    command: sudo dpkg -i filebeat-7.6.1-amd64.deb


  - name: drop in filebeat.yml
    copy:
      src: /etc/ansible/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml


  - name: enable and configure system module
    command: filebeat modules enable system


  - name: setup filebeat
    command: filebeat setup


  - name: start filebeat service
    command: service filebeat start


  - name: enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes




--Playbook data for filebeat-playbook.yml--
---
- name: installing and launching metricbeat
  hosts: webservers
  become: yes
  tasks:


  - name: download metricbeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb


  - name: install metricbeat deb
    command: sudo dpkg -i metricbeat-7.6.1-amd64.deb


  - name: drop in metricbeat.yml
    copy:
      src: /etc/ansible/files/metricbeat-config.yml
      dest: /etc/metricbeat/metricbeat.yml


  - name: enable and configure system module
    command: metricbeat modules enable system


  - name: enables to docker
    command: metricbeat modules enable docker


  - name: setup metricbeat
    command: metricbeat setup


  - name: start metricbeat service
    command: service metricbeat start


  - name: enable service metricbeat on boot
    systemd:
      name: metricbeat
      enabled: yes
      
      https://drive.google.com/file/d/16161EUWsLFaWLvNRgo6KjUpglq3_VcQC/view?usp=sharing
