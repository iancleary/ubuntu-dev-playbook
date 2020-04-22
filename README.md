# ansible-desktop

[![Build Status](https://img.shields.io/travis/com/iancleary/ansible-desktop/master.svg)](https://img.shields.io/travis/com/iancleary/ansible-desktop)
[![Updates](https://pyup.io/repos/github/iancleary/ansible-desktop/shield.svg)](https://pyup.io/repos/github/iancleary/ansible-desktop/)
[![Python 3](https://pyup.io/repos/github/iancleary/ansible-desktop/python-3-shield.svg)](https://pyup.io/repos/github/iancleary/ansible-desktop/)

## Ansible Playbook to configure my laptops and desktops

I care about not having to think too much about my setup between machines.
Especially when I want to get right to work.

For that reason, it is very comfortable for me
to have the same base configuration
on each machine (look, feel,
keyboard shortcuts, core software, etc.).

### My journey to the current state of this repo

* I found a cool bash script on the internet (*I didn't understand most of it*) 🤷
* I modified cool bash script for my needs and it worked! 🚀
* I learned about Makefiles. 😄
* I proceeded to do everything with Makefiles. 🤩🤩🤩
* I got tired of running successive Make targets over and again 😐.
* I used ansible at work and decided to take a course to learn more about it. 🤓
* I put off actually taking the plunge to use Ansible. 🕒🕕🕘🕛
* I finally took the plunge and decided to use ansible for my configuration. ✔️

## Core Software

This isn't exactly the list of Ansible roles,
but below is a list of what the software installs.

> Note: the ~~crossed out~~ out items haven't
> been ported over from the previous Makefiles.

* `ansible`,
* `cherrytree`,
* [Breaktimer](https://snapcraft.io/breaktimer),
* `Visual Studio Code`,
* [VSCodium](https://vscodium.com/),
* [carbon-cli](https://github.com/mixn/carbon-now-cli)
for beautiful images of my code - right inside my terminal,
* `Chromium`,
* `docker`,
* `docker-compose`,
* [Flameshot](https://flameshot.js.org/#/),
* Flameshot keybinding to the Print Screen key using `gsettings`,
* `Firefox`,
* `Flatpak`,
* `gh` [GitHub CLI](https://github.com/cli/cli#installation-and-upgrading)
* `Nordvpn`,
* `nodejs`,
* [Peek](https://github.com/phw/peek) animated GIF screen recorder,
* [Postman](https://www.postman.com/) for API testing,
* `Protonmail-bridge` <https://protonmail.com/bridge/install>,
* `python3.6`,
* `python3.7`,
* `Signal Desktop`,
* `Slack`,
* `Snap`,
* `Spotify`,
* `Stacer` <https://github.com/oguzhaninan/Stacer>,
* `Standard Notes`,
* `Steam`,
* `Sublime Text`,
* `Telegram`,
* `TickTick` using [nativefier](https://github.com/jiahaog/nativefier/),
* `Timeshift` <https://github.com/teejee2008/timeshift>,
* `Tresorit`,
* `yarn`,
* `zsh`

> See the [archive](archive) folder for not used targets.

### Configuration

The GNOME Ansible roles configure my GNOME personal preferences.

* Extensions: [gnome-extensions](roles/gnome-extensions/tasks/main.yml)
* Keybindings: [gnome-keybindings](roles/gnome-keybindings/tasks/main.yml)
* Preferences: [gnome-preferences](roles/gnome-preferences/tasks/main.yml)
* Themes: [gnome-themes](roles/gnome-themes/tasks/main.yml)

---

## Getting Started with this repo

### Makefile

The [Makefile](Makefile) is the entry point.

### Common Utilty Scripts

The [scripts](scripts) folder contains common setup between local scripts and Travis-CI.

### Quick Note on /etc/profile.d/

Investigate this folder and your
~/.bashrc, ~/.zshrc, etc. files
will become simpler and more maintable! 🚀

> Let's stuff a few more lines of configuration into that file, it will be fine 😬😬😬😬.

Tl;dr is that most shells source all files in that folder,
similar to `source ~/.bashrc` on a fresh Ubuntu install.
The main advantage for using the `/etc/profile.d/` folder
is that it is modular and maintable.

Fast forward to your using that folder as it was intended.

> A zen like calm washes over you now that there is
> a single file per application and use case!

Your messy filing cabinet of assorted patches is no more. 🔥

> The `. /etc/profile` command is used to
> manually source the `/etc/profile.d/ folder.

### Testing

Continuous Integration Testing is done with the
[.travis.yml](.travis.yml) file and [PyUp](https://pyup.io/).

Multiple jobs test independent portions of the installation.

### Linting

Linting is performed on common file types:

* YAML files with [yamllint](https://yamllint.readthedocs.io/)
* Bash files with [shellcheck](https://www.shellcheck.net/)
* Markdown files with [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)

---

## New Machine Setup

For a new machine, I run the following command
to set up my computer:

> Please make sure you adjust your hostname as Ansible keys off this variable.
> I like to do this during the initial configuration of the machine.

```bash
wget -qO- \
https://github.com/iancleary/personal-ansible/raw/master/run.sh | \
bash
```

This will prompt you for your `sudo` password
for the bash script and then once later for
`ansible`'s "BECOME PASSWORD" prompt.

Voila! 🎉🎉🎉

---

## Existing Machine

On an existing machine, I run the following bash command,
to ensure I am consistent with my playbook:

```bash
make all
```

This target runs four other targets in series:

* `bootstrap`
* `bootstrap-check`
* `install`
* `non-ansible`

Let's go through each.

### Make bootstrap

This installs several packages with `apt` and
python packages per the [requirements.txt](requirements.txt) file.

> This includes Ansible, using Python3.

This also moves the [home-local-bin.sh](home-local-bin.sh)
file to the `/etc/profile.d/` folder as described above.

> The `yarn` roles does a similar operation,
> except with Ansible instead of bash.

### Make bootstrap-check

This is to confirm both the `ansible` and `psutil`
Python3 packages are installed and on the `$PATH`.

If the pip installation falls back to using the `--user` flag,
packages will be located in the following directory under `$HOME`:

> Target: `export PATH="$HOME/.local/bin:$PATH"`

```bash
#/etc/profile.d/home-local-bin.sh

# https://unix.stackexchange.com/questions/14895/duplicate-entries-in-path-a-problem
addToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# Important for python pip packages installed with --user
addToPATH "$HOME/.local/bin"
```

> `make bootstrap` will set this up for you!

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

### Make non-ansible

This the targets that I found easier to maintain with bash or Makefile scripts.

```bash
# No user input required
make flameshot-keybindings
make python-three-six-install
make python-three-six-supporting
make python-three-seven-install
make python-three-seven-supporting
make poetry
```

### Naming Convention for Make Targets

> `make check` and `make install` are two of the standard
> [Makefile targets](https://www.gnu.org/prep/standards/html_node/Standard-Targets.html)
> for this repo.

---

## Per Machine Setup

The [inventory](inventory) file uses the `localhost` and `{hostname}` groups to ensure
the IPv4 address used is `127.0.0.1`.

```bash
[hostname]
127.0.0.1
```

### Host specific variables

If you want per machine variables, create a `{hostname}.yml` in either:

* The [group_vars](group_vars) folder local to the repo (version controlled; not sensitive)
* The machine's `/etc/ansible/group_vars/` folder (not version controlled; sensitive)

> This allows hostnames to remain private outside of version control, for say secret operations 🕵️


#### Example

For example, a `my-awesome-hostname.yml` could be:

```yaml
---
nodejs_yarn_global_packages:
  - name: "@vue/cli"
  - name: "@gridsome/cli"
  - name: "nativefier"
  - name: "markdownlint-cli"
  - name: "carbon-now-cli"
```



---

## Requirements.txt

 Notable Ansible Modules Used with regards to dependencies

* [dconf](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
  * This is drives the `psutil` Python3 requirement
* [snap](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
  * This drives the ansible >=2.8.0 requirement

## One off Commands

You have two options.

`Make {target}`, replacing *{target}* with what you want.
This runs the install for that tag only.

If you want to run a check first or run select tags, you can use:

### Only certain tags

```bash
ansible-playbook personal_computer.yml \
-i inventory \
--ask-become-pass \
-e 'ansible_user='$(whoami) \
--tags="common-snaps,zsh,cherrytree,flameshot,stacer"
```

### Check

```bash
ansible-playbook personal_computer.yml \
-i inventory \
--ask-become-pass \
-e 'ansible_user='$(whoami) \
--check
```

> Note: Any check against a role that has an `apt_repository` task
> (that has not been installed yet) will fail to
> find the corresponding package in the subsequent `apt` task.

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
