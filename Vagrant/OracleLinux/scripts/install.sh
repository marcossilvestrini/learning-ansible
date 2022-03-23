#!/bin/bash

cd /home/vagrant

#Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant

#Set profile in /etc/profile
cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

# Enable Epel repo
#dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

# Install packages
dnf -y install vim

# SSH,FIREWALLD AND SELINUX
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
cat security/id_ecdsa.pub >>.ssh/authorized_keys
systemctl stop firewalld
systemctl disable firewalld
setenforce Permissive
