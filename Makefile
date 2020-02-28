
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
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'


bootstrap:
bootstrap: ## Installs dependencies needed to run playbook

	@echo "Installing make and ansible"

	# Remove any version of ansible
	sudo apt remove -y ansible

	## Remove old packages
	sudo apt -y autoremove

	# Make for ease of use, python-apt for --check ansible flag
	sudo apt-get install -y make python-apt python3-apt

	## Install latest Ansible (snap is only in Ansible >= 2.8)
	sudo apt update
	sudo apt install -y software-properties-common
	python3 -m pip install --user ansible
	python3 -m pip install --user psutil # for dconf ansible module
	#-python -m pip install psutil # for dconf ansible module
	ansible --version | grep "python version"
	python3 -m pip list | grep psutil
	#-python -m pip list | grep psutil

check: DARGS?=
check: ## Checks personal-computer.yml playbook

	@ansible-playbook --connection=local --inventory=127.0.0.1, personal_computer.yml --check --ask-become-pass -e 'ansible_user='$(whoami) $(DARGS)

install: DARGS?=
install: ## Installs everything via personal-computer.yml playbook

	@ansible-playbook --connection=local --inventory=127.0.0.1, personal_computer.yml --ask-become-pass -e 'ansible_user='$(whoami) $(DARGS)


.DEFAULT_GOAL := help
