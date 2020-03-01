# install-scripts

![CI Badge](https://github.com/iancleary/install-scripts/workflows/CI/badge.svg)

## Personal Makefile to install common packages on Ubuntu based distributions

### Install Core Software

* `ansible`,
* `cherrytree`,
* `Visual Studio Code`,
* `Chromium`,
* `docker`,
* `docker-compose`,
* `flameshot`,
* `Flatpak`,
* `gh` GitHub CLI <https://github.com/cli/cli#installation-and-upgrading>
* `Nordvpn`,
* `nodejs`,
* `Peek`,
* `postman`,
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
* `TickTick`,
* `Timeshift` <https://github.com/teejee2008/timeshift>,
* `Tresorit`,
* `yarn`,
* `zsh`

### Configuration

* Configure GNOME keybindings and personal preferences
* Install GNOME themes from [tliron/install-gnome-themes](https://github.com/tliron/install-gnome-themes)

### GNOME Extensions

#### Caffeine-plus

```bash
# Install Caffeine-Plus
git clone git://github.com/qunxyz/gnome-shell-extension-caffeine.git
cd gnome-shell-extension-caffeine
bash build.sh
cp -r caffeine-plus@patapon.info ~/.local/share/gnome-shell/extensions
## Restart the shell (ALT+F2, r, ENTER) and then enable the extension.
```

### Changes

See [CHANGELOG](CHANGELOG.md) for history.

See [archive/Makefile](archive/Makefile) for deleted targets.


## Ansible documentation

### Installing latest ansible

<https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu>

Ubuntu builds are available in a PPA here.

To configure the PPA on your machine and install Ansible run these commands:

```bash
sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
```

Note

On older Ubuntu distributions, `software-properties-common` is called `python-software-properties`. You may want to use apt-get instead of apt in older versions. Also, be aware that only newer distributions (i.e. 18.04, 18.10, etc.) have a `-u` or `--update` flag, so adjust your script accordingly.

Debian/Ubuntu packages can also be built from the source checkout, run:

```bash
make deb
```

You may also wish to run from source to get the development branch, which is covered below.

### Syntax Notes

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

### Ansible Modules Used

* [dconf](https://docs.ansible.com/ansible/latest/modules/dconf_module.html)
* [f;atpak_remote](https://docs.ansible.com/ansible/latest/modules/flatpak_remote_module.html)
