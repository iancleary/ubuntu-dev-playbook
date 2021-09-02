ansible-role-docker
=========

<p align="center">

<a href="https://github.com/icancclearynow/ansible-role-docker/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-docker/workflows/CI/badge.svg" alt="CI workflow status">
</a>

<a href="https://github.com/icancclearynow/ansible-role-docker/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-docker/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://galaxy.ansible.com/icancclearynow/docker" target="_blank">
    <img src="https://img.shields.io/badge/ansible--galaxy-icancclearynow.docker-blue.svg" alt="Ansible Galaxy">
</a>
<a href="https://raw.githubusercontent.com/icancclearynow/ansible-role-docker/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>
</p>

This role installs docker and docker-compose.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here.

Supported and Tested `ansible_os_families`:

* Ubuntu 18.04
* Ubuntu 20.04

> Pull Requests welcome!

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

---

```yaml
docker_install_compose: true
```
Boolean value to install docker-compose

---

```yaml
docker_compose_version: 1.29.2
```

Release tag to use from [Docker Compose GitHub Repo's Releases](https://github.com/docker/compose/releases/)

---

```yaml
docker_compose_path: /usr/local/bin/docker-compose
```
Path to install docker-compose executable to

```yaml
docker_users: []
```

The users to be added to the docker group, this defaults to an empty list. This allows the listed users to run docker without `sudo`.

---

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

`N/A`

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: servers
  user: unprivelaged
  roles:
    - role: icancclearynow.docker
      become: true
```

```yaml
- hosts: servers
  user: root
  roles:
    - role: icancclearynow.docker
```

License
-------

[MIT](LICENSE)

Author Information
------------------

This role was created in 2021 by [Ian Cleary](https://icancclearynow.dev).

Inspiration for the structure of this repo came from [Jeff Geerling](https://github.com/geerlingguy/ansible-role-docker).
