#!/usr/bin/env bash

SRC_DIR=~/src/github.com
SETTINGS_PROJECT=nascent-mac

xcode-select --install || true

sudo easy_install pip
sudo pip install ansible

mkdir -p ${SRC_DIR}
cd ${SRC_DIR}

# git clone "https://github.com/sgerogia/${SETTINGS_PROJECT}.git" || true

cd "${SETTINGS_PROJECT}/ansible"

ansible-galaxy install -r requirements.yml

ansible-playbook desktop.yml 