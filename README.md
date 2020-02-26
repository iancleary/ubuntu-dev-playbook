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
