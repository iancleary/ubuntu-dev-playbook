# personal-ansible

![CI Badge](https://github.com/iancleary/personal-ansible/workflows/CI/badge.svg)

## Personal Ansible Playbook to configure my laptops and desktops.

I care about not having to think too much about my setup between machines, especially when I want to get right to work.  For that reason, it is very comfortable for me to have the same base configuration on each machine (look, feel, keyboard shortcuts, core software, etc.).

### My journey to the current state of this repo:

* I found a cool bash script on the internet (*I didn't understand most of it*) 🤷
* I modified cool bash script for my needs and it worked! 🚀
* I learned about Makefiles. 😄
* I proceeded to do everything with Makefiles. 🤩🤩🤩
* I got tired of running successive Make targets over and again 😐.
* I used ansible at work and decided to take a course to learn more about it. 🤓
* I put off actually taking the plunge to use Ansible. 🕒🕕🕘🕛
* I finally took the plunge and decided to use ansible for my configuration. ✔️


## Core Software

This isn't exactly the list of Ansible roles, but below is a list of what the software installs.

> Note: the ~~crossed out~~ out items haven't been ported over from the previous Makefiles.


* `ansible`,
* `cherrytree`,
* `Visual Studio Code`,
* `Chromium`,
* `docker`,
* `docker-compose`,
* `flameshot`,
* `Flatpak`,
* `gh` [GitHub CLI](https://github.com/cli/cli#installation-and-upgrading)
* `Nordvpn`,
* `nodejs`,
* `Peek`,
* `postman`,
* ~~`Protonmail-bridge` <https://protonmail.com/bridge/install>~~,
* ~~`python3.6`~~,
* ~~`python3.7`~~,
* `Signal Desktop`,
* `Slack`,
* `Snap`,
* `Spotify`,
* `Stacer` <https://github.com/oguzhaninan/Stacer>,
* `Standard Notes`,
* `Steam`,
* `Sublime Text`,
* `Telegram`,
* ~~`TickTick`~~,
* `Timeshift` <https://github.com/teejee2008/timeshift>,
* ~~`Tresorit`~~,
* `yarn`,
* `zsh`

> See the [archive](archive) folder for deleted/old targets.

### Configuration

* The `gnome-*` Ansible roles configure GNOME keybindings and personal preferences. 

---

## Getting Started with this repo

The [Makefile](Makefile) is the entry point.

For a new machine or to ensure I am consistent with my playbook, I run the following bash command:

```bash
make all
```

This target runs three other targets in series:
* `bootstrap`
* `bootstrap-check`
* `install`

Let's go through each.

### Make bootstrap

This installs several packages with `apt` and python packages per the [requirements.txt](requirements.txt) file.

> This includes Ansible, using Python3.

### Make bootstrap-check

This is to confirm both the `ansible` and `psutil` Python3 packages are installed and on the `$PATH`.

> If the pip installation puts the packages in `--user`, you will need to update your ~/.bashrc, ~/.zshrc file.

```bash
# ~/.bashrc or ~/.zshrc, etc.
export PATH="$HOME/.local/bin:$PATH"
```

### Make install

This runs the `personal_computer.yml` Ansible playbook.

The following two commands yield the same bash command:

```bash
make install
```

```bash
ansible-playbook personal_computer.yml -i inventory --ask-become-pass -e 'ansible_user='$(whoami)
```

> Note: `$(shell whoami)` in a Makefile translates to `$(whoami)` in bash.

## Naming Convention for Make Targets

> `make check` and `make install` are two of the standard  [Makefile targets](https://www.gnu.org/prep/standards/html_node/Standard-Targets.html) for this repo.

----

## Requirements.txt 

 Notable Ansible Modules Used with regards to dependencies

* [dconf](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
  - This is drives the `psutil` Python3 requirement
* [snap](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
  - This drives the ansible >=2.8.0 requirement

## One off Commands

You have two options.  

`Make <target>`, replacing *<target>* with what you want.  This runs the install for that tag only.

If you want to run a check first or run select tags, you can use:

```bash
ansible-playbook personal_computer.yml -i inventory --ask-become-pass -e 'ansible_user='$(whoami) --tags="common,zsh,cherrytree,flameshot,stacer"
```

> Note: those are also some of my favorites!


---

## Changes

See [CHANGELOG](CHANGELOG.md) for history.

---

## Authors

I benefited from the source work of others, see [AUTHORS.md](AUTHORS.md).

> My choice to open source my work here is to share back with you.


---

## Syntax Notes

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

### Python Interpreter

[ansible.cfg](ansible.cfg)

```ini
[defaults]
#ansible_python_interpreter = "/usr/bin/python3"
interpreter_python ="/usr/bin/python3"
```

Reference:
<https://docs.ansible.com/ansible/latest/reference_appendices/interpreter_discovery.html>