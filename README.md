# Leaning Ansible

![Ansible](https://user-images.githubusercontent.com/62715900/118187521-6a8efa00-b415-11eb-9479-6d73e36886a3.png)

## Getting Started

Fork the project and enjoy.\
Atention for pre requisites and License!!!

## Prerequisites

Virtual Box\
Vagrant\
Python3\
Ansible

## Authors

Marcos Silvestrini

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## References

[Virtualbox Docs](https://www.virtualbox.org/wiki/Documentation)\
[Vagrant Docs](https://www.vagrantup.com/docs/index.html)\
[Ansible Core Docs](https://docs.ansible.com/ansible-core/devel/index.html)\
[Ansible Main Page](https://docs.ansible.com/)\
[Ansible Tutorial](https://www.javatpoint.com/ansible)\
[Ansible Configuration Settings](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)\
[Ansible Configuration Examples](https://github.com/ansible/ansible/blob/devel/examples/ansible.cfg)\
[Best Practices](https://docs.ansible.com/ansible/2.9/user_guide/playbooks_best_practices.html#id9)
[Course Udemy](https://www.udemy.com/course/ansible-para-sysadmin/learn)

## Ansible Architeture

![image](https://user-images.githubusercontent.com/62715900/153963404-c0b87db7-dd0e-4c46-9b40-9b23e31593d8.png)

### Inventory

Inventory is lists of nodes or hosts having their IP addresses, databases, servers, etc. which are need to be managed.

### API's

The Ansible API's works as the transport for the public or private cloud services.

### Modules

Ansible connected the nodes and spread out the Ansible modules programs. Ansible executes the modules and removed after finished. These modules can reside on any machine; no database or servers are required here. You can work with the chose text editor or a terminal or version control system to keep track of the changes in the content.

### Plugins

Plugins is a piece of code that expends the core functionality of Ansible. There are many useful plugins, and you also can write your own.

### Playbooks

Playbooks consist of your written code, and they are written in YAML format, which describes the tasks and executes through the Ansible. Also, you can launch the tasks synchronously and asynchronously with playbooks.

### Hosts

In the Ansible architecture, hosts are the node systems, which are automated by Ansible, and any machine such as RedHat, Linux, Windows, etc.

### Networking

Ansible is used to automate different networks, and it uses the simple, secure, and powerful agentless automation framework for IT operations and development. It uses a type of data model which separated from the Ansible automation engine that spans the different hardware quite easily.

### Cloud

A cloud is a network of remote servers on which you can store, manage, and process the data. These servers are hosted on the internet and storing the data remotely rather than the local server. It just launches the resources and instances on the cloud, connect them to the servers, and you have good knowledge of operating your tasks remotely.

### CMDB

CMDB is a type of repository which acts as a data warehouse for the IT installations.

## Install Ansible

### Debian

```sh
sudo apt install -y ansible
```

### Rhel Centos 7\8

```sh
sudo yum install epel-release
sudo yum install ansible
```

### Install Ansible with pip(Recommended)

```sh
pip install ansible
```

## About ansible.cfg

### Generate ansible.cfg

```sh
#To generate an example config file (a "disabled" one with all default settings, commented out)
ansible-config init --disabled > ansible.cfg

#Also you can now have a more complete file by including existing plugins
ansible-config init --disabled -t all > ansible.cfg
```

### Examples custom ansible.cfg

```sh
[defaults]

#--- General settings
interpreter_python             = auto_legacy_silent
forks                           = 5
log_path                        = /var/log/ansible.log
module_name                     = command
executable                      = /bin/bash
ansible_managed                 = Ansible managed

#--- Files/Directory settings
inventory                       = /etc/ansible/hosts
library                         = /usr/share/ansible/plugins/modules
local_tmp                       = ~/.ansible/tmp
roles_path                      = /etc/ansible/roles

#--- Users settings
remote_user                     = root
ask_pass                        = False

#--- SSH settings
private_key_file                = ~/.ssh/id_rsa
remote_port                     = 22
timeout                         = 10
host_key_checking               = False

[privilege_escalation]

become                          = True
become_ask_pass                 = False
become_method                   = sudo
become_user                     = root

[persistent_connection]

command_timeout                 = 30
connect_timeout                 = 30

```

## Ad-Hoc Commands

### Commom Options

-i=inventory\
-u=user\
-k=password(ask_pass)\
-K=elevated privilege user(become)\
-b=execute elevate privilege\
-v,-vv,-vvv=verbose\
-m=define module\
-a=module args\
-- help= helps

### Collect and Display infos of server

`ansible localhost -m setup`

### Check inventory  hosts

```sh
ansible -i provisioning/hosts all -m ping
ansible -i provisioning/hosts web -m ping
```

### Check uptime

`ansible protheus -m command -a "uptime"`

### Get infos about setup

```sh
ansible protheus -m command -a "setup"
ansible -i hosts linux -u vagrant -m setup -a 'filter=ansible_distribution'
```

## Working with Inventory

```sh
#Example

[linux]
app_linux ansible_ssh_host=192.168.0.134
db_linux ansible_ssh_host=192.168.0.135

[win]
app_win ansible_ssh_host=192.168.0.136

[app]
app_linux ansible_ssh_host=192.168.0.134
app_win ansible_ssh_host=192.168.0.136

[linux:vars]
ansible_user=vagrant

[win:vars]
ansible_user= vagrant
ansible_password= vagrant
ansible_connection= winrm
ansible_port= 5986
ansible_winrm_transport= basic
ansible_winrm_server_cert_validation= ignore
ansible_python_interpreter= C:\Python310

[app:vars]
ansible_user= vagrant

[servers:children]
linux
win
```

## Roles

### Example Default Structure Paths

```sh
playbook.yml
roles/
    common/
        tasks/
        handlers/
        files/
        templates/
        vars/
        defaults/
        meta/
```

- tasks
list of tasks to be performed in a role.
- handlers
are handlers/events triggered by a task.
- files files
used for deployment within a function.
- templates
templates to deploy within a role (allows the use of
variable)
- vars
additional variables of a role.
- defaults
default variables of a function. Maximum priority.
- meta
handles dependencies of one role by another role – first
path analized by role.

## AWX

### Install
