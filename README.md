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

## Supported Ubuntu LTS Versions

* Ubuntu 18.04
* Ubuntu 20.04

> There are no plans to support or test non-LTS versions.
>
> Software support is LTS version dependent.

## Ansible Galaxy Roles

--------------------------

| Role | Description |
|:-------------|:-------------:|
|  [iancleary.jetbrains_mono](https://github.com/iancleary/ansible-role-jetbrains_mono) | installs [Jetbrains-Mono](https://www.jetbrains.com/lp/mono/) font|
|  [iancleary.zsh_antibody](https://github.com/iancleary/ansible-role-zsh_antibody) | Installs [Zsh](https://www.zsh.org/), [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh), and the [antibody](https://getantibody.github.io/) plugin manager|

## Core Software

--------------------------

This isn't exactly the list of Ansible roles,
but below is a list of what the repo helps install.

### Application Base

* `Flatpak`,
* `Snap`,

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
* `python3.6`,
* `python3.7`,
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

* Extensions: [gnome-extensions](roles/gnome-extensions/tasks/main.yml)
* Keybindings: [gnome-keybindings](roles/gnome-keybindings/tasks/main.yml)
* Preferences: [gnome-preferences](roles/gnome-preferences/tasks/main.yml)

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

* [Breaktimer](https://snapcraft.io/breaktimer),
* `Nordvpn`,

### Web Browsers

* `Chromium`,
* `Firefox`,

--------------------------

## Documentation

Detailed documentation is hosted by Netlify at <https://ansible-desktop.iancleary.me>.

### Existing Machine

For a walk through of my process on existing machine, please visit
<https://ansible-desktop.iancleary.me/makefile>.

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

### Customization

If you want to edit the variables, hit `CTRL + C` at `ansible`'s "BECOME PASSWORD" prompt.

The script created two extra files that ensure that the `ansible-playbook` will on your host name.

> Note: Both files are intentionally not version controlled.
> This allows hostname specific group_vars relative to the playbook.

* a private `.inventory` file

```bash
#.inventory
[$(hostname)]
127.0.0.1
```

* a group_vars file

```yml
# group_vars/$(hostname)/all.yml
---
# You can copy and modify variables over from group_vars/all/*.yml
```

Then run `make all`

Voila (with your edits)! 🚀🚀🚀

--------------------------

## Changes

See [CHANGELOG](CHANGELOG.md) for history.

--------------------------

## Authors

I benefited from the source work of others, see [AUTHORS.md](docs/AUTHORS.md).

> My choice to open source my work here is to share back with you.
