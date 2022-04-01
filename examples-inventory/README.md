# Example using inventory file

```sh
ansible -i hosts app_linux -u vagrant -m setup
ansible -i hosts linux -m setup
ansible -i hosts servers -m ping
ansible -i hosts linux -u vagrant -m setup -a 'filter=ansible_distribution'

```
