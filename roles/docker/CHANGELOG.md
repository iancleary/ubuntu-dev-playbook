# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]


## [3.0.0] - 2021-08-29

### Changed

- username from `iancleary` to `icancclearynow`

## [2.0.2] - 2021-08-13

### Changed

- Added more specific when conditionals for Ubuntu 20.04 and elementary OS 6

## [2.0.1] - 2021-08-12

### Changed

- Bumped docker-compose to [1.29.2](https://github.com/docker/compose/releases/tag/1.29.2)

## [2.0.0] - 2021-08-12

### Changed

- Switched to root user with `become: true`

### Removed

- Removed start on boot command, since it is already the [default on Debian and Ubuntu based systems](https://docs.docker.com/engine/install/linux-postinstall/#configure-docker-to-start-on-boot)

## [1.0.1] - 2021-03-28

### Changed

- Bumped docker-compose to [1.28.6](https://github.com/docker/compose/releases/tag/1.28.6)

## [1.0.0] - 2021-02-26

## Added

- Descriptions of role variables

### Changed

- Bumped docker-compose to [1.28.5](https://github.com/docker/compose/releases/tag/1.28.5)

## [0.1.0] - 2021-02-08

### Added

- Initial role! 🚀

[Unreleased]: https://github.com/icancclearynow/ansible-role-docker/compare/v3.0.0...HEAD
[3.0.0]: https://github.com/icancclearynow/ansible-role-docker/releases/tag/v3.0.0
[2.0.2]: https://github.com/icancclearynow/ansible-role-docker/releases/tag/v2.0.2
[2.0.1]: https://github.com/icancclearynow/ansible-role-docker/releases/tag/v2.0.1
[2.0.0]: https://github.com/icancclearynow/ansible-role-docker/releases/tag/v2.0.0
[1.0.1]: https://github.com/icancclearynow/ansible-role-docker/releases/tag/v1.0.1
[1.0.0]: https://github.com/icancclearynow/ansible-role-docker/releases/tag/v1.0.0
[0.1.0]: https://github.com/icancclearynow/ansible-role-docker/releases/tag/v0.1.0
