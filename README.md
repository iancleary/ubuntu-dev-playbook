<img src="https://raw.githubusercontent.com/geerlingguy/mac-dev-playbook/master/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" />

# Ubuntu Development Ansible Playbook

[![CI][badge-gh-actions]][link-gh-actions]

This playbook installs and configures most of the software I use on my Ubuntu Installations for web and software development. Some things are slightly difficult to automate, so I still have a few manual installation steps, but at least it's all documented here.

## Installation

  1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html):

     1. Upgrade Pip: `python3 -m pip install --upgrade pip`
     2. Run the following command to add Python 3 to your $PATH: `export PATH="$HOME/.local/bin:$PATH"`
     3. Install Ansible: `python3 -m pip install ansible --user`

  2. Clone or download this repository to your local drive.
  3. Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
  4. Run `ansible-playbook plabook.yml --ask-become-pass` inside this directory. Enter your sudo account password when prompted for the 'BECOME' password.

> Note: If some Homebrew commands fail, you might need logout and log back in again.
### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `homebrew`, `mas`, `extra-packages` and `osx`.

    ansible-playbook playbook.yml -K --tags "dotfiles,homebrew"

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

```yaml
homebrew_installed_packages:
  - cowsay
  - git
  - go

mas_installed_apps:
  - { id: 443987910, name: "1Password" }
  - { id: 498486288, name: "Quick Resizer" }
  - { id: 557168941, name: "Tweetbot" }
  - { id: 497799835, name: "Xcode" }

composer_packages:
  - name: hirak/prestissimo
  - name: drush/drush
    version: '^8.1'

gem_packages:
  - name: bundler
    state: latest

npm_packages:
  - name: webpack

pip_packages:
  - name: mkdocs

configure_dock: true
dockitems_remove:
  - Launchpad
  - TV
dockitems_persist:
  - name: "Sublime Text"
    path: "/Applications/Sublime Text.app/"
    pos: 5
```

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

## Included Applications / Configuration (Default)

Applications (installed with Homebrew Cask):

  - [ChromeDriver](https://sites.google.com/chromium.org/driver/)
  - [Docker](https://www.docker.com/)
  - [Dropbox](https://www.dropbox.com/)
  - [Firefox](https://www.mozilla.org/en-US/firefox/new/)
  - [Google Chrome](https://www.google.com/chrome/)
  - [Handbrake](https://handbrake.fr/)
  - [Homebrew](http://brew.sh/)
  - [LICEcap](http://www.cockos.com/licecap/)
  - [nvALT](http://brettterpstra.com/projects/nvalt/)
  - [Sequel Ace](https://sequel-ace.com) (MySQL client)
  - [Slack](https://slack.com/)
  - [Sublime Text](https://www.sublimetext.com/)
  - [Transmit](https://panic.com/transmit/) (S/FTP client)

Packages (installed with Homebrew):

  - autoconf
  - bash-completion
  - doxygen
  - gettext
  - gifsicle
  - git
  - github/gh/gh
  - go
  - gpg
  - httpie
  - iperf
  - libevent
  - sqlite
  - mcrypt
  - nmap
  - node
  - nvm
  - php
  - ssh-copy-id
  - cowsay
  - readline
  - openssl
  - pv
  - wget
  - wrk
  - zsh-history-substring-search

My [dotfiles](https://github.com/geerlingguy/dotfiles) are also installed into the current user's home directory, including the `.osx` dotfile for configuring many aspects of macOS for better performance and ease of use. You can disable dotfiles management by setting `configure_dotfiles: no` in your configuration.

Finally, there are a few other preferences and settings added on for various apps and services.

## Full / From-scratch setup guide

Since I've used this playbook to set up something like 20 different Ubuntu desktops, I decided to write up a full 100% from-scratch install for my own reference (everyone's particular install will be slightly different).

You can see my full from-scratch setup document here: [full-ubuntu-setup.md](full-ubuntu-setup.md).

## Testing the Playbook

While I often setup new machines while I experiment Many people have asked me if I often wipe my entire workstation and start from scratch just to test changes to the playbook. Nope! This project is [continuously tested on GitHub Actions' macOS infrastructure](https://github.com/geerlingguy/mac-dev-playbook/actions?query=workflow%3ACI).

## Virtual Machines

You can also run Ubuntu inside a VM, for at least some of the required testing (App Store apps and some proprietary software might not install properly). I currently recommend:

  - [VirtualBox](https://mac.getutm.app)
  - [Easy SSH Setup for VirtualBox](https://dev.to/developertharun/easy-way-to-ssh-into-virtualbox-machine-any-os-just-x-steps-5d9i), this can scale to different VMs by changing which host port you forward each VM to, and changing the ssh config on the host accordingly.

## Windows

For Windows hosts, I've had issues with WSL while using certain VPNs (say Cisco AnyConnect).  While there are likely guides on how to get WSLs DNS issues resolved under WSL2, that is not the focus of this repo.  The playbook will generally work on WSL though.

Hyper-V is also possible for Virtualization, but I've had difficulties with static IP Configuration, see [local-ssh-config](https://github.com/iancleary/local-ssh-config).

> Note: If you go the Hyper-V route, there is also a [hyper-v](roles/hyper-v/) role that helps set the resolution, such that the Hyper-V window on the host will be scaled to the correct resolution.  In general, Hyper-V will be faster than VirtualBox, due to what layer of hypervisor each are.

If your machine is fast enough, I recommend the [VirtualBox and port forwarding route](#virtual-machines).



## Author

This project was created by [Ian Cleary](https://iancleary.me), (originally inspired by [Jeff Geerling](https://www.jeffgeerling.com/)).

[badge-gh-actions]: https://github.com/iancleary/ubuntu-dev-playbook/workflows/CI/badge.svg?event=push
[link-gh-actions]: https://github.com/iancleary/ubuntu-dev-playbook/actions?query=workflow%3ACI

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

> [GitHub Actions: Ubuntu 22.04 is now generally available on GitHub-hosted runners](https://github.blog/changelog/2022-08-09-github-actions-ubuntu-22-04-is-now-generally-available-on-github-hosted-runners/)

| LTS | Last Supported Branch/Tag  |
|:-------------|:-------------:|
|  Ubuntu 20.04 and 22.04 (including elementary OS 6.x and 7.x, respectively) | [main](https://github.com/iancleary/ubuntu-dev-playbook)|
|  Ubuntu 20.04 (including elementary OS 6.0) | [2022.9.25](https://github.com/iancleary/ubuntu-dev-playbook/releases/tag/v2022.9.25)|
|  Ubuntu 18.04 | [2020.1.0](https://github.com/iancleary/ubuntu-dev-playbook/releases/tag/v2020.1.0)|

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
* [colorls](https://github.com/athityakumar/colorls): A Ruby script that colorizes the ls output with color and icons.

### Development Tooling

* `ansible`,
* `docker`,
* `docker-compose`,
* `nodejs`, `npm`, and `yarn`
* `python3`, `python3.10`
* `gh` [GitHub CLI](https://github.com/cli/cli#installation-and-upgrading)
* `yarn`
* `terraform`
* `linode` CLI

## Dotfiles

* [iancleary/dotfiles](https://github.com/iancleary/dotfiles) managed with the [yadm](https://yadm.io/docs/getting_started) dotfile manager

> Check out their [Getting Started Documentation](https://yadm.io/docs/getting_started)

The ansible role [yadm](roles/yadm) does more or less the following:

```bash
yadm clone -b main https://github.com/iancleary/dotfiles --bootstrap
```

This clones my dotfiles repo via HTTPS using yadm's [bootstrap](https://yadm.io/docs/bootstrap) standard command.

My Bootstrap script is [iancleary/dotfiles/blob/main/.config/yadm/bootstrap](https://github.com/iancleary/dotfiles/blob/main/.config/yadm/bootstrap). It's purpose is to:

* loads my dotfiles (including SSH keys)
* decrypt the private key (prompts for password),
* add the key to ssh-agent,
* tests the connection,
* and exit.

## Hyper-V

This [role](https://github.com/iancleary/ubuntu-dev-playbook/tree/main/roles/hyper-v/tasks/main.yml) allows you to set the screen resolution in `/etc/default/grub`.

## Desktop

### Integrated Development Environment

* [VSCode](https://code.visualstudio.com/),
* VS Code Extensions

> If you prefer a fully open source option, checkout [VSCodium](https://vscodium.com/)! Set "code_executable" to "/snap/bin/codium".

### Application Base

* `Flatpak`,
* `Snap`,

> various applications are installed with both packages managers.

### AppImageLauncher

* [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher), see the [Integrate any AppImage into the Ubuntu Desktop](https://dev.to/strotgen/integrate-tinkerwell-or-any-appimage-into-the-ubuntu-desktop-le9) article.

### Application Launcher

* [ULauncher](https://github.com/ULauncher/ULauncher), A ctrl + spacebar productivity bar, Ulauncher is inspired by Alfred for macOS and similar semantic search tools that followed in its wake.

### Backups

* `Timeshift` <https://github.com/teejee2008/timeshift>,

### Screenshots and GIFs

* [Flameshot](https://flameshot.js.org/#/),

> Flameshot keybinding to the Print Screen key using `gsettings`

* [Peek](https://github.com/phw/peek), a simple screen recorder with an easy to use interface

### Utilities

* [Tailscale (A secure network that just works)](https://tailscale.com/download/linux)
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
python packages per the [requirements-ansible.txt](https://github.com/iancleary/ubuntu-dev-playbook/blob/main/requirements-ansible.txt) file.

> This includes Ansible, using Python3.

This also moves the [home-local-bin.sh](https://github.com/iancleary/ubuntu-dev-playbook/blob/main/home-local-bin.sh)
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

The "-e" is for extra variable and is from my Ansible Galaxy role [iancleary/ansible-role-zsh#example-playbook](https://github.com/iancleary/ansible-role-zsh#example-playbook)

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
https://github.com/iancleary/ubuntu-dev-playbook/raw/main/run_terminal.sh | \
bash
```

### New Desktop Setup

```bash
wget -qO- \
https://github.com/iancleary/ubuntu-dev-playbook/raw/main/run_desktop.sh | \
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
* The version controlled [default.config.yml](https://github.com/iancleary/ubuntu-dev-playbook/tree/main/default.config.yml) file.

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
