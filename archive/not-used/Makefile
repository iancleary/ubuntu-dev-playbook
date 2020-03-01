
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

brave: ## Install Brave browser
brave:
	# https://brave-browser.readthedocs.io/en/latest/installing-brave.html#linux
	sudo apt install apt-transport-https curl

	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

	source /etc/os-release

	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $(OS_VERSION_NAME) main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-$(OS_VERSION_NAME).list

	sudo apt update

	sudo apt install brave-browser

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

icloud-for-linux: ## Installs icloud-for-linux snap
icloud-for-linux: snap
	sudo snap install icloud-for-linux

snap:  ## Install snapd
snap:
	sudo apt install snapd
	sudo snap install snap-store

zim-desktop-wiki: ## Install zim-desktop-wiki from Ubuntu PPA
zim-desktop-wiki: update
	sudo add-apt-repository ppa:jaap.karssenberg/zim
	sudo apt-get update
	sudo apt-get install zim

test: ## Test conditional flow
test: DARGS?=
test:
	@echo $(MAKEFLAGS)
	# ifneq (,$(findstring main-install,$(MAKEFLAGS)))
	# 	@echo "hello main-install"
	# else
	# 	@echo "regular path"
	# endif

.DEFAULT_GOAL := help
