#!/bin/sh
pip3 install --user --upgrade pip
pip3 install --upgrade keyrings.alt --user
pip3 install --user --upgrade setuptools
pip3 install --user wheel
pip3 install --user -r requirements.txt