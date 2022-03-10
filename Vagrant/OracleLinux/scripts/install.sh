#!/bin/bash

cd /home/vagrant

#Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant

#Set profile in /etc/profile
sudo cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

# SSH,FIREWALLD AND SELINUX
cat security/id_rsa.pub >>.ssh/authorized_keys
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo setenforce Permissive

# Enable Epel repo
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
#sudo dnf -y upgrade

# Install packages
sudo dnf -y install vim
