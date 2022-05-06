# Example Roles and Tasks

## Example

File: examples/roles/commons/tasks/main.yml

```yml

---

- name: Update System
  dnf:
    name: '*'
    state: latest
    update_cache: yes


- name: Install Packages
  package:
    name: "{{ item }}"
    state: latest
  loop:
    - "{{ common_packages }}"



```

## Running Roles\Tasks

File: examples/play.yml

```yml

---

name: Paybook for Update System and Install Packages
hosts: linux
roles:
  - commom

...

```

```sh
#Example Execute Role\Tasks
ansible-playbook -i hosts play.yaml

```
