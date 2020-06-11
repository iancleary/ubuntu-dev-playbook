# ansible-desktop

[![Build Status](https://img.shields.io/travis/com/iancleary/ansible-desktop/master.svg)](https://img.shields.io/travis/com/iancleary/ansible-desktop)
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

## Supported Ubuntu LTS Versions

* Ubuntu 18.04
* Ubuntu 20.04

> There are no plans to support non-LTS versions.
> Software (support) is LTS version dependent.

## Ansible Galaxy Roles

--------------------------

| Role | Description |
|:-------------|:-------------:|
|  [iancleary.jetbrains_mono](https://github.com/iancleary/ansible-role-jetbrains_mono) | installs [Jetbrains-Mono](https://www.jetbrains.com/lp/mono/) font|
|  [iancleary.zsh_antibody](https://github.com/iancleary/ansible-role-zsh_antibody) | Installs [Zsh](https://www.zsh.org/), [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh), and the [antibody](https://getantibody.github.io/) plugin manager|

## Local Roles

--------------------------

| Role | Description |
|:-------------|:-------------:|
| [github-cli](https://github.com/iancleary/ansible-desktop/tree/master/roles/github-cli) | Installs the [GitHub CLI](https://github.com/cli/cli#installation-and-upgrading) deb|

## Core Software

This isn't exactly the list of Ansible roles,
but below is a list of what the software installs.

> Note: the ~~crossed out~~ out items haven't
> been ported over from the previous Makefiles.

* `ansible`,
* [antibody](https://getantibody.github.io/) shell plugin manager (concurrent and compiled)
* `cherrytree`,
* [Breaktimer](https://snapcraft.io/breaktimer),
* `Visual Studio Code`,
* [kite AI Autocompletion and Docs for Python](https://kite.com/), runs locally
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
* `python3.8`,
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
* `yarn`

> See the [archive](https://github.com/iancleary/ansible-desktop/tree/masterarchive) folder for not used targets.

### Configuration

The GNOME Ansible roles configure my GNOME personal preferences.

* Extensions: [gnome-extensions](https://github.com/iancleary/ansible-desktop/tree/master/roles/gnome-extensions/tasks/main.yml)
* Keybindings: [gnome-keybindings](https://github.com/iancleary/ansible-desktop/tree/master/roles/gnome-keybindings/tasks/main.yml)
* Preferences: [gnome-preferences](https://github.com/iancleary/ansible-desktop/tree/master/roles/gnome-preferences/tasks/main.yml)

--------------------------

## Getting Started with this repo

### Makefile

The [Makefile](https://github.com/iancleary/ansible-desktop/blob/master/Makefile)  is the entry point.

### Common Utilty Scripts

The [scripts](https://github.com/iancleary/ansible-desktop/tree/master/scripts) folder contains common setup between local scripts and Travis-CI.

### Testing

Continuous Integration Testing is done with the
[.travis.yml](https://github.com/iancleary/ansible-desktop/blob/master/.travis.yml) file.

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
https://github.com/iancleary/ansible-desktop/raw/master/run.sh | \
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

See [CHANGELOG](https://github.com/iancleary/ansible-desktop/blob/master/CHANGELOG.md) for history.

--------------------------

## Authors

I benefited from the source work of others, see [AUTHORS.md](AUTHORS.md).

> My choice to open source my work here is to share back with you.
