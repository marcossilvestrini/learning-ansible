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

[Ansible Core Docs](https://docs.ansible.com/ansible-core/devel/index.html)\
[Ansible Main Page](https://docs.ansible.com/)\
[Virtualbox Docs](https://www.virtualbox.org/wiki/Documentation)\
[Vagrant Docs](https://www.vagrantup.com/docs/index.html)

## Install Ansible in Rhel Centos 7\8

```sh
sudo yum install epel-release
sudo yum install ansible
```

## Setup Inventory file examples

```sh
[all]
192.168.0.134
192.168.0.135
192.168.0.136

[debian]
192.168.0.134

[debian:vars]
ansible_user=ansible
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[ol8]
192.168.0.135

[ol8:vars]
ansible_user=ansible
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[win]
192.168.0.136

[win:vars]
ansible_user=ansible
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

## Ad-Hoc Commands

### Collect and Display infos of server

`ansible localhost -m setup`

### Check inventory  hosts

```sh
ansible -i provisioning/hosts all -m ping
ansible -i provisioning/hosts web -m ping

```

### Check uptime

`ansible protheus -m command -a "uptime"`

## Check playbook syntax

`ansible-playbook playbook.yml --syntax-check`
