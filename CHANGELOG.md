# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.0]

### Added

- Added TickTick Native App using [nativefier](https://github.com/jiahaog/nativefier)
- Added [Yet Another Dotfile Manager](https://yadm.io)
- Flameshot: download and install 0.6.0 deb from Github (apt installs 0.5.1-2 at time of writing)
- Stacer: download and install 1.1.0 deb from Github
- Timeshift: added ppa per <https://github.com/teejee2008/timeshift>
- Python upgrade Setuptools, [reference](https://stackoverflow.com/questions/14426491/python-3-importerror-no-module-named-setuptools)
- Added `gh` CLI <https://github.com/cli/cli/releases/tag/v0.5.5>
- Added Protonmail-bridge beta client

## [0.3.0]

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

[Unreleased]: https://github.com/iancleary/install-scripts/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.4.0
[0.3.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.3.0
[0.2.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.2.0
[0.1.1]: https://github.com/iancleary/install-scripts/releases/tag/v0.1.1
[0.1.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.1.0
