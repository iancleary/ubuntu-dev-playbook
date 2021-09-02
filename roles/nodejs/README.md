ansible-role-nodejs
=========

<p align="center">

<a href="https://github.com/icancclearynow/ansible-role-nodejs/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-nodejs/workflows/CI/badge.svg" alt="CI workflow status">
</a>

<a href="https://github.com/icancclearynow/ansible-role-nodejs/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-nodejs/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://galaxy.ansible.com/icancclearynow/nodejs" target="_blank">
    <img src="https://img.shields.io/badge/ansible--galaxy-icancclearynow.nodejs-blue.svg" alt="Ansible Galaxy">
</a>
<a href="https://raw.githubusercontent.com/icancclearynow/ansible-role-nodejs/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>
</p>

This role installs nodejs and npm.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here.

Supported and Tested `ansible_os_families`:

* Ubuntu 20.04

> Pull Requests welcome!

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

```yaml
---
# Set the version of Node.js to install (8.x", "10.x", "12.x", "13.x", etc.).
# Version numbers from Nodesource: https://github.com/nodesource/distributions
nodejs_version: "14.x"

# The directory for global installations.
npm_config_prefix: "/usr"

# Set to true to suppress the UID/GID switching when running package scripts. If
# set explicitly to false, then installing as a non-root user will fail.
npm_config_unsafe_perm: "false"

# Define a list of global packages to be installed with NPM.
# nodejs_npm_global_packages: []
#  # Install a specific version of a package.
#  - name: jslint
#    version: 0.9.3
#  # Install the latest stable release of a package.
#  - name: node-sass

nodejs_npm_global_packages:
 - name: yarn
```

Additionally, one can define the user and group for the `npm_config_prefix` directory.

The default is for them to be undefined, upon which they both  default to the `USER` environment variable.

```yaml
nodejs_install_npm_user: 'user1'
nodejs_install_npm_group: 'group1'
```

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

N/A

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: servers
  user: unprivelaged
  roles:
    - role: icancclearynow.nodejs
      become: true
      npm_config_unsafe_perm: "true"
      nodejs_npm_global_packages:
        # Install a specific version of a package.
        - name: jslint
          version: 0.9.3
        # Install the latest stable release of a package.
        - name: node-sass
```

```yaml
- hosts: servers
  user: root
  roles:
    - role: icancclearynow.nodejs
      nodejs_npm_global_packages:
        # Install a specific version of a package.
        - name: jslint
          version: 0.9.3
        # Install the latest stable release of a package.
        - name: node-sass
```

License
-------

[MIT](LICENSE)

Author Information
------------------

This role was created in 2021 by [Ian Cleary](https://icancclearynow.dev).

Inspiration for the structure of this repo came from [Jeff Geerling](https://github.com/geerlingguy/ansible-role-nodejs).
