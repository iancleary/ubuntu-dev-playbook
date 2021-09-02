ansible-role-zsh
=========

<p align="center">

<a href="https://github.com/icancclearynow/ansible-role-zsh/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-zsh/workflows/CI/badge.svg" alt="CI workflow status">
</a>

<a href="https://github.com/icancclearynow/ansible-role-zsh/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/icancclearynow/ansible-role-zsh/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://galaxy.ansible.com/icancclearynow/zsh" target="_blank">
    <img src="https://img.shields.io/badge/ansible--galaxy-icancclearynow.zsh-blue.svg" alt="Ansible Galaxy">
</a>
<a href="https://raw.githubusercontent.com/icancclearynow/ansible-role-zsh/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>
</p>

This role installs the [ZSH](https://www.zsh.org/), with the [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) plugin manager, onto a supported Linux system (see Requirements section below for list of supported OS).

Official plugins can be found here:

* <https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins>
* <https://github.com/zsh-users> (only select repos are plugins)

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here.

Supported and Tested `ansible_os_families`:

* Ubuntu 18.04
* Ubuntu 20.04
* Fedora 34

> Pull Requests welcome!

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

```yaml
---
ohmyzsh_bundles:
  # Bundles from the default repo (robbyrussell's oh-my-zsh) only need a name
  # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
  #
  # `name` is required (must match ohmyzsh Plugin name and/or git repo
  # `git.user` is git username
  # `git.repo` is git repo name
  # `git.version` is git release
  ## **** While `git` is option, if used, all three git attributes are required ****
   - name: gitfast
  # - name: pipenv
  - name: yarn
  # Syntax highlighting bundle.
  - name: zsh-syntax-highlighting
    git:
      user: zsh-users
      repo: zsh-syntax-highlighting
      version: 0.7.1
  # # Autosuggestions
  # - name: zsh-autosuggestions # `name` is required (any valid file name will do so long as it's unique for the bundles)
  #   repo:
  #     user: zsh-users
  #     repo: zsh-autosuggestions
  #     version: v0.6.4
  - name: powerlevel10k
    skip_zshrc_plugin:
    git:
      user: romkatv
      repo: powerlevel10k
      version: v1.12.0
zsh_theme: robbyrussell
zsh_custom_shell_command: "false"
# useful when users are bound to external systems (i.e. active directory)
# zsh_custom_shell_command: "true"
# zsh_default_shell_command: "/opt/pbis/bin/config LoginShellTemplate /usr/bin/zsh"
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
  roles:
    - role: icancclearynow.zsh
      users:
        - username: test_usr1
        - username: test_usr2
        - username: test_usr3
          skip_zshrc: true
      ohmyzsh_bundles:
        - name: gitfast
        - name: yarn
        # Syntax highlighting bundle.
        - name: zsh-syntax-highlighting
          git:
            user: zsh-users
            repo: zsh-syntax-highlighting
            version: 0.7.1
      zsh_aliases:
        # https://opensource.com/article/19/7/bash-aliases
        - ls='ls -F'
        - ll='ls -lh'
        - mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
        - hg='history|grep' # search bash history, I swapped the letters for github-cli compatibility
        - left='ls -t -1' # most recently edited files
        - cg='cd `git rev-parse --show-toplevel`' # go to git main level
```

> Note: the role currently assumes:

* all users want the same plugins, pull requests welcome if you'd prefer per user `ohmyzsh_bundles`

License
-------

[MIT](LICENSE)

Author Information
------------------

This role was created in 2020 by [Ian Cleary](https://blog.icancclearynow.me).

It was derived from the MIT licensed [gantsign/ansible-role-oh-my-zsh](https://github.com/gantsign/ansible-role-oh-my-zsh).

Inspiration for the structure of this repo came from [Jeff Geerling](https://github.com/geerlingguy/ansible-role-nginx).
