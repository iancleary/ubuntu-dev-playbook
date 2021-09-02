ansible-role-github_cli
=========

<p align="center">

<a href="https://github.com/icancclearynow/ansible-role-github_cli/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-github_cli/workflows/CI/badge.svg" alt="CI workflow status">
</a>

<a href="https://github.com/icancclearynow/ansible-role-github_cli/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-github_cli/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://galaxy.ansible.com/icancclearynow/github_cli" target="_blank">
    <img src="https://img.shields.io/badge/ansible--galaxy-icancclearynow.github_cli-blue.svg" alt="Ansible Galaxy">
</a>
<a href="https://raw.githubusercontent.com/icancclearynow/ansible-role-github_cli/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>
</p>

This role installs the [GitHub CLI](https://github.com/cli/cli).

> gh is GitHub on the command line. It brings pull requests, issues, and other GitHub concepts to the terminal next to where you are already working with git and your code.

Requirements
------------

This role has the `github3.py` pip dependency to get the latest release of the GitHub repo.

> `python3 -m pip install github3.py`

Supported and Tested `ansible_os_families`:

* Ubuntu 18.04
* Ubuntu 20.04
* elementary OS 6
* Fedora 34

> Pull Requests welcome!

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

------------

Specify the release version to install from GitHub

```yaml
# gh_version: 1.6.1 # undefined is latest release
```

------------

Specify the archicture you which to install on: i.e. `amd64`, `arm64`, `armv6`, or `386` at the time of this writing.

```yaml
gh_arch: "amd64" # used in remote package url
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
- hosts: servers
  roles:
    - role: icancclearynow.github_cli
```

License
-------

[MIT](LICENSE)

Author Information
------------------

This role was created in 2021 by [Ian Cleary](https://icancclearynow.dev).

Inspiration for the structure of this repo came from [Jeff Geerling](https://github.com/geerlingguy/ansible-role-nginx).
