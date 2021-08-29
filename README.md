# ubuntu-dev-playbook

[![Test](https://github.com/icancclearynow/ubuntu-dev-playbook/workflows/Test/badge.svg)](https://github.com/icancclearynow/ubuntu-dev-playbook/actions)
[![Lint](https://github.com/icancclearynow/ubuntu-dev-playbook/workflows/Lint/badge.svg)](https://github.com/icancclearynow/ubuntu-dev-playbook/actions)
[![Calendar Versioning](https://img.shields.io/badge/calver-YY.0M.MICRO-22bfda.svg)](https://calver.org)

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
* I used Ansible at work and decided to take a course to learn more about it. 🤓
* I put off actually taking the plunge to use Ansible. 🕒🕕🕘🕛
* I finally took the plunge and decided to use Ansible for my configuration. ✔️

## Supported Ubuntu LTS Versions

I will support the LTS versions I use. There are no plans to support non-LTS versions.

| LTS | Last Supported Branch/Tag  |
|:-------------|:-------------:|
|  Ubuntu 20.04 (including elementary OS 6) | [main](https://github.com/icancclearynow/ubuntu-dev-playbook)|
|  Ubuntu 18.04 | [2020.1.0](https://github.com/icancclearynow/ubuntu-dev-playbook/releases/tag/v2020.1.0)|

## Ansible Galaxy Roles

There may be broader LTS or distribution support in the following roles:

| Role | Description |
|:-------------|:-------------|
|  [icancclearynow.docker](https://github.com/icancclearynow/ansible-role-docker) | Installs [Docker](https://docs.docker.com/get-started/) and [docker-compose](https://docs.docker.com/compose/). |
|  [icancclearynow.github_cli](https://github.com/icancclearynow/ansible-role-github_cli) | Installs the [GitHub CLI](https://github.com/cli/cli). |
|  [icancclearynow.nodejs](https://github.com/icancclearynow/ansible-role-nodejs) | Installs [nodejs](https://www.nodejs.org/) and the [npm](https://www.npmjs.com/) and [yarn](https://yarnpkg.com/) package managers. | 
|  [icancclearynow.zsh](https://github.com/icancclearynow/ansible-role-zsh) | Installs [Zsh](https://www.zsh.org/), [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) plugin manager, and adds `~/.zshrc_aliases`. |
## Use Cases

--------------------------

I've aligned ansible tags/roles around my common use cases:

* [Terminal/WSL](#Terminal/WSL)
* [Dotfiles](#Dotfiles)
* [Hyper-V](#Hyper-V)
* [Desktop](#Desktop)

## Terminal/WSL

### Shell

* `zsh` and `oh-my-zsh`
* [powerlevel10k theme](https://github.com/romkatv/powerlevel10k) with [needed fonts](https://github.com/romkatv/powerlevel10k/#meslo-nerd-font-patched-for-powerlevel10k), *installs fonts automatically*!

### Development Tooling

* `ansible`,
* `docker`,
* `docker-compose`,
* `nodejs`, `yarn`
* `python3.8`,
* `gh` [GitHub CLI](https://github.com/cli/cli#installation-and-upgrading)
* `yarn`
* `terraform`
* `linode` CLI

## Dotfiles

* [icancclearynow/dotfiles](https://github.com/icancclearynow/dotfiles) managed with the [yadm](https://yadm.io/docs/getting_started) dotfile manager

> Check out their [Getting Started Documentation](https://yadm.io/docs/getting_started)

The ansible role [icancclearynow.yadm](https://github.com/icancclearynow/ansible-role-yadm) does more or less the following:

```bash
yadm clone -b main https://github.com/icancclearynow/dotfiles --bootstrap
```

This clones my dotfiles repo via HTTPS using yadm's [bootstrap](https://yadm.io/docs/bootstrap) standard command.

My Bootstrap script is [icancclearynow/dotfiles/blob/main/.config/yadm/bootstrap](https://github.com/icancclearynow/dotfiles/blob/main/.config/yadm/bootstrap). It's purpose is to:

* loads my dotfiles (including SSH keys)
* decrypt the private key (prompts for password),
* add the key to ssh-agent,
* tests the connection,
* and exit.

## Hyper-V

This [role](https://github.com/icancclearynow/ubuntu-dev-playbook/tree/main/roles/hyper-v/tasks/main.yml) allows you to set the screen resolution in `/etc/default/grub`.

## Desktop

### Integrated Development Environment

* [VSCode](https://code.visualstudio.com/),
* VS Code Extensions

> If you prefer a fully open source option, checkout [VSCodium](https://vscodium.com/)! Set "code_executable" to "/snap/bin/codium".

### Application Base

* `Flatpak`,
* `Snap`,

### AppImageLauncher

* [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher), see the [Integrate any AppImage into the Ubuntu Desktop](https://dev.to/strotgen/integrate-tinkerwell-or-any-appimage-into-the-ubuntu-desktop-le9) article.

### Application Launcher

* [ULauncher](https://github.com/ULauncher/ULauncher), A ctrl + spacebar productivity bar, Ulauncher is inspired by Alfred for macOS and similar semantic search tools that followed in its wake.

### Backups

* `Timeshift` <https://github.com/teejee2008/timeshift>,

### Screenshots and GIFs

* [carbon-cli](https://github.com/mixn/carbon-now-cli)
for beautiful images of my code - right inside my terminal,
* [Flameshot](https://flameshot.js.org/#/),

> Flameshot keybinding to the Print Screen key using `gsettings`

* [Peek](https://github.com/phw/peek), a simple screen recorder with an easy to use interface

### Utilities

* [Caffeine](https://launchpad.net/caffeine),
* `Nordvpn`,
* [PDFSlicer](https://github.com/junrrein/pdfslicer)
* Blanket: Background sounds
* Flatseal: Manage flatpak permissions
* WhatIP: Info on your IP
* Bitwarden:  A secure and free fassword manager for all of your devices

### Music

* `Spotify`,

### Notes

* `cherrytree`,
* `Standard Notes`,

### System Info

* `Stacer` <https://github.com/oguzhaninan/Stacer>,

### Email, Contacts, Calendar

* TBD

### File Storage

* `Tresorit`

--------------------------

## Existing Machine

On an existing machine, I run the following bash command,
to ensure I am consistent with my playbook

## Make All

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
python packages per the [requirements-ansible.txt](https://github.com/icancclearynow/ubuntu-dev-playbook/blob/main/requirements-ansible.txt) file.

> This includes Ansible, using Python3.

This also moves the [home-local-bin.sh](https://github.com/icancclearynow/ubuntu-dev-playbook/blob/main/home-local-bin.sh)
file to the `/etc/profile.d/` folder as described above.

> The `yarn` roles does a similar operation,
> except with Ansible instead of bash.

### Make bootstrap-check

This is to confirm both the `ansible` and `psutil`
Python3 packages are installed and on the `$PATH`.

If the pip installation falls back to using the `--user` flag,
packages will be located in the following directory under `$HOME`:

> Goal: `export PATH="$HOME/.local/bin:$PATH"` without duplication!

```bash
#/etc/profile.d/home-local-bin.sh

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

*Source: [duplicate-entries-in-path-a-problem](https://unix.stackexchange.com/questions/14895/duplicate-entries-in-path-a-problem)*

### Make install

This runs the `playbook.yml` Ansible playbook.

The following two commands yield the same bash command:

```bash
make install
```

```bash
ansible-playbook playbook.yml \
-i inventory \
--ask-become-pass \
-e '{"users": [{"username": "$(shell whoami)"}]}'
```

> Note: `$(shell whoami)` in a Makefile translates to `$(whoami)` in bash.

The "-e" is for extra variable and is from my Ansible Galaxy role [icancclearynow/ansible-role-zsh_antibody#example-playbook](https://github.com/icancclearynow/ansible-role-zsh#example-playbook)

### Make non-ansible

This the targets that I found easier to maintain with bash or Makefile scripts.

```bash
# configure Flameshot with gsettings to bind to PrtScr
make flameshot-keybindings

# Ubuntu 20.04 defaults
make python-three-eight-install
make python-three-eight-supporting

...

```

### Naming Convention for Make Targets

> `make check` and `make install` are two of the standard
> [Makefile targets](https://www.gnu.org/prep/standards/html_node/Standard-Targets.html)
> for this repo.

--------------------------

## New Machine Setup Scripts

For a new machine, I run the following command
to set up my computer:

> Please make sure you adjust your hostname as Ansible keys off this variable.
> I like to do this during the initial configuration of the machine.

This will prompt you for your `sudo` password
for the bash script and then once later for
`ansible`'s "BECOME PASSWORD" prompt.

Voila! 🎉🎉🎉

### New Terminal Setup

```bash
wget -qO- \
https://github.com/icancclearynow/ubuntu-dev-playbook/raw/main/run_terminal.sh | \
bash
```

### New Desktop Setup

```bash
wget -qO- \
https://github.com/icancclearynow/ubuntu-dev-playbook/raw/main/run_desktop.sh | \
bash
```

--------------------------

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

```yaml
    nodejs_version: "14.x"
    nodejs_npm_global_packages:
      - name: "@vue/cli"
      - name: "nativefier"
      - name: "markdownlint-cli"
      - name: "carbon-now-cli"

```

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

### Order of precedence for variables

* Any content in the `config.yml` has the highest precedence (not version controlled; sensitive)
* The version controlled [default.config.yml](https://github.com/icancclearynow/ubuntu-dev-playbook/tree/main/default.config.yml) file.

> This allows hostnames to remain private outside of version control, for say secret operations 🕵️

## Example Using This Repo As Is

For example, a `config.yml` could contain:

```yaml
---
nodejs_npm_global_packages:
  - name: "@vue/cli"
  - name: "@gridsome/cli"
```

## Example Forking This Repo

For example, a `default.config.yml` could contain:

```yaml
---
nodejs_npm_global_packages:
  - name: "@vue/cli"
```

Then run `make all`

Voila (with your edits)! 🚀🚀🚀

--------------------------

## Quick Note on /etc/profile.d/

Investigate this folder and your
~/.bashrc, ~/.zshrc, etc. files
will become simpler and more maintainable! 🚀

> Let's stuff a few more lines of configuration into that file, it will be fine 😬😬😬😬.

Tl;dr is that most shells source all files in that folder,
similar to `source ~/.bashrc` on a fresh Ubuntu install.
The main advantage for using the `/etc/profile.d/` folder
is that it is modular and maintainable.

Fast forward to your using that folder as it was intended.

> A zen like calm washes over you now that there is
> a single file per application and use case!

Your messy filing cabinet of assorted patches is no more. 🔥

> The `. /etc/profile` command is used to
> manually source the `/etc/profile.d/ folder.

## Changes

See [CHANGELOG](CHANGELOG.md) for history.

## Calendar Versioning

This project adheres to [Calendar Versioning](https://calver.org/), YY.0M.MICRO.  This is similar to Ubuntu.

> Note that I've iterated to this and it wasn't always calver.

## Linting

Linting is performed on common file types:

* YAML files with [yamllint](https://yamllint.readthedocs.io/)
* Bash files with [shellcheck](https://www.shellcheck.net/)
* Markdown files with [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)

## Requirements_ansible.txt

 Notable Ansible Modules Used with regards to dependencies

* [snap](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
  * This drives the ansible >=2.8.0 requirement

--------------------------

## Authors

I benefited from the source work of others, see [AUTHORS.md](AUTHORS.md).

> My choice to open source my work here is to share back with you.

If you wish to contribute, see [CONTRIBUTING.md](CONTRIBUTING.md)
