sudo apt install -y git make

# Setup Repo Locally
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
    echo "Exited since repo exists"
    #exit
fi

# Run Make Targets
make bootstrap