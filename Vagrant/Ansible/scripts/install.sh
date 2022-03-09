#!/bin/bash

cd /home/vagrant

#Set profile in /etc/profile
cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

# Install Packages
apt install -y vim
apt install -y net-tools
apt install -y git

# Install Ansible
#sudo apt install -y ansible
apt install -y python3-pip
pip3 install --no-cache-dir ansible

#Clone Project Repository files

rm -rf ansible/
git clone https://github.com/marcossilvestrini/learning-ansible.git
mv learning-ansible ansible
chown -R vagrant:vagrant ansible/

#Ansible Configs
mkdir -p /etc/ansible/roles
mkdir -p /usr/share/ansible/plugins/modules
echo localhost >/etc/ansible/hosts
touch /var/log/ansible.log
chmod 447 /var/log/ansible.log
mv ansible/Configs/ansible_custom.cfg /etc/ansible/ansible.cfg
rm -rf ansible/Configs/ ansible/Vagrant ansible/diagrams ansible/scripts ansible/Helps LICENSE README.md
rm ansible/LICENSE ansible/README.md

# Set ssh
cat security/id_rsa.pub >>.ssh/authorized_keys
cp -f security/id_ecdsa* .ssh/
