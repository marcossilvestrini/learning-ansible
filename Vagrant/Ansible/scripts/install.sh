#!/bin/bash

cd /home/vagrant

#Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant

#Set profile in /etc/profile
cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

# Install Packages
apt install -y sshpass
apt install -y vim
apt install -y tree
apt install -y net-tools
apt install -y git

# Set ssh
cp -f configs/01-sshd-custom.conf /etc/ssh/sshd_config.d
cat security/id_ecdsa.pub >>.ssh/authorized_keys
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)
systemctl restart sshd

#Copy public keys for clients
echo vagrant | $(su -c "ssh-keyscan 192.168.0.134 >>.ssh/known_hosts" -s /bin/bash vagrant)
echo vagrant | $(su -c "ssh-keyscan 192.168.0.135 >>.ssh/known_hosts" -s /bin/bash vagrant)
echo vagrant | $(su -c "sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub vagrant@192.168.0.134" -s /bin/bash vagrant)
echo vagrant | $(su -c "sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub vagrant@192.168.0.135" -s /bin/bash vagrant)

# Install Ansible
#sudo apt install -y ansible
apt install -y python3-pip
pip3 install --no-cache-dir ansible
pip3 install --no-cache-dir --ignore-installed --no-warn-script-location pywinrm

#Clone Project Repository files
rm -rf ansible/
git clone https://github.com/marcossilvestrini/learning-ansible.git
mv learning-ansible ansible
chown -R vagrant:vagrant ansible/

#Ansible Configs
mkdir -p /etc/ansible/roles
mkdir -p /usr/share/ansible/plugins/modules
echo 192.168.0.1333 >/etc/ansible/hosts
touch /var/log/ansible.log
chmod 447 /var/log/ansible.log
mv ansible/Configs/ansible_custom.cfg /etc/ansible/ansible.cfg
rm -rf ansible/Configs/ ansible/Vagrant ansible/diagrams ansible/scripts ansible/Helps LICENSE README.md
rm ansible/LICENSE ansible/README.md
