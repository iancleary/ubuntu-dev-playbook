#!/bin/sh

## ------------------------
## Install Dependencies Required for this script
sudo apt-get update
sudo apt install -y git make

## ------------------------
## Setup Repo Locally
FOLDER=Personal
GIT_USER=icancclearynow
GIT_REPO=ubuntu-dev-playbook
GIT_BRANCH=main
URL=https://github.com/$GIT_USER/$GIT_REPO.git

cd ~ || exit
mkdir -p $FOLDER
cd $FOLDER || exit
if [ ! -d "$GIT_REPO" ] ; then
    # git clone --recurse-submodules -j8 -b $GIT_BRANCH $URL $GIT_REPO
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

# Bootstrap machine setup
make bootstrap
make bootstrap-check

# Initalize any machine (VM or Host)
make terminal

# Upgrade System After Fresh Install
sudo apt update
sudo apt -y full-upgrade
sudo apt -y autoremove
