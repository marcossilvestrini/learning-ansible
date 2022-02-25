#!/bin/bash

#Set profile in /etc/profile
sudo cp -f /home/vagrant/configs/profile /etc

# Set bash session
rm /home/vagrant/.bashrc
cp -f /home/vagrant/configs/.bashrc /home/vagrant

# Set ssh
cat /home/vagrant/security/id_rsa.pub >>/home/vagrant/.ssh/authorized_keys

# Install Packages
sudo apt install -y vim
sudo apt install -y net-tools
sudo apt install -y git

# Install Ansible
#sudo apt install -y ansible
sudo apt install -y python3-pip
sudo pip3 install --no-cache-dir ansible

#Clone Project Repository
git clone https://github.com/marcossilvestrini/learning-ansible.git
mkdir ansible
