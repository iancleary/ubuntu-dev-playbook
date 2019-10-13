
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
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

upgrade: DARGS?=
upgrade: ## Apt update & upgrade
	sudo apt-get update && sudo apt-get -y upgrade && sudo apt -y autoremove

ansible: ## Install ansible
ansible:
	sudo apt -y install ansible

code: ## Install Microsoft Visual Studio Code as a snap
code: snap
	sudo snap install code --classic

docker: ## Install docker with apt 
docker: DARGS?=
docker: upgrade
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

flameshot: ## Install flameshot, update gnome keybindings
flameshot: upgrade

	# Ubuntu >=18.04 
	sudo apt install -y flameshot

	# Update gnome keybindings
	# source: https://askubuntu.com/a/1116076
	# gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot ''
	# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
	# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'flameshot'
	# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/usr/bin/flameshot gui'
	# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Print'

	## doesn't seem to work
	# sudo snap install flameshot-app

flatpak: ## Install flatpack on GNOME
flatpak: upgrade
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

	# Close Windows
	gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"

	# Launch Terminal
	gsettings set org.gnome.settings-daemon.plugins.media-keys terminal '<Super>t'


gnome-preferences: ## Install GNOME preferences
gnome-preferences:
	# Set SCP as Monospace (Code) Font
	gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro Semi-Bold 12'

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

	# Dash to Dock Theme
	# gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
	# gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color false
	# gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots true
	# gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-color '#729fcf'
	# gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
	# gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
	# gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
	# gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner false
	# gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
	# gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'ALL_WINDOWS'
	# gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
	# gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
	# gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
	# gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
	# gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'SEGMENTED'
	# gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.70000000000000000

gnome-theming: ## Install GNOME themes and configure them
gnome-theming:
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

	# Flat Remix Gnome (https://www.gnome-look.org/p/1013030/)
	-sudo add-apt-repository ppa:daniruiz/flat-remix
	sudo apt-get update
	-sudo apt-get install flat-remix-gnome

	#Adapta GTK Theme
	-sudo apt-add-repository ppa:tista/adapta
	sudo apt-get update
	-sudo apt-get install adapta-gtk-theme

	# Enable all possible from above
	-gsettings set org.gnome.desktop.interface gtk-theme 'Adapta-Nokto-Eta'
	-gsettings set org.gnome.desktop.interface cursor-theme 'Pop'
	-gsettings set org.gnome.desktop.interface icon-theme 'Paper'
	-gsettings set org.gnome.shell.extensions.user-theme name 'Adapta-Nokto-Eta' #'Pop-dark'

nodejs: ## Install node.js
nodejs:
	# Using Ubuntu
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs

postman: ## Install Postman as a snap
postman: snap
	sudo snap install postman

python-three-seven: ## Install python3.7
python-three-seven: upgrade
	# Start by updating the packages list and installing the prerequisites:
	sudo apt install software-properties-common

	# Next, add the deadsnakes PPA to your sources list:
	sudo add-apt-repository ppa:deadsnakes/ppa # not for 19.04
	# when prompted, press Enter to continue

	# Once the repository is enabled, install Python 3.7 with: (added libpython3.7-dev for pip installs)
	# - httptools wasn't installing correctly until adding it
	# - see: https://github.com/huge-success/sanic/issues/1503#issuecomment-469031275
	sudo apt update
	sudo apt install -y python3.7 libpython3.7-dev

	# python3 pip
	sudo apt install -y python3-pip
	# upgrade pip
	python3.7 -m pip install --upgrade pip

	# python3 pytest
	sudo apt install -y python3-pytest

	# At this point, Python 3.7 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.7 --version
	python3.7 -m pip --version
	python3.7 -m pytest --version

python-supporting: ## Install useful packages
python-supporting:
	python3.7 -m pip install --user twine
	python3.7 -m pip install --user wheel
	python3.7 -m pip install --user cookiecutter

	# add the following to your .bashrc (.zshrc, etc.) file
	# export PATH=$$HOME/.local/bin:$$PATH

secure-comms: ## Install secure communication snaps
secure-comms: snap
	# Signal Desktop Private Messaging
	sudo snap install signal-desktop

	# Telegram messenger
	sudo snap install telegram-desktop

snap:  ## Install snapd
snap:
	sudo apt install snapd

spotify: ## Install Spotify as a snap
spotify: snap
	sudo snap install spotify

steam: ## Install Steam via Flatpak
steam: flatpak
	flatpak -y install flathub com.valvesoftware.Steam
	# Installed but not displayed? Check with: flatpak run com.valvesoftware.Steam


sublime-text: ## Install Sublime Text as a snap
sublime-text: snap
	sudo snap install sublime-text --classic 

tresorit: ## Install Tresorit
tresorit:
	wget -O ~/Downloads/tresorit_installer.run https://installerstorage.blob.core.windows.net/public/install/tresorit_installer.run
	chmod +x ~/Downloads/tresorit_installer.run
	$(echo $0) ~/Downloads/tresorit_installer.run

yarn: ## Install node.js and yarn
yarn: upgrade nodejs

	################################################
	# Install Yarn
	# https://yarnpkg.com/en/docs/install#debian-stable
	###############################################
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	@echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt-get update && sudo apt-get install yarn

yarn-globals: ## Install Vue and Gridsome CLIs
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

zsh: ## Install zsh and oh-my-zsh, change shell to zsh
zsh: upgrade

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
