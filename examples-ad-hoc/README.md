# Examples ad-hoc modules

## Commom Options

-i=inventory\
-u=user\
-k=password(ask_pass)\
-K=elevated privilege user(become)\
-b=execute elevate privilege\
-v,-vv,-vvv=verbose\
-m=define module\
-a=module args\
-- help= helps

## command(default in ansible.cfg)

ansible -i hosts all -u vagrant -a "ls -la"
ansible -i hosts all -u vagrant -a "ls -la" -vv
ansible -i hosts all -u vagrant -a "cat /etc/hosts"

## ping

ansible -i hosts all -u vagrant -m ping
ansible -i hosts 192.168.0.135 -u vagrant -m ping
ansible -i hosts 192.168.0.135 -u vagrant -k -m ping

## setup

ansible -i hosts all -u vagrant -m setup
ansible -i hosts 192.168.0.135 -u vagrant -m setup
ansible -i hosts 192.168.0.135 -u -k vagrant -m setup

## systemd

ansible -i hosts 192.168.0.135 -u vagrant -b -m systemd -a "name=ssh state=restarted"

## shell

ansible -i hosts 192.168.0.134 -u vagrant -b -m shell -a "systemctl status ssh"
