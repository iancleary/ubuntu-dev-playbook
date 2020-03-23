
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
	-python3.6 -m pip install --user --upgrade setuptools

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
	-python3.7 -m pip install --user --upgrade setuptools

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

poetry: ## Install Poetry (Python Packaging and Dependencey Management)
poetry:
	# curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3
	sudo apt-get install -y python3-venv
	python3.7 -m pip install --user poetry


.DEFAULT_GOAL := help
