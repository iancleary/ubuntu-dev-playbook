
.PHONY: help

# Shell that make should use
SHELL:=bash

# Ubuntu distro string
OS_VERSION_NAME := $(shell lsb_release -cs)

HOSTNAME = $(shell hostname)

# Main Ansible Playbook Command (prompts for password)
ANSIBLE=ansible-playbook personal_computer.yml -v -i inventory --ask-become-pass -e 'ansible_user='$(shell whoami)

# Travis CI Ansible Playbook Command (doesn't prompt for password)
TRAVIS=travis
ifeq "$(HOSTNAME)" "$(TRAVIS)"
	ANSIBLE=ansible-playbook personal_computer.yml -v -i inventory -e 'ansible_user='$(shell whoami)
endif

$(warning ANSIBLE is $(ANSIBLE)) 

# - to suppress if it doesn't exist
-include make.env

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# adds anything that has a double # comment to the phony help list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


bootstrap:
bootstrap: ## Installs dependencies needed to run playbook

	# Apt Dependencies (removes apt ansible)
	bash scripts/before_install_apt_dependencies.sh

	# Python3 Dependencies (install python3 ansible)
	bash scripts/install_python3_dependencies.sh

	# Ensure "$$HOME/.local/bin" is part of PATH
	bash scripts/before_script_path_fix.sh

bootstrap-check:
bootstrap-check: ## Check that PATH and requirements are correct

	# Check that PATH and requirements are correct
	ansible --version | grep "python version"
	python3 -m pip list | grep psutil

check: DARGS?=
check: ## Checks personal-computer.yml playbook
	@$(ANSIBLE) --check

install: DARGS?=
install: ## Installs everything via personal-computer.yml playbook
	@$(ANSIBLE)

all: ## Does eveything
all: bootstrap bootstrap-check install

zsh:
zsh: ## Install zsh and oh-my-zsh
	@$(ANSIBLE) --tags="zsh"

common:
common: ## Install Common apt packages
	@$(ANSIBLE) --tags="common"


cherrytree:
cherrytree: ## Install Cherrytree using a PPA and apt
	@$(ANSIBLE) --tags="cherrytree"

docker:
docker: ## Install Docker and Docker-Compose
	@$(ANSIBLE) --tags="docker"

python:
python: ## Install Python 3.6 and 3.7, with extras
	@$(ANSIBLE) --tags="python"

snaps:
snaps: ## Install Many Snaps
	@$(ANSIBLE) --tags="snaps"

web-browsers:
web-browsers: ## Installs web-browsers as snaps
	@$(ANSIBLE) --tags="web-browsers"

peek:
peek: ## Install Peek (GIF Screen Recorder) using a PPA and apt
	@$(ANSIBLE) --tags="peek"

timeshift:
timeshift: ## Install Timeshift (Backup Utility) using a PPA and apt
	@$(ANSIBLE) --tags="timeshift"

flameshot:
flameshot: ## Install Flameshot 0.6.0 Screenshot Tool and Create Custom GNOME Keybindings
	@$(ANSIBLE) --tags="flameshot"

github-cli:
github-cli: ## Install GitHub CLI deb, directly from GitHub Release
	@$(ANSIBLE) --tags="github-cli"

gnome-boxes:
gnome-boxes: ## Install GNOME Boxes, using Flatpak
	@$(ANSIBLE) --tags="flatpak,gnome-boxes"

gnome-extensions:
gnome-extensions: ## Install GNOME Extensions
	@$(ANSIBLE) --tags="gnome-extensions"

gnome-keybindings:
gnome-keybindings: ## Set my GNOME Keybindings
	@$(ANSIBLE) --tags="gnome-keybindings"

gnome-themes:
gnome-themes: ## Install and Set GNOME Theme, Icons, and Cursor
	@$(ANSIBLE) --tags="gnome-themes"

gnome-preferences:
gnome-preferences: ## Set GNOME Preferences
	@$(ANSIBLE) --tags="gnome-preferences"

nordvpn:
nordvpn: ## Install Peek (GIF Screen Recorder) using a PPA and apt
	@$(ANSIBLE) --tags="nordvpn"

stacer:
stacer: ## Install Stacer (Material System Utility)
	@$(ANSIBLE) --tags="stacer"

flatpak:
flatpak: ## Install Peek (GIF Screen Recorder) using a PPA and apt
	@$(ANSIBLE) --tags="flatpak"

planner:
planner: ## Install Planner, using Flatpak
	@$(ANSIBLE) --tags="flatpak, planner"

steam: flatpak
steam: ## Install Steam, using Flatpak
	@$(ANSIBLE) --tags="steam"

evolution:
evolution: ## Install Evolution Email/Calendar/Tasks Client, using Flatpak
	@$(ANSIBLE) --tags="evolution"

protonmail-bridge:
protonmail-bridge: ## Install Protonmail Bridge Deb from their website
	@$(ANSIBLE) --tags="protonmail-bridge"

libreoffice:
libreoffice: ## Install LibreOffice Office Suite, using Flatpak
	@$(ANSIBLE) --tags="libreoffice"

yarn:
yarn: ## Installs Yarn (and Nodejs)
	# This role takes care of $$PATH
	@$(ANSIBLE) --tags="yarn"

ticktick:
ticktick: ## Installs TickTick using yarn global Nativefier
	@$(ANSIBLE) --tags="ticktick"


.DEFAULT_GOAL := help
