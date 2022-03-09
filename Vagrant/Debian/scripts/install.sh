#!/bin/bash

cd /home/vagrant

#Set profile in /etc/profile
sudo cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

# Set ssh
cat security/id_rsa.pub >>.ssh/authorized_keys
cat security/id_ecdsa.pub >>.ssh/authorized_keys

# Install vim
sudo apt install -y vim
#sudo apt install -y net-tools
