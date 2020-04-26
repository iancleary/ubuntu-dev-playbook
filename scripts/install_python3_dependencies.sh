#!/bin/sh
FOLDER=$HOME/.local/bin

mkdir -p "$FOLDER"

sudo chown -R "$USER:$USER" "$FOLDER"
sudo chmod -R 755 "$FOLDER"

python3 -m pip install --user --upgrade pip
python3 -m pip install --upgrade keyrings.alt --user
python3 -m pip install --user --upgrade setuptools
python3 -m pip install --user wheel
python3 -m pip install --user -r requirements_ansible.txt
