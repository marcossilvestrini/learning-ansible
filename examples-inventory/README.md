# Example using inventory file

ansible -i hosts app -u vagrant -m ping

ansible -i hosts db -u vagrant -m setup
