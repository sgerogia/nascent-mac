#!/usr/bin/env bash

SRC_DIR=~/src/github.com/sgerogia
SETTINGS_PROJECT=nascent-mac

echo "----> Updating XCode..."
xcode-select --install || true

sudo xcodebuild -license accept

echo "----> Installing Ansible..."
sudo easy_install pip
sudo pip install ansible

echo "----> Cloning project to ${SRC_DIR}..."
mkdir -p ${SRC_DIR}
cd ${SRC_DIR}

git clone "https://github.com/sgerogia/${SETTINGS_PROJECT}.git" || true

cd "${SRC_DIR}/${SETTINGS_PROJECT}/ansible"

echo "----> Updating Mac. Hold on tight!..."
ansible-galaxy install -r requirements.yml

ansible-playbook -v setup.yml