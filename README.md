# linux-dev-playbook

[![Test](https://github.com/iancleary/linux-dev-playbook/workflows/Test/badge.svg)](https://github.com/iancleary/linux-dev-playbook/actions)
[![Lint](https://github.com/iancleary/linux-dev-playbook/workflows/Lint/badge.svg)](https://github.com/iancleary/linux-dev-playbook/actions)
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
|  Ubuntu 20.04 | [main](https://github.com/iancleary/linux-dev-playbook)|
|  Ubuntu 18.04 | [2020.1.0](https://github.com/iancleary/linux-dev-playbook/releases/tag/v2020.1.0)|

## Ansible Galaxy Roles

There is broader LTS and Distribution support in the following roles:

| Role | Description |
|:-------------|:-------------:|
|  [iancleary.docker](https://github.com/iancleary/ansible-role-docker) | Installs Docker and Docker-compose|
|  [iancleary.zsh](https://github.com/iancleary/ansible-role-zsh) | Installs [Zsh](https://www.zsh.org/), [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) plugin manager, and addes `~/.zshrc_aliases`|


## Use Cases

--------------------------

I've aligned ansible tags/roles around my common use cases:

* [Terminal/WSL](#Terminal/WSL)
* [Dotfiles](#Dotfiles)
* [Hyper-V](#Hyper-V)
* [Desktop](#Desktop)
* [GNOME Desktop](#GNOME-Desktop)

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

* [iancleary/dotfiles](https://github.com/iancleary/dotfiles) managed with the [yadm](https://yadm.io/docs/getting_started) dotfile manager

## Hyper-V

This [role](https://github.com/iancleary/linux-dev-playbook/tree/main/roles/hyper-v/tasks/main.yml) allows you to set the screen resolution in `/etc/default/grub`.

## Desktop 

### Integrated Develeopment Environment

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

* [Peek](https://github.com/phw/peek) animated GIF screen recorder,

### Text Editors

* `Sublime Text`,

### Utilities

* [Caffeine](https://launchpad.net/caffeine),
* [Breaktimer](https://snapcraft.io/breaktimer),
* `Nordvpn`,
* [PDFSlicer](https://github.com/junrrein/pdfslicer)

### Web Browsers

* `Chromium`,
* `Firefox`,

### Music

* `Spotify`,

### Notes

* `cherrytree`,
* `Standard Notes`,

### System Info

* `Stacer` <https://github.com/oguzhaninan/Stacer>,

### Email

* TBD

### File Storage

* `Tresorit`,

## GNOME Desktop

The GNOME Ansible roles configure my GNOME personal preferences.

* Extensions: [gnome-extensions](https://github.com/iancleary/linux-dev-playbook/tree/main/roles/gnome-extensions/tasks/main.yml)
* Keybindings: [gnome-keybindings](https://github.com/iancleary/linux-dev-playbook/tree/main/roles/gnome-keybindings/tasks/main.yml)
* Preferences: [gnome-preferences](https://github.com/iancleary/linux-dev-playbook/tree/main/roles/gnome-preferences/tasks/main.yml)


--------------------------

## Documentation

Detailed documentation is hosted by Vercel at <https://linux-dev-playbook.iancleary.me/>.

### Existing Machine

For a walk through of my process on existing machine, please visit
<https://linux-dev-playbook.iancleary.me/makefile>.

--------------------------

## New Machine Setup

For a new machine, I run the following command
to set up my computer:

> Please make sure you adjust your hostname as Ansible keys off this variable.
> I like to do this during the initial configuration of the machine.

```bash
wget -qO- \
https://github.com/iancleary/linux-dev-playbook/raw/main/run.sh | \
bash
```

This will prompt you for your `sudo` password
for the bash script and then once later for
`ansible`'s "BECOME PASSWORD" prompt.

Voila! 🎉🎉🎉

--------------------------

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

```yaml
    nodejs_version: "14.x"
    nodejs_yarn_global_packages:
      - name: "@vue/cli"
      - name: "nativefier"
      - name: "markdownlint-cli"
      - name: "carbon-now-cli"

```

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

### Order of precedence for variables

* Any content in the `config.yml` has the highest precedence (not version controlled; sensitive)
* The version controlled [default.config.yml](https://github.com/iancleary/linux-dev-playbook/tree/main/default.config.yml) file.

> This allows hostnames to remain private outside of version control, for say secret operations 🕵️

Then run `make all`

Voila (with your edits)! 🚀🚀🚀

--------------------------

## Changes

See [CHANGELOG](CHANGELOG.md) for history.

## Calendar Versioning

This project adheres to [Calendar Versioning](https://calver.org/), YY.0M.MICRO.  This is similar to Ubuntu.

> Note that I've iterated to this and it wasn't always calver.

--------------------------

## Authors

I benefited from the source work of others, see [AUTHORS.md](docs/AUTHORS.md).

> My choice to open source my work here is to share back with you.
