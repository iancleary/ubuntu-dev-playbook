#!/bin/sh
sudo apt remove -y ansible
sudo apt -y autoremove
sudo apt update
sudo apt install -y software-properties-common
sudo apt install -y python3-setuptools python3-apt python3-pip
