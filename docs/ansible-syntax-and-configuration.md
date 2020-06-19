# Syntax Notes

For reference:

[Loop syntax reference](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html)

After Ansible 2.5:

```yaml
- name: install core packages
  become: true
  apt:
    name: "{{ item }}"
    state: present
  loop:
    - git
    - make
```

Before Ansible 2.5:

```yaml
- name: install core packages
  become: true
  apt:
    name: "{{ item }}"
    state: present
  with_items:
    - git
    - make
```

Passwords for enable mode

<https://docs.ansible.com/ansible/latest/user_guide/become.html>

## Python Interpreter

[ansible.cfg](https://github.com/iancleary/ansible-desktop/blob/main/ansible.cfg)

```ini
[defaults]
#ansible_python_interpreter = "/usr/bin/python3"
interpreter_python ="/usr/bin/python3"
```

Reference:
<https://docs.ansible.com/ansible/latest/reference_appendices/interpreter_discovery.html>
