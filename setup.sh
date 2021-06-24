#!/usr/bin/env bash

SRC_DIR=~/src/github.com/sgerogia
SETTINGS_PROJECT=nascent-mac

echo "----> Updating XCode..."
xcode-select --install || true

sudo xcodebuild -license accept

chmod +x ./scripts/*.sh

echo "----> Updating Mac. Hold on tight!..."

cd ./scripts

echo "----> Executing shell.sh"
./shell.sh

echo "----> Executing homebrew.sh"
./homebrew.sh

echo "----> Executing osx.sh"
./osx.sh

echo "----> Executing post_setup.sh"
./post_setup.sh