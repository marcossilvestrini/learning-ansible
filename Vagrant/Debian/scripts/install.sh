#!/bin/bash

cd /home/vagrant

#Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant

#Set profile in /etc/profile
cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

#Set hosts
{
    echo "192.168.79.133 debian-ansible-master"
    echo "192.168.79.134 debian-ansible"
    echo "192.168.79.135 ol8-ansible"
} >> /etc/hosts

# Install Packages
apt install -y vim

# Set ssh
cp -f configs/01-sshd-custom.conf /etc/ssh/sshd_config.d
systemctl restart sshd
cat security/id_ecdsa.pub >>.ssh/authorized_keys
