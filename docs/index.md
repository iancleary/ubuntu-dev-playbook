# ansible-desktop

[![Test](https://github.com/iancleary/ansible-desktop/workflows/Test/badge.svg)](https://github.com/iancleary/ansible-desktop/actions)
[![Netlify Status](https://api.netlify.com/api/v1/badges/0a90303b-4694-4407-964b-0caa5a68827c/deploy-status)](https://app.netlify.com/sites/iancleary-ansible-desktop/deploys)

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

## Calendar Versioning

This project adheres to [Calendar Versioning](https://calver.org/), YYYY.MINOR.MICRO.

## Supported Ubuntu LTS Versions

I will support the LTS versions I use. There are no plans to support non-LTS versions.

| LTS | Last Supported Branch/Tag  |
|:-------------|:-------------:|
|  Ubuntu 20.04 | [main](https://github.com/iancleary/ansible-desktop)|
|  Ubuntu 18.04 | [2020.1.0](https://github.com/iancleary/ansible-desktop/releases/tag/v2020.1.0)|

## Ansible Galaxy Roles

There is broader LTS and Distribution support in the following roles:

| Role | Description |
|:-------------|:-------------:|
|  [iancleary.jetbrains_mono](https://github.com/iancleary/ansible-role-jetbrains_mono) | installs [Jetbrains-Mono](https://www.jetbrains.com/lp/mono/) font|
|  [iancleary.zsh_antibody](https://github.com/iancleary/ansible-role-zsh_antibody) | Installs [Zsh](https://www.zsh.org/), [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh), and the [antibody](https://getantibody.github.io/) plugin manager|

## Core Software

This isn't exactly the list of Ansible roles,
but below is a list of what the software installs.

### Application Base

* `Flatpak`,
* `Snap`,

### AppImageLauncher

* [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher), see the [Integrate any AppImage into the Ubuntu Desktop](https://dev.to/strotgen/integrate-tinkerwell-or-any-appimage-into-the-ubuntu-desktop-le9) article.

### Application Launcher

* [ULauncher](https://github.com/ULauncher/ULauncher), A ctrl + spacebar productivity bar, Ulauncher is inspired by Alfred for macOS and similar semantic search tools that followed in its wake.

### Backups

* `Timeshift` <https://github.com/teejee2008/timeshift>,

### Chat Clients

* `Signal Desktop`,
* `Slack`,
* `Telegram`,

### Development Tooling

* `ansible`,
* `docker`,
* `docker-compose`,
* `gh` [GitHub CLI](https://github.com/cli/cli#installation-and-upgrading)
* `nodejs`,
* `python3.8`,
* `yarn`

### Dotfiles

* [yadm](https://yadm.io/docs/getting_started) dotfile manager

### Email

* HEY Mail, by Basecamp, [hey-main snap](https://snapcraft.io/hey-mail)

### File Storage

* `Tresorit`,

### Games

* `Steam`,

### GNOME Configuration

The GNOME Ansible roles configure my GNOME personal preferences.

* Extensions: [gnome-extensions](https://github.com/iancleary/ansible-desktop/blob/main/roles/gnome-extensions/tasks/main.yml)
* Keybindings: [gnome-keybindings](https://github.com/iancleary/ansible-desktop/blob/main/roles/gnome-keybindings/tasks/main.yml)
* Preferences: [gnome-preferences](https://github.com/iancleary/ansible-desktop/blob/main/roles/gnome-preferences/tasks/main.yml)

### Integrated Development Environments (IDE)

* [VSCode](https://code.visualstudio.com/),

> If you prefer a fully open source option, checkout [VSCodium](https://vscodium.com/)!

* [Postman](https://www.postman.com/) for API testing,

* [kite AI Autocompletion and Docs for Python](https://kite.com/), runs locally

### Music

* `Spotify`,

### Notes

* `cherrytree`,
* `Standard Notes`,

### System Info

* `Stacer` <https://github.com/oguzhaninan/Stacer>,

### Tasks

* `TickTick` using [nativefier](https://github.com/jiahaog/nativefier/),

### Terminal

* [antibody](https://getantibody.github.io/) shell plugin manager (concurrent and compiled)
* [Hyper Terminal](https://hyper.is), with "pane:splitHorizontal": "ctrl+shift+f", // changed from "ctrl+shift+e" because [vercel/hyper #3660](https://github.com/vercel/hyper/issues/3660)
* `zsh` and `oh-my-zsh`
* [powerlevel10k theme](https://github.com/romkatv/powerlevel10k) with [needed fonts](https://github.com/romkatv/powerlevel10k/#meslo-nerd-font-patched-for-powerlevel10k)

### Screenshots and GIFs

* [carbon-cli](https://github.com/mixn/carbon-now-cli)
for beautiful images of my code - right inside my terminal,
* [Flameshot](https://flameshot.js.org/#/),

> Flameshot keybinding to the Print Screen key using `gsettings`

* [Peek](https://github.com/phw/peek) animated GIF screen recorder,

### Text Editors

* `Sublime Text`,

### Utilities

* [Caffeine](https://launchpad.net/caffeine),
* [Breaktimer](https://snapcraft.io/breaktimer),
* `Nordvpn`,

### Web Browsers

* `Chromium`,
* `Firefox`,

--------------------------

## Getting Started with this repo

### Makefile

The [Makefile](https://github.com/iancleary/ansible-desktop/blob/main/Makefile)  is the entry point.

### Common Utility Scripts

The [scripts](https://github.com/iancleary/ansible-desktop/tree/main/scripts) folder contains common setup between local scripts and Travis-CI.

### Testing

Continuous Integration Testing is done with the
[.github/workflows/test.yml](https://github.com/iancleary/ansible-desktop/blob/main/.github/workflows/test.yml) file.

Multiple jobs test independent portions of the installation.

> While testing the playbook in order would be ideal,
> the preference here is to have the Continuous Integration
> finish faster.

### Linting

Linting is performed on common file types:

* YAML files with [yamllint](https://yamllint.readthedocs.io/)
* Bash files with [shellcheck](https://www.shellcheck.net/)
* Markdown files with [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)

--------------------------

## New Machine Setup

For a new machine, I run the following command
to set up my computer:

> Please make sure you adjust your hostname as Ansible keys off this variable.
> I like to do this during the initial configuration of the machine.

```bash
wget -qO- \
https://github.com/iancleary/ansible-desktop/raw/main/run.sh | \
bash
```

This will prompt you for your `sudo` password
for the bash script and then once later for
`ansible`'s "BECOME PASSWORD" prompt.

Voila! 🎉🎉🎉

--------------------------

## Requirements_ansible.txt

 Notable Ansible Modules Used with regards to dependencies

* [dconf](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
  * This is drives the `psutil` Python3 requirement
* [snap](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
  * This drives the ansible >=2.8.0 requirement

--------------------------

## Changes

See [CHANGELOG](https://github.com/iancleary/ansible-desktop/blob/main/CHANGELOG.md) for history.

--------------------------

## Authors

I benefited from the source work of others, see [AUTHORS.md](AUTHORS.md).

> My choice to open source my work here is to share back with you.
