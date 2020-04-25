# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- [JetBrains Mono Font](https://www.jetbrains.com/lp/mono/) via [Download JetBrainMono-1.0.3.zip](https://download.jetbrains.com/fonts/JetBrainsMono-1.0.3.zip)
- [group_vars](group_vars) folder
- [library/json_mod](library/json_mod) module, from [bradymholt/json_mod](https://gist.github.com/bradymholt/17cb99185c7b80b0f34a)
- Kite AI Autocompletion and Docs for Python, via [kite.com](https://kite.com/)
- Flameshot detection on installed package version
- Docker support for Ubuntu 20.04
- Snaps and Code Extensions variables per [#83](https://github.com/iancleary/ansible-desktop/issues/83)
- Snaps variables
- Added pre-commit python package per [#116](https://github.com/iancleary/ansible-desktop/issues/116)

## Changed

- Moved role vars/ to defaults/ when group_vars make sense
- Changed `gnome-extensions` to have dock on bottom, and multi-monitor dock turned off
- `inventory` now uses the `localhost` and `{hostname}` groups.
- Removed unneeded apt_repository task for Docker on Ubuntu 20.04
- Bumped gh CLI version to 0.7.0
- Moved peek role after Flatpak to ensure dependencies are met
- GNOME Themes role on performed on Ubuntu 18.04 due to PPA availability at 20.04 launch
- Fixed repo name in README
- Moved flatpak application list to group_vars
- Updated evolution and libreoffice roles to remove apt packages

## Removed

- Ticktick from `make install` as it fails during fresh install
- `sudo reboot` from end of [run.sh](run.sh)
- Moved `Poetry` to archive

## [0.8.0] - 2020-04-18

### Added

- Make non-ansible role for new machine script
- GNOME terminal: set `theme-variant` to 'dark' (fixed)
- GNOME Extensions: Set dock icon size to 24
- Chown and chmod `$HOME/.local/bin`
- Chown and chmod cloned repo in `run.sh`
- Source `. /etc/profile` in yarn role
- Start Flameshot automatically
- Upgrade system in run.sh, reboot when done
- Python 3.8 and flit
- Added [ncspot snap](https://snapcraft.io/ncspot)

### Changed

- CI: Moved flameshot test to GNOME job
to test `make flameshot-keybindings`
- Moved Python3.6 and Python3.7 `make` targets to main Makefile
- `sh` linting in `yarn.sh.j2` template
- Changed `.travis.yml` to use Makefile for lifecyle
- Upgraded github-cli version to 0.6.4
- Peek: switched from a deb to Flatpak
- Upgraded github-cli version to 0.6.3
- Upgraded protonmail-bridge to 1.2.6-1
- Changed `pip3` to `python3 -m pip` for version compatibility

## Removed

- Removed `sudo` from `sudo bash` in new machine script

## [0.7.0] - 2020-03-23

### Added

- Common-snaps: Added [breaktimer](https://snapcraft.io/breaktimer) snap
- Development-tools: Added [VSCodium](https://snapcraft.io/vscodium) snap
- Apt Dependencies Script: Added [yamllint](https://yamllint.readthedocs.io/)
- CI: linting - [yamllint](https://yamllint.readthedocs.io/) and [shellcheck](https://www.shellcheck.net/)
- CI: linting - [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)
- Added `flameshot-keybindings` and `tresorit` Make targets to New Machine Setup
- Added [carbon-cli](https://github.com/mixn/carbon-now-cli) to Yarn globals
- CI: Added coverage for GNOME roles
- CI: Combined jobs since Travis Open Source allows 5 parallel jobs

### Changed

- CI: Switched from GitHub Actions to Travis-CI
- Snaps: moved constituent parts of snap role into separate roles
- Linted all yaml files with [yamllint](https://yamllint.readthedocs.io/)
- Linted all bash files with [shellcheck](https://www.shellcheck.net/)
- Linted non CHANGELOG.md files with [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)
- Moved contents from archive folder

### Removed

- Spring cleaning in archive folder

## [0.6.0] - 2020-03-20

### Added

- GNOME Preferences: Show date in clock -> true
- Created Protonmail Bridge Ansible Role
- Firefox: changed from apt to snap
- GNOME Preferences: Show Desktop Icons -> false
- TickTick: Add Nativefier yarn global and role for TickTick install

## [0.5.0] - 2020-03-14

### Added

- Moved to Ansible for the backend
- Added GNOME Evolution, using Flatpak
- Added LibreOffice, using Flatpak
- Added GNOME theme, icon, cursor installation
- Added ZSH installation, custom zshrc template
- Added Yarn (and Nodejs)
- GNOME Preferences - set "attach-modal-dialogs" to False
- GNOME Preferences - set Desktop Window Management "focus-mode" to sloppy
- Added [Planner](https://flathub.org/apps/details/com.github.alainm23.planner), using Flatpak
- Added [run.sh](run.sh) new machine script

### Removed

- have yet to port (TBD if will port all)
  - custom gnome-extensions, tresorit, unifi-controller

## [0.4.0] - 2020-02-28

- Added TickTick Native App using [nativefier](https://github.com/jiahaog/nativefier)
- Added [Yet Another Dotfile Manager](https://yadm.io)
- Flameshot: download and install 0.6.0 deb from Github (apt installs 0.5.1-2 at time of writing)
- Stacer: download and install 1.1.0 deb from Github
- Timeshift: added ppa per <https://github.com/teejee2008/timeshift>
- Python upgrade Setuptools, [reference](https://stackoverflow.com/questions/14426491/python-3-importerror-no-module-named-setuptools)
- Added `gh` CLI <https://github.com/cli/cli/releases/tag/v0.5.5>
- Added Protonmail-bridge beta client

## [0.3.0] - 2020-01-12

### Fixed

- fixed python3.* [keyring.alt pip issue with package upgrade](https://bugs.launchpad.net/usd-importer/+bug/1794041)

### Removed

- Removed Brave Browser
- Removed [icloud-for-linux](https://snapcraft.io/icloud-for-linux) snap
- Removed zim-desktop-wiki

### Updated

- updated GNOME theme installation to use [tliron/install-gnome-themes](https://github.com/tliron/install-gnome-themes)
- moved dash-to-dock to unique target

### Added

- Added Peek (GIF Screen Recorder)
- Added Nordvpn
- Added Standard Notes snap

## [0.2.0] - 2019-11-17

### Added

- GNOME keybindings: terminal and close window set to Pop!_OS defaults
- GNOME preferences: changed default clock to '24h'
- GNOME extensions: added GNOME tweak tool, argos installation, and my custom argos extensions
- Docker: run-as-non-root user resolving
- oh-my-zsh: modified install to work within Makefile and use /tmp
- Various: -y flags for apt installs
- Working python altinstall
- Added [poetry](https://poetry.eustace.io/), Python packaging and dependency management made easy
- Added Slack as a snap
- Added Chromium as a snap (note the snap isolation prevents some corp domain DNS resolution)
- Added Lock screensaver to `<Super>l`
- Added [Zim-Desktop-Wiki](https://zim-wiki.org/downloads.html) Ubuntu PPA
- Added [Cherrytree](https://www.giuspen.com/cherrytree/) Ubuntu PPA
- Github Actions CI for most make targets that are not GUI or login/logout dependent

## [0.1.1] - 2019-10-10

### Added

- Install `flatpak`, `steam`

## [0.1.0] - 2019-10-07

### Added

- Use of Makefile as default scripting interface
- Install `ansible`, `Visual Studio Code`, `docker`, `docker-compose`, `nodejs`, `postman`, `python3.7`, `Signal Desktop`, `Telegram`, `Snap`, `Spotify`, `Sublime Text`, `Tresorit`, `yarn`, and `zsh`
- Configure GNOME keybindings and personal preferences

[Unreleased]: https://github.com/iancleary/install-scripts/compare/v0.8.0...HEAD
[0.8.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.8.0
[0.7.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.7.0
[0.6.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.6.0
[0.5.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.5.0
[0.4.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.4.0
[0.3.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.3.0
[0.2.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.2.0
[0.1.1]: https://github.com/iancleary/install-scripts/releases/tag/v0.1.1
[0.1.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.1.0
