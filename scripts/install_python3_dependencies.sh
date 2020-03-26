#!/bin/sh
FOLDER=$HOME/.local/bin

mkdir -p $FOLDER

sudo chown -R "$USER:$USER" "$FOLDER"
sudo chmod -R 755 "$FOLDER"

pip3 install --user --upgrade pip
pip3 install --upgrade keyrings.alt --user
pip3 install --user --upgrade setuptools
pip3 install --user wheel
pip3 install --user -r requirements.txt
