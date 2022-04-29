#!/bin/bash

cd /home/vagrant || exit

#Set password account
usermod --password "$(echo vagrant | openssl passwd -1 -stdin)" vagrant

#Set profile in /etc/profile
cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

#Set hosts
echo "192.168.0.133 debian-ansible-master" >>/etc/hosts

# Install Packages
apt install -y curl
apt install -y sshpass
apt install -y vim
apt install -y tree
apt install -y net-tools
apt install -y git
apt install -y firefox-esr

#Install X11 Server
apt install xserver-xorg -y
Xorg -configure
mv /root/xorg.conf.new /etc/X11/xorg.conf

# Set ssh
cp -f configs/01-sshd-custom.conf /etc/ssh/sshd_config.d
cat security/id_ecdsa.pub >>.ssh/authorized_keys
cp security/cert* .ssh/
chmod 600 .ssh/cert_key.pem
chmod 644 .ssh/cert.pem
chown vagrant:vagrant .ssh/cert_key.pem
chown vagrant:vagrant .ssh/cert.pem
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)
systemctl restart sshd

# #Copy public keys for clients
# echo vagrant | "$(su -c "ssh-keyscan 192.168.0.134 >>.ssh/known_hosts" -s /bin/bash vagrant)"
# echo vagrant | "$(su -c "ssh-keyscan 192.168.0.135 >>.ssh/known_hosts" -s /bin/bash vagrant)"
# echo vagrant | "$(su -c "sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub vagrant@192.168.0.134" -s /bin/bash vagrant)"
# echo vagrant | "$(su -c "sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub vagrant@192.168.0.135" -s /bin/bash vagrant)"

# # Install Ansible
# #sudo apt install -y ansible
# apt install -y python3-pip
# pip3 install --no-cache-dir ansible
# pip3 install --no-cache-dir --ignore-installed --no-warn-script-location pywinrm

# #Clone Project Repository files
# rm -rf ansible/
# git clone https://github.com/marcossilvestrini/learning-ansible.git
# mv learning-ansible ansible
# chown -R vagrant:vagrant ansible/

# #Ansible Configs
# mkdir -p /etc/ansible/roles
# mkdir -p /usr/share/ansible/plugins/modules
# echo 192.168.0.1333 >/etc/ansible/hosts
# touch /var/log/ansible.log
# chmod 447 /var/log/ansible.log
# mv ansible/Configs/ansible_custom.cfg /etc/ansible/ansible.cfg
# rm -rf ansible/Configs \
# ansible/Vagrant \
# ansible/diagrams \
# ansible/scripts \
# ansible/Helps \
# ansible/docs \
# ansible/LICENSE \
# ansible/README.md

#Install k3s
curl -sfL https://get.k3s.io | sh -
systemctl enable k3s

#Install and Configure AWX Operator
git clone https://github.com/ansible/awx-operator.git
cp -R configs/awx/staging/ awx-operator
cp configs/awx/staging/kustomization.yml awx-operator
cd awx-operator || exit
rm -rf .git .github
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
./kustomize build . | kubectl apply -f -

#Install Kubernets Dashboard
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
# kubectl apply -f /home/vagrant/configs/awx/staging/kub-dash-user.yml
# kubectl apply -f /home/vagrant/configs/awx/staging/kub-dash-cluster-role-binding.yml
