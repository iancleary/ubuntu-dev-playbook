#!/bin/sh
FOLDER=$HOME/.local/bin

mkdir -p "$FOLDER"

sudo chown -R "$USER:$USER" "$FOLDER"
sudo chmod -R 755 "$FOLDER"

python3 -m pip install --user --upgrade pip setuptools keyrings.alt
python3 -m pip install --user testresources wheel
python3 -m pip install --user -r requirements_ansible.txt
