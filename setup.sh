#!/usr/bin/env bash

SRC_DIR=~/src/github.com/sgerogia
SETTINGS_PROJECT=nascent-mac

echo "----> Updating XCode..."
xcode-select --install || true

sudo xcodebuild -license accept

echo "----> Installing Brew and Python..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install pyenv
pyenv install 3.9.5
pyenv global 3.9.5

echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile

echo "----> Installing Ansible..."
sudo pip install ansible

echo "----> Cloning project to ${SRC_DIR}..."
mkdir -p ${SRC_DIR}
cd ${SRC_DIR}

git clone "https://github.com/sgerogia/${SETTINGS_PROJECT}.git" || true

cd "${SRC_DIR}/${SETTINGS_PROJECT}/ansible"

echo "----> Updating Mac. Hold on tight!..."
sudo ansible-galaxy install -r requirements.yml

sudo ansible-playbook -v ./yaml/osx.yml
ansible-playbook -v ./yaml/homebrew.yml
sudo ansible-playbook -v ./yaml/shell.yml