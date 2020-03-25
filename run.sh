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
URL=https://github.com/$GIT_USER/$GIT_REPO.git

cd ~ || exit
mkdir -p $FOLDER
cd $FOLDER || exit
if [ ! -d "$GIT_REPO" ] ; then
    git clone $URL $GIT_REPO
else
    echo "Didn't clone repo since folder exists"
fi

# Fix permissions and ownership
sudo chown -R "$USER:$USER" $GIT_REPO
sudo chmod -R 755 $GIT_REPO

# Enter Repo
cd $GIT_REPO || exit

## ------------------------
## Run Make Target to bootstrap, bootstrap-check, and install

make all
