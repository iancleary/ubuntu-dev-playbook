
.PHONY: help

# Shell that make should use
# Make changes to path persistent
# https://stackoverflow.com/a/13468229/13577666
SHELL := /bin/bash
PATH := $(PATH)

# Ubuntu distro string
OS_VERSION_NAME := $(shell lsb_release -cs)

HOSTNAME = $(shell hostname)

# This next section is needed to ensure $$HOME is on PATH in the initial shell session
# The file from bash scripts/before_script_path_fix.sh
# is only loaded in a new shell session.
LOCAL_BIN = $(shell echo $$HOME/.local/bin)
# $(warning LOCAL_BIN is $(LOCAL_BIN))

# Source for conditional: https://stackoverflow.com/a/2741747/13577666
ifneq (,$(findstring $(LOCAL_BIN),$(PATH)))
	# Found: all set; do nothing, $(LOCAL_BIN) is on PATH
	PATH := $(PATH);
else
	# Not found: adding $(LOCAL_BIN) to PATH for this shell session
export PATH := $(LOCAL_BIN):$(PATH); @echo $(PATH)
endif

# "users" format is from https://github.com/iancleary/ansible-role-zsh
VARIABLES = '{"users": [{"username": "$(shell whoami)"}], "ansible_user": "$(shell whoami)", "docker_users": ["$(shell whoami)"]}'

# Main Ansible Playbook Command (prompts for password)
PLAYBOOK=playbook.yml
INSTALL_ANSIBLE_ROLES = ansible-galaxy install -r requirements.yml
ANSIBLE_PLAYBOOK = ansible-playbook $(PLAYBOOK) -v -e $(VARIABLES)

ANSIBLE = $(ANSIBLE_PLAYBOOK) --ask-become-pass

# GitHub Actions Ansible Playbook Command (doesn't prompt for password)
RUNNER = runner
ifeq "$(HOSTNAME)" "$(RUNNER)"
	ANSIBLE = $(INSTALL_ANSIBLE_ROLES) && $(ANSIBLE_PLAYBOOK) --skip-tags "fonts"
endif

ifeq "$(shell whoami)" "$(RUNNER)"
	ANSIBLE = $(INSTALL_ANSIBLE_ROLES) && $(ANSIBLE_PLAYBOOK) --skip-tags "fonts"
endif

# Custome GNOME keybindings
CUSTOM_KEYBINDING_BASE = /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings

# - to suppress if it doesn't exist
-include make.env

$(warning ANSIBLE is $(ANSIBLE))

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# adds anything that has a double # comment to the phony help list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


bootstrap-before-install:
bootstrap-before-install:
	# Apt Dependencies (removes apt ansible)
	bash scripts/before_install_apt_dependencies.sh

bootstrap-install:
bootstrap-install:
	# Python3 Dependencies (install python3 ansible)
	bash scripts/install_python3_dependencies.sh

bootstrap-before-script:
bootstrap-before-script:
	# Ensure "$$HOME/.local/bin" is part of PATH on future shell sessions
	# The top of the Makefile takes care of this in the initial session
	bash scripts/before_script_path_fix.sh

requirements:
requirements:  ## Install ansible requirements
	@$(INSTALL_ANSIBLE_ROLES)

bootstrap: bootstrap-before-install bootstrap-install bootstrap-before-script requirements
bootstrap: ## Installs dependencies needed to run playbook

bootstrap-check:
bootstrap-check: ## Check that PATH and requirements are correct
	@ansible --version | grep "python version"
	@python3 -m pip list | grep psutil

check: DARGS?=
check: ## Checks personal-computer.yml playbook
	@$(ANSIBLE) --check

submodule:
submodule: ## Use GitHub SSH key to setup git submodules
	git submodule init
	git submodule update

init: ## Initializes any machine (Host or VM)
init:
	@$(ANSIBLE) --tags="init"

host: ## Adds extras for a host OS (bare metal)
host:
	@$(ANSIBLE) --tags="host"

hyper-v: ## Configures Hyper-V Resolution
hyper-v:
	@$(ANSIBLE) --tags="hyper-v"


code: ## Code and Terraform
code:
	@$(ANSIBLE) --tags="code"

init-github-runner: ## Initializes any machine (Host or VM)
init-github-runner:
	# test coverage is in the ansible roles themselves
	@$(ANSIBLE) --tags="init" --skip-tags="zsh,docker"

install: DARGS?=
install: ## Installs everything via personal-computer.yml playbook
	@$(ANSIBLE) --skip-tags="ticktick, nautilus-mounts"
	# ticktick doesn't work on fresh install for some reason
	# no planned test coverage to nautilus-mounts as it deals with file mounts

all: ## Does most eveything with Ansible and Make targets
all: bootstrap bootstrap-check install non-ansible

non-ansible:
non-ansible: ## Runs all non-ansible make targets for fresh install (all target)

	# No user input required
	make flameshot-keybindings

	# Ubuntu 20.04 defaults
	make python-three-eight-install
	make python-three-eight-supporting

lint:  ## Lint the repo
lint:
	bash scripts/lint.sh

docs-develop:
docs-develop: ## setup pipenv to develop docs
	pipenv
	pipenv run python3 -m pip install -r requirements.txt
	pipenv shell
	# make docs-live

docs-live:
docs-live: ## create live docs
	bash scripts/docs-live.sh

zsh:
zsh: ## Install zsh and oh-my-zsh
	@$(ANSIBLE) --tags="zsh"

fonts:
fonts: ## Install Fonts for Powerlevel10k
	@$(ANSIBLE) --tags="fonts"

yadm:
yadm: ## Install yadm dotfile manager
	@$(ANSIBLE) --tags="yadm"

docker:
docker: ## Install Docker and Docker-Compose
	@$(ANSIBLE) --tags="docker"

nautilus-mounts:
nautilus-mounts: ## Setup for CIFS Network Mounts, with Nautilus Scripts
	@$(ANSIBLE) --tags="nautilus-mounts"

pulseaudio:
pulseaudio: ## Install pulseaudio GUI
	@$(ANSIBLE) --tags="pulseaudio"

python-three-eight-install: ## Install python3.8 using apt (main install)
python-three-eight-install:

	sudo apt-get update

	# Start by updating the packages list and installing the prerequisites:
	sudo apt install software-properties-common

	# Once the repository is enabled, install Python 3.8 with: (added libpython3.8-dev for pip installs)
	# - httptools wasn't installing correctly until adding it
	# - see: https://github.com/huge-success/sanic/issues/1503#issuecomment-469031275
	sudo apt update
	sudo apt install -y python3.8 libpython3.8-dev

	# At this point, Python 3.8 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.8 --version

python-three-eight-supporting: ## Install useful packages
python-three-eight-supporting:

	# python3 pip
	sudo apt install -y python3-pip

	# upgrade pip
	python3.8 -m pip install --user --upgrade pip
	-python3.8 -m pip install --upgrade keyrings.alt --user
	-python3.8 -m pip install --user --upgrade setuptools

	# python3 pytest
	sudo apt install -y python3-pytest

	# At this point, Python 3.7 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.8 --version
	python3.8 -m pip --version
	python3.8 -m pytest --version

	python3.8 -m pip install --user testresources
	python3.8 -m pip install --user twine
	python3.8 -m pip install --user wheel
	python3.8 -m pip install --user flit
	python3.8 -m pip install --user cookiecutter
	python3.8 -m pip install --user pipenv
	python3.8 -m pip install --user pre-commit
	python3.8 -m pip install --user linode_api4
	# https://python-poetry.org/docs/
	python3.8 -m pip install --user poetry
	sudo apt-get install -y python3-venv
	# https://github.com/python-poetry/poetry/issues/721#issuecomment-623399861
	# Ubuntu 20.04 https://wiki.ubuntu.com/FocalFossa/ReleaseNotes#Python3_by_default
	-sudo apt install python-is-python3

common-snaps:
common-snaps: ## Install Common Snaps
	@$(ANSIBLE) --tags="common-snaps"

chat-clients:
chat-clients: ## Install Chat Client Snaps
	@$(ANSIBLE) --tags="chat-clients"

development-tools:
development-tools: ## Install VS Code, Postman, and Sublime Text Snaps
	@$(ANSIBLE) --tags="development-tools"

web-browsers:
web-browsers: ## Installs web-browsers as snaps
	@$(ANSIBLE) --tags="web-browsers"

peek:
peek: ## Install Peek (GIF Screen Recorder) using a Flatpak
	@$(ANSIBLE) --tags="flatpak" -e '{"flatpak_applications": ["com.uploadedlobster.peek"]}'

pdf-slicer:
pdf-slicer: ## Install PDFSlicer (split and combine PDFs) using a Flatpak
	@$(ANSIBLE) --tags="flatpak" -e '{"flatpak_applications": ["com.github.junrrein.PDFSlicer"]}'

timeshift:
timeshift: ## Install Timeshift (Backup Utility) using a PPA and apt
	@$(ANSIBLE) --tags="timeshift"

flameshot:
flameshot: ## Install Flameshot 0.6.0 Screenshot Tool and Create Custom GNOME Keybindings
	@$(ANSIBLE) --tags="common-snaps" -e '{"snaps_common": [{"name": "flameshot"}]}'

gsettings-keybindings:
gsettings-keybindings:  ## Sets GNOME custom keybindings

	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$(CUSTOM_KEYBINDING_BASE)/flameshot/','$(CUSTOM_KEYBINDING_BASE)/hyper/']"

flameshot-keybindings: ## Flameshot custon GNOME keybindings
flameshot-keybindings: gsettings-keybindings
	# For whatever reason, I bricked my GNOME session trying this with ansible
	# so for now, I'm just going to chain this to the new machine script
	# and leave it as a make target

	# Update gnome keybindings
	# source: https://askubuntu.com/a/1116076

	gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "[]"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ name 'flameshot'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ command '/snap/bin/flameshot gui'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ binding 'Print'

github-cli:
github-cli: ## Install GitHub CLI deb, directly from GitHub Release
	@$(ANSIBLE) --tags="github-cli"

# gnome-boxes:
# gnome-boxes: ## Install GNOME Boxes, using Flatpak
# 	@$(ANSIBLE) --tags="flatpak,gnome-boxes"

gnome:
gnome: ## Set up my GNOME desktop like I like
	@$(ANSIBLE) --tags="gnome"

hyper: ## Install Hyper (A terminal built on web technologies)
hyper: gsettings-keybindings
	@$(ANSIBLE) --tags="hyper"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/hyper/ name 'hyper'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/hyper/ command '/usr/local/bin/hyper'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/hyper/ binding '<Super>t'

nordvpn:
nordvpn: ## Install Peek (GIF Screen Recorder) using a PPA and apt
	@$(ANSIBLE) --tags="nordvpn"

stacer:
stacer: ## Install Stacer (Material System Utility)
	@$(ANSIBLE) --tags="stacer"

flatpak:
flatpak: ## Install Peek (GIF Screen Recorder) using a PPA and apt
	@$(ANSIBLE) --tags="flatpak"

cherrytree:
cherrytree: ## Install Cherrytree, using Flatpak
	@$(ANSIBLE) --tags="flatpak" -e '{"flatpak_applications": ["com.giuspen.cherrytree"]}'

okular:
okular: ## Install Okular, using Flatpak
	@$(ANSIBLE) --tags="flatpak" -e '{"flatpak_applications": ["org.kde.okular"]}'

tresorit: ## Install Tresorit
tresorit:
	wget -O ~/Downloads/tresorit_installer.run https://installerstorage.blob.core.windows.net/public/install/tresorit_installer.run
	chmod +x ~/Downloads/tresorit_installer.run
	$(echo $0) ~/Downloads/tresorit_installer.run

yarn:
yarn: ## Installs Yarn (and Nodejs)
	# This role takes care of $$PATH
	@$(ANSIBLE) --tags="yarn"

wifi-analyzer:
wifi-analyzer: ## Installs LinSSID Wifi Analyzer
	# Attribution: podcasts.apple.com/us/podcast/linux-unplugged/id687598126?i=1000475937121
	@$(ANSIBLE) --tags="wifi-analyzer"

app-image:
app-image: ## Install App Image Launcher
	@$(ANSIBLE) --tags="app-image"

ulauncher:
ulauncher: ## Install ULauncher App Launcher (CTRL+spacebar)
	@$(ANSIBLE) --tags="ulauncher"

caffeine:
caffeine: ## Install caffeine (screen stay awake toggle, plus indicator)
	@$(ANSIBLE) --tags="caffeine"


.DEFAULT_GOAL := help
