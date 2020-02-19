
.PHONY: help

# Shell that make should use
SHELL:=bash

# Ubuntu distro string
OS_VERSION_NAME := $(shell lsb_release -cs)

# - to suppress if it doesn't exist
-include make.env

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# adds anything that has a double # comment to the phony help list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

update: DARGS?=
update: ## Apt update
	sudo apt-get update

upgrade: DARGS?=
upgrade: ## Apt update & upgrade
	sudo apt-get update && sudo apt-get -y upgrade && sudo apt -y autoremove

ansible: ## Install ansible
ansible:
	sudo apt -y install ansible

# basecamp: ## Standalone app for basecamp.com using nativefier
# basecamp:
# 	-rm -rf /tmp/nativefier/basecamp
# 	mkdir -p /tmp/nativefier/basecamp
# 	nativefier "https://launchpad.37signals.com" /tmp/nativefier/basecamp --icon icons/basecamp.png --name "Basecamp" --single-instance --internal-urls ".*?"
# 	-sudo rm -rf /opt/basecamp
# 	-sudo mkdir /opt/basecamp
# 	sudo cp -r /tmp/nativefier/basecamp /opt
# 	-rm $(HOME)/.local/share/applications/basecamp.desktop
# 	desktop-file-install --dir=$(HOME)/.local/share/applications ./desktop/basecamp.desktop
# 	update-desktop-database $(HOME)/.local/share/applications

cherrytree: ## Installs Cherrytree deb by adding PPA
cherrytree:
	sudo add-apt-repository ppa:giuspen/ppa
	sudo apt install -y cherrytree

chromium: ## Install Chromium as a snap
chromium: snap
	sudo snap install chromium

	# allows opening files
	sudo snap connect chromium:home

code: ## Install Microsoft Visual Studio Code as a snap
code: snap
	sudo snap install code --classic

docker: ## Install docker with apt
docker: DARGS?=
docker:
	# Uninstall old versions
	sudo apt-get remove docker docker-engine docker.io containerd runc

	# Set up the repository
	sudo apt-get update

	# Install packages to allow apt ot use a repository over HTTPS
	sudo apt-get -y install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common

	# Add Docker's official GPG key
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	# Setup the stable repository
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(OS_VERSION_NAME) stable"

	# Update the apt package update
	sudo apt-get update

	# Install the latest version of Docker CE and containerd
	sudo apt-get -y install docker-ce docker-ce-cli containerd.io

	# Verify that Docker CE is installed correctly by running the hello-world image.
	sudo docker run hello-world

docker-run-as-non-root: ## Manage Docker as a non-root user
docker-run-as-non-root: DARGS?=
docker-run-as-non-root:

	###############################################
	# Docker CE (Post-installation steps for Linux)
	# - Manage Docker as a non-root user
	###############################################

	# Create the docker group.
	-sudo groupadd docker

	# Add your user to the docker group.
	sudo usermod -aG docker $(USER)

	# Log out and log back in so that your group membership is re-evaluated.
	# If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.
	# On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.

docker-start-on-boot: ## Start docker on boot
docker-start-on-boot:
	sudo systemctl enable docker

docker-stopped-on-boot: ## Don't start docker on boot
docker-stopped-on-boot:
	sudo systemctl disable docker

docker-compose: ## Install Docker Compose
docker-compose:

	# Run this command to download the current stable release of Docker Compose:
	sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(shell uname -s)-$(shell uname -m)" -o /usr/local/bin/docker-compose

	# Apply executable permissions to the binary:
	sudo chmod +x /usr/local/bin/docker-compose

	# Test the installation
	docker-compose --version

flameshot-install: ## Install Flameshot
flameshot-install: update

	# Ubuntu >=18.04
	# sudo apt install -y flameshot (apt fetches a 0.5.x version, want >= 0.6.0)

	## Snap cannot be found
	# sudo snap install flameshot-app

	## Download deb (0.6.0) from GitHub
	-sudo apt remove -y flameshot
	rm -rf /tmp/flameshot/
	mkdir /tmp/flameshot/
	wget 'https://github.com/lupoDharkael/flameshot/releases/download/v0.6.0/flameshot_0.6.0_bionic_x86_64.deb' -P /tmp/flameshot

	## Install dependencies (https://askubuntu.com/a/248675/1042945)
	# Install package, and install required dependencies
	sudo dpkg --skip-same-version -i /tmp/flameshot/flameshot_0.6.0_bionic_x86_64.deb || sudo apt-get -y --fix-broken install

flameshot: ## Install Flameshot and Update gnome keybindings
flameshot: flameshot-install

	# Update gnome keybindings
	# source: https://askubuntu.com/a/1116076
	# first is allowed to fail, i.e. when no screenshot value is set
	gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "[]"
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ name 'flameshot'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ command '/usr/bin/flameshot gui'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ binding 'Print'


flatpak: ## Install flatpack on GNOME
flatpak: update
	sudo apt install -y flatpak
	-sudo apt install -y gnome-software-plugin-flatpak
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

gnome-firefox-theme: ## Install GNOME Firefox theme
gnome-firefox-theme:
	################################################
	# Install gnome firefox theme
	# https://github.com/rafaelmardojai/firefox-gnome-theme
	# Updating gnome firefox theme
	# https://github.com/rafaelmardojai/firefox-gnome-theme#updating
	###############################################
	git clone git@github.com:rafaelmardojai/firefox-gnome-theme.git /tmp/firefox-gnome-theme && cd /tmp/firefox-gnome-theme
	bash /tmp/firefox-gnome-theme/scripts/install.sh -g

gnome-keybindings:  ## Configure GNOME keybindings
gnome-keybindings:
	## Adjust key bindings for window/application switching (default is for all of below to switch-applications)
	### Rather change gsettings than install an extension!

	# Dconf-editor for tweaking Gnome keyboard shortcuts
	sudo apt install dconf-editor

	# Window and Application switching for sane people
	gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"

	# Move windows and workspaces
	gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down "['<Primary><Shift><Super>Down']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Primary><Shift><Super>Left']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Primary><Shift><Super>Right']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up "['<Primary><Shift><Super>Up']"

	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Shift><Super>Down']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "['<Shift><Alt>End']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Shift><Alt>Left']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Shift><Alt>Right']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Shift><Super>Up']"

	# Close Windows
	# gsettings set org.gnome.desktop.wm.keybindings close '<Super>w'
	gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"

	# Launch Terminal
	gsettings set org.gnome.settings-daemon.plugins.media-keys terminal '<Super>t'

	# Lock Computer (screensaver)
	gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Super>l'

gnome-preferences: ## Install GNOME preferences
gnome-preferences:
	# Set SCP as Monospace (Code) Font
	# gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro Semi-Bold 12'

	# Better Font Smoothing
	gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'

	# Usability Improvements
	-gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'adaptive'
	-gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
	-gsettings set org.gnome.desktop.calendar show-weekdate true
	-gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
	-gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
	-gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

	# Nautilus (File Manager) Usability
	-gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
	-gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'
	-gsettings set org.gtk.Settings.FileChooser sort-directories-first true
	-gsettings set org.gnome.nautilus.list-view use-tree-view true

	# Clock format
	gsettings set org.gnome.desktop.interface clock-format '24h'

gnome-extensions: ## Install GNOME extensions
gnome-extensions:
	# Install Tweak Tool
	-sudo add-apt-repository universe
	sudo apt install gnome-tweak-tool

	# extensions.gnome.org read installed extensions
	sudo apt-get install chrome-gnome-shell

	# Install common extensions via apt
	sudo apt install -y gnome-shell-extensions

	# Install Argos
	## Clone the repository, then copy or symlink the directory argos@pew.worldwidemann.com into ~/.local/share/gnome-shell/extensions. 
	-rm -rf /tmp/argos
	git clone git@github.com:p-e-w/argos.git /tmp/argos
	cp -r /tmp/argos/argos@pew.worldwidemann.com  ~/.local/share/gnome-shell/extensions
	-rm -rf /tmp/argos
	## Restart GNOME Shell by pressing Alt+F2, then entering r.
	## On some systems, you may additionally have to enable the Argos extension using GNOME Tweak Tool.

	# Install my argos scripts
	-rm -rf /tmp/gnome-argos-extensions
	git clone git@github.com:iancleary/gnome-argos-extensions.git /tmp/gnome-argos-extensions
	-rm -rf $(HOME)/.config/argos
	mkdir $(HOME)/.config/argos
	## use rsync rather than cp -r to exclude folders
	rsync -rv /tmp/gnome-argos-extensions/ --exclude=.gitignore --exclude=.vscode --exclude=LICENSE --exclude=CHANGELOG.md --exclude=images/ --exclude=.git --exclude=Makefile . $(HOME)/.config/argos
	-rm -rf /tmp/gnome-argos-extensions

gnome-dash-to-dock: ## Configure dask to dock
gnome-dash-to-dock:
	# Dash to Dock Theme
	gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color false
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots true
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-color '#729fcf'
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
	gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
	gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner false
	gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
	gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
	gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
	gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
	gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
	gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
	gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'SEGMENTED'
	gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.70000000000000000

gnome-themes: ## Install GNOME themes and configure them
gnome-themes:
	###############################################
	# Theming and GNOME Options
	# Install Icons and Themes
	###############################################

	# Paper Icons (https://snwh.org/paper/download)
	# add daily builds PPA
	-sudo add-apt-repository -u ppa:snwh/ppa
	# Install icon theme
	-sudo apt-get install paper-gtk-theme
	-sudo apt-get install paper-icon-theme
	-sudo apt-get install paper-cursor-theme

	## install script for GNOME Themes
	-git clone https://github.com/tliron/install-gnome-themes ~/install-gnome-themes
	# install dependencies
	sudo bash ~/install-gnome-themes/install-requirements-debian

	# run install script (THIS TAKES A LONG TIME)
	@~/install-gnome-themes/install-gnome-themes

	# Enable all possible from above
	## You can echo back current settings with `gsettings get ...`
	-gsettings set org.gnome.desktop.interface gtk-theme 'vimix-laptop-beryl'
	-gsettings set org.gnome.desktop.interface cursor-theme 'Paper'
	-gsettings set org.gnome.desktop.interface icon-theme 'Paper'
	-gsettings set org.gnome.shell.extensions.user-theme name 'vimix-laptop-beryl'

gnome-extras: ## Install gtk3
gnome-extras:
	# https://askubuntu.com/questions/695796/view-list-of-all-available-unique-icons-with-their-names-and-thumbnail/695958
	sudo apt-get install -y gtk-3-examples
	@gtk3-icon-browser &

nodejs: ## Install node.js
nodejs:
	# Using Ubuntu
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs

nordvpn: ## install nordvpn
nordvpn:
	curl -o /tmp/nordvpn-release_1.0.0_all.deb https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
	sudo apt install /tmp/nordvpn-release_1.0.0_all.deb
	sudo apt-get update
	sudo apt install -y nordvpn

peek: ## Install Peek (GIF Screen Recorder)
peek:
	sudo add-apt-repository ppa:peek-developers/stable
	sudo apt update && sudo apt install -y peek

poetry: ## Install Poetry (Python Packaging and Dependencey Management)
poetry:
	# curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3
	sudo apt-get install -y python3-venv
	python3.7 -m pip install --user poetry

postman: ## Install Postman as a snap
postman: snap
	sudo snap install postman

python-three-six-install: ## Install python3.6 using apt (main install)
python-three-six-install: update
	# Start by updating the packages list and installing the prerequisites:
	sudo apt install software-properties-common

	# install python3.6
	sudo apt update
	sudo apt install -y python3.6

	# python3 pip
	sudo apt install -y python3-pip

python-three-six-altinstall: ## Install python3.6 as altinstall (prerequisites and )
python-three-six-altinstall: update
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
		libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
		xz-utils tk-dev libffi-dev liblzma-dev

	# fixes for pip SSL issues
	sudo apt install libssl-dev libncurses5-dev libsqlite3-dev libreadline-dev libgdm-dev libdb4o-cil-dev libpcap-dev

	# sudo apt-get install zlib1g-dev # needed on Pop!_OS 19.10

	# cd ~/Downloads
	# wget https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
	# tar xvf Python-3.6.9.tgz
	# cd Python-3.6.9
	#./configure --enable-optimizations --enable-shared \
		--with-ensurepip=install \
		--prefix=/usr/local \
        LDFLAGS="-Wl,--rpath=/usr/local/lib"
	# make -j8
	# sudo make altinstall
	# python3.6

python-three-six-supporting: ## Install useful packages
python-three-six-supporting:

	# upgrade pip
	python3.6 -m pip install --user --upgrade pip
	-python3.6 -m pip install --upgrade keyrings.alt --user

	# python3 pytest
	sudo apt install -y python3-pytest

	# At this point, Python 3.6 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.6 --version
	python3.6 -m pip --version
	python3.6 -m pytest --version

	python3.6 -m pip install --user twine
	python3.6 -m pip install --user wheel
	python3.6 -m pip install --user cookiecutter
	python3.6 -m pip install --user pipenv

	# add the following to your .bashrc (.zshrc, etc.) file
	# export PATH="$$HOME/.local/bin:$$PATH"

python-three-seven-install: ## Install python3.7 using apt (main install)
python-three-seven-install: update
	# Start by updating the packages list and installing the prerequisites:
	sudo apt install software-properties-common

	# Next, add the deadsnakes PPA to your sources list:
	# sudo add-apt-repository ppa:deadsnakes/ppa # not for 19.04
	# when prompted, press Enter to continue

	# Once the repository is enabled, install Python 3.7 with: (added libpython3.7-dev for pip installs)
	# - httptools wasn't installing correctly until adding it
	# - see: https://github.com/huge-success/sanic/issues/1503#issuecomment-469031275
	sudo apt update
	sudo apt install -y python3.7 libpython3.7-dev

	# At this point, Python 3.7 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.7 --version

python-three-seven-supporting: ## Install useful packages
python-three-seven-supporting:

	# python3 pip
	sudo apt install -y python3-pip

	# upgrade pip
	python3.7 -m pip install --user --upgrade pip
	-python3.7 -m pip install --upgrade keyrings.alt --user

	# python3 pytest
	sudo apt install -y python3-pytest

	# At this point, Python 3.7 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.7 --version
	python3.7 -m pip --version
	python3.7 -m pytest --version

	python3.7 -m pip install --user twine
	python3.7 -m pip install --user wheel
	python3.7 -m pip install --user cookiecutter
	python3.7 -m pip install --user pipenv

	# add the following to your .bashrc (.zshrc, etc.) file
	# export PATH="$$HOME/.local/bin:$$PATH"

secure-comms: ## Install secure communication snaps
secure-comms: snap
	# Signal Desktop Private Messaging
	sudo snap install signal-desktop

	# Telegram messenger
	sudo snap install telegram-desktop

slack: ## Install Slack as a snap
slack: snap
	sudo snap install slack --classic

snap:  ## Install snapd
snap:
	sudo apt install snapd
	sudo snap install snap-store

spotify: ## Install Spotify as a snap
spotify: snap
	sudo snap install spotify

stacer: ## Install Stacer from Github
stacer: update

	## Download deb (1.1.0) from GitHub
	-sudo apt remove -y stacer
	rm -rf /tmp/stacer/
	mkdir /tmp/stacer/
	wget 'https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb' -P /tmp/stacer

	## Install dependencies (https://askubuntu.com/a/248675/1042945)
	# Install package, and install required dependencies
	sudo dpkg --skip-same-version -i /tmp/stacer/stacer_1.1.0_amd64.deb || sudo apt-get -y --fix-broken install


standard-notes: ## Install standard-notes as a snap
standard-notes: snap
	sudo snap install standard-notes

steam: ## Install Steam via Flatpak
steam: flatpak
	flatpak -y install flathub com.valvesoftware.Steam
	# Installed but not displayed? Check with: flatpak run com.valvesoftware.Steam


sublime-text: ## Install Sublime Text as a snap
sublime-text: snap
	sudo snap install sublime-text --classic

ticktick: ## Standalone app for ticktick.com using nativefier
ticktick:
	-rm -rf /tmp/nativefier/ticktick
	mkdir -p /tmp/nativefier/ticktick
	nativefier "https://ticktick.com" /tmp/nativefier/ticktick --icon icons/ticktick.png --name "TickTick" --single-instance
	-sudo rm -rf /opt/ticktick
	-sudo mkdir /opt/ticktick
	sudo cp -r /tmp/nativefier/ticktick /opt
	-rm $(HOME)/.local/share/applications/ticktick.desktop
	desktop-file-install --dir=$(HOME)/.local/share/applications ./desktop/ticktick.desktop
	update-desktop-database $(HOME)/.local/share/applications

timeshift: ## GPL v3 System restore tool for Linux
timeshift: update
	sudo add-apt-repository -y ppa:teejee2008/timeshift
	sudo apt-get update
	sudo apt-get install -y timeshift

tresorit: ## Install Tresorit
tresorit:
	wget -O ~/Downloads/tresorit_installer.run https://installerstorage.blob.core.windows.net/public/install/tresorit_installer.run
	chmod +x ~/Downloads/tresorit_installer.run
	$(echo $0) ~/Downloads/tresorit_installer.run


unifi-controller: ## Download and run UniFi Controller Docker Image
unifi-controller:
	# https://hub.docker.com/r/jacobalberty/unifi
	mkdir -p ~/unifi/data
	mkdir -p ~/unifi/log
	docker run --rm --init -p 8080:8080 -p 8443:8443 -p 3478:3478/udp -p 10001:10001/udp -e TZ='America/Phoenix' -v ~/unifi:/unifi --name unifi jacobalberty/unifi:stable

yadm: ## Yet Another Dotfile Manager (yadm.io)
yadm:
	sudo apt-get install -y yadm

yarn: ## Install node.js and yarn
yarn: update nodejs

	################################################
	# Install Yarn
	# https://yarnpkg.com/en/docs/install#debian-stable
	###############################################
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	@echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt-get update && sudo apt-get install yarn

yarn-globals: ## Install Vue, Gridsome, and Nativefier CLIs
yarn-globals:
	yarn --version
	## Add the next two lines, without the comment, to your .bashrc (.zshrc, etc.) file
	# export PATH="$$PATH:/opt/yarn-$(shell yarn --version)/bin"
	# export PATH="$$(yarn global bin):$$PATH"
	## source it and run again

	#yarn global remove @vue/cli
	yarn global add @vue/cli
	# yarn global remove @gridsome/cli
	yarn global add @gridsome/cli

	# https://github.com/jiahaog/nativefier
	yarn global add nativefier

zsh: ## Install zsh and oh-my-zsh, instructions to change shell to zsh
zsh: update

	################################################
	# Install ZSH and Oh-my-zsh
	# https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
	###############################################
	sudo apt -y install zsh

	zsh --version

	# change shell
	# chsh -s $(shell which zsh)

	# install oh-my-zsh
	-rm -rf /tmp/oh-my-zsh/
	mkdir /tmp/oh-my-zsh/
	curl -Lo /tmp/oh-my-zsh/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	-@sh /tmp/oh-my-zsh/install.sh
	-rm -rf /tmp/oh-my-zsh/

.DEFAULT_GOAL := help
