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
    echo "192.168.0.133 ol8-ansible"
    echo "192.168.0.133 awx-dev.tesp2.local"

} \
    >>/etc/hosts

# Install Packages
dnf update -y
dnf install -y curl
dnf install -y sshpass
dnf install -y vim
dnf install -y tree
dnf install -y net-tools
dnf install -y git

# Set ssh
cp -f configs/01-sshd-custom.conf /etc/ssh/sshd_config.d
cat security/id_ecdsa.pub >>.ssh/authorized_keys
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)
systemctl restart sshd

# First diasbale swap
sudo swapoff -a

#And then to disable swap on startup in /etc/fstab
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Install K3S
export INSTALL_K3S_CHANNEL=v1.21
export K3S_NODE_NAME=${HOSTNAME//_/-}
export INSTALL_K3S_EXEC="--write-kubeconfig /home/vagrant/.kube/config --write-kubeconfig-mode 666"

curl -sfL https://get.k3s.io | sh -
systemctl enable k3s
chown vagrant:vagrant .kube/config

# # Deploy AWX
# kubectl apply -f /home/vagrant/configs/awx/staging/namespace.yml
# kubectl apply -f /home/vagrant/configs/awx/staging/secrets.yml

# git clone https://github.com/ansible/awx-operator.git
# cd awx-operator || exit
# git checkout 0.20.0
# export NAMESPACE=awx-dev
# make deploy
# kubectl apply -f /home/vagrant/configs/awx/staging/awx.yml
# kubectl apply -f /home/vagrant/configs/awx/staging/ingress.yml
