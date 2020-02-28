
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

docker-compose: ## Install Docker Compose
docker-compose:

	# Run this command to download the current stable release of Docker Compose:
	sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(shell uname -s)-$(shell uname -m)" -o /usr/local/bin/docker-compose

	# Apply executable permissions to the binary:
	sudo chmod +x /usr/local/bin/docker-compose

	# Test the installation
	docker-compose --version

gnome-extensions: ## Install GNOME extensions
gnome-extensions:

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

gnome-themes: ## Install GNOME themes and configure them
gnome-themes:

	# Enable all possible from above
	## You can echo back current settings with `gsettings get ...`
	-gsettings set org.gnome.desktop.interface gtk-theme 'vimix-laptop-beryl'
	-gsettings set org.gnome.shell.extensions.user-theme name 'vimix-laptop-beryl'

nodejs: ## Install node.js
nodejs:
	# Using Ubuntu
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs

protonmail-bridge: ## Install Protonmail Bridge deb
protonmail-bridge:
	## Download deb (1.2.3-1) from website
	-sudo apt remove -y protonmail-bridge
	rm -rf /tmp/protonmail-bridge/
	mkdir /tmp/protonmail-bridge/
	wget 'https://protonmail.com/download/protonmail-bridge_1.2.3-1_amd64.deb' -P /tmp/protonmail-bridge

	## Install dependencies (https://askubuntu.com/a/248675/1042945)
	# Install package, and install required dependencies
	sudo dpkg --skip-same-version -i /tmp/protonmail-bridge/protonmail-bridge_1.2.3-1_amd64.deb || sudo apt-get -y --fix-broken install

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



.DEFAULT_GOAL := help
