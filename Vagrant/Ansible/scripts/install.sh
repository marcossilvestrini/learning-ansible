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
echo "192.168.0.133 debian-ansible-master" >>/etc/hosts

# Install Packages
apt install -y curl
apt install -y vim
apt install -y tree
apt install -y git

#Install X11 Server
apt install xserver-xorg -y
Xorg -configure
mv /root/xorg.conf.new /etc/X11/xorg.conf

# Set ssh
cp -f configs/01-sshd-custom.conf /etc/ssh/sshd_config.d
cat security/id_ecdsa.pub >>.ssh/authorized_keys
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)
systemctl restart sshd

#Install and Configure AWX Operator(with k3s)
curl -sfL https://get.k3s.io | sh -
systemctl enable k3s
git clone https://github.com/ansible/awx-operator.git
export NAMESPACE=awx-staging
cd  awx-operator || exit
git checkout 0.20.0
kubectl apply -f /home/vagrant/configs/awx/staging/namespace.yml
kubectl apply -f /home/vagrant/configs/awx/staging/secrets.yml
make deploy
kubectl apply -f /home/vagrant/configs/awx/staging/awx.yml
kubectl apply -f /home/vagrant/configs/awx/staging/ingress.yml

# #Install Kubernets Dashboard
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
# kubectl apply -f /home/vagrant/configs/kub-dash-user.yml
# kubectl apply -f /home/vagrant/configs/kub-dash-cluster-role-binding.yml
