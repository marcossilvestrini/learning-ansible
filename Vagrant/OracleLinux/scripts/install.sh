#!/bin/bash

cd /home/vagrant

#Set profile in /etc/profile
sudo cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

# SSH,FIREWALLD AND SELINUX
cat security/id_rsa.pub >>.ssh/authorized_keys
cat security/id_ecdsa.pub >>.ssh/authorized_keys
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo setenforce Permissive

# Enable Epel repo
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo dnf -y upgrade
#sudo dnf makecache --refresh

# Install packages
sudo dnf -y install vim
sudo dnf -y install net-tools
