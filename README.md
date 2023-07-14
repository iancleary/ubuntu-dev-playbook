ARCHIVED 
=========

> This repo is archived. I no longer plan to maintain it.  You are welcome to do anything permitted by the [LICENSE](LICENSE).
> 
> Why, see this article about [NixOS vs Ansible](https://discourse.nixos.org/t/nixos-vs-ansible/16757/17) for more details.


<p align="center">

<img src="./img/ubuntu_orange_hex.svg" width="250" height="156" alt="Ubuntu Logo" />
<img src="./img/plus.svg" width="30" height="130" alt="Plus Sign SVG" />
<img src="./img//Ansible-Wordmark-RGB-White.svg" width="250" height="130" alt="Ansible Logo" />

</p>

# Ubuntu Development Ansible Playbook

<p align="center">

<a href="https://github.com/iancleary/ubuntu-dev-playbook/actions?query=workflow%3ACI" target="_blank">
    <img src="https://github.com/iancleary/ubuntu-dev-playbook/workflows/CI/badge.svg" alt="CI workflow status">
</a>
<a href="https://raw.githubusercontent.com/iancleary/ubuntu-dev-playbook/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>
</p>

This playbook installs and configures most of the software I use on my Ubuntu Installations for web and software development.
Some things are slightly difficult to automate, so I still have a few manual installation steps, but at least it's all documented here.

## Installation

  1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html):

     1. Upgrade Pip: `python3 -m pip install --upgrade pip`
     2. Run the following command to add Python 3 to your $PATH: `export PATH="$HOME/.local/bin:$PATH"`
     3. Install Ansible: `python3 -m pip install ansible`

  2. Clone or download this repository to your local drive.
  3. Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
  4. Run `ansible-playbook playbook_terminal.yml --ask-become-pass` inside this directory. Enter your sudo account password when prompted for the 'BECOME' password.
  5. (if desired) Run `ansible-playbook playbook_desktop.yml --ask-become-pass` inside this directory. Enter your sudo account password when prompted for the 'BECOME' password.

> Note: If some commands fail, you might need logout and log back in again.


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

> Note I run both the playbook_terminal.yml and playbook_desktop.yml as they are mutually exclusive.  In older releases, they were a single playbook, but I've separated them.

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in [group_vars](group_vars) by creating a `config.yml` file and setting the overrides in that file.

**For example, you can customize the installed packages and apps with something like:**

```yaml
apt_packages:
  - python3.10
  - git
  - nala

nodejs_version: "18.x"
# Set to true to suppress the UID/GID switching when running package scripts. If
# set explicitly to false, then installing as a non-root user will fail.
npm_config_unsafe_perm: true
npm_global_packages:
  - name: "yarn"
  - name: "vercel"

gem_packages:
  - name: bundler
    state: latest

pip_packages:
  - name: mkdocs

pipx_packages:
  - name: ruff
  - name: pre-commit


snaps:
  - name: "authy"  # 2-Factor Authentication
  - name: "beekeeper-studio"  # An open source SQL editor and database management app
  - name: "code"
    classic: "yes"
  - name: "flameshot"  # Powerful yet simple to use screenshot software
  - name: "slack"
    classic: "yes"
  - name: "chromium"
  - name: "standard-notes"

# you are responsible for making sure there is a matching snap
snap_plugs:
  - plug: "home"
    app: "chromium"
  - plug: "password-manager-service"
    app: "standard-notes"


configure_flatpak: true
configure_flatpak_gnome_software: true  # gnome software plugin, can turn off to avoid duplicate stores (snap-store and gnome-software)
flatpaks:
  # - "net.giuspen.cherrytree"  # Hierarchical Note Taking
  - "io.github.seadve.Kooha"  # Simple screen recorder with an easy to use interface
  - "com.rafaelmardojai.Blanket"  # Background Sounds
  - "com.github.tchx84.Flatseal"  # Manage Flatpak permissions
  - "org.gabmus.whatip"  # Info on your IP
  - "org.libreoffice.LibreOffice"
  - "org.mozilla.firefox"
  - "org.videolan.VLC"
  - "nl.hjdskes.gcolor3"  # Color Picker
  - "re.sonny.Junction"
  - "com.mattjakeman.ExtensionManager"
  - "ca.desrt.dconf-editor"
  - "io.podman_desktop.PodmanDesktop"

gem_packages:
  - name: bundler
    state: present # present/absent/latest, default: present
    version: "~> 1.15.1" # default: N/A

configure_code_extensions: true
code_extensions:
  - # General Development
  - christian-kohler.path-intellisense
  - vscode-icons-team.vscode-icons
  - riccardoNovaglia.missinglineendoffile
  - shardulm94.trailing-spaces
  - oderwat.indent-rainbow
  - ms-vscode.makefile-tools
  # - Shan.code-settings-sync

  ## Git Utilities
  - eamodio.gitlens
  - donjayamanne.githistory
  - mhutchie.git-graph

  ## Markdown Linting
  - DavidAnson.vscode-markdownlint

  ## Python Development
  - ms-python.python
  - himanoa.Python-autopep8
  - njpwerner.autodocstring
  - wholroyd.jinja
  - ms-python.vscode-pylance

  ## Spellchecking
  - streetsidesoftware.code-spell-checker

  ## Themes
  - sdras.night-owl
  - akamud.vscode-theme-onedark

  ## Vue.js Development
  - octref.vetur
  - dbaeumer.vscode-eslint
  - pranaygp.vscode-css-peek
  - sdras.vue-vscode-snippets

  ## HTML
  - formulahendry.auto-close-tag
  - anteprimorac.html-end-tag-labels
  - vincaslt.highlight-matching-tag
  - formulahendry.auto-rename-tag

```

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.

## Included Applications / Configuration (Default)

Default applications are controlled on a group basis, with hosts being localhosts.
This yields a groups_vars folder for [terminal](group_vars/terminal/) and one for [desktop](group_vars/desktop/)

The folders contain the defaults, as well as some of the Ansible Galaxy Roles:

* [iancleary.ohmyzsh](https://github.com/iancleary/ansible-role-ohmyzsh/) and it's [defaults](https://github.com/iancleary/ansible-role-ohmyzsh/blob/main/defaults/main.yml)


## Testing the Playbook

While I often setup new machines while I experiment Many people have asked me if I often wipe my entire workstation and start from scratch just to test changes to the playbook. Nope! This project is [continuously tested on GitHub Actions' Ubuntu infrastructure](https://github.com/iancleary/ubuntu-dev-playbook/actions?query=workflow%3ACI).

## Testing the Ansible Roles is done elsewhere

This project intentionally doesn't not test the Ansible Galaxy roles that are continuously tested on Github Actions Ubuntu infrastructure elsewhere.  That testing uses Docker and (generally) targets the latest Ubuntu LTS and the latest Fedora release.

This project doesn't test on Github Actions with Fedora, as that (at the time of writing) isn't easily supported with Github Actions while not using docker.

That said, I'm considering adding Fedora support (as there are just a few apt installs that would need to be expanded upon to also support rpm/dnf)


### iancleary.meslolgs

<a href="https://github.com/iancleary/meslolgs/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-meslolgs/workflows/CI/badge.svg" alt="CI workflow status">
</a>
<a href="https://github.com/iancleary/ansible-role-meslolgs/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-meslolgs/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://raw.githubusercontent.com/iancleary/ansible-role-meslolgs/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>

### iancleary.colorls

<a href="https://github.com/iancleary/ansible-role-colorls/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-colorls/workflows/CI/badge.svg" alt="CI workflow status">
</a>
<a href="https://github.com/iancleary/ansible-role-colorls/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-colorls/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://raw.githubusercontent.com/iancleary/ansible-role-colorls/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>

### iancleary.ohmyzsh

<a href="https://github.com/iancleary/ansible-role-ohmyzsh/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-ohmyzsh/workflows/CI/badge.svg" alt="CI workflow status">
</a>
<a href="https://github.com/iancleary/ansible-role-ohmyzsh/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-ohmyzsh/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://raw.githubusercontent.com/iancleary/ansible-role-ohmyzsh/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>

### iancleary.gh

<a href="https://github.com/iancleary/ansible-role-gh/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-gh/workflows/CI/badge.svg" alt="CI workflow status">
</a>
<a href="https://github.com/iancleary/ansible-role-gh/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-gh/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://raw.githubusercontent.com/iancleary/ansible-role-gh/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>

### iancleary.tailscale

<a href="https://github.com/iancleary/ansible-role-tailscale/actions?query=workflow%3Aci" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-tailscale/workflows/CI/badge.svg" alt="CI workflow status">
</a>
<a href="https://github.com/iancleary/ansible-role-tailscale/actions?query=workflow%3Arelease" target="_blank">
    <img src="https://github.com/iancleary/ansible-role-tailscale/workflows/Release/badge.svg" alt="Release workflow status">
</a>
<a href="https://raw.githubusercontent.com/iancleary/ansible-role-tailscale/main/LICENSE" target="_blank">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>


## Virtual Machines

You can also run Ubuntu inside a VM.

If you do, I currently recommend:

  - [VirtualBox](https://virtualbox.org)
  - [Easy SSH Setup for VirtualBox](https://dev.to/developertharun/easy-way-to-ssh-into-virtualbox-machine-any-os-just-x-steps-5d9i), this can scale to different VMs by changing which host port you forward each VM to, and changing the ssh config on the host accordingly.

Additionally, it is useful to mount a shared drive.

## Windows

For Windows hosts, I've had issues with WSL while using certain VPNs (say Cisco AnyConnect).  While there are likely guides on how to get WSLs DNS issues resolved under WSL2, that is not the focus of this repo.  The playbook will generally work on WSL though.

Hyper-V is also possible for Virtualization, but I've had difficulties with static IP Configuration, see [local-ssh-config](https://github.com/iancleary/local-ssh-config).

> Note: If you go the Hyper-V route, there is also a [hyper-v](roles/hyper-v/) role that helps set the resolution, such that the Hyper-V window on the host will be scaled to the correct resolution.  In general, Hyper-V will be faster than VirtualBox, due to what layer of hypervisor each are.

If your machine is fast enough, I recommend the [VirtualBox and port forwarding route](#virtual-machines).  Especially useful with a shared drive and a symlink from /mnt/shared to the home directory within the virtual machine.  I recommend that workflow.


## Author

This project was created by [Ian Cleary](https://iancleary.me), (originally inspired by [Jeff Geerling](https://www.jeffgeerling.com/)).

[badge-gh-actions]: https://github.com/iancleary/ubuntu-dev-playbook/workflows/CI/badge.svg
[link-gh-actions]: https://github.com/iancleary/ubuntu-dev-playbook/actions?query=workflow%3ACI

## Supported Ubuntu LTS Versions

I will support the LTS versions I use. There are no plans to support non-LTS versions.

> [GitHub Actions: Ubuntu 22.04 is now generally available on GitHub-hosted runners](https://github.blog/changelog/2022-08-09-github-actions-ubuntu-22-04-is-now-generally-available-on-github-hosted-runners/)

| LTS | Last Supported Branch/Tag  |
|:-------------|:-------------:|
|  Ubuntu 20.04 and 22.04 (including elementary OS 6.x and 7.x, respectively) | [main](https://github.com/iancleary/ubuntu-dev-playbook)|
|  Ubuntu 20.04 (including elementary OS 6.0) | [2022.9.25](https://github.com/iancleary/ubuntu-dev-playbook/releases/tag/v2022.9.25)|
|  Ubuntu 18.04 | [2020.1.0](https://github.com/iancleary/ubuntu-dev-playbook/releases/tag/v2020.1.0)|

## Authors

I benefited from the source work of others, see [AUTHORS.md](AUTHORS.md).

> My choice to open source my work here is to share back with you.

If you wish to contribute, see [CONTRIBUTING.md](CONTRIBUTING.md)
