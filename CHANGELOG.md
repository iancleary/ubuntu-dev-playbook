# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

## [0.1.1] - 2019-10-10

### Added

- Install `flatpak`, `steam`

## [0.1.0] - 2019-10-07

### Added

- Use of Makefile as default scripting interface
- Install `ansible`, `Visual Studio Code`, `docker`, `docker-compose`, `nodejs`, `postman`, `python3.7`, `Signal Desktop`, `Telegram`, `Snap`, `Spotify`, `Sublime Text`, `Tresorit`, `yarn`, and `zsh`
- Configure GNOME keybindings and personal preferences

[Unreleased]: https://github.com/iancleary/install-scripts/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/iancleary/install-scripts/releases/tag/v0.1.1
[0.1.0]: https://github.com/iancleary/install-scripts/releases/tag/v0.1.0
