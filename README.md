## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](/Diagrams/network.drawio.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  - [Elk Install](Ansible/install-elk.yml)
  - [Filebeat Install](Ansible/filebeat-playbook.yml)
  - [Metricbeat Install](Ansible/metricbeat-playbook.yml)
  - [DVWA setup](Ansible/pentest.yml)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly monitored, in addition to restricting access to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_
	A load balancer acts as a single access point to all servers it services. This allows it to monitors the stress of traffic on those under its network to distribute traffic between all servers its monitoring and allows for restricted access to those servers if required. 
	A jumpbox gives a secure environment, be that a computer or virtual machine, that an admin first connects to before connecting to a server or untrusted environment. This allows for a more secure server because you only need to whitelist the jumpbox as opposed to all admin of the server.
Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system data.
- _TODO: What does Filebeat watch for?_
	Filebeat monitors the log files of all VMs its monitoring and any other files its told to watch. It then logs those changes and forwards them to another program for an admin to look over later.
- _TODO: What does Metricbeat record?_
	Metricbeat monitors the operating system and services running on the VMs and logs the data. This can be viewed with another service by an admin if needed on a later date, allowing you to see stresses or other problems to your network.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     |       Function      | IP Address | Operating System |
|----------|---------------------|------------|------------------|
| Jump Box |       Gateway       |  10.0.0.4  | Linux            |
| Web 1    |      Web Server     |  10.0.0.5  | Linux            |
| Web 2    |      Web Server     |  10.0.0.6  | Linux            |
| ELK VM   | Elasticsearch Stack |  10.1.0.4  | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: Add whitelisted IP addresses_
	75.168.94.215

Machines within the network can only be accessed by the Jump box.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_
	My personal desktop through port 5601 @ IP 75.168.94.215
	Any machine with the correct key can connect through port 22 (but only the vm on the jumpbox currently is set up to do so)
A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible:(Ports) | Allowed IP Addresses |
|---------------|-----------------------------|----------------------|
| Jump Box      | Yes:22, 80, 3389            | 75.168.94.215        |
| Load Balancer | Yes:22, 80, 3389            | Any                  |
| Elk Server    | Yes:22, 5601                | Any                  |
| Web-1         | No                          | 10.0.0.4, 10.1.0.4   |
| Web-2         | No                          | 10.0.0.4, 10.1.0.4   |

* This may not be the answers you were looking for as far as access goes, but I feel like this is a more correct then saying Web-1 is not publicly availible, because people get there from port 80 after going through the load balancer. Even though the server has no public IP, they do gain access to the system. That is why I have said any IP has access to all public servers, they may only be able to access those 3 ports but that doesnt mean they can ssh into them, but those ports are still open.
### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?
	Configuring an ansible playbook allows you to set up several environments with less time used than if set up manually. By running the correctly configured playbook you minimize the potential for errors and change the required time to set up a system to one command.

The playbook implements the following tasks:
- Install Dockers
- Installs Python3
- Installs Dockers python modules and allocates more memory to each system
- Installs ELK container
- Enables docker service on system boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![sudo docker ps](/Diagrams/ssforP1.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: Forwards log data to the Elk server for monitoring my the system admin. This information is then viewed through a 3rd party software such as elasticsearch/Logstash to make system monitor easily searchable and minitored through their GUI. Will track any changed to the log files on either system.
- Metricbeat: Tracks metrics from operating systems and services running on the server. 
### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the hosts file to root/etc/ansible/roles.
- Update the root/etc/ansible/hosts file to include the private IP's of webservers and ELKserver
- Update the root/etc/ansible/ansible.cfg to include the remote_user of the intended users
- Run the playbook, and navigate to the newly created container and type curl localhost/setup.php to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_ the playbook is pentest.yml. You copy that file to /etc/ansible/hosts. The command should be anisble-playbook /etc/ansible/pentest.yml
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_ To run the playbook on a new system edit the /etc/ansible/hosts file with the local IP of the new VM. If you are attempting to add an ELK server you should use the install-elk.yml file. To differentiate between a normal server setup and an ELK server set up, the host.cfg file has different spots for each type of server. Elk servers should be under a new group called [elkservers] while other servers will be added under [webservers] after the # is taken out of the file in that section.
- _Which URL do you navigate to in order to check that the ELK server is running? http://<ELK_SERVER_PUBLIC_IP>:5601

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
