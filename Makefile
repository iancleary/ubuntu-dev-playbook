
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

docker: ## Install docker with apt 
docker: DARGS?=
docker: upgrade
	# Uninstall old versions
	sudo apt-get remove docker docker-engine docker.io containerd runc

	# Set up the repository
	sudo apt-get update

	# Install packages to allow apt ot use a repository over HTTPS
	sudo apt-get install \
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
	sudo groupadd docker

	# Add your user to the docker group.
	sudo usermod -aG docker $USER

	# Log out and log back in so that your group membership is re-evaluated.
	# If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.
	# On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.

docker-start-on-boot: ## Start docker on boot
docker-start-on-boot:
	sudo systemctl enable docker

docker-stopped-on-boot: ## Don't start docker on boot
docker-stopped-on-boot:
	sudo systemctl disable docker

docker-compose: ## Manage Docker as a non-root user
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


nodejs: ## Install node.js
nodejs:
	# Using Ubuntu
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs

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
	sh -c "$(shell curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


.DEFAULT_GOAL := help