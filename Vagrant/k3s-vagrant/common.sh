# temporarily update resolv.conf in case that mirrors could not be resolved
cat <<EOF >> /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
service networking restart

# change mirror (for China users only)
# generated by: https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/

if [ "$OVERRIDE_MIRROR" = "yes" ]; then
    echo "Updating ububtu mirror to use tsinghua mirror"
cat <<EOF > /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
EOF
fi

if [ ! -z "$GITHUB_IP" ]; then
    echo "Resolve github.com to ${GITHUB_IP}"
    echo "$GITHUB_IP   github.com" >> /etc/hosts
fi

apt -y update && apt -y upgrade && apt install -y net-tools resolvconf


# add nameserver so that external domains could be resolved inside pods
# https://rancher.com/docs/rancher/v2.5/en/troubleshooting/dns/

cat <<EOF >> /etc/resolvconf/resolv.conf.d/head
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

sudo resolvconf -u
