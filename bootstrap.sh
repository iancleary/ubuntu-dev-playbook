#!/bin/bash

echo "Installing make and ansible"

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
python -m pip install psutil # for dconf ansible module
ansible --version | grep "python version"
python3 -m pip list | grep psutil
python -m pip list | grep psutil

## The below may work when Ubuntu fully deprecates python2
#sudo apt-add-repository --yes --update ppa:ansible/ansible
#sudo apt install -y ansible
