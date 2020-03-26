#!/bin/sh

## ------------------------
## Install Dependencies Required for this script
sudo apt-get update
sudo apt install -y git make

## ------------------------
## Setup Repo Locally
FOLDER=personal
GIT_USER=iancleary
GIT_REPO=personal-ansible
GIT_BRANCH=master
URL=https://github.com/$GIT_USER/$GIT_REPO.git

cd ~ || exit
mkdir -p $FOLDER
cd $FOLDER || exit
if [ ! -d "$GIT_REPO" ] ; then
    git clone -b $GIT_BRANCH $URL $GIT_REPO
else
    echo "Didn't clone repo since folder exists"
fi

# Fix permissions and ownership
sudo chown -R "$USER:$USER" $GIT_REPO
sudo chmod -R 755 $GIT_REPO

# Enter Repo
cd $GIT_REPO || exit

## ------------------------
## Run Make Targets

# Initial Bootstrap to Setup Machine
make bootstrap

# Source home-local-bin.sh file in /etc/profile.d/
# shellcheck disable=SC1091
. /etc/profile

# Check Path
make bootstrap-check

# Install Everything
make install

# Start Flameshot
flameshot > /dev/null 2>&1

# Upgrade System After Fresh Install
sudo apt update
sudo apt -y full-upgrade
sudo apt -y autoremove

# Install non-ansible (no user input required)
make non-ansible

# Needs to run last as requires user input
make tresorit

# Restart to start using machine
sudo reboot
