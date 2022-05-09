# Example Roles and Tasks

## Example Update System

File: examples/roles-tasks/roles/updates/tasks/main.yml

```yml

---

# Update Debian
- name: Update System RPM (Debian, Ubuntu)
  apt:
    update_cache: yes
    upgrade: yes
  when: ansible_facts['os_family'] == "Debian"

# Update RPM
- name: Update System RPM (RedHat, OracleLinux,CentOS,Fedora)
  yum:
    name: '*'
    state: latest
    security: yes
  when: ansible_facts['os_family'] == "RedHat"

...

```

## Example Install Packages

File: examples/roles-tasks/roles/commons/tasks/main.yml

```yml

---

- name: Install Packages
  package:
    name: "{{ item }}"
    state: latest
  loop:
    - "{{ common_packages }}"

...

```

## Example Handlers

File: examples/roles-tasks/roles/commom/handlers/main.yml

```yml

---

- name: Restart nginx
  systemd:
    name: nginx
    state: restarted
    enable: yes

...

```

## Example Meta

File: examples/roles-tasks/roles/commom/meta/main.yml

```yml

dependencies:
  - {role: updates}
  - {role: php}

```

## Running Roles\Tasks

File: examples/play.yml

```yml

---

name: Deploy Application
hosts: linux
roles:
  - commom
  - set-motd
  - sync-bkp

...

```

```sh
#Example Execute Role\Tasks
ansible-playbook -i hosts play.yaml

```
