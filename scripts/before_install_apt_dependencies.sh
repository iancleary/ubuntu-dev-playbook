#!/bin/sh
sudo apt remove -y ansible
sudo apt -y autoremove
sudo apt update

# Python3 & Pip3
sudo apt install -y python3-pip

# Linting
sudo apt install -y yamllint shellcheck
