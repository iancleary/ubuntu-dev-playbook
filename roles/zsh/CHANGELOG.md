# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0] - 2021-08-29

### Changed

- username from `iancleary` to `icancclearynow`

## [2.1.2] - 2021-08-13

### Changed

- Add `elementary OS` to the `Debian` when conditional `apt` installations

## [2.1.1] - 2021-08-11

### Changed

- `zsh` installation path from `/bin/zsh` to output of `which zsh`, with debug statements

## [2.1.0] - 2021-05-31

### Changed

- Added Fedora 34 Support

## [2.0.3] - 2021-04-06

### Changed

- `zshrc_aliases` swapped `gh` to `hg` for [GitHub CLI compatibility](https://github.com/cli/cli)
## [2.0.2] - 2021-04-01

### Changed

- Fixed order of `.zshrc` plugins and `oh-my-zsh.sh` lines
- Removed stale default plugins

## [2.0.1] - 2021-03-26

### Changed

- Typo in meta/main.yml for Ansible Galaxy

## [2.0.0] - 2021-03-26

### Added

- alias support in `~/.zshrc_aliases`

### Changed

- Switched from Antibody to oh-my-zsh

## [1.0.0] - 2021-02-02

### Changed

- Switch from travis to GitHub Workflows
- Bumped Anitbody from 6.0.1 to 6.1.1

### Removed

- Archiving this role since Antibody is now deprecated.
- Dropping Fedora support

## [0.5.0] - 2020-07-24

### Added

- `skip_zshrc` per user option

## [0.4.2] - 2020-07-24

### Changed

- `download-zsh-plugins` role incorrectly used `git.name` (should clone to `git.repo`) within the plugins folder

## [0.4.1] - 2020-07-24

### Changed

- .zshrc.j2 template had extra `}` in jinja2 if block

## [0.4.0] - 2020-07-24

### Changed

- `repo` variable now has `user`, `repo` attributes instead of `url`
- Fixed bug where plugins folder was always [zsh-autosuggestions](https://github.com/icancclearynow/ansible-role-zsh/blob/15c3751c2b59bb212c4289284a0ed380c5a1745c/tasks/download-zsh-plugins.yml#L9)

## [0.3.0] - 2020-07-12

### Added

- Fedora 31 and 32 support

### Changed

- TravisCI logic to only build on "main" branch and Pull Requests (please make a draft PR to test)

## [0.2.0] - 2020-06-18

### Changed

- Switched from `git` to [gitfast](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitfast) oh-my-zsh plugin

## [0.1.0] - 2020-06-07

### Added

- Initial role! 🚀

[Unreleased]: https://github.com/icancclearynow/ansible-role-zsh/compare/v3.0.0...HEAD
[3.0.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v3.0.0
[2.1.2]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v2.1.2
[2.1.1]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v2.1.1
[2.1.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v2.1.0
[2.0.3]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v2.0.3
[2.0.2]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v2.0.2
[2.0.1]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v2.0.1
[2.0.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v2.0.0
[1.0.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v1.0.0
[0.5.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v0.5.0
[0.4.2]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v0.4.2
[0.4.1]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v0.4.1
[0.4.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v0.4.0
[0.3.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v0.3.0
[0.2.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v0.2.0
[0.1.0]: https://github.com/icancclearynow/ansible-role-zsh/releases/tag/v0.1.0
