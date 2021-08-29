ansible-role-yadm
=========

<p align="center">

<a href="https://github.com/icancclearynow/ansible-role-yadm/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-yadm/workflows/CI/badge.svg" alt="CI workflow status">
</a>

<a href="https://github.com/icancclearynow/ansible-role-yadm/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-yadm/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://galaxy.ansible.com/icancclearynow/yadm" target="_blank">
    <img src="https://img.shields.io/badge/ansible--galaxy-icancclearynow.yadm-blue.svg" alt="Ansible Galaxy">
</a>
<a href="https://raw.githubusercontent.com/icancclearynow/ansible-role-yadm/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>
</p>

This role installs the `yadm` dotfile manager.

Requirements
------------

A dotfile repo is recommended.

Supported and Tested `ansible_os_families`:

* Ubuntu 20.04

> Pull Requests welcome!

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

------------

Dotfiles repo to run `yadm clone`.


```yaml
yadm_dotfiles_repo: "https://github.com/icancclearynow/dotfiles"
```

------------

Dotfiles repo branch to clone from.

```yaml
yadm_dotfiles_branch: "main"
```

------------

Whether to run yadm bootstrap after cloning, if the repo doesn't already exist on your target.

```yaml
yadm_bootstrap: "false"
```

------------

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

N/A

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: desktop
  roles:
    - role: icancclearynow.yadm
      vars:
        yadm_dotfiles_repo: "https://github.com/icancclearynow/dotfiles"
        yadm_dotfiles_branch: "main"
        yadm_bootstrap: "false"
```

License
-------

[MIT](LICENSE)

Author Information
------------------

This role was created in 2021 by [Ian Cleary](https://icancclearynow.dev).

Inspiration for the structure of this repo came from [Jeff Geerling](https://github.com/geerlingguy/ansible-role-nginx).
