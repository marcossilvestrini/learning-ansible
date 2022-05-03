#!/bin/bash

cd /home/vagrant || exit

#Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant

#Set profile in /etc/profile
cp -f configs/profile /etc

# Set bash session
rm .bashrc
cp -f configs/.bashrc .
cp -f configs/.vimrc .

#Set hosts
{
    echo "192.168.0.133 debian-ansible-awx"
    echo "192.168.0.133 awx-dev.tesp2.local"
    echo "192.168.0.134 debian-ansible"
    echo "192.168.0.135 ol8-ansible"
} >>/etc/hosts

# Install Packages
apt update -y
apt install -y curl
apt install -y sshpass
apt install -y vim
apt install -y tree
apt install -y net-tools
apt install -y git

# #Install X11 Server
# apt install xserver-xorg -y
# Xorg -configure
# mv /root/xorg.conf.new /etc/X11/xorg.conf

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

# Copy public keys for clients
# echo vagrant | $(su -c "ssh-keyscan 192.168.0.134 >>.ssh/known_hosts" -s /bin/bash vagrant)
# echo vagrant | $(su -c "ssh-keyscan 192.168.0.135 >>.ssh/known_hosts" -s /bin/bash vagrant)
# echo vagrant | $(su -c "sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub vagrant@192.168.0.134" -s /bin/bash vagrant)
#echo vagrant | $(su -c "sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ecdsa.pub vagrant@192.168.0.135" -s /bin/bash vagrant)

# Install Ansible
apt install -y python3-pip
pip3 install --no-cache-dir ansible
pip3 install --no-cache-dir --ignore-installed --no-warn-script-location pywinrm

# # Clone Project Repository files
# rm -rf ansible/
# git clone https://github.com/marcossilvestrini/learning-ansible.git
# mv learning-ansible ansible
# chown -R vagrant:vagrant ansible/

# # Ansible Configs
# mkdir -p /etc/ansible/roles
# mkdir -p /usr/share/ansible/plugins/modules
# echo 192.168.0.1333 >/etc/ansible/hosts
# touch /var/log/ansible.log
# chmod 447 /var/log/ansible.log
# mv ansible/Configs/ansible_custom.cfg /etc/ansible/ansible.cfg
# rm -rf ansible/Configs \
#     ansible/Vagrant \
#     ansible/diagrams \
#     ansible/scripts \
#     ansible/Helps \
#     ansible/docs \
#     ansible/LICENSE \
#     ansible/README.md

# First diasbale swap
sudo swapoff -a

#And then to disable swap on startup in /etc/fstab
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Install K3S
export INSTALL_K3S_CHANNEL=v1.22
export K3S_NODE_NAME=${HOSTNAME//_/-}
export INSTALL_K3S_EXEC="--write-kubeconfig /home/vagrant/.kube/config --write-kubeconfig-mode 666"

curl -sfL https://get.k3s.io | sh -
systemctl enable k3s
chown vagrant:vagrant .kube/config

# Deploy AWX
kubectl apply -f /home/vagrant/configs/awx/staging/namespace.yml
kubectl apply -f /home/vagrant/configs/awx/staging/secrets.yml

git clone https://github.com/ansible/awx-operator.git
cd awx-operator || exit
git checkout 0.20.0
export NAMESPACE=awx-dev
make deploy
kubectl apply -f /home/vagrant/configs/awx/staging/awx.yml
kubectl apply -f /home/vagrant/configs/awx/staging/ingress.yml

# # #Copy token for workers
# # cat /var/lib/rancher/k3s/server/node-token >/home/vagrant/k3s-token
# # scp -i /home/vagrant/.ssh/id_ecdsa \
# #     -o UserKnownHostsFile=/dev/null \
# #     -o StrictHostKeyChecking=no \
# #     /home/vagrant/k3s-token \
# #     vagrant@192.168.0.134:/home/vagrant

# #Install Kubernets Dashboard
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
# kubectl apply -f /home/vagrant/configs/kub-dash-user.yml
# kubectl apply -f /home/vagrant/configs/kub-dash-cluster-role-binding.yml
