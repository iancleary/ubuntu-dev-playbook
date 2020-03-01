
.PHONY: help

# Shell that make should use
SHELL:=bash

# Ubuntu distro string
OS_VERSION_NAME := $(shell lsb_release -cs)

# Main Ansible Playbook Command
## if used with bash, outside Makefile, remove the change 'S(shell whoami)' to '$(whoami)'
ANSIBLE=ansible-playbook --connection=local --inventory=127.0.0.1, personal_computer.yml --ask-become-pass -e 'ansible_user='$(shell whoami)

# - to suppress if it doesn't exist
-include make.env

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# adds anything that has a double # comment to the phony help list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


bootstrap:
bootstrap: ## Installs dependencies needed to run playbook

	#Installing make and ansible

	# Remove any version of ansible
	sudo apt remove -y ansible

	## Remove old packages
	sudo apt -y autoremove

	# Make for ease of use, python-apt for --check ansible flag
	sudo apt-get install -y make python-apt python-pip python3-apt python3-pip

	## Install latest Ansible (snap is only in Ansible >= 2.8)
	sudo apt update
	sudo apt install -y software-properties-common

	# This plays nicer when not --user installed
	python3 -m pip install ansible
	python3 -m pip install psutil # for dconf ansible module


	@echo ""
	@echo ""
	@echo ""
	@echo "Update ~/.bashrc with the following, uncomment export line"
	# Python Path
	# export PATH="$$HOME/.local/bin:$$PATH"
	@echo ""

bootstrap-check:
bootstrap-check: ## Check Boostrap and ~/.bashrc, ~/.zshrc setup

	ansible --version | grep "python version"
	python3 -m pip list | grep psutil

check: DARGS?=
check: ## Checks personal-computer.yml playbook
	#@ansible-playbook --connection=local --inventory=127.0.0.1, personal_computer.yml --check --ask-become-pass -e 'ansible_user='$(whoami)
	@$(ANSIBLE) --check

install: DARGS?=
install: ## Installs everything via personal-computer.yml playbook
	@$(ANSIBLE)

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

steam: flatpak
steam: ## Install Steam, using Flatpak
	@$(ANSIBLE) --tags="steam"

evolution:
evolution: ## Install Evolution Email/Calendar/Tasks Client, using Flatpak
	@$(ANSIBLE) --tags="evolution"

libreoffice:
libreoffice: ## Install LibreOffice Office Suite, using Flatpak
	@$(ANSIBLE) --tags="libreoffice"


.DEFAULT_GOAL := help
