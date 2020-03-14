## ------------------------
## Install Dependencies Required for this script
sudo apt install -y git make

## ------------------------
## Setup Repo Locally
FOLDER=personal
GIT_USER=iancleary
GIT_REPO=personal-ansible
URL=https://github.com/$GIT_USER/$GIT_REPO.git

cd ~
mkdir -p $FOLDER
cd $FOLDER
if [ ! -d "$GIT_REPO" ] ; then
    git clone $URL $GIT_REPO
else
    cd $GIT_REPO
    echo "Didn't clone repo since folder exists"
    #exit
fi

## ------------------------
## Run Make Targets

#make bootstrap
#make bootstrap-check
make all