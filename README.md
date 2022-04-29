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
[Best Practices](https://docs.ansible.com/ansible/2.9/user_guide/playbooks_best_practices.html#id9)\
[Operator Framework](https://operatorframework.io/)\
[Operator Hub](https://operatorhub.io/)\
[AWX Operator](https://github.com/ansible/awx-operator)\
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

### Variables

Variable precedence
<https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html>

Ansible does apply variable precedence, and you might have a use for it.\
Here is the order of precedence from least to greatest (the last listed variables override all other variables):

1. command line values (for example, -u my_user, these are not variables)
2. role defaults (defined in role/defaults/main.yml)
3. inventory file or script group vars
4. inventory group_vars/all
5. playbook group_vars/all
6. inventory group_vars/*
7. playbook group_vars/*
8. inventory file or script host vars
9. inventory host_vars/*
10. playbook host_vars/*
11. host facts / cached set_facts
12. play vars
13. play vars_prompt
14. play vars_files
15. role vars (defined in role/vars/main.yml)
16. block vars (only for tasks in block)
17. task vars (only for the task)
18. include_vars
19. set_facts / registered vars
20. role (and include_role) params
21. include params
22. extra vars (for example, -e "user=my_user")(always win precedence)

### Inventory vars

```yml
[linux]
debian ansible_host=192.168.0.134
ol8 ansible_host=192.168.0.135

[win]
win2019 ansible_host=192.168.0.136

[linux:vars]
ansible_user=vagrant

[win:vars]
ansible_connection=winrm
ansible_winrm_scheme=https
ansible_port=5986
ansible_winrm_transport= certificate
ansible_winrm_cert_pem= /home/vagrant/.ssh/cert.pem
ansible_winrm_cert_key_pem=/home/vagrant/.ssh/cert_key.pem
ansible_winrm_server_cert_validation=ignore
```

### Vars in host_vars

host_vars/debian.yml

```yml

ansible_user: foo

```

### Vars in group_vars

group_vars/win

```yml
ansible_connection: winrm
ansible_winrm_scheme: https
ansible_port: 5986
ansible_winrm_transport: certificate
ansible_winrm_cert_pem: /home/vagrant/.ssh/cert.pem
ansible_winrm_cert_key_pem: /home/vagrant/.ssh/cert_key.pem
ansible_winrm_server_cert_validation: ignore
```

### Vars in Tasks

roles/common/default/main.yml

```yml

---
common_packages:
  - vim
  - gcc
  - tcdump

```

roles/common/tasks/main.yml

```yml
---

- name: Install Packages
  apt: name={{ item }} state=latest
  loop:
    - "{{ common_packages }}"

```

## AWX

### Architecture of awx

![image](https://user-images.githubusercontent.com/62715900/163888547-9c83681a-c541-4399-98db-d0b9e5f64e54.png)

![image](https://user-images.githubusercontent.com/62715900/163888299-fd41d7bd-b267-482c-a1d2-d5966bfd3ac7.png)

#### awx_web

The name delivers what this guy does, he's the one who provides the web interface and does all the intermediary between the awx_task and the user. As stated earlier, it is written in Python and uses the DJango framework

#### awx_task

As its name implies, this is the guy who performs all AWX tasks. Written in Python, it makes use of Ansible (obviously) to execute all the tasks that are scheduled and those that are triggered by launch

#### awx_rabbitmq

RabbitMQ is a messaging service developed in Erlang, implemented to support messages in a protocol called Advanced Message Queuing Protocol (AMQP). In the AWX architecture, it is used to exchange messages between awx_web and awx_tasks, allowing the decoupling between these two services

#### awx_memcached

This service is used to store the key value (KV) that AWX uses to store some information and perform “sticker exchange” between awx_tasks and awx_web

#### awx_postgres

This is the database used by AWX to store all the information created by the web interface. You can either use an existing database or upload a container with the database (which is the default in the installation).

### Install AWX (Using K3S)

#### Requirements AWX

>RAM: >=6GB
CPU: >= 2 Cores\
Storage: >= 20GB\

#### Requirements K3S

>RAM: >=512MB
CPU: >= 1 Cores\
Storage: >= SSD,Unique disk with mount point at /var/lib/rancher

#### Install k3s

```sh
curl -sfL https://get.k3s.io | sh -
systemctl enable k3s
```

#### Set secrets (optional)

`secrets.yml`

```yaml

---

apiVersion: v1
kind: Secret
metadata:
  name: awx-admin-password
  namespace: default
stringData:
  password: "vagrant"
...

```

```sh
#Apply secrets
kubectl apply -f secrets.yml
```

#### Deploy AWX Operator

```sh
#clone projetc
git clone https://github.com/ansible/awx-operator.git
cd awx-operator

#set latest version
git checkout 0.20.0

#define namespace
export NAMESPACE=default

#compile project
make deploy
```

`awx.yml`

```yaml
---
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx
spec:
  service_type: NodePort
  ingress_type: Ingress
  hostname: debian-ansible-master.local
...

```

```sh
#deploy pods
kubectl apply -f awx.yml
```

`ingress.yml`

```yaml

---

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: awx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  tls:
  - hosts:
    - debian-ansible-master
  rules:
    - host: debian-ansible-master
      http:
        paths:
          - backend:
              service:
                name: awx-service
                port:
                  number: 80
            path: /
            pathType: Prefix

...

```

```sh
#apply ingress
kubectl apply -f ingress.yml
```

#### Access AWX Web Gui

>URL: <http://debian-ansible-master>\
User: admin
Password: vagrant

#### Some Important Commands

```sh
#So we don't have to keep repeating -n awx, let's set the current namespace for kubectl:
#kubectl config set-context --current --namespace=awx

#Get secrets
kubectl get secrets


#Decrypt secret
kubectl get secret awx-admin-password -o jsonpath="{.data.password}"| base64 --decode

#list pod
kubectl get pods

#inspect pods
kubectl get events -w

#list services
kubectl get services

#list ingress
kubectl get ingress

#Access Kubernets Dashboard
##Get token
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

##URL
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```
